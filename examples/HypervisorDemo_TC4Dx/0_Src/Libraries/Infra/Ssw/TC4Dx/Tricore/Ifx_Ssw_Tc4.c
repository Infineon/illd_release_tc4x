/**
 * \file Ifx_Ssw_Tc4.c
 * \brief Startup Software for Core4
 *
 * \copyright Copyright (c) 2026 Infineon Technologies AG. All rights reserved.
 *
 * $Date: 2025-02-26 06:30:03
 *
 *                                 IMPORTANT NOTICE
 *
 * Infineon Technologies AG (Infineon) licenses this file to you under the
 * Infineon Automotive SW Lab License v2025-01 (IFASLL). You may not use
 * this file except in compliance with IFASLL.
 *
 * The full license text is contained in IFASLL202501.pdf delivered with this SW.
 * Unless required by applicable law or agreed to in writing, software distributed
 * under this license is distributed "AS IS" without any warranty or liability of any
 * kind and Infineon hereby expressly disclaims any warranties or representations,
 * whether express, implied, statutory or otherwise, including but not limited to
 * warranties of workmanship, merchantability, fitness for a particular purpose,
 * defects in the licensed items, or non-infringement of third parties'
 * intellectual property rights. See the full license text for the specific
 * language governing permissions and limitations under IFASLL.
 *
 */

/*******************************************************************************
**                      Includes                                              **
*******************************************************************************/

#include "Ifx_Cfg.h"
#include "Ifx_Ssw.h"
#include "Ifx_Ssw_Infra.h"
#include "IfxHv_CpuVmSched.h"

/******************************************************************************/
/*                          Macros                                            */
/******************************************************************************/

/** \brief Configuration for cache enable.
 *
 */
#ifndef IFX_CFG_SSW_ENABLE_TRICORE4_PCACHE
#   define IFX_CFG_SSW_ENABLE_TRICORE4_PCACHE (1U)  /**< Program Cache enabled by default*/
#endif
#ifndef IFX_CFG_SSW_ENABLE_TRICORE4_DCACHE
#   define IFX_CFG_SSW_ENABLE_TRICORE4_DCACHE (1U)  /**< Data Cache enabled by default*/
#endif

/*******************************************************************************
**                      Imported Function Declarations                        **
*******************************************************************************/

IFX_SSW_COMMON_LINKER_SYMBOLS();
IFX_SSW_CORE_LINKER_SYMBOLS(4, 0);
IFX_SSW_CORE_LINKER_SYMBOLS(4, 1);
IFX_SSW_CORE_LINKER_SYMBOLS(4, 2);
IFX_SSW_CORE_LINKER_SYMBOLS(4, 3);
IFX_SSW_CORE_LINKER_SYMBOLS(4, 4);
IFX_SSW_CORE_LINKER_SYMBOLS(4, 5);
IFX_SSW_CORE_LINKER_SYMBOLS(4, 6);
IFX_SSW_CORE_LINKER_SYMBOLS(4, 7);

extern void core4_vm1_main(void);
extern void core4_vm2_main(void);
extern void core4_vm3_main(void);
extern void core4_vm4_main(void);
extern void core4_vm5_main(void);
extern void core4_vm6_main(void);
extern void core4_vm7_main(void);

#if defined(__TASKING__)
__asm("\t .extern core4_vm1_main");
__asm("\t .extern core4_vm2_main");
__asm("\t .extern core4_vm3_main");
__asm("\t .extern core4_vm4_main");
__asm("\t .extern core4_vm5_main");
__asm("\t .extern core4_vm6_main");
__asm("\t .extern core4_vm7_main");
#endif

/*******************************************************************************
**                      Prototypes & Externals                                **
*******************************************************************************/

IFX_SSW_WEAK void Ifx_Ssw_MultiCore_Sync_Cpu4(void)
{}

/*********************************************************************************
* - startup code
*********************************************************************************/

void __Core4_start(void)
{
    /* By default mapped to empty, skip only if configured */
    IFX_CFG_SSW_SKIP_STARTUP_ROUTINE(4);
    
    #if (IFX_PROT_ENABLED == 1U)
        IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU4.PROTSFRE), IfxSswProt_State_config);
    #endif
    /* Load Base Address of Trap Vector Table. */
    Ifx_Ssw_MTCR(CPU_BTV, (unsigned int)__TRAPTAB(4, 0));
    #if (IFX_PROT_ENABLED == 1U)
        IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU4.PROTSFRE), IfxSswProt_State_run);
    #endif


    /* Set the PSW to its reset value in case of a warm start,clear PSW.IS */
    Ifx_Ssw_MTCR(CPU_PSW, IFX_CFG_SSW_PSW_DEFAULT);

    {
        Ifx_CPU_PCON0 pcon0;
        pcon0.U       = 0;
        pcon0.B.PCBYP = IFX_CFG_SSW_ENABLE_TRICORE4_PCACHE ? 0 : 1; /*depending on the enable bypass bit is reset/set */
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU4.PROTSFRE), IfxSswProt_State_config);
        #endif
        Ifx_Ssw_MTCR(CPU_PCON0, pcon0.U);
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU4.PROTSFRE), IfxSswProt_State_run);
        #endif
    }

    {
        Ifx_CPU_DCON0 dcon0;
        dcon0.U       = 0;
        dcon0.B.DCBYP = IFX_CFG_SSW_ENABLE_TRICORE4_DCACHE ? 0 : 1; /*depending on the enable bypass bit is reset/set */
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU4.PROTSFRE), IfxSswProt_State_config);
        #endif
        Ifx_Ssw_MTCR(CPU_DCON0, dcon0.U);
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU4.PROTSFRE), IfxSswProt_State_run);
        #endif
    }

    #if (IFX_PROT_ENABLED == 1U)
        IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU4.PROTSFRE), IfxSswProt_State_config);
    #endif
    /* Trap vector table for HV mode initialization is necessary when HV mode is enabled */
    Ifx_Ssw_MTCR(CPU_BHV, (unsigned int)__TRAPTABHV_CPU40);
    /* Load Base Address of Trap Vector Table. */
    Ifx_Ssw_MTCR(CPU_BTV, (unsigned int)__TRAPTAB(4, 0));

    /* Load Base Address of Interrupt Vector Table. we will do this later in the program */
    Ifx_Ssw_MTCR(CPU_BIV, (unsigned int)__INTTAB(4, 0));

    /* Load interrupt stack pointer. */
    Ifx_Ssw_MTCR(CPU_ISP, (unsigned int)__ISTACK(4, 0));
    #if (IFX_PROT_ENABLED == 1U)
         IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU4.PROTSFRE), IfxSswProt_State_run);
    #endif
    Ifx_Ssw_initCSA((unsigned int *)__CSA(4, 0), (unsigned int *)__CSA_END(4, 0));

    /* initialize SDA base pointers */
    Ifx_Ssw_setAddressReg(a0, __SDATA1(4));
    Ifx_Ssw_setAddressReg(a1, __SDATA2(4));
    Ifx_Ssw_setAddressReg(a8, __SDATA3(4));
    Ifx_Ssw_setAddressReg(a9, __SDATA4(4));

    /*Initialize CPU Private Global Variables*/
    volatile unsigned int tempVar = ((unsigned int)&__ENABLE_INDIVIDUAL_C_INIT_CPU4);
    if (tempVar != 0U)
    {
      /* Hook functions to initialize application specific HW extensions */
      hardware_init_hook();

      /* Initialization of C runtime variables and CPP constructors and destructors */
      (void)Ifx_Ssw_doCppInit();
	
      /* Hook functions to initialize application specific SW extensions */
      software_init_hook();	
    }
    /* MultiCore synchronization hooks to execute Safety Library tests */
    Ifx_Ssw_MultiCore_Sync_Cpu4();

    /*Call Hypervisor Function */
    Ifx_Ssw_jumpToFunction(core4_vm0_start);
}


IFX_SSW_USED static void core4_vm1_start(void)
{
	IFX_SSW_CORE_VM_START(4,1);
    /* Call main function of CPU4 VM 1 */
    Ifx_Ssw_jumpToFunction(core4_vm1_main);
}

IFX_SSW_USED static void core4_vm2_start(void)
{
	IFX_SSW_CORE_VM_START(4,2);
    /* Call main function of CPU4 VM 2 */
    Ifx_Ssw_jumpToFunction(core4_vm2_main);
}

IFX_SSW_USED static void core4_vm3_start(void)
{
	IFX_SSW_CORE_VM_START(4,3);
    /* Call main function of CPU4 VM 3 */
    Ifx_Ssw_jumpToFunction(core4_vm3_main);
}

IFX_SSW_USED static void core4_vm4_start(void)
{
	IFX_SSW_CORE_VM_START(4,4);
    /* Call main function of CPU4 VM 4 */
    Ifx_Ssw_jumpToFunction(core4_vm4_main);
}

IFX_SSW_USED static void core4_vm5_start(void)
{
	IFX_SSW_CORE_VM_START(4,5);
    /* Call main function of CPU4 VM 5 */
    Ifx_Ssw_jumpToFunction(core4_vm5_main);
}

IFX_SSW_USED static void core4_vm6_start(void)
{
	IFX_SSW_CORE_VM_START(4,6);
    /* Call main function of CPU4 VM 6 */
    Ifx_Ssw_jumpToFunction(core4_vm6_main);
}

IFX_SSW_USED static void core4_vm7_start(void)
{
	IFX_SSW_CORE_VM_START(4,7);
    /* Call main function of CPU4 VM 7 */
    Ifx_Ssw_jumpToFunction(core4_vm7_main);
}



/******************************************************************************
 *                        reset vector address                                *
 *****************************************************************************/
#if defined(__TASKING__)
#pragma protect on
#pragma section code "start_cpu40"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu40" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu40"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu40" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu40" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu40"
#endif

IFX_SSW_USED void _START40(void)
{
	Ifx_Ssw_Start(__USTACK(4, 0), __Core4_start);
}

/* reset the sections defined above, to normal region */
#if defined(__TASKING__)
#pragma protect restore
#pragma section code restore
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=""
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#elif defined(__DCC__)
#pragma section CODE
#elif defined(__ghs__)
#pragma ghs section text=default
#endif
#if defined(__TASKING__)
#pragma protect on
#pragma section code "start_cpu41"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu41" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu41"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu41" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu41" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu41"
#endif

IFX_SSW_USED void _START41(void)
{
    Ifx_Ssw_jumpToFunction(core4_vm1_start);
}

/* reset the sections defined above, to normal region */
#if defined(__TASKING__)
#pragma protect restore
#pragma section code restore
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=""
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#elif defined(__DCC__)
#pragma section CODE
#elif defined(__ghs__)
#pragma ghs section text=default
#endif
#if defined(__TASKING__)
#pragma protect on
#pragma section code "start_cpu42"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu42" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu42"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu42" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu42" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu42"
#endif

IFX_SSW_USED void _START42(void)
{
    Ifx_Ssw_jumpToFunction(core4_vm2_start);
}

/* reset the sections defined above, to normal region */
#if defined(__TASKING__)
#pragma protect restore
#pragma section code restore
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=""
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#elif defined(__DCC__)
#pragma section CODE
#elif defined(__ghs__)
#pragma ghs section text=default
#endif
#if defined(__TASKING__)
#pragma protect on
#pragma section code "start_cpu43"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu43" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu43"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu43" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu43" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu43"
#endif

IFX_SSW_USED void _START43(void)
{
    Ifx_Ssw_jumpToFunction(core4_vm3_start);
}

/* reset the sections defined above, to normal region */
#if defined(__TASKING__)
#pragma protect restore
#pragma section code restore
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=""
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#elif defined(__DCC__)
#pragma section CODE
#elif defined(__ghs__)
#pragma ghs section text=default
#endif
#if defined(__TASKING__)
#pragma protect on
#pragma section code "start_cpu44"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu44" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu44"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu44" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu44" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu44"
#endif

IFX_SSW_USED void _START44(void)
{
    Ifx_Ssw_jumpToFunction(core4_vm4_start);
}

/* reset the sections defined above, to normal region */
#if defined(__TASKING__)
#pragma protect restore
#pragma section code restore
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=""
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#elif defined(__DCC__)
#pragma section CODE
#elif defined(__ghs__)
#pragma ghs section text=default
#endif
#if defined(__TASKING__)
#pragma protect on
#pragma section code "start_cpu45"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu45" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu45"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu45" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu45" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu45"
#endif

IFX_SSW_USED void _START45(void)
{
    Ifx_Ssw_jumpToFunction(core4_vm5_start);
}

/* reset the sections defined above, to normal region */
#if defined(__TASKING__)
#pragma protect restore
#pragma section code restore
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=""
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#elif defined(__DCC__)
#pragma section CODE
#elif defined(__ghs__)
#pragma ghs section text=default
#endif
#if defined(__TASKING__)
#pragma protect on
#pragma section code "start_cpu46"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu46" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu46"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu46" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu46" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu46"
#endif

IFX_SSW_USED void _START46(void)
{
    Ifx_Ssw_jumpToFunction(core4_vm6_start);
}

/* reset the sections defined above, to normal region */
#if defined(__TASKING__)
#pragma protect restore
#pragma section code restore
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=""
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#elif defined(__DCC__)
#pragma section CODE
#elif defined(__ghs__)
#pragma ghs section text=default
#endif
#if defined(__TASKING__)
#pragma protect on
#pragma section code "start_cpu47"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu47" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu47"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu47" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu47" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu47"
#endif

IFX_SSW_USED void _START47(void)
{
    Ifx_Ssw_jumpToFunction(core4_vm7_start);
}

/* reset the sections defined above, to normal region */
#if defined(__TASKING__)
#pragma protect restore
#pragma section code restore
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=""
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#elif defined(__DCC__)
#pragma section CODE
#elif defined(__ghs__)
#pragma ghs section text=default
#endif

