/**
 * \file IfxMailBox.h
 *
 * \version TBD
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

#ifndef COMMON_MBX_H_
#define COMMON_MBX_H_

/** \brief LOCK
 */
#define RESOURCE_LOCK              (0xB0580E00)

/** \brief TC0 Mailbox
 */
#define TRICORE_0_REQUEST_MAILBOX  (0xB0580200)

/** \brief TC1 Mailbox
 */
#define TRICORE_1_REQUEST_MAILBOX  (0xB0580400)

/** \brief TC2 Mailbox
 */
#define TRICORE_2_REQUEST_MAILBOX  (0xB0580600)

/** \brief TC3 Mailbox
 */
#define TRICORE_3_REQUEST_MAILBOX  (0xB0580800)

/** \brief TC4 Mailbox
 */
#define TRICORE_4_REQUEST_MAILBOX  (0xB0580A00)

/** \brief TC5 Mailbox
 */
#define TRICORE_5_REQUEST_MAILBOX  (0xB0580C00)

/** \brief TC5 Mailbox
 */
#define TRICORE_6_HANDSHAKE_MAILBOX  (0xB0581000)

/** \brief MAX Args
 */
#define MAX_ARGS (10)

/** \brief Num of Cores
 */
#define MAX_NUM_CORES 6U

/** \brief if defined, the interrupt from Server to Client is configured as the notifier
 */
//#define S2C_INTERRUPT_NOTIFICATION 1

/** \brief Status of the operation/service
 */
typedef enum
{
	IfxMailbox_Status_requestDone=0U,      /**< \brief Service Request Done */
	IfxMailbox_Status_requestInProgress,   /**< \brief Service Request In progress */
	IfxMailbox_Status_successful,          /**< \brief Service Request executed successfully */
	IfxMailbox_Status_notsuccessful,       /**< \brief Service Request not executed successfully */
	IfxMailbox_Status_tryLater             /**< \brief Server busy/ occupied */
}IfxMailbox_Status;

/** \brief New command or not
 */
typedef enum
{
	IfxMailbox_Command_none=0U,    /**< \brief No new command */
	IfxMailbox_Command_new         /**< \brief New command */
}IfxMailbox_Command;

/** \brief Mailbox structure
 */
typedef struct
{
	unsigned int command;     /**< \brief Describe if there is a new command */
	unsigned int status;      /**< \brief Describe the status of the request */
	unsigned int id;          /**< \brief Identifier to the specific service request */
	unsigned int numArgs;     /**< \brief  Number of Data to be passed to the Server */
	int *args[MAX_ARGS];      /**< \brief Pointer to the data members */
}IfxMailbox;

#endif /* COMMON_MBX_H_ */
