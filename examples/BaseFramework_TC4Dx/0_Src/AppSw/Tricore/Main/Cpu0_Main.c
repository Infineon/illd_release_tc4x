/**
 * \file Cpu0_Main.c
 * \brief Main function definition for Cpu core 0 .
 *
 * \copyright Copyright (c) 2026 Infineon Technologies AG. All rights reserved.
 *
 *
 *                                 IMPORTANT NOTICE
 *
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

#include "Ifx_Types.h"
#include "Ifx_Cfg.h"
#include "IfxStm.h"
#include "IfxWtu.h"
#include "Ifx_reg.h"
#include "Ifx_Cfg_Ssw.h"

volatile uint32 counter0=0U;
volatile uint32 counterint0=0U;


#if !defined(IFX_CFG_SSW_RETURN_FROM_MAIN)
void core0_main (void)
{
#else
int core0_main (void)
{
#endif
    /*
     * !!WATCHDOG0 IS DISABLED HERE!!
     * Enable the watchdog in the demo if it is required and also service the watchdog periodically
     * */
	IfxWtu_disableCpuWatchdog(IfxWtu_getCpuWatchdogPassword());
	IfxWtu_disableSystemWatchdog(IfxWtu_getSystemWatchdogPassword());

	/* Enable interrupts by setting the IE bit */
	IfxCpu_enableInterrupts();

	/* STM configuration handler */
	IfxStm_CompareConfig stmCompareConfig;

	/* Call the constructor of configuration
	 * Step 1 : Load the default configuration
	 * Step 2 : Modify the configuration parameters
	 * Step 3 : Initialize the STM with the configuration
	 * In the default configuration STM, Comparator0 is used
	 */
	IfxStm_initCompareConfig(&stmCompareConfig);
	stmCompareConfig.ticks	         = (uint32)(IFX_CFG_INTERRUPT_INTERVAL * IFX_STM_RESOULTION);
	stmCompareConfig.triggerPriority = IFX_CFG_CPU0_PRIO;
	stmCompareConfig.typeOfService   = IfxSrc_Tos_cpu0;
	/* When Virtulization is disabled SRC.VM needs to be always configured with zero */
	stmCompareConfig.vmId		     = IfxSrc_VmId_0;

	/* Initialize STM compare functionality */
	IfxStm_initCompare(&MODULE_CPU0, &stmCompareConfig);


#if !defined(IFX_CFG_SSW_RETURN_FROM_MAIN)
    while (1)
    {
    	counter0++;
    }
#else
	return 0;
#endif

}

IFX_INTERRUPT(cpu0_isr,0,IFX_CFG_CPU0_PRIO)
{
	uint32 stmTicks;
	stmTicks = (uint32)(IFX_CFG_INTERRUPT_INTERVAL * IFX_STM_RESOULTION);
    IfxStm_updateCompare(&MODULE_CPU0, IfxStm_Comparator_0, (uint32)IfxStm_get(&MODULE_CPU0) + stmTicks);
	counterint0++;
}

#if defined(__HIGHTEC__) && defined(__clang__)
void _exit(int a)
{
	while(1);
} 
#endif
