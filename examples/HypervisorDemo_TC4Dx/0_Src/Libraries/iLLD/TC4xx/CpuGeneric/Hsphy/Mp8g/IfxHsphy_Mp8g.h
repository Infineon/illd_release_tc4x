/**
 * \file IfxHsphy_Mp8g.h
 * \brief HSPHY MP8G details
 * \ingroup IfxLld_Hsphy
 *
 * \copyright Copyright (c) 2026 Infineon Technologies AG. All rights reserved.
 *
 * $Date: 2025-07-30 13:43:07
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
 *
 * \defgroup IfxLld_Hsphy_Mp8g MP8G
 * \ingroup IfxLld_Hsphy
 * \defgroup IfxLld_Hsphy_Mp8g_Enumerations Enumerations
 * \ingroup IfxLld_Hsphy_Mp8g
 * \defgroup IfxLld_Hsphy_Mp8g_Data Structures Data Structures
 * \ingroup IfxLld_Hsphy_Mp8g
 * \defgroup IfxLld_Hsphy_Mp8g_Config Variable Config Variable
 * \ingroup IfxLld_Hsphy_Mp8g
 * \defgroup IfxLld_Hsphy_Mp8g_Functions Functions
 * \ingroup IfxLld_Hsphy_Mp8g
 */

#ifndef IFXHSPHY_MP8G_H
#define IFXHSPHY_MP8G_H 1

/******************************************************************************/
/*----------------------------------Includes----------------------------------*/
/******************************************************************************/

#include "Hsphy/Std/IfxHsphy.h"

/** \addtogroup IfxLld_Hsphy_Mp8g_Functions
 * \{ */

/******************************************************************************/
/*-------------------------Global Function Prototypes-------------------------*/
/******************************************************************************/

/** \brief Resets the HSPHY module and waits for the reset to complete.
 * \param hsphyRegPtr Pointer to the HSPHY register structure.
 * \return TRUE Indicates a timeout error occurred during the reset process.
 */
IFX_EXTERN boolean IfxHsphy_Mp8g_resetModule(Ifx_HSPHY *hsphyRegPtr);

/** \brief Sets the reference clock selection for the specified PHY device.
 * \param hsphyRegPtr Pointer to the HSPHY register structure.
 * \param phyIndex PHY index
 * \param device The target device type for which the reference clock is being set.
 * \return TRUE The reference clock selection was successfully configured.
 */
IFX_EXTERN boolean IfxHsphy_Mp8g_setPhyRefClockSel(Ifx_HSPHY *hsphyRegPtr, IfxHsphy_PhyIndex phyIndex, IfxHsphy_TrgtDevice device);

/** \brief Select the function of operation
 * \param hsphyRegPtr Pointer to the HSPHY register structure.
 * \param phyIndex PHY index
 * \param device Target device type to configure the HSPHY module for.
 * \return TRUE: Configuration was successful.
 *  FALSE: Function selection not succesful
 */
IFX_EXTERN boolean IfxHsphy_Mp8g_selFunction(Ifx_HSPHY *hsphyRegPtr, IfxHsphy_PhyIndex phyIndex, IfxHsphy_TrgtDevice device);

/** \brief Check if the PHY is ready after reset
 * \param hsphyRegPtr Pointer to the HSPHY register structure.
 * \param phyIndex PHY index
 * \return TRUE: The PHY is ready	FALSE:Error
 */
IFX_EXTERN boolean IfxHsphy_Mp8g_isPhyReady(Ifx_HSPHY *hsphyRegPtr, IfxHsphy_PhyIndex phyIndex);

/** \brief Check if the external loading of the application into SRAM is complete
 * \param hsphyRegPtr Pointer to the HSPHY register structure.
 * \param phyIndex PHY index
 * \return TRUE: Application SRAM loading complete	FALSE:Error
 */
IFX_EXTERN boolean IfxHsphy_Mp8g_setExtLdDone(Ifx_HSPHY *hsphyRegPtr, IfxHsphy_PhyIndex phyIndex);

/** \brief Power Down PHY
 * \param hsphySFR HPSHY pointer
 * \param phyIndex PHY index
 * \param phyPowerMode 0: PHY power up 1: PHY power down
 * \return None
 */
IFX_EXTERN void IfxHsphy_Mp8g_PowerDownReset(Ifx_HSPHY *hsphySFR, IfxHsphy_PhyIndex phyIndex, IfxHsphy_PhyPowerMode phyPowerMode);

/** \} */

#endif /* IFXHSPHY_MP8G_H */
