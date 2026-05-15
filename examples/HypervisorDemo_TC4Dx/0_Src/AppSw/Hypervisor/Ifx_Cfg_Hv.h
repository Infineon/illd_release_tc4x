/**
 * \file Ifx_Cfg_Hv.h
 * \brief Configuration of MPU ranges for HV.
 *
 * \copyright Copyright (c) 2026 Infineon Technologies AG. All rights reserved.
 *
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
 */
#ifndef IFX_CFG_HV_H_
#define IFX_CFG_HV_H_

#include "Ifx_Cfg.h"
#include "Ifx_Cfg_Mpu.h"
#include "IfxHv_Intrinsics.h"


#ifndef IFX_CFG_HV_PSW_DEFAULT
#define IFX_CFG_HV_PSW_DEFAULT     (0x00000980u)
#endif

extern const VmMpuRangeType HvMpuConfig;
extern const VmMpuRangeType Hv_Vm1MpuConfig;
extern const VmMpuRangeType Hv_Vm2MpuConfig;
extern const VmMpuRangeType Hv_Vm3MpuConfig;
extern const VmMpuRangeType Hv_Vm4MpuConfig;
extern const VmMpuRangeType Hv_Vm5MpuConfig;
extern const VmMpuRangeType Hv_Vm6MpuConfig;
extern const VmMpuRangeType Hv_Vm7MpuConfig;

/** \brief Comparator Configuration Structure
 */
typedef struct
{
    float32                     timeInSec;                 /**< \brief time for next comparison from current timer count. */
    uint8                       compareOffset;             /**< \brief Comparator start bit position  defined in STMx.CMCON.B.MSTART0(x = 0,1,2). */
    uint8                       compareSize;               /**< \brief Size of compare value to compare with timer defined in STMx.CMCON.B.MSIZE0(x = 0,1,2). */
    uint8                       triggerPriority;           /**< \brief Interrupt priority. Range = 0 .. 255. 0 = interrupt is disabled. */
    uint8                       typeOfService;             /**< \brief Type of service. */
	uint8                       comparator;                /**< \brief Comparator Id defined in STMx.ISCR.B.CMP0IRR(x = 0, 1, 2). */
    uint8                       comparatorInterrupt;       /**< \brief Comparator Interrupt request source defined in SRx (x =0, 1). */
    uint8                       comparison;                /**< \brief Compare with Relative or Absolute timer */
    uint8                       vmId;                      /**< \brief Virtual Machine number */
} IfxHv_StmCompareConfig;


/** \brief Interrupt threshold Config
 */
typedef struct
{
    uint8                       vm1ThresholdVal;         /**< \brief VM1 Threshold Value */
    uint8                       vm2ThresholdVal;         /**< \brief VM1 Threshold Value */
    uint8                       vm3ThresholdVal;         /**< \brief VM1 Threshold Value */
    uint8                       vm4ThresholdVal;         /**< \brief VM1 Threshold Value */
    uint8                       vm5ThresholdVal;         /**< \brief VM1 Threshold Value */
    uint8                       vm6ThresholdVal;         /**< \brief VM1 Threshold Value */
    uint8                       vm7ThresholdVal;         /**< \brief VM1 Threshold Value */
} IfxHv_VmThresholdConfig;

#endif /*  IFX_CFG_VM1_H_ */
