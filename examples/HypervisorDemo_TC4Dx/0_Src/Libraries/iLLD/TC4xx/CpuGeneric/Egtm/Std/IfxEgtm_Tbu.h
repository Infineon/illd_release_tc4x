/**
 * \file IfxEgtm_Tbu.h
 * \brief EGTM  basic functionality
 * \ingroup IfxLld_Egtm
 *
 * \copyright Copyright (c) 2026 Infineon Technologies AG. All rights reserved.
 *
 * $Date: 2023-03-29 09:36:30
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
 *
 * \defgroup IfxLld_Egtm_Std_Tbu Tbu Basic Functionality
 * \ingroup IfxLld_Egtm_Std
 * \defgroup IfxLld_Egtm_Std_Tbu_Enumerations TBU Enumerations
 * \ingroup IfxLld_Egtm_Std_Tbu
 * \defgroup IfxLld_Egtm_Std_Tbu_Basic_Functions TBU Basic Functions
 * \ingroup IfxLld_Egtm_Std_Tbu
 */

#ifndef IFXEGTM_TBU_H
#define IFXEGTM_TBU_H 1

/******************************************************************************/
/*----------------------------------Includes----------------------------------*/
/******************************************************************************/

#include "_Impl/IfxEgtm_cfg.h"
#include "IfxEgtm_Cmu.h"

/******************************************************************************/
/*--------------------------------Enumerations--------------------------------*/
/******************************************************************************/

/** \addtogroup IfxLld_Egtm_Std_Tbu_Enumerations
 * \{ */
/** \brief EGTM TOM TBU Time stamps
 */
typedef enum
{
    IfxEgtm_Tbu_Ts_0,
    IfxEgtm_Tbu_Ts_1,
    IfxEgtm_Tbu_Ts_2,
    IfxEgtm_Tbu_Ts_3
} IfxEgtm_Tbu_Ts;

/** \} */

/** \addtogroup IfxLld_Egtm_Std_Tbu_Basic_Functions
 * \{ */

/******************************************************************************/
/*-------------------------Inline Function Prototypes-------------------------*/
/******************************************************************************/

/** \brief Enables the channel
 * \param egtm Pointer to EGTM module
 * \param cluster Cluster index
 * \param channel TBU Time stamps
 * \return None
 */
IFX_INLINE void IfxEgtm_Tbu_enableChannel(Ifx_EGTM *egtm, IfxEgtm_Cluster cluster, IfxEgtm_Tbu_Ts channel);

/** \brief Returns the clock frequency
 * \param egtm Pointer to EGTM module
 * \param cluster Cluster index
 * \param channel TBU Time stamps
 * \return frequency
 */
IFX_INLINE float32 IfxEgtm_Tbu_getClockFrequency(Ifx_EGTM *egtm, IfxEgtm_Cluster cluster, IfxEgtm_Tbu_Ts channel);

/** \brief Function to check if a TBU channel is enabled.
 * Returns TRUE if the corresponding channel is enabled
 * Returns FALSE if the corresponding channel is disabled.
 * \param egtm Pointer to EGTM SFR
 * \param cluster Cluster index
 * \param channel Channel of TBU
 * \return TRUE: channel is enabled
 */
IFX_INLINE boolean IfxEgtm_Tbu_isChannelEnabled(Ifx_EGTM *egtm, IfxEgtm_Cluster cluster, IfxEgtm_Tbu_Ts channel);

/** \} */

/******************************************************************************/
/*---------------------Inline Function Implementations------------------------*/
/******************************************************************************/

IFX_INLINE void IfxEgtm_Tbu_enableChannel(Ifx_EGTM *egtm, IfxEgtm_Cluster cluster, IfxEgtm_Tbu_Ts channel)
{
    uint32 shift = (uint32)channel << 1u;

    Ifx__ldmst(&egtm->CLS[cluster].TBU.CHEN.U, (uint32)((uint32)3u << shift), ((uint32)IfxEgtm_FeatureControl_enable << shift));
}


IFX_INLINE float32 IfxEgtm_Tbu_getClockFrequency(Ifx_EGTM *egtm, IfxEgtm_Cluster cluster, IfxEgtm_Tbu_Ts channel)
{
    float32 result = 0.0F;

    if (channel == IfxEgtm_Tbu_Ts_0)
    {
        result = IfxEgtm_Cmu_getClkFrequency(egtm, (IfxEgtm_Cmu_Clk)egtm->CLS[cluster].TBU.CH0_CTRL.B.CH_CLK_SRC, TRUE);
    }
    else if (channel == IfxEgtm_Tbu_Ts_1)
    {
        result = IfxEgtm_Cmu_getClkFrequency(egtm, (IfxEgtm_Cmu_Clk)egtm->CLS[cluster].TBU.CH1_CTRL.B.CH_CLK_SRC, TRUE);
    }
    else if (channel == IfxEgtm_Tbu_Ts_2)
    {
        result = IfxEgtm_Cmu_getClkFrequency(egtm, (IfxEgtm_Cmu_Clk)egtm->CLS[cluster].TBU.CH2_CTRL.B.CH_CLK_SRC, TRUE);
    }
    else
    {}

    return result;
}


IFX_INLINE boolean IfxEgtm_Tbu_isChannelEnabled(Ifx_EGTM *egtm, IfxEgtm_Cluster cluster, IfxEgtm_Tbu_Ts channel)
{
    uint32  shift         = (uint32)channel << 1u;
    uint32  enable_status = (egtm->CLS[cluster].TBU.CHEN.U & ((uint32)3u << shift)) >> shift;
    boolean enabled;

    enabled = (enable_status == (uint32)IfxEgtm_FeatureControl_enabled) ? TRUE : FALSE;
    return enabled;
}


#endif /* IFXEGTM_TBU_H */
