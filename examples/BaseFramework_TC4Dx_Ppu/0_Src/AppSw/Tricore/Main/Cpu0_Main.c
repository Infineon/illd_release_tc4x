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
#include "IfxCpu.h"
#include "IfxWtu.h"
#include "PpuInterface.h"
#include "IfxCpu_Trap.h"

volatile uint32 counterCpu0= 0;

void core0_main(void)
{
    /*
     * !!WATCHDOG0 IS DISABLED HERE!!
     * Enable the watchdog in the demo if it is required and also service the watchdog periodically
     * */
	IfxWtu_disableCpuWatchdog(IfxWtu_getCpuWatchdogPassword());
	IfxWtu_disableSystemWatchdog(IfxWtu_getSystemWatchdogPassword());

	/* Enable interrupts by setting the IE bit */
	IfxCpu_enableInterrupts();

    /* Start up the PPU */
    PpuInterface_startPpu();

    while(1)
    {
        counterCpu0++;
    }
}

#if defined(__HIGHTEC__) && defined(__clang__)
void _exit(int a)
{
	while(1);
} 
#endif