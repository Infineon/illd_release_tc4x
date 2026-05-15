/**
 * \file Ifx_Cfg_Trap_Hv.h
 * \brief Configuration of Trap handlers.
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

#ifndef _IFX_CFG_TRAP_HV_H_
#define _IFX_CFG_TRAP_HV_H_

#include "IfxCpu_Trap.h"
#include "IfxCpu_Intrinsics.h"
#include "IfxHv_CpuVmSched.h"

#define IFX_CFG_CPU_TRAP_HVCALL_CPU0_HOOK()  __jumpToFunction(Hv0_Vm_Scheduler)

/* split the scheduler after interrupt handling is available */
#define IFX_CFG_CPU_TRAP_ISRINT_CPU0_HOOK()  __jumpToFunction(Hv0_Vm_PreEmptionScheduler)


#define IFX_CFG_CPU_TRAP_HVCALL_CPU1_HOOK()  __jumpToFunction(Hv1_Vm_Scheduler)

/* split the scheduler after interrupt handling is available */
#define IFX_CFG_CPU_TRAP_ISRINT_CPU1_HOOK()  __jumpToFunction(Hv1_Vm_PreEmptionScheduler)

#define IFX_CFG_CPU_TRAP_HVCALL_CPU2_HOOK()  __jumpToFunction(Hv2_Vm_Scheduler)

/* split the scheduler after interrupt handling is available */
#define IFX_CFG_CPU_TRAP_ISRINT_CPU2_HOOK()  __jumpToFunction(Hv2_Vm_PreEmptionScheduler)

#define IFX_CFG_CPU_TRAP_HVCALL_CPU3_HOOK()  __jumpToFunction(Hv3_Vm_Scheduler)

/* split the scheduler after interrupt handling is available */
#define IFX_CFG_CPU_TRAP_ISRINT_CPU3_HOOK()  __jumpToFunction(Hv3_Vm_PreEmptionScheduler)

#define IFX_CFG_CPU_TRAP_HVCALL_CPU4_HOOK()  __jumpToFunction(Hv4_Vm_Scheduler)

/* split the scheduler after interrupt handling is available */
#define IFX_CFG_CPU_TRAP_ISRINT_CPU4_HOOK()  __jumpToFunction(Hv4_Vm_PreEmptionScheduler)

#define IFX_CFG_CPU_TRAP_HVCALL_CPU5_HOOK()  __jumpToFunction(Hv5_Vm_Scheduler)

/* split the scheduler after interrupt handling is available */
#define IFX_CFG_CPU_TRAP_ISRINT_CPU5_HOOK()  __jumpToFunction(Hv5_Vm_PreEmptionScheduler)

#define IFX_CFG_CPU_TRAP_HVL2MPURW_HOOK()

#define IFX_CFG_CPU_TRAP_HVL2MPUEX_HOOK()

#define IFX_CFG_CPU_TRAP_HVCSFR_HOOK()

#endif /* _IFX_CFG_TRAP_H_ */
