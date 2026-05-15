/**
 * \file IfxHv_Intrinsics.h
 *
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
#ifndef IFXHV_INTRINSICS_H
#define IFXHV_INTRINSICS_H
/******************************************************************************/

/* Include the Intrinsics/Compiler macros file here */
#include "IfxCpu_Intrinsics.h"
#include "Compilers.h"


/* Adapt the macros as per the intrinsics in your project */
#define IFXHV_ENABLE_INTERRUPT __enable

#define IFXHV_MTCR __mtcr

#define IFXHV_MFCR __mfcr

#define IFXHV_SETA11 Ifx_Ssw_setA11

#define IFXHV_RFH Ifx__rfh

#define IFXHV_INLINE IFX_INLINE


/******************************************************************************/
#endif /* IFXHV_INTRINSICS_H */
