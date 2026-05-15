/**
 * \file Ifx_Ssw_Tc2.c
 * \brief Startup Software for Core2
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
#ifndef IFX_CFG_SSW_ENABLE_TRICORE2_PCACHE
#   define IFX_CFG_SSW_ENABLE_TRICORE2_PCACHE (1U)  /**< Program Cache enabled by default*/
#endif
#ifndef IFX_CFG_SSW_ENABLE_TRICORE2_DCACHE
#   define IFX_CFG_SSW_ENABLE_TRICORE2_DCACHE (1U)  /**< Data Cache enabled by default*/
#endif

/*******************************************************************************
**                      Imported Function Declarations                        **
*******************************************************************************/

IFX_SSW_COMMON_LINKER_SYMBOLS();
IFX_SSW_CORE_LINKER_SYMBOLS(2, 0);
IFX_SSW_CORE_LINKER_SYMBOLS(2, 1);
IFX_SSW_CORE_LINKER_SYMBOLS(2, 2);
IFX_SSW_CORE_LINKER_SYMBOLS(2, 3);
IFX_SSW_CORE_LINKER_SYMBOLS(2, 4);
IFX_SSW_CORE_LINKER_SYMBOLS(2, 5);
IFX_SSW_CORE_LINKER_SYMBOLS(2, 6);
IFX_SSW_CORE_LINKER_SYMBOLS(2, 7);

extern void core2_vm1_main(void);
extern void core2_vm2_main(void);
extern void core2_vm3_main(void);
extern void core2_vm4_main(void);
extern void core2_vm5_main(void);
extern void core2_vm6_main(void);
extern void core2_vm7_main(void);

#if defined(__TASKING__)
__asm("\t .extern core2_vm1_main");
__asm("\t .extern core2_vm2_main");
__asm("\t .extern core2_vm3_main");
__asm("\t .extern core2_vm4_main");
__asm("\t .extern core2_vm5_main");
__asm("\t .extern core2_vm6_main");
__asm("\t .extern core2_vm7_main");
#endif

/*******************************************************************************
**                      Prototypes & Externals                                **
*******************************************************************************/

IFX_SSW_WEAK void Ifx_Ssw_MultiCore_Sync_Cpu2(void)
{}

/*********************************************************************************
* - startup code
*********************************************************************************/

void __Core2_start(void)
{
    /* By default mapped to empty, skip only if configured */
    IFX_CFG_SSW_SKIP_STARTUP_ROUTINE(2);
    
    #if (IFX_PROT_ENABLED == 1U)
        IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU2.PROTSFRE), IfxSswProt_State_config);
    #endif
    /* Load Base Address of Trap Vector Table. */
    Ifx_Ssw_MTCR(CPU_BTV, (unsigned int)__TRAPTAB(2, 0));
    #if (IFX_PROT_ENABLED == 1U)
        IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU2.PROTSFRE), IfxSswProt_State_run);
    #endif


    /* Set the PSW to its reset value in case of a warm start,clear PSW.IS */
    Ifx_Ssw_MTCR(CPU_PSW, IFX_CFG_SSW_PSW_DEFAULT);

    {
        Ifx_CPU_PCON0 pcon0;
        pcon0.U       = 0;
        pcon0.B.PCBYP = IFX_CFG_SSW_ENABLE_TRICORE2_PCACHE ? 0 : 1; /*depending on the enable bypass bit is reset/set */
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU2.PROTSFRE), IfxSswProt_State_config);
        #endif
        Ifx_Ssw_MTCR(CPU_PCON0, pcon0.U);
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU2.PROTSFRE), IfxSswProt_State_run);
        #endif
    }

    {
        Ifx_CPU_DCON0 dcon0;
        dcon0.U       = 0;
        dcon0.B.DCBYP = IFX_CFG_SSW_ENABLE_TRICORE2_DCACHE ? 0 : 1; /*depending on the enable bypass bit is reset/set */
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU2.PROTSFRE), IfxSswProt_State_config);
        #endif
        Ifx_Ssw_MTCR(CPU_DCON0, dcon0.U);
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU2.PROTSFRE), IfxSswProt_State_run);
        #endif
    }

    #if (IFX_PROT_ENABLED == 1U)
        IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU2.PROTSFRE), IfxSswProt_State_config);
    #endif
    /* Trap vector table for HV mode initialization is necessary when HV mode is enabled */
    Ifx_Ssw_MTCR(CPU_BHV, (unsigned int)__TRAPTABHV_CPU20);
    /* Load Base Address of Trap Vector Table. */
    Ifx_Ssw_MTCR(CPU_BTV, (unsigned int)__TRAPTAB(2, 0));

    /* Load Base Address of Interrupt Vector Table. we will do this later in the program */
    Ifx_Ssw_MTCR(CPU_BIV, (unsigned int)__INTTAB(2, 0));

    /* Load interrupt stack pointer. */
    Ifx_Ssw_MTCR(CPU_ISP, (unsigned int)__ISTACK(2, 0));
    #if (IFX_PROT_ENABLED == 1U)
         IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU2.PROTSFRE), IfxSswProt_State_run);
    #endif
    Ifx_Ssw_initCSA((unsigned int *)__CSA(2, 0), (unsigned int *)__CSA_END(2, 0));

    /* initialize SDA base pointers */
    Ifx_Ssw_setAddressReg(a0, __SDATA1(2));
    Ifx_Ssw_setAddressReg(a1, __SDATA2(2));
    Ifx_Ssw_setAddressReg(a8, __SDATA3(2));
    Ifx_Ssw_setAddressReg(a9, __SDATA4(2));

    /*Initialize CPU Private Global Variables*/
    volatile unsigned int tempVar = ((unsigned int)&__ENABLE_INDIVIDUAL_C_INIT_CPU2);
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
    Ifx_Ssw_MultiCore_Sync_Cpu2();

    /*Call Hypervisor Function */
    Ifx_Ssw_jumpToFunction(core2_vm0_start);
}


IFX_SSW_USED static void core2_vm1_start(void)
{
	IFX_SSW_CORE_VM_START(2,1);
    /* Call main function of CPU2 VM 1 */
    Ifx_Ssw_jumpToFunction(core2_vm1_main);
}

IFX_SSW_USED static void core2_vm2_start(void)
{
	IFX_SSW_CORE_VM_START(2,2);
    /* Call main function of CPU2 VM 2 */
    Ifx_Ssw_jumpToFunction(core2_vm2_main);
}

IFX_SSW_USED static void core2_vm3_start(void)
{
	IFX_SSW_CORE_VM_START(2,3);
    /* Call main function of CPU2 VM 3 */
    Ifx_Ssw_jumpToFunction(core2_vm3_main);
}

IFX_SSW_USED static void core2_vm4_start(void)
{
	IFX_SSW_CORE_VM_START(2,4);
    /* Call main function of CPU2 VM 4 */
    Ifx_Ssw_jumpToFunction(core2_vm4_main);
}

IFX_SSW_USED static void core2_vm5_start(void)
{
	IFX_SSW_CORE_VM_START(2,5);
    /* Call main function of CPU2 VM 5 */
    Ifx_Ssw_jumpToFunction(core2_vm5_main);
}

IFX_SSW_USED static void core2_vm6_start(void)
{
	IFX_SSW_CORE_VM_START(2,6);
    /* Call main function of CPU2 VM 6 */
    Ifx_Ssw_jumpToFunction(core2_vm6_main);
}

IFX_SSW_USED static void core2_vm7_start(void)
{
	IFX_SSW_CORE_VM_START(2,7);
    /* Call main function of CPU2 VM 7 */
    Ifx_Ssw_jumpToFunction(core2_vm7_main);
}



/******************************************************************************
 *                        reset vector address                                *
 *****************************************************************************/
#if defined(__TASKING__)
#pragma protect on
#pragma section code "start_cpu20"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu20" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu20"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu20" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu20" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu20"
#endif

IFX_SSW_USED void _START20(void)
{
	Ifx_Ssw_Start(__USTACK(2, 0), __Core2_start);
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
#pragma section code "start_cpu21"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu21" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu21"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu21" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu21" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu21"
#endif

IFX_SSW_USED void _START21(void)
{
    Ifx_Ssw_jumpToFunction(core2_vm1_start);
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
#pragma section code "start_cpu22"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu22" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu22"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu22" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu22" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu22"
#endif

IFX_SSW_USED void _START22(void)
{
    Ifx_Ssw_jumpToFunction(core2_vm2_start);
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
#pragma section code "start_cpu23"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu23" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu23"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu23" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu23" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu23"
#endif

IFX_SSW_USED void _START23(void)
{
    Ifx_Ssw_jumpToFunction(core2_vm3_start);
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
#pragma section code "start_cpu24"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu24" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu24"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu24" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu24" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu24"
#endif

IFX_SSW_USED void _START24(void)
{
    Ifx_Ssw_jumpToFunction(core2_vm4_start);
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
#pragma section code "start_cpu25"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu25" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu25"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu25" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu25" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu25"
#endif

IFX_SSW_USED void _START25(void)
{
    Ifx_Ssw_jumpToFunction(core2_vm5_start);
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
#pragma section code "start_cpu26"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu26" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu26"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu26" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu26" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu26"
#endif

IFX_SSW_USED void _START26(void)
{
    Ifx_Ssw_jumpToFunction(core2_vm6_start);
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
#pragma section code "start_cpu27"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu27" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu27"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu27" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu27" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu27"
#endif

IFX_SSW_USED void _START27(void)
{
    Ifx_Ssw_jumpToFunction(core2_vm7_start);
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

