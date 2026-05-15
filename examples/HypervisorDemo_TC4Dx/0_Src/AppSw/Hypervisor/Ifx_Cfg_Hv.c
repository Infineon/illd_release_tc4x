/**
 * \file Ifx_Cfg_Hv.c
 * \brief Hypervisor Startup Software over Core0
 *
 * \version Hypervisor Demonstrator
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
 */

#include "Ifx_Cfg_Hv.h"
/* Include the low level driver implementation if being used */
#include "IfxWtu.h"
#include "IfxClock.h"

/* Currently full range of access need to be updated */
const VmMpuRangeType HvMpuConfig = {
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xEFFFFFFF},
    {0xd0000000, 0xD003BFFF}
};

const VmMpuRangeType Hv_Vm1MpuConfig = {
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xEFFFFFFF},
    {0xd0000000, 0xD003BFFF}
};

const VmMpuRangeType Hv_Vm2MpuConfig = {
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xEFFFFFFF},
    {0xd0000000, 0xD003BFFF}
};

const VmMpuRangeType Hv_Vm3MpuConfig = {
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xEFFFFFFF},
    {0xd0000000, 0xD003BFFF}
};

const VmMpuRangeType Hv_Vm4MpuConfig = {
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xEFFFFFFF},
    {0xd0000000, 0xD003BFFF}
};

const VmMpuRangeType Hv_Vm5MpuConfig = {
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xEFFFFFFF},
    {0xd0000000, 0xD003BFFF}
};

const VmMpuRangeType Hv_Vm6MpuConfig = {
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xEFFFFFFF},
    {0xd0000000, 0xD003BFFF}
};

const VmMpuRangeType Hv_Vm7MpuConfig = {
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xFFFFFFFF},
    {0x00000000, 0xEFFFFFFF},
    {0xd0000000, 0xD003BFFF}
};

/* STM Config for Hypervisor Interrupt based scheduler for CORE0
 * The user to adapt the configuration as per the application needs.
 * Default configuration provided as below:
 * Ticks as defined by User
 * Compare Offset = 0
 * compareSize = 32 bits
 * Priority as defined by user
 * TOS = CPU0
 * Comparator  = Comparator 0
 * Comparator interrupt request source = ir0
 * Comparison = Absolute Comparison
 * VmId = 0
 */
const IfxHv_StmCompareConfig IfxHv0_StmConfig = {
    .timeInSec           = IFX_CORE0_VM1_EXECUTION_TIME,
    .compareOffset       = 0U,
    .compareSize         = 31U,
    .triggerPriority     = IFX_VM0_SCHD_PRIORITY,
    .typeOfService       = 0U,
    .comparator          = 0U,
    .comparatorInterrupt = 0U,
    .comparison          = 0U,
    .vmId                = 0U
};

const IfxHv_StmCompareConfig IfxHv1_StmConfig = {
    .timeInSec           = IFX_CORE1_VM1_EXECUTION_TIME,
    .compareOffset       = 0U,
    .compareSize         = 31U,
    .triggerPriority     = IFX_VM0_SCHD_PRIORITY,
    .typeOfService       = 1U,
    .comparator          = 0U,
    .comparatorInterrupt = 0U,
    .comparison          = 0U,
    .vmId                = 0U
};

const IfxHv_StmCompareConfig IfxHv2_StmConfig = {
    .timeInSec           = IFX_CORE2_VM1_EXECUTION_TIME,
    .compareOffset       = 0U,
    .compareSize         = 31U,
    .triggerPriority     = IFX_VM0_SCHD_PRIORITY,
    .typeOfService       = 2U,
    .comparator          = 0U,
    .comparatorInterrupt = 0U,
    .comparison          = 0U,
    .vmId                = 0U
};

const IfxHv_StmCompareConfig IfxHv3_StmConfig = {
    .timeInSec           = IFX_CORE3_VM1_EXECUTION_TIME,
    .compareOffset       = 0U,
    .compareSize         = 31U,
    .triggerPriority     = IFX_VM0_SCHD_PRIORITY,
    .typeOfService       = 3U,
    .comparator          = 0U,
    .comparatorInterrupt = 0U,
    .comparison          = 0U,
    .vmId                = 0U
};

const IfxHv_StmCompareConfig IfxHv4_StmConfig = {
    .timeInSec           = IFX_CORE4_VM1_EXECUTION_TIME,
    .compareOffset       = 0U,
    .compareSize         = 31U,
    .triggerPriority     = IFX_VM0_SCHD_PRIORITY,
    .typeOfService       = 4U,
    .comparator          = 0U,
    .comparatorInterrupt = 0U,
    .comparison          = 0U,
    .vmId                = 0U
};

const IfxHv_StmCompareConfig IfxHv5_StmConfig = {
    .timeInSec           = IFX_CORE5_VM1_EXECUTION_TIME,
    .compareOffset       = 0U,
    .compareSize         = 31U,
    .triggerPriority     = IFX_VM0_SCHD_PRIORITY,
    .typeOfService       = 5U,
    .comparator          = 0U,
    .comparatorInterrupt = 0U,
    .comparison          = 0U,
    .vmId                = 0U
};

/* Threshold config for CORE0 VMs
 * The default values are set to 255, which indicates no pre-emption
 * In case user needs to use pre-emption feature, the threshold values to be
 * configured accordingly.
 */
const IfxHv_VmThresholdConfig IfxHv0_VmThresholdConfig = {
    .vm1ThresholdVal = 255U,
    .vm2ThresholdVal = 255U,
    .vm3ThresholdVal = 255U,
    .vm4ThresholdVal = 255U,
    .vm5ThresholdVal = 255U,
    .vm6ThresholdVal = 255U,
    .vm7ThresholdVal = 255U
};

const IfxHv_VmThresholdConfig IfxHv1_VmThresholdConfig = {
    .vm1ThresholdVal = 255U,
    .vm2ThresholdVal = 255U,
    .vm3ThresholdVal = 255U,
    .vm4ThresholdVal = 255U,
    .vm5ThresholdVal = 255U,
    .vm6ThresholdVal = 255U,
    .vm7ThresholdVal = 255U
};

const IfxHv_VmThresholdConfig IfxHv2_VmThresholdConfig = {
    .vm1ThresholdVal = 255U,
    .vm2ThresholdVal = 255U,
    .vm3ThresholdVal = 255U,
    .vm4ThresholdVal = 255U,
    .vm5ThresholdVal = 255U,
    .vm6ThresholdVal = 255U,
    .vm7ThresholdVal = 255U
};

const IfxHv_VmThresholdConfig IfxHv3_VmThresholdConfig = {
    .vm1ThresholdVal = 255U,
    .vm2ThresholdVal = 255U,
    .vm3ThresholdVal = 255U,
    .vm4ThresholdVal = 255U,
    .vm5ThresholdVal = 255U,
    .vm6ThresholdVal = 255U,
    .vm7ThresholdVal = 255U
};

const IfxHv_VmThresholdConfig IfxHv4_VmThresholdConfig = {
    .vm1ThresholdVal = 255U,
    .vm2ThresholdVal = 255U,
    .vm3ThresholdVal = 255U,
    .vm4ThresholdVal = 255U,
    .vm5ThresholdVal = 255U,
    .vm6ThresholdVal = 255U,
    .vm7ThresholdVal = 255U
};

const IfxHv_VmThresholdConfig IfxHv5_VmThresholdConfig = {
    .vm1ThresholdVal = 255U,
    .vm2ThresholdVal = 255U,
    .vm3ThresholdVal = 255U,
    .vm4ThresholdVal = 255U,
    .vm5ThresholdVal = 255U,
    .vm6ThresholdVal = 255U,
    .vm7ThresholdVal = 255U
};

void IfxHv_disableCpuWatchdog(void)
{
    IfxWtu_disableCpuWatchdog(IfxWtu_getCpuWatchdogPassword());
}


void IfxHv_disableSystemWatchdog(void)
{
    IfxWtu_disableSystemWatchdog(IfxWtu_getSystemWatchdogPassword());
}


uint32 IfxHv_getStmFrequency(void)
{
    return IfxClock_getStmFrequency();
}
