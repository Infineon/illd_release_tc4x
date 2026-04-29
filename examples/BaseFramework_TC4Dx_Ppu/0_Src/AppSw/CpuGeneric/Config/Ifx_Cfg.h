/**
 * \file Ifx_Cfg.h
 * \brief Project configuration file.
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

#ifndef IFX_CFG_H
#define IFX_CFG_H 1
/******************************************************************************/

/*______________________________________________________________________________
** Configuration for IfxClock_cfg.h
**____________________________________________________________________________*/
#define IFX_CFG_CLOCK_XTAL_FREQUENCY		(25000000)	/**< default supported: 40000000, 25000000, 20000000, 16000000 */
#define IFX_CFG_CLOCK_SYSPLL_FREQUENCY		(500000000) /**< default supported: 300000000, 200000000, 160000000, 133000000, 80000000 */
#define IFX_CFG_CLOCK_PPUPLL_FREQUENCY		(450000000) /**< default supported: If SYSPLL = 400MHz  PPUPLL = 400MHz, If SYSPLL = 500MHz  PPUPLL = 450MHz*/
#define IFX_CFG_CLOCK_PERPLL1_FREQUENCY		(160000000) /**< default supported: 320000000, 160000000 */
#define IFX_CFG_CLOCK_PERPLL2_FREQUENCY		(200000000) /**< default supported: 200000000 */
#define IFX_CFG_CLOCK_PERPLL3_FREQUENCY		(200000000) /**< default supported: 200000000 */

/*______________________________________________________________________________
** Configuration for Software managed interrupt
**____________________________________________________________________________*/

// #define IFX_PROT_ENABLED 1
//#define IFX_USE_SW_MANAGED_INT

#define IFX_STM_RESOULTION IFX_CFG_CLOCK_SYSPLL_FREQUENCY

#define IFX_CFG_INTERRUPT_INTERVAL (0.003)

#define IFX_CFG_CPU0_PRIO 10
#define IFX_CFG_CPU1_PRIO 10
#define IFX_CFG_CPU2_PRIO 10
#define IFX_CFG_CPU3_PRIO 10
#define IFX_CFG_CPU4_PRIO 10
#define IFX_CFG_CPU5_PRIO 10

//#define IFX_CFG_EXTEND_TRAP_HOOKS

/******************************************************************************/

//#define IFX_VP_DEBUG_PRINT   1u

#define DEVICE_TC4DX			1


#if defined(__CARC__) || defined (__arc__)
#define IFX_PPU_BUILD
#else
#undef IFX_PPU_BUILD
#endif

/******************************************************************************/

#endif /* IFX_CFG_H */
