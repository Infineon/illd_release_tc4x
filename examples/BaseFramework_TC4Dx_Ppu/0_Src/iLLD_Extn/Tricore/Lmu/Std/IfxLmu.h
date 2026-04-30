/**
 * \file IfxLmu.h
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

#ifndef IFXLMU_H_
#define IFXLMU_H_

/*********************************************************************************************************************/
/*-----------------------------------------------------Includes------------------------------------------------------*/
/*********************************************************************************************************************/
#include "Ifx_Types.h"
#include "IfxLmu_reg.h"
#include "IfxApProt.h"          //This file is only required for the user to configure the tagids

/*********************************************************************************************************************/
/*------------------------------------------------------Macros-------------------------------------------------------*/
/*********************************************************************************************************************/

/*********************************************************************************************************************/
/*-------------------------------------------------Global variables--------------------------------------------------*/
/*********************************************************************************************************************/

/*********************************************************************************************************************/
/*-------------------------------------------------Data Structures---------------------------------------------------*/
/*********************************************************************************************************************/
 typedef struct
{
    uint64 enableTagBits;
    uint8  enableVmBits;
    uint8  enablePrsBits;
} IfxLmu_Masters;

typedef struct
{
    void          *startAddress;     /**< Start address of region shall be beginning of 64 byte aligned block */
    void          *endAddress;       /**< End address of region shall be end of 64 byte aligned block */
    IfxLmu_Masters wMasters;
    IfxLmu_Masters rMasters;
} IfxLmu_Region;

typedef struct
{
    Ifx_LMU        *module;
    IfxLmu_Region  *regions;         /**< Up to 16 regions */
    uint8           numRegions;
}IfxLmu_ProtectionConfig;
/*********************************************************************************************************************/
/*--------------------------------------------Private Variables/Constants--------------------------------------------*/
/*********************************************************************************************************************/

/*********************************************************************************************************************/
/*------------------------------------------------Function Prototypes------------------------------------------------*/
/*********************************************************************************************************************/
void IfxLmu_configProtection(const IfxLmu_ProtectionConfig *config);

#endif /* IFXLMU_H_ */
