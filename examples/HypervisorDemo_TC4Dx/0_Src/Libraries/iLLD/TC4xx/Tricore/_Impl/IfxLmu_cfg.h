/**
 * \file IfxLmu_cfg.h
 * \brief Lmu on-chip implementation data 
 * \ingroup IfxLld_Lmu 
 *
 * \copyright Copyright (c) 2025 Infineon Technologies AG. All rights reserved.
 *
 * $Date: 2016-12-01 06:47:11
 *
 *                                 IMPORTANT NOTICE
 *
 *
 * Infineon Technologies AG (Infineon) is supplying this file for use
 * exclusively with Infineon's microcontroller products. This file can be freely
 * distributed within development tools that are supporting such microcontroller
 * products.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
 * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
 * INFINEON SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL,
 * OR CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
 *
 * \defgroup IfxLld_Lmu Lmu
 * \ingroup IfxLld
 * \defgroup IfxLld_Lmu_Impl Implementation
 * \ingroup IfxLld_Lmu
 */

#ifndef IFXLMU_CFG_H
#define IFXLMU_CFG_H 1

/******************************************************************************/
/*----------------------------------Includes----------------------------------*/
/******************************************************************************/

#include "Ifx_Cfg.h"

#if defined DEVICE_TC4DX
#include "TC4Dx/IfxLmu_cfg_TC4Dx.h"
#endif

#endif /* IFXLMU_CFG_H */
