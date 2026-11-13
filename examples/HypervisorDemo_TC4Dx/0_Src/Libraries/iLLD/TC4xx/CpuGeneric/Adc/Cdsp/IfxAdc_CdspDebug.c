/******************************************************************************/
/*----------------------------------Includes----------------------------------*/
/******************************************************************************/

#include "Ifx_Cfg.h"
#if defined (__TASKING__)
#pragma warning 508		/* To suppress empty file warning */
#endif
#if defined (__ghs__)
#pragma diag_suppress 96		/* To suppress empty file warning */
#endif

#include "IfxAdc_Cdsp.h"

#if IFXADC_CDSP_SW_BREAKPOINTS
#include "IfxCbs_reg.h"

/******************************************************************************/
/*-------------------Private Types, Macros and Linker Symbols-----------------*/
/******************************************************************************/

/* CDSP memory a breakpoint table address belongs to */
typedef enum
{
    IfxAdc_Cdsp_SwBreakpointMemory_none = 0,
    IfxAdc_Cdsp_SwBreakpointMemory_iccm,
    IfxAdc_Cdsp_SwBreakpointMemory_dccm
} IfxAdc_Cdsp_SwBreakpointMemory;

/* Debugger software breakpoint table. Layout and handshake are shared with the debugger (from CdspInterface.c):
 * core n owns slots [n * 8, n * 8 + 7]. The debugger writes a CDSP-local address and REQUESTED; after a complete
 * image load the driver saves the original halfword in opcode, writes brk_s and reports PATCHED. Unused slots and
 * addresses outside ICCM/DCCM are reported as SKIPPED (SKIPPED_LAST for the last slot of a core). */
typedef struct
{
    uint32 addr;      /* CDSP-local byte address (ICCM from 0x0, DCCM from 0x8000); 0 = unused */
    uint16 opcode;    /* Original instruction halfword saved before brk_s was patched in */
    uint16 valid;     /* Slot state, one of the IFXADC_CDSP_SW_BREAKPOINT_* values */
} IfxAdc_Cdsp_SwBreakpoint;

#define IFXADC_CDSP_SW_BREAKPOINT_SLOTS_PER_CORE (8u)
#define IFXADC_CDSP_SW_BREAKPOINT_REQUESTED      (0xAAAAu)
#define IFXADC_CDSP_SW_BREAKPOINT_PATCHED        (0xBBBBu)
#define IFXADC_CDSP_SW_BREAKPOINT_SKIPPED        (0xEEE0u)
#define IFXADC_CDSP_SW_BREAKPOINT_SKIPPED_LAST   (0xEEEEu)
#define IFXADC_CDSP_BRK_S_OPCODE                 (0x7FFFu)   /* ARC EM 16-bit brk_s */
#define IFXADC_CDSP_DCCM_LOCAL_BASE              (0x8000u)   /* DCCM base as seen by the ARC core and debugger */

/* Table bounds, provided by the application linker script. Weak references keep applications without the table
 * linkable: the addresses then resolve to 0 and breakpoint injection is skipped. */
extern IfxAdc_Cdsp_SwBreakpoint __CDSP_BREAK[] __attribute__((weak));
extern IfxAdc_Cdsp_SwBreakpoint __CDSP_BREAK_END[] __attribute__((weak));

/******************************************************************************/
/*-----------------------Private Function Prototypes--------------------------*/
/******************************************************************************/

/** \brief Patch brk_s at the address of one breakpoint table slot and save the original halfword
 *
 * \param[in]    coreId CDSP core owning the slot
 * \param[inout] entry  Breakpoint table slot holding an ICCM or DCCM address
 * \param[in]    memory Memory the address belongs to
 *
 * \retval None
 */
IFX_STATIC void IfxAdc_Cdsp_lPatchSwBreakpoint(IfxAdc_CdspCore coreId, IfxAdc_Cdsp_SwBreakpoint *entry,
    IfxAdc_Cdsp_SwBreakpointMemory memory);

/** \brief Classify a CDSP-local breakpoint address
 *
 * \param[in] addr CDSP-local byte address from the breakpoint table
 *
 * \retval Memory the address belongs to; none for 0 (unused slot) and out-of-range addresses
 */
IFX_STATIC IfxAdc_Cdsp_SwBreakpointMemory IfxAdc_Cdsp_lGetSwBreakpointMemory(uint32 addr);

/******************************************************************************/
/*-------------------------Function Implementations---------------------------*/
/******************************************************************************/

void IfxAdc_Cdsp_lInjectSwBreakpoints(IfxAdc_CdspCore coreId)
{
    IfxAdc_Cdsp_SwBreakpoint *table    = __CDSP_BREAK;
    IfxAdc_Cdsp_SwBreakpoint *tableEnd = __CDSP_BREAK_END;

    if ((table != NULL_PTR) && (tableEnd > table) && (CBS_OSTATE.B.OEN != 0u))
    {
        uint32 firstSlot = (uint32)coreId * IFXADC_CDSP_SW_BREAKPOINT_SLOTS_PER_CORE;
        uint32 lastSlot  = firstSlot + IFXADC_CDSP_SW_BREAKPOINT_SLOTS_PER_CORE - 1u;
        uint32 slot;

        for (slot = firstSlot; (slot <= lastSlot) && (&table[slot] < tableEnd); slot++)
        {
            IfxAdc_Cdsp_SwBreakpoint      *entry       = &table[slot];
            IfxAdc_Cdsp_SwBreakpointMemory entryMemory = IfxAdc_Cdsp_lGetSwBreakpointMemory(entry->addr);

            if ((entryMemory != IfxAdc_Cdsp_SwBreakpointMemory_none) &&
                (entry->valid == IFXADC_CDSP_SW_BREAKPOINT_REQUESTED))
            {
                IfxAdc_Cdsp_lPatchSwBreakpoint(coreId, entry, entryMemory);
            }
            else
            {
                /* Unused slot, out-of-range address, or a patch that the image load just overwrote */
                entry->valid = (slot == lastSlot) ? IFXADC_CDSP_SW_BREAKPOINT_SKIPPED_LAST
                                                  : IFXADC_CDSP_SW_BREAKPOINT_SKIPPED;
            }
        }
    }
}

IFX_STATIC void IfxAdc_Cdsp_lPatchSwBreakpoint(IfxAdc_CdspCore coreId, IfxAdc_Cdsp_SwBreakpoint *entry,
    IfxAdc_Cdsp_SwBreakpointMemory memory)
{
    uint32           addr = entry->addr;
    volatile uint32 *word;
    uint32           insn;

    if (memory == IfxAdc_Cdsp_SwBreakpointMemory_iccm)
    {
        word = &((volatile uint32 *)IFXADC_CDSP_GETICCM_ADDRESS(coreId))[addr >> 2u];
    }
    else
    {
        word = &((volatile uint32 *)IFXADC_CDSP_GETDCCM_ADDRESS(coreId))[(addr - IFXADC_CDSP_DCCM_LOCAL_BASE) >> 2u];
    }

    insn = *word;

    /* ARC is little endian: a 4-byte aligned address selects the lower halfword of the 32-bit word */
    if ((addr & 0x3u) == 0u)
    {
        entry->opcode = (uint16)(insn & 0x0000FFFFu);
        *word         = (insn & 0xFFFF0000u) | IFXADC_CDSP_BRK_S_OPCODE;
    }
    else
    {
        entry->opcode = (uint16)(insn >> 16u);
        *word         = (insn & 0x0000FFFFu) | ((uint32)IFXADC_CDSP_BRK_S_OPCODE << 16u);
    }

    entry->valid = IFXADC_CDSP_SW_BREAKPOINT_PATCHED;
}

IFX_STATIC IfxAdc_Cdsp_SwBreakpointMemory IfxAdc_Cdsp_lGetSwBreakpointMemory(uint32 addr)
{
    IfxAdc_Cdsp_SwBreakpointMemory memory = IfxAdc_Cdsp_SwBreakpointMemory_none;

    if ((addr != 0u) && (addr < (uint32)ADC_CDSP_DSP0_ICCM_SIZE))
    {
        memory = IfxAdc_Cdsp_SwBreakpointMemory_iccm;
    }
    else if ((addr >= IFXADC_CDSP_DCCM_LOCAL_BASE) &&
             (addr < (IFXADC_CDSP_DCCM_LOCAL_BASE + (uint32)ADC_CDSP_DSP0_DCCM_SIZE)))
    {
        memory = IfxAdc_Cdsp_SwBreakpointMemory_dccm;
    }
    else
    {
        /* Unused slot (address 0) or address outside ICCM/DCCM */
    }

    return memory;
}
#endif

#if defined (_TASKING_) || defined (_ghs_)
#pragma restore
#endif
