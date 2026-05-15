/**
 * \file Ifx_Ssw_Tc1.c
 * \brief Startup Software for Core1
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
#ifndef IFX_CFG_SSW_ENABLE_TRICORE1_PCACHE
#   define IFX_CFG_SSW_ENABLE_TRICORE1_PCACHE (1U)  /**< Program Cache enabled by default*/
#endif
#ifndef IFX_CFG_SSW_ENABLE_TRICORE1_DCACHE
#   define IFX_CFG_SSW_ENABLE_TRICORE1_DCACHE (1U)  /**< Data Cache enabled by default*/
#endif

/*******************************************************************************
**                      Imported Function Declarations                        **
*******************************************************************************/

IFX_SSW_COMMON_LINKER_SYMBOLS();
IFX_SSW_CORE_LINKER_SYMBOLS(1, 0);
IFX_SSW_CORE_LINKER_SYMBOLS(1, 1);
IFX_SSW_CORE_LINKER_SYMBOLS(1, 2);
IFX_SSW_CORE_LINKER_SYMBOLS(1, 3);
IFX_SSW_CORE_LINKER_SYMBOLS(1, 4);
IFX_SSW_CORE_LINKER_SYMBOLS(1, 5);
IFX_SSW_CORE_LINKER_SYMBOLS(1, 6);
IFX_SSW_CORE_LINKER_SYMBOLS(1, 7);

extern void core1_vm1_main(void);
extern void core1_vm2_main(void);
extern void core1_vm3_main(void);
extern void core1_vm4_main(void);
extern void core1_vm5_main(void);
extern void core1_vm6_main(void);
extern void core1_vm7_main(void);

#if defined(__TASKING__)
__asm("\t .extern core1_vm1_main");
__asm("\t .extern core1_vm2_main");
__asm("\t .extern core1_vm3_main");
__asm("\t .extern core1_vm4_main");
__asm("\t .extern core1_vm5_main");
__asm("\t .extern core1_vm6_main");
__asm("\t .extern core1_vm7_main");
#endif

/*******************************************************************************
**                      Prototypes & Externals                                **
*******************************************************************************/

IFX_SSW_WEAK void Ifx_Ssw_MultiCore_Sync_Cpu1(void)
{}

/*********************************************************************************
* - startup code
*********************************************************************************/

void __Core1_start(void)
{
    /* By default mapped to empty, skip only if configured */
    IFX_CFG_SSW_SKIP_STARTUP_ROUTINE(1);
    
    #if (IFX_PROT_ENABLED == 1U)
        IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU1.PROTSFRE), IfxSswProt_State_config);
    #endif
    /* Load Base Address of Trap Vector Table. */
    Ifx_Ssw_MTCR(CPU_BTV, (unsigned int)__TRAPTAB(1, 0));
    #if (IFX_PROT_ENABLED == 1U)
        IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU1.PROTSFRE), IfxSswProt_State_run);
    #endif


    /* Set the PSW to its reset value in case of a warm start,clear PSW.IS */
    Ifx_Ssw_MTCR(CPU_PSW, IFX_CFG_SSW_PSW_DEFAULT);

    {
        Ifx_CPU_PCON0 pcon0;
        pcon0.U       = 0;
        pcon0.B.PCBYP = IFX_CFG_SSW_ENABLE_TRICORE1_PCACHE ? 0 : 1; /*depending on the enable bypass bit is reset/set */
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU1.PROTSFRE), IfxSswProt_State_config);
        #endif
        Ifx_Ssw_MTCR(CPU_PCON0, pcon0.U);
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU1.PROTSFRE), IfxSswProt_State_run);
        #endif
    }

    {
        Ifx_CPU_DCON0 dcon0;
        dcon0.U       = 0;
        dcon0.B.DCBYP = IFX_CFG_SSW_ENABLE_TRICORE1_DCACHE ? 0 : 1; /*depending on the enable bypass bit is reset/set */
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU1.PROTSFRE), IfxSswProt_State_config);
        #endif
        Ifx_Ssw_MTCR(CPU_DCON0, dcon0.U);
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU1.PROTSFRE), IfxSswProt_State_run);
        #endif
    }

    #if (IFX_PROT_ENABLED == 1U)
        IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU1.PROTSFRE), IfxSswProt_State_config);
    #endif
    /* Trap vector table for HV mode initialization is necessary when HV mode is enabled */
    Ifx_Ssw_MTCR(CPU_BHV, (unsigned int)__TRAPTABHV_CPU10);
    /* Load Base Address of Trap Vector Table. */
    Ifx_Ssw_MTCR(CPU_BTV, (unsigned int)__TRAPTAB(1, 0));

    /* Load Base Address of Interrupt Vector Table. we will do this later in the program */
    Ifx_Ssw_MTCR(CPU_BIV, (unsigned int)__INTTAB(1, 0));

    /* Load interrupt stack pointer. */
    Ifx_Ssw_MTCR(CPU_ISP, (unsigned int)__ISTACK(1, 0));
    #if (IFX_PROT_ENABLED == 1U)
         IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU1.PROTSFRE), IfxSswProt_State_run);
    #endif
    Ifx_Ssw_initCSA((unsigned int *)__CSA(1, 0), (unsigned int *)__CSA_END(1, 0));

    /* initialize SDA base pointers */
    Ifx_Ssw_setAddressReg(a0, __SDATA1(1));
    Ifx_Ssw_setAddressReg(a1, __SDATA2(1));
    Ifx_Ssw_setAddressReg(a8, __SDATA3(1));
    Ifx_Ssw_setAddressReg(a9, __SDATA4(1));

    /*Initialize CPU Private Global Variables*/
    volatile unsigned int tempVar = ((unsigned int)&__ENABLE_INDIVIDUAL_C_INIT_CPU1);
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
    Ifx_Ssw_MultiCore_Sync_Cpu1();

    /*Call Hypervisor Function */
    Ifx_Ssw_jumpToFunction(core1_vm0_start);
}


IFX_SSW_USED static void core1_vm1_start(void)
{
	IFX_SSW_CORE_VM_START(1,1);
    /* Call main function of CPU1 VM 1 */
    Ifx_Ssw_jumpToFunction(core1_vm1_main);
}

IFX_SSW_USED static void core1_vm2_start(void)
{
	IFX_SSW_CORE_VM_START(1,2);
    /* Call main function of CPU1 VM 2 */
    Ifx_Ssw_jumpToFunction(core1_vm2_main);
}

IFX_SSW_USED static void core1_vm3_start(void)
{
	IFX_SSW_CORE_VM_START(1,3);
    /* Call main function of CPU1 VM 3 */
    Ifx_Ssw_jumpToFunction(core1_vm3_main);
}

IFX_SSW_USED static void core1_vm4_start(void)
{
	IFX_SSW_CORE_VM_START(1,4);
    /* Call main function of CPU1 VM 4 */
    Ifx_Ssw_jumpToFunction(core1_vm4_main);
}

IFX_SSW_USED static void core1_vm5_start(void)
{
	IFX_SSW_CORE_VM_START(1,5);
    /* Call main function of CPU1 VM 5 */
    Ifx_Ssw_jumpToFunction(core1_vm5_main);
}

IFX_SSW_USED static void core1_vm6_start(void)
{
	IFX_SSW_CORE_VM_START(1,6);
    /* Call main function of CPU1 VM 6 */
    Ifx_Ssw_jumpToFunction(core1_vm6_main);
}

IFX_SSW_USED static void core1_vm7_start(void)
{
	IFX_SSW_CORE_VM_START(1,7);
    /* Call main function of CPU1 VM 7 */
    Ifx_Ssw_jumpToFunction(core1_vm7_main);
}



/******************************************************************************
 *                        reset vector address                                *
 *****************************************************************************/
#if defined(__TASKING__)
#pragma protect on
#pragma section code "start_cpu10"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu10" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu10"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu10" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu10" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu10"
#endif

IFX_SSW_USED void _START10(void)
{
	Ifx_Ssw_Start(__USTACK(1, 0), __Core1_start);
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
#pragma section code "start_cpu11"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu11" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu11"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu11" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu11" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu11"
#endif

IFX_SSW_USED void _START11(void)
{
    Ifx_Ssw_jumpToFunction(core1_vm1_start);
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
#pragma section code "start_cpu12"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu12" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu12"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu12" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu12" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu12"
#endif

IFX_SSW_USED void _START12(void)
{
    Ifx_Ssw_jumpToFunction(core1_vm2_start);
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
#pragma section code "start_cpu13"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu13" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu13"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu13" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu13" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu13"
#endif

IFX_SSW_USED void _START13(void)
{
    Ifx_Ssw_jumpToFunction(core1_vm3_start);
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
#pragma section code "start_cpu14"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu14" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu14"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu14" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu14" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu14"
#endif

IFX_SSW_USED void _START14(void)
{
    Ifx_Ssw_jumpToFunction(core1_vm4_start);
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
#pragma section code "start_cpu15"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu15" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu15"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu15" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu15" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu15"
#endif

IFX_SSW_USED void _START15(void)
{
    Ifx_Ssw_jumpToFunction(core1_vm5_start);
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
#pragma section code "start_cpu16"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu16" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu16"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu16" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu16" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu16"
#endif

IFX_SSW_USED void _START16(void)
{
    Ifx_Ssw_jumpToFunction(core1_vm6_start);
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
#pragma section code "start_cpu17"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu17" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu17"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu17" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu17" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu17"
#endif

IFX_SSW_USED void _START17(void)
{
    Ifx_Ssw_jumpToFunction(core1_vm7_start);
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

