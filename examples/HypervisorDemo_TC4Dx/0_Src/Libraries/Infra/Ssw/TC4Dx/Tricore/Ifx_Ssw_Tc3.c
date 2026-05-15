/**
 * \file Ifx_Ssw_Tc3.c
 * \brief Startup Software for Core3
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
#ifndef IFX_CFG_SSW_ENABLE_TRICORE3_PCACHE
#   define IFX_CFG_SSW_ENABLE_TRICORE3_PCACHE (1U)  /**< Program Cache enabled by default*/
#endif
#ifndef IFX_CFG_SSW_ENABLE_TRICORE3_DCACHE
#   define IFX_CFG_SSW_ENABLE_TRICORE3_DCACHE (1U)  /**< Data Cache enabled by default*/
#endif

/*******************************************************************************
**                      Imported Function Declarations                        **
*******************************************************************************/

IFX_SSW_COMMON_LINKER_SYMBOLS();
IFX_SSW_CORE_LINKER_SYMBOLS(3, 0);
IFX_SSW_CORE_LINKER_SYMBOLS(3, 1);
IFX_SSW_CORE_LINKER_SYMBOLS(3, 2);
IFX_SSW_CORE_LINKER_SYMBOLS(3, 3);
IFX_SSW_CORE_LINKER_SYMBOLS(3, 4);
IFX_SSW_CORE_LINKER_SYMBOLS(3, 5);
IFX_SSW_CORE_LINKER_SYMBOLS(3, 6);
IFX_SSW_CORE_LINKER_SYMBOLS(3, 7);

extern void core3_vm1_main(void);
extern void core3_vm2_main(void);
extern void core3_vm3_main(void);
extern void core3_vm4_main(void);
extern void core3_vm5_main(void);
extern void core3_vm6_main(void);
extern void core3_vm7_main(void);

#if defined(__TASKING__)
__asm("\t .extern core3_vm1_main");
__asm("\t .extern core3_vm2_main");
__asm("\t .extern core3_vm3_main");
__asm("\t .extern core3_vm4_main");
__asm("\t .extern core3_vm5_main");
__asm("\t .extern core3_vm6_main");
__asm("\t .extern core3_vm7_main");
#endif

/*******************************************************************************
**                      Prototypes & Externals                                **
*******************************************************************************/

IFX_SSW_WEAK void Ifx_Ssw_MultiCore_Sync_Cpu3(void)
{}

/*********************************************************************************
* - startup code
*********************************************************************************/

void __Core3_start(void)
{
    /* By default mapped to empty, skip only if configured */
    IFX_CFG_SSW_SKIP_STARTUP_ROUTINE(3);
    
    #if (IFX_PROT_ENABLED == 1U)
        IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU3.PROTSFRE), IfxSswProt_State_config);
    #endif
    /* Load Base Address of Trap Vector Table. */
    Ifx_Ssw_MTCR(CPU_BTV, (unsigned int)__TRAPTAB(3, 0));
    #if (IFX_PROT_ENABLED == 1U)
        IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU3.PROTSFRE), IfxSswProt_State_run);
    #endif


    /* Set the PSW to its reset value in case of a warm start,clear PSW.IS */
    Ifx_Ssw_MTCR(CPU_PSW, IFX_CFG_SSW_PSW_DEFAULT);

    {
        Ifx_CPU_PCON0 pcon0;
        pcon0.U       = 0;
        pcon0.B.PCBYP = IFX_CFG_SSW_ENABLE_TRICORE3_PCACHE ? 0 : 1; /*depending on the enable bypass bit is reset/set */
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU3.PROTSFRE), IfxSswProt_State_config);
        #endif
        Ifx_Ssw_MTCR(CPU_PCON0, pcon0.U);
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU3.PROTSFRE), IfxSswProt_State_run);
        #endif
    }

    {
        Ifx_CPU_DCON0 dcon0;
        dcon0.U       = 0;
        dcon0.B.DCBYP = IFX_CFG_SSW_ENABLE_TRICORE3_DCACHE ? 0 : 1; /*depending on the enable bypass bit is reset/set */
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU3.PROTSFRE), IfxSswProt_State_config);
        #endif
        Ifx_Ssw_MTCR(CPU_DCON0, dcon0.U);
        #if (IFX_PROT_ENABLED == 1U)
            IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU3.PROTSFRE), IfxSswProt_State_run);
        #endif
    }

    #if (IFX_PROT_ENABLED == 1U)
        IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU3.PROTSFRE), IfxSswProt_State_config);
    #endif
    /* Trap vector table for HV mode initialization is necessary when HV mode is enabled */
    Ifx_Ssw_MTCR(CPU_BHV, (unsigned int)__TRAPTABHV_CPU30);
    /* Load Base Address of Trap Vector Table. */
    Ifx_Ssw_MTCR(CPU_BTV, (unsigned int)__TRAPTAB(3, 0));

    /* Load Base Address of Interrupt Vector Table. we will do this later in the program */
    Ifx_Ssw_MTCR(CPU_BIV, (unsigned int)__INTTAB(3, 0));

    /* Load interrupt stack pointer. */
    Ifx_Ssw_MTCR(CPU_ISP, (unsigned int)__ISTACK(3, 0));
    #if (IFX_PROT_ENABLED == 1U)
         IfxSswProt_setState((Ifx_PROT_PROT *)&(MODULE_CPU3.PROTSFRE), IfxSswProt_State_run);
    #endif
    Ifx_Ssw_initCSA((unsigned int *)__CSA(3, 0), (unsigned int *)__CSA_END(3, 0));

    /* initialize SDA base pointers */
    Ifx_Ssw_setAddressReg(a0, __SDATA1(3));
    Ifx_Ssw_setAddressReg(a1, __SDATA2(3));
    Ifx_Ssw_setAddressReg(a8, __SDATA3(3));
    Ifx_Ssw_setAddressReg(a9, __SDATA4(3));

    /*Initialize CPU Private Global Variables*/
    volatile unsigned int tempVar = ((unsigned int)&__ENABLE_INDIVIDUAL_C_INIT_CPU3);
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
    Ifx_Ssw_MultiCore_Sync_Cpu3();

    /*Call Hypervisor Function */
    Ifx_Ssw_jumpToFunction(core3_vm0_start);
}


IFX_SSW_USED static void core3_vm1_start(void)
{
	IFX_SSW_CORE_VM_START(3,1);
    /* Call main function of CPU3 VM 1 */
    Ifx_Ssw_jumpToFunction(core3_vm1_main);
}

IFX_SSW_USED static void core3_vm2_start(void)
{
	IFX_SSW_CORE_VM_START(3,2);
    /* Call main function of CPU3 VM 2 */
    Ifx_Ssw_jumpToFunction(core3_vm2_main);
}

IFX_SSW_USED static void core3_vm3_start(void)
{
	IFX_SSW_CORE_VM_START(3,3);
    /* Call main function of CPU3 VM 3 */
    Ifx_Ssw_jumpToFunction(core3_vm3_main);
}

IFX_SSW_USED static void core3_vm4_start(void)
{
	IFX_SSW_CORE_VM_START(3,4);
    /* Call main function of CPU3 VM 4 */
    Ifx_Ssw_jumpToFunction(core3_vm4_main);
}

IFX_SSW_USED static void core3_vm5_start(void)
{
	IFX_SSW_CORE_VM_START(3,5);
    /* Call main function of CPU3 VM 5 */
    Ifx_Ssw_jumpToFunction(core3_vm5_main);
}

IFX_SSW_USED static void core3_vm6_start(void)
{
	IFX_SSW_CORE_VM_START(3,6);
    /* Call main function of CPU3 VM 6 */
    Ifx_Ssw_jumpToFunction(core3_vm6_main);
}

IFX_SSW_USED static void core3_vm7_start(void)
{
	IFX_SSW_CORE_VM_START(3,7);
    /* Call main function of CPU3 VM 7 */
    Ifx_Ssw_jumpToFunction(core3_vm7_main);
}



/******************************************************************************
 *                        reset vector address                                *
 *****************************************************************************/
#if defined(__TASKING__)
#pragma protect on
#pragma section code "start_cpu30"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu30" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu30"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu30" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu30" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu30"
#endif

IFX_SSW_USED void _START30(void)
{
	Ifx_Ssw_Start(__USTACK(3, 0), __Core3_start);
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
#pragma section code "start_cpu31"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu31" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu31"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu31" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu31" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu31"
#endif

IFX_SSW_USED void _START31(void)
{
    Ifx_Ssw_jumpToFunction(core3_vm1_start);
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
#pragma section code "start_cpu32"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu32" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu32"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu32" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu32" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu32"
#endif

IFX_SSW_USED void _START32(void)
{
    Ifx_Ssw_jumpToFunction(core3_vm2_start);
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
#pragma section code "start_cpu33"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu33" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu33"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu33" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu33" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu33"
#endif

IFX_SSW_USED void _START33(void)
{
    Ifx_Ssw_jumpToFunction(core3_vm3_start);
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
#pragma section code "start_cpu34"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu34" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu34"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu34" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu34" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu34"
#endif

IFX_SSW_USED void _START34(void)
{
    Ifx_Ssw_jumpToFunction(core3_vm4_start);
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
#pragma section code "start_cpu35"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu35" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu35"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu35" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu35" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu35"
#endif

IFX_SSW_USED void _START35(void)
{
    Ifx_Ssw_jumpToFunction(core3_vm5_start);
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
#pragma section code "start_cpu36"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu36" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu36"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu36" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu36" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu36"
#endif

IFX_SSW_USED void _START36(void)
{
    Ifx_Ssw_jumpToFunction(core3_vm6_start);
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
#pragma section code "start_cpu37"
#elif defined(__HIGHTEC__) && !defined(__clang__)
#pragma section
#pragma section ".start_cpu37" x
#elif defined(__HIGHTEC__) && defined(__clang__)
#pragma clang section text=".start_cpu37"
#elif defined(__GNUC__) && !defined(__HIGHTEC__)
#pragma section
#pragma section ".start_cpu37" x
#elif defined(__DCC__)
#pragma section CODE ".start_cpu37" X
#elif defined(__ghs__)
#pragma ghs section text=".start_cpu37"
#endif

IFX_SSW_USED void _START37(void)
{
    Ifx_Ssw_jumpToFunction(core3_vm7_start);
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

