/**
 * \file IfxLmu.c
 * \brief This file contains the APIs for Trap related functions.
 *
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
 *
 */


/*********************************************************************************************************************/
/*-----------------------------------------------------Includes------------------------------------------------------*/
/*********************************************************************************************************************/

#include "IfxLmu.h"
#include "IfxApApu.h"

/*********************************************************************************************************************/
/*-------------------------------------------------Global variables--------------------------------------------------*/
/*********************************************************************************************************************/

/*********************************************************************************************************************/
/*--------------------------------------------Private Variables/Constants--------------------------------------------*/
/*********************************************************************************************************************/

/*********************************************************************************************************************/
/*------------------------------------------------Function Prototypes------------------------------------------------*/
/*********************************************************************************************************************/

/*********************************************************************************************************************/
/*---------------------------------------------Function Implementations----------------------------------------------*/
/*********************************************************************************************************************/
void IfxLmu_configProtection(const IfxLmu_ProtectionConfig *config)
{
    int region;
    for(region= 0; region <= config->numRegions; region++)
    {
        IfxApApu_ApuConfig apuConfig=
        {
            .wraTagId= (uint32)config->regions[region].wMasters.enableTagBits,
            .wrbTagId= (uint32)(config->regions[region].wMasters.enableTagBits >> 32),
            .rdaTagId= (uint32)config->regions[region].rMasters.enableTagBits,
            .rdbTagId= (uint32)(config->regions[region].rMasters.enableTagBits >> 32),
            .vmWrId= config->regions[region].wMasters.enableVmBits,
            .vmRdId= config->regions[region].rMasters.enableVmBits,
            .prsWrId= config->regions[region].wMasters.enablePrsBits,
            .prsRdId= config->regions[region].rMasters.enablePrsBits
        };

        IfxApApu_ApuMemoryConfig memConfig=
        {
            .apuConfig= &apuConfig,
            .rgnlaVal= (uint32)config->regions[region].startAddress & 0xDFFFFFC0U,
            .rgnuaVal= (uint32)config->regions[region].endAddress & 0xDFFFFFC0U
        };

        IfxApApu_configMemoryAccess((Ifx_ACCEN_ACCEN *)&config->module->ACCENCFG, &memConfig, (Ifx_PROT_PROT *)&config->module->PROTRGN, (uint8)region);
    }
}

