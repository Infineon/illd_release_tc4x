/**
 * \file IfxCpu_Trap.h
 * \brief This file contains the APIs for Trap related functions for hypervisor.
 *
 * \version
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
 * \defgroup IfxLld_Cpu_Trap Trap Functions
 * \ingroup IfxLld_Cpu
 *
 * \defgroup IfxLld_Cpu_Trap_Hooks Trap Function Hooks
 * \ingroup IfxLld_Cpu_Trap
 *
 * \defgroup IfxLld_Cpu_Trap_Usage How to use the Trap Function Hooks?
 * \ingroup IfxLld_Cpu_Trap
 *
 */

#ifndef IFXCPU_TRAP_HV_H
#define IFXCPU_TRAP_HV_H 1

/*******************************************************************************
**                      Includes                                              **
*******************************************************************************/
#include "Ifx_Types.h"

/*******************************************************************************
**                      Type definitions                                     **
*******************************************************************************/
/** \addtogroup IfxLld_Cpu_Trap_Hooks
 * \{ */

/** \brief Enum for available Trap classes.
 *
 */
typedef enum
{
    IfxCpu_HvTrap_Class_hypervisorCall        = 0U,
    IfxCpu_HvTrap_Class_interruptIntervention = 1U,
    IfxCpu_HvTrap_Class_memoryProtectionL2rw  = 3U,
    IfxCpu_HvTrap_Class_memoryProtectionL2x   = 4U,
    IfxCpu_HvTrap_Class_nmiHypervisor         = 5U,
    IfxCpu_HvTrap_Class_csfrInstructionError  = 6U
} IfxCpu_HvTrap_Class;

/*******************************************************************************
**         Global Exported macros/inlines/function ptototypes                 **
*******************************************************************************/
/*
* Function specifies the return from exception or hypervisor. 
*/
IFX_EXTERN void IfxCpu_Trap_hvReturnExe(void);

#if defined(__HIGHTEC__) && defined(__clang__)
#define IFX_TRAP_HV_HANDLER __attribute__((interrupt_handler))
#define IFX_TRAP_HV_RET
#else
#define IFX_TRAP_HV_HANDLER
/* Restore lower context before returning. lower context was stored in the trap vector */
#define IFX_TRAP_HV_RET \
	    __asm("rslcx"); \
	    IfxCpu_Trap_hvReturnExe();

#endif

#endif /* IFXCPU_TRAPS_H_ */
