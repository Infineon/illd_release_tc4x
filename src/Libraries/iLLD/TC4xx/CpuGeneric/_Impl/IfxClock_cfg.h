/**
 * \file IfxClock_cfg.h
 * \brief CLOCK on-chip implementation data 
 * \ingroup IfxLld_Clock 
 *
 * \version iLLD-TC4-v2.7.0
 * \copyright Copyright (c) 2026 Infineon Technologies AG. All rights reserved.
 *
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
 * \defgroup IfxLld_Clock CLOCK
 * \ingroup IfxLld
 * \defgroup IfxLld_Clock_Impl Implementation
 * \ingroup IfxLld_Clock
 * \defgroup IfxLld_Clock_Std Standard Driver
 * \ingroup IfxLld_Clock
 */

#ifndef IFXCLOCK_CFG_H
#define IFXCLOCK_CFG_H 1

/******************************************************************************/
/*----------------------------------Includes----------------------------------*/
/******************************************************************************/

#include "Ifx_Cfg.h"

#if defined DEVICE_TC4DX
#include "TC4Dx/IfxClock_cfg_TC4Dx.h"
#endif

/* Default OSCCON.MODE value used when IFX_CFG_CLOCK_EXT_CLOCK is 0. */
/* This allows the oscillator mode to be selected via configuration (IfxClock_Config.oscConModeVal) */
/* without relying on the IFX_CFG_CLOCK_EXT_CLOCK compile switch. */
#ifndef IFX_CFG_CLOCK_OSCCON_MODE
#    define IFX_CFG_CLOCK_OSCCON_MODE 0U /**< \brief Default OSCCON.MODE (0: oscillator enabled) */
#endif
#endif /* IFXCLOCK_CFG_H */
