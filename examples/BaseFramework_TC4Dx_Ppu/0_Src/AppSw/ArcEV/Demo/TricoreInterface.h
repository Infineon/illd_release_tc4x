/**********************************************************************************************************************
 * \file TricoreInterface.h
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

#ifndef TRICOREINTERFACE_H_
#define TRICOREINTERFACE_H_

/*********************************************************************************************************************/
/*-----------------------------------------------------Includes------------------------------------------------------*/
/*********************************************************************************************************************/
#include "IfxSrc.h"

/*********************************************************************************************************************/
/*------------------------------------------------------Macros-------------------------------------------------------*/
/*********************************************************************************************************************/

/*********************************************************************************************************************/
/*-------------------------------------------------Global variables--------------------------------------------------*/
/*********************************************************************************************************************/

/*********************************************************************************************************************/
/*-------------------------------------------------Data Structures---------------------------------------------------*/
/*********************************************************************************************************************/

/*********************************************************************************************************************/
/*--------------------------------------------Private Variables/Constants--------------------------------------------*/
/*********************************************************************************************************************/

/*********************************************************************************************************************/
/*------------------------------------------------Function Prototypes------------------------------------------------*/
/*********************************************************************************************************************/
/** \brief API to signal to TC.
 * This is done by triggering the TC General Purpose interrupt up.
 * TC is configured to receive the interrupt (or poll), then such communication is established.
 */
IFX_INLINE void TriCoreInterface_signalToTc(void)
{
    /* Wait until PPU takes up last signal */
    while(IfxSrc_isRequested(&MODULE_SRC.GPSR[0].SR0));
    IfxSrc_setRequest(&MODULE_SRC.GPSR[0].SR0);
}

/** \brief API to signal that PPU bootup is done.
 * This is done by triggering the PPUC Inter core communication interrupt up.
 * If one of the TriCores are configured to receive the interrupt (or poll),
 * then such communication is established.
 */
IFX_INLINE void TriCoreInterface_flagPpuBootedUp(void)
{
    TriCoreInterface_signalToTc();
}

IFX_INLINE boolean TriCoreInterface_acknowledgeTcSignal(void)
{
    boolean requested= IfxSrc_isRequested(&MODULE_SRC.PPU.ICI);
    if(requested)
    {
        IfxSrc_clearRequest(&MODULE_SRC.PPU.ICI);
    }
    return requested;
}

#endif /* TRICOREINTERFACE_H_ */
