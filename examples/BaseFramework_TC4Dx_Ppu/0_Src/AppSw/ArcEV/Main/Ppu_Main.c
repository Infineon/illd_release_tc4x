/**********************************************************************************************************************
 * \file Ppu_Main.c
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
 *********************************************************************************************************************/

#include "Ifx_Types.h"
#include "TricoreInterface.h"
#if defined(__arc__)
#include "speed_aux.h"
#endif

volatile uint32* PpuMemCounter = (volatile uint32*)(0xB2090000);
volatile uint32* PpuMemHandshake = (volatile uint32*)(0xB2090004);

uint32 counterPpu = 0u;

int main(void)
{
	/* disable MPU protection of the PPU */
#if defined(__arc__)
    speed_hal_aux_Reg mpu_reg;
    mpu_reg.addr = 0x409;
    speed_hal_aux_Store( 0x0, mpu_reg );
#endif

    /* Notifies CPU0 that PPU is booted up */
    TriCoreInterface_flagPpuBootedUp();

    *PpuMemHandshake = 0xBA55BA55;

    while(1)
    {
        counterPpu++;
       *PpuMemCounter = *PpuMemCounter + 1;
    }
    return 0;
}



