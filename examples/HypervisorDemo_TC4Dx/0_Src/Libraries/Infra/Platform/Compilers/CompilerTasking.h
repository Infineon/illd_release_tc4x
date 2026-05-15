/**
 * \file CompilerTasking.h
 *
 * \version iLLD_New
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

#ifndef COMPILERTASKING_H
#define COMPILERTASKING_H 1

/******************************************************************************/

#include <stddef.h>

/*Linker definitions which are specific to Tasking */
/* IFX_CFG_USE_COMPILER_DEFAULT_LINKER shall be defined in Ifx_Cfg.h
 * to use the default compiler linker varaibles and startup */
#ifndef IFX_CFG_USE_COMPILER_DEFAULT_LINKER

#ifndef __cplusplus
/*Start: Common definitions ********************************************** */
#define IFXCOMPILER_COMMON_LINKER_SYMBOLS() \
    __asm("\t .extern _SMALL_DATA_, _LITERAL_DATA_, _A8_DATA_, _A9_DATA_");

/*End: Common definitions ********************************************** */

/*Start: Core 0 definitions ********************************************** */

#define IFXCOMPILER_CORE_LINKER_SYMBOLS(cpu)                                                                         \
    __asm("\t .extern __USTACK"#cpu);         /**< user stack end is required as asm to be used with setreg macro */ \
    extern unsigned int __ISTACK##cpu[];      /**< interrupt stack end */                                            \
    extern unsigned int __INTTAB_CPU##cpu[];  /**< interrupt vector table */                                         \
    extern unsigned int __TRAPTAB_CPU##cpu[]; /**< trap vector table */                                              \
    extern unsigned int __CSA##cpu[];         /**< context save area begin */                                        \
    extern unsigned int __CSA##cpu##_END[];   /**< context save area end   */
#endif

#define __USTACK(cpu,vm)      __USTACK##cpu##vm
#define __ISTACK(cpu,vm)      __ISTACK##cpu##vm
#define __INTTAB_CPU(cpu,vm)  __INTTAB_CPU##cpu##vm
#define __TRAPTAB_CPU(cpu,vm) __TRAPTAB_CPU##cpu##vm
#define __CSA(cpu,vm)         __CSA##cpu##vm
#define __CSA_END(cpu,vm)     __CSA##cpu##vm##_END
#define __START(cpu,vm)       __START##cpu##vm

/*Wrapper macros for the tool specific definitions */
#if defined(IFX_USE_SW_MANAGED_INT)
#define __INTTAB(cpu)      ((unsigned int)__INTTAB_CPU##cpu | (unsigned int)0x1FE0)
#else
#define __INTTAB(cpu,vm)      __INTTAB_CPU##cpu##vm
#endif /*defined(IFX_USE_SW_MANAGED_INT) */

#define __TRAPTAB(cpu,vm)     __TRAPTAB_CPU##cpu##vm

#define __SDATA1(cpu)      _SMALL_DATA_
#define __SDATA2(cpu)      _LITERAL_DATA_
#define __SDATA3(cpu)      _A8_DATA_
#define __SDATA4(cpu)      _A9_DATA_

#endif /*IFX_CFG_USE_COMPILER_DEFAULT_LINKER*/

/******************************************************************************/

#define IFX_INLINE        static inline
/* FXIME check how to pack structure members */
#define IFX_PACKED

#define COMPILER_NAME     "TASKING"
#define COMPILER_VERSION  __VERSION__

/* Note that __REVISION__ is only available for tasking compiler! */
#define COMPILER_REVISION __REVISION__

/******************************************************************************/

#if defined(IFX_USE_SW_MANAGED_INT)

#ifndef IFX_INTERRUPT
#define IFX_INTERRUPT(isr, vectabNum, prio) void isr(void)
#endif

#else
/* *INDENT-OFF* */
#ifndef IFX_INTERRUPT
#define IFX_INTERRUPT(isr, vectabNum, prio) IFX_INTERRUPT_INTERNAL(isr, vectabNum, prio)
#endif

#endif /*defined(IFX_USE_SW_MANAGED_INT)*/

#define IFX_INTERRUPT_FAST(isr, vectabNum, prio) void __interrupt_fast(prio) __vector_table(vectabNum) isr(void)

/* The IFX_INTERRUPT_INTERNAL macro is added as a workaround for the
 * Virtualization enable case since the TC1.8 TASKING compiler doesn't support
 *  more than 5 vector table number entries. This macro can be removed in future
 *  if the TASKING compiler supports the same
 */
/* Virtualization case for interrupt handled by a Virtual Machine */
#ifndef IFX_INTERRUPT_VM
#define IFX_INTERRUPT_VM(isr, cpu, vm, prio) IFX_INTERRUPT_VM_INTERNAL(isr, cpu, vm, prio)
#endif

/* Virtualization case for interrupt handled by a Hypervisor with proper interrupt epilog  */
#ifndef IFX_INTERRUPT_VM_RFH
#define IFX_INTERRUPT_VM_RFH(isr, cpu, vm, prio) IFX_INTERRUPT_VM_RFH_INTERNAL(isr, cpu, vm, prio)
#endif

#define IFX_INTERRUPT_FAST(isr, vectabNum, prio) void __interrupt_fast(prio) __vector_table(vectabNum) isr(void)
#define IFX_INTERRUPT_INTERNAL(isr, vectabNum, prio) void __interrupt(prio) __vector_table(vectabNum) isr(void)
#define IFX_INTERRUPT_VM_INTERNAL(isr, cpu, vm, prio) void __vm(vm)__interrupt(prio) __vector_table(cpu) isr(void)
#define IFX_INTERRUPT_VM_RFH_INTERNAL(isr, cpu, vm, prio) void __hvinterrupt(prio) __vector_table(cpu) isr(void)
/* *INDENT-ON* */

/******************************************************************************/

#define IFX_ALIGN(n)       __attribute__ ((__align(n)))

/******************************************************************************/
/*Memory qualifiers*/
#ifndef IFX_FAR_ABS
#define IFX_FAR_ABS __far
#endif

#ifndef IFX_NEAR_ABS
#define IFX_NEAR_ABS __near
#endif

#ifndef IFX_REL_A0
#define IFX_REL_A0 __a0
#endif

#ifndef IFX_REL_A1
#define IFX_REL_A1 __a1
#endif

#ifndef IFX_REL_A8
#define IFX_REL_A8 __a8
#endif

#ifndef IFX_REL_A9
#define IFX_REL_A9 __a9
#endif
/******************************************************************************/

#endif /* COMPILERTASKING_H */
