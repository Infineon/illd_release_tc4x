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
#include "Cpu/Std/IfxCpu.h"
#include "IfxPort_reg.h"
#include "IfxPms_reg.h"
#include "Pms/Std/IfxPmsPm.h"
extern const unsigned int scrProgramSize;
extern const unsigned char scrProgram[];

volatile uint32 counter0=0U;


void core0_main (void)
{
    uint32 *addrPtr;
    /*
     * !!WATCHDOG0 AND SAFETY WATCHDOG ARE DISABLED HERE!!
     * Enable the watchdog in the demo if it is required and also service the watchdog periodically
     * */
	IfxWtu_disableCpuWatchdog(IfxWtu_getCpuWatchdogPassword());
	IfxWtu_disableSystemWatchdog(IfxWtu_getSystemWatchdogPassword());

    IfxCpu_enableInterrupts();

	// Assigning Port to SCR
    {
		P32_PCSRSEL.U=0x000000F4;
		P33_PCSRSEL.U=0x0000FFFE;
		P34_PCSRSEL.U=0x0000003E;
    }

    /* SCR initialization */
    {
		addrPtr = PMS_XRAM;
		/* clear xram memory */
		while((uint32)addrPtr <= (uint32)0xF0247FFF)
		{
			*addrPtr = 0u;
			addrPtr++;
		}

		// SCR initialization
		IfxPmsPm_MemoryConfig memCfg = {&scrProgram, PMS_XRAM, scrProgramSize};
		IfxPmsPm_initScr(IfxPmsPm_ScrBootMode_userMode, FALSE, &memCfg);
		IfxPmsPm_resetScr(&MODULE_PMS);
    }

    /* Handshake between SCR and Tricore */
    IfxPmsPm_sendMessageToScr(&MODULE_PMS, 0xAA);  /* Send AA to Tricore */

    /* Wait until 0xBB is received from SCR */
    while(0xBB != IfxPmsPm_readMessageFromScr(&MODULE_PMS));

    while (1)
    {
    	counter0++;
    }
}

#if defined(__HIGHTEC__) && defined(__clang__)
void _exit(int a)
{
	while(1);
} 
#endif