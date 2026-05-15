/**
 * \file Ifx_Cfg_Mpu.h
 * \brief Mpu configuration data types.
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

#ifndef IFX_CFG_MPU_H_
#define IFX_CFG_MPU_H_

typedef struct
{
    unsigned int lowerLimit;
    unsigned int upperLimit;
}MpuRangeType;

typedef struct
{
    MpuRangeType code_cached;
    MpuRangeType code_noncached;
    MpuRangeType data_cached;
    MpuRangeType data_noncached;
}VmMpuRangeType;

#endif /* IFX_CFG_MPU_H_ */
