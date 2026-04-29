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
#define IFX_CFG_H                       1
/******************************************************************************/

/*______________________________________________________________________________
** Configuration for IfxClock_cfg.h
**____________________________________________________________________________*/
#define IFX_CFG_CLOCK_XTAL_FREQUENCY		(25000000)	/**< default supported: 25000000, 20000000, 10000000 */
#define IFX_CFG_CLOCK_SYSPLL_FREQUENCY		(500000000) /**< default supported: 400000000 */
#define IFX_CFG_CLOCK_PPUPLL_FREQUENCY		(450000000) /**< default supported: If SYSPLL = 400MHz  PPUPLL = 400MHz, If SYSPLL = 500MHz  PPUPLL = 450MHz*/
#define IFX_CFG_CLOCK_PERPLL1_FREQUENCY		(160000000) /**< default supported: 160000000 */
#define IFX_CFG_CLOCK_PERPLL2_FREQUENCY		(200000000) /**< default supported: 200000000 */
#define IFX_CFG_CLOCK_PERPLL3_FREQUENCY		(200000000) /**< default supported: 200000000 */

#define SYSCON_PROT_ENABLE              (0x2U)

#define IFX_CFG_EXTEND_HV_TRAP_HOOKS    1

/* Enable/disable the prints */
#define IFX_DEBUG_PRINT                 (0U)

/* Priority for the HV */
#define IFX_VM0_SCHD_PRIORITY           10

/* INT priority for the VM1 and VM2 */
#define IFX_VM1_ISR_PRIORITY            8
#define IFX_VM2_ISR_PRIORITY            7
#define IFX_VM3_ISR_PRIORITY            6
#define IFX_VM4_ISR_PRIORITY            5
#define IFX_VM5_ISR_PRIORITY            4
#define IFX_VM6_ISR_PRIORITY            3
#define IFX_VM7_ISR_PRIORITY            2

/* VMs execution time configuration */
/* The interval is to be given in seconds */

#define IFX_CORE0_VM1_EXECUTION_TIME    (0.0018)
#define IFX_CORE0_VM2_EXECUTION_TIME    (0.0036)
#define IFX_CORE0_VM3_EXECUTION_TIME    (0.0054)
#define IFX_CORE0_VM4_EXECUTION_TIME    (0.0072)
#define IFX_CORE0_VM5_EXECUTION_TIME    (0.0090)
#define IFX_CORE0_VM6_EXECUTION_TIME    (0.0108)
#define IFX_CORE0_VM7_EXECUTION_TIME    (0.0126)

#define IFX_CORE1_VM1_EXECUTION_TIME    (0.0018)
#define IFX_CORE1_VM2_EXECUTION_TIME    (0.0036)
#define IFX_CORE1_VM3_EXECUTION_TIME    (0.0054)
#define IFX_CORE1_VM4_EXECUTION_TIME    (0.0072)
#define IFX_CORE1_VM5_EXECUTION_TIME    (0.0090)
#define IFX_CORE1_VM6_EXECUTION_TIME    (0.0108)
#define IFX_CORE1_VM7_EXECUTION_TIME    (0.0126)

#define IFX_CORE2_VM1_EXECUTION_TIME    (0.0018)
#define IFX_CORE2_VM2_EXECUTION_TIME    (0.0036)
#define IFX_CORE2_VM3_EXECUTION_TIME    (0.0054)
#define IFX_CORE2_VM4_EXECUTION_TIME    (0.0072)
#define IFX_CORE2_VM5_EXECUTION_TIME    (0.0090)
#define IFX_CORE2_VM6_EXECUTION_TIME    (0.0108)
#define IFX_CORE2_VM7_EXECUTION_TIME    (0.0126)

#define IFX_CORE3_VM1_EXECUTION_TIME    (0.0018)
#define IFX_CORE3_VM2_EXECUTION_TIME    (0.0036)
#define IFX_CORE3_VM3_EXECUTION_TIME    (0.0054)
#define IFX_CORE3_VM4_EXECUTION_TIME    (0.0072)
#define IFX_CORE3_VM5_EXECUTION_TIME    (0.0090)
#define IFX_CORE3_VM6_EXECUTION_TIME    (0.0108)
#define IFX_CORE3_VM7_EXECUTION_TIME    (0.0126)

#define IFX_CORE4_VM1_EXECUTION_TIME    (0.0018)
#define IFX_CORE4_VM2_EXECUTION_TIME    (0.0036)
#define IFX_CORE4_VM3_EXECUTION_TIME    (0.0054)
#define IFX_CORE4_VM4_EXECUTION_TIME    (0.0072)
#define IFX_CORE4_VM5_EXECUTION_TIME    (0.0090)
#define IFX_CORE4_VM6_EXECUTION_TIME    (0.0108)
#define IFX_CORE4_VM7_EXECUTION_TIME    (0.0126)

#define IFX_CORE5_VM1_EXECUTION_TIME    (0.0018)
#define IFX_CORE5_VM2_EXECUTION_TIME    (0.0036)
#define IFX_CORE5_VM3_EXECUTION_TIME    (0.0054)
#define IFX_CORE5_VM4_EXECUTION_TIME    (0.0072)
#define IFX_CORE5_VM5_EXECUTION_TIME    (0.0090)
#define IFX_CORE5_VM6_EXECUTION_TIME    (0.0108)
#define IFX_CORE5_VM7_EXECUTION_TIME    (0.0126)

/* The interval is to be given in seconds */
#define IFX_VM1_INTERRUPT_INTERVAL      (0.0003)
#define IFX_VM2_INTERRUPT_INTERVAL      (0.0003)
#define IFX_VM3_INTERRUPT_INTERVAL      (0.0003)
#define IFX_VM4_INTERRUPT_INTERVAL      (0.0003)
#define IFX_VM5_INTERRUPT_INTERVAL      (0.0003)
#define IFX_VM6_INTERRUPT_INTERVAL      (0.0003)
#define IFX_VM7_INTERRUPT_INTERVAL      (0.0003)

/* Enable/Disable the interrupt use */
#define IFX_CFG_HV0_TIME_BASED_SCHD     (1U)
#define IFX_CFG_HV1_TIME_BASED_SCHD     (1U)
#define IFX_CFG_HV2_TIME_BASED_SCHD     (1U)
#define IFX_CFG_HV3_TIME_BASED_SCHD     (1U)
#define IFX_CFG_HV4_TIME_BASED_SCHD     (1U)
#define IFX_CFG_HV5_TIME_BASED_SCHD     (1U)

/* Switch to enable and disable interrupt (except scheduler interrupt in HV) usage
 * in VM1 and VM2*/
#define IFX_CFG_TC0_VM1_INT             (1U)
#define IFX_CFG_TC0_VM2_INT             (1U)
#define IFX_CFG_TC0_VM3_INT             (1U)
#define IFX_CFG_TC0_VM4_INT             (1U)
#define IFX_CFG_TC0_VM5_INT             (1U)
#define IFX_CFG_TC0_VM6_INT             (1U)
#define IFX_CFG_TC0_VM7_INT             (1U)
#define IFX_CFG_TC1_VM1_INT             (1U)
#define IFX_CFG_TC1_VM2_INT             (1U)
#define IFX_CFG_TC1_VM3_INT             (1U)
#define IFX_CFG_TC1_VM4_INT             (1U)
#define IFX_CFG_TC1_VM5_INT             (1U)
#define IFX_CFG_TC1_VM6_INT             (1U)
#define IFX_CFG_TC1_VM7_INT             (1U)
#define IFX_CFG_TC2_VM1_INT             (1U)
#define IFX_CFG_TC2_VM2_INT             (1U)
#define IFX_CFG_TC2_VM3_INT             (1U)
#define IFX_CFG_TC2_VM4_INT             (1U)
#define IFX_CFG_TC2_VM5_INT             (1U)
#define IFX_CFG_TC2_VM6_INT             (1U)
#define IFX_CFG_TC2_VM7_INT             (1U)
#define IFX_CFG_TC3_VM1_INT             (1U)
#define IFX_CFG_TC3_VM2_INT             (1U)
#define IFX_CFG_TC3_VM3_INT             (1U)
#define IFX_CFG_TC3_VM4_INT             (1U)
#define IFX_CFG_TC3_VM5_INT             (1U)
#define IFX_CFG_TC3_VM6_INT             (1U)
#define IFX_CFG_TC3_VM7_INT             (1U)
#define IFX_CFG_TC4_VM1_INT             (1U)
#define IFX_CFG_TC4_VM2_INT             (1U)
#define IFX_CFG_TC4_VM3_INT             (1U)
#define IFX_CFG_TC4_VM4_INT             (1U)
#define IFX_CFG_TC4_VM5_INT             (1U)
#define IFX_CFG_TC4_VM6_INT             (1U)
#define IFX_CFG_TC4_VM7_INT             (1U)
#define IFX_CFG_TC5_VM1_INT             (1U)
#define IFX_CFG_TC5_VM2_INT             (1U)
#define IFX_CFG_TC5_VM3_INT             (1U)
#define IFX_CFG_TC5_VM4_INT             (1U)
#define IFX_CFG_TC5_VM5_INT             (1U)
#define IFX_CFG_TC5_VM6_INT             (1U)
#define IFX_CFG_TC5_VM7_INT             (1U)

/******************************************************************************/

#define IFX_CFG_SSW_ENABLE_TRICORE1     (1U)
#define IFX_CFG_SSW_ENABLE_TRICORE2     (1U)
#define IFX_CFG_SSW_ENABLE_TRICORE3     (1U)
#define IFX_CFG_SSW_ENABLE_TRICORE4     (1U)
#define IFX_CFG_SSW_ENABLE_TRICORE5     (1U)

#define IFX_CFG_EXTEND_HVTRAP_HOOKS


#define DEVICE_TC4DX			1

#endif /* IFX_CFG_H */
