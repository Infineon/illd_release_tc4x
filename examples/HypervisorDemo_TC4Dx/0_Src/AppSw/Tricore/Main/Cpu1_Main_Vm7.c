/**
 * \file Cpu1_Main_Vm7.c
 * \brief Main function definition for Cpu core 1 , VM7.
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
#include "Ifx_Cfg.h"
#include "Ifx_Types.h"
#include "IfxCpu.h"
#include "IfxStm.h"
#include "IfxHv_CpuVmSched.h"
#if (IFX_DEBUG_PRINT == 1U)
#include "printf_to_tspi.h"
#endif

volatile unsigned int tc1_vm7_scheduler_ctr = 0u;
volatile unsigned int tc1_vm7_main_ctr      = 0u;
volatile unsigned int tc1_vm7_isr_ctr       = 0u;
IFX_INTERRUPT_FUNC void Cpu1_Vm7_Isr(void);

/*VM7 main function
 * 1. In case cooperative scheduling mode is selected: relinquish the control after some ticks
 * 2. In case Timer mode is selected : No action needed
 * 3. If VM7 ISR is enabled: initialize STM to trigger event for VM7 */
void core1_vm7_main(void)
{
#if (IFX_CFG_TC1_VM7_INT != 0U)
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
    stmCompareConfig.ticks           = (uint32)(IFX_VM7_INTERRUPT_INTERVAL * IfxHv_getStmFrequency());
    stmCompareConfig.triggerPriority = IFX_VM7_ISR_PRIORITY;
    stmCompareConfig.typeOfService   = IfxSrc_Tos_cpu1;
    stmCompareConfig.vmId            = IfxSrc_VmId_7;

    /* Initialize STM compare functionality */
    IfxStm_initCompare(&MODULE_CPU1, &stmCompareConfig);
#endif

    while (1)
    {
        tc1_vm7_main_ctr++;
        tc1_vm7_scheduler_ctr++;
#if (IFX_DEBUG_PRINT == 1U)

#if (IFX_CFG_TC1_VM7_INT != 0U)
        printf("TC1 VM7 isr Counter is %d\n", tc1_vm7_isr_ctr);
#else
        printf("TC1 VM7 main Counter is %d\n", tc1_vm7_main_ctr);
#endif
#endif

#if (IFX_CFG_HV1_TIME_BASED_SCHD == 0U)

        if (tc1_vm7_scheduler_ctr > 50u)
        {
            tc1_vm7_scheduler_ctr = 0u;
            Ifx__hvcall(7);
        }

#endif
    }
}


/* ISR for STM1 event on VM7
 * 1. Reload the STM1 timer value for next event
 * 2. Increment VM7 ISR counter value */
#if (IFX_CFG_TC1_VM7_INT != 0U)
IFX_INTERRUPT_VM(Cpu1_Vm7_Isr, IFX_CFG_INT_TC1, IFX_CFG_INT_VM7, IFX_VM7_ISR_PRIORITY)
{
    uint32 stmTicks;
    stmTicks = (uint32)(IFX_VM7_INTERRUPT_INTERVAL * IfxHv_getStmFrequency());
    IfxStm_updateCompare(&MODULE_CPU1, IfxStm_Comparator_0, (uint32)IfxStm_get(&MODULE_CPU1) + stmTicks);

    tc1_vm7_isr_ctr += 1u;
}
#endif
