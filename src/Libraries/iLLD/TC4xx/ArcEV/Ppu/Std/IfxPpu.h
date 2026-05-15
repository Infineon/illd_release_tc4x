/**
 * \file IfxPpu.h
 *
 * \version iLLD-TC4-v2.4.2
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

#ifndef IFXPPU_H
#define IFXPPU_H 1

#include "Ifx_Types.h"
#include "Compilers.h"
#if defined (__CARC__)
#include <sfr\regppu.sfr>
#endif

IFX_INLINE void IfxPpu_setVccmRegion(uint8 region)
{
#if defined (__CCAC__)
	_sr(((uint32)region << 28), 0x544U);
#endif
#if defined (__CARC__)
	AUX_VECMEM_REGION = ((uint32)region << 28);
#endif
}

IFX_INLINE uint8 IfxPpu_getVccmRegion(uint32 *region)
{
#if defined (__CCAC__)
	return (uint8)(_lr(0x544U) >> 28);
#endif
#if defined (__CARC__)
	return (uint8)(AUX_VECMEM_REGION >> 28);
#endif
}

IFX_INLINE void IfxPpu_requestTricoreToWriteToBits(uint32 *address, uint32 value, uint32 mask)
{

}


#endif /* IFXPPU_H_ */
