/**
 * \file main.c
 * \brief Main function definition for Cpu: SCR.
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

/* TODO: To be updated with the iLLD driver code */

#include "IfxScr_reg.h"
#include "Cpu/Std/IfxScrCpuIrq.h"
#include "Scu/Std/IfxScrScu.h"
#include "Port/Std/IfxScrPort.h"
#include "Rtc/Std/IfxScrRtc.h"

#define PORT0 IfxScrPort_Index_00
#define PIN1  IfxScrPort_PinIndex_1
#define __INTNO(nr) ((8*nr)+3)

volatile __xdata unsigned char rtc_flag    __at(0x700C);

void __interrupt(__INTNO(13)) rtc_interrupt(void)
{
	IfxScrPort_togglePinState(PORT0, PIN1); //Toggle port P33.0
	rtc_flag++;
}

void main(void)
{
    uint8 i = 0;
    IfxScrRtc_Config Rtc_Config;	//RTC

    IfxScrCpuIrq_sendMessageToTricore(0xEE);
    //disable bit protection scheme(PASSWD.MODE = 00b)
    IfxScrScu_disableBitProtectionScheme();

    //Enable the global Interrupt
    IfxScrCpuIrq_enableGlobalInterrupt();

    while(IfxScrCpuIrq_readMessageFromTricore() != 0xAA);
    IfxScrCpuIrq_sendMessageToTricore(0xBB);

    /* Port configuration P33.1 */
    {
    	IfxScrPort_enablePortPad(PORT0, PIN1);//Enable SCR_P0.0 (P33.0) portpad
    	IfxScrPort_configurePortControl(PORT0, PIN1, IfxScrPort_IoControl_output_pushpullGpio);//Configure SCR_P0.0 (P33.0)
    }

	//Enable RTC module
    {
		IfxScrScu_enableModule(IfxScrScu_Module_rtc);
		//Enable RTC Interrupt
		IfxScrCpuIrq_enableInterruptNode(IfxScrCpuIrq_InterruptNode_rtc);

		//Configure RTC
		Rtc_Config.clockSource = IfxScrRtc_ClockSel_pclk;//IfxScrRtc_ClockSel_70Khz;
		Rtc_Config.bypassPrescaler = 0x1;
		Rtc_Config.enableInterruptOnCompare = 0x1;
		Rtc_Config.initialCountValue = 0x00000000;
		Rtc_Config.compareValue = 0x114E20;
		IfxScrRtc_initModule(&Rtc_Config);
		//Start RTC
		IfxScrRtc_enableRtc();
    }

    while(1)
    {
    	// Toggle Pin
    	IfxScrCpuIrq_sendMessageToTricore(i++);
    }

}
