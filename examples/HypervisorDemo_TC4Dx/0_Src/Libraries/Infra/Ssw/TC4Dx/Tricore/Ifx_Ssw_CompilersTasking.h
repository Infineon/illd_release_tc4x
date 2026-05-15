/**
 * \file Ifx_Ssw_CompilersTasking.h
 * \brief Startup Software for Tasking compiler options
 *
 * \version TBD
 * \copyright Copyright (c) 2026 Infineon Technologies AG. All rights reserved.
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
#ifndef IFX_SSW_COMPILERSTASKING_H
#define IFX_SSW_COMPILERSTASKING_H 1

/******************************************************************************/
/*----------------------------------Includes----------------------------------*/
/******************************************************************************/

/******************************************************************************/
/*-----------------------------------Macros-----------------------------------*/
/******************************************************************************/

/*Linker definitions which are specific to Tasking */
/* IFX_CFG_USE_COMPILER_DEFAULT_LINKER shall be defined in Ifx_Cfg.h
 * to use the default compiler linker varaibles and startup */
#ifndef IFX_CFG_USE_COMPILER_DEFAULT_LINKER

/*Start: Common definitions ********************************************** */
#define IFX_SSW_COMMON_LINKER_SYMBOLS()                                     \
    __asm("\t .extern _SMALL_DATA_, _LITERAL_DATA_, _A8_DATA_, _A9_DATA_"); \
    extern unsigned int __START00[];     /**< Pointer to the startup code */   \
    extern unsigned int __START01[];     /**< Pointer to the startup code */   \
    extern unsigned int __START02[];     /**< Pointer to the startup code */   \
    extern unsigned int __START03[];     /**< Pointer to the startup code */   \
    extern unsigned int __START04[];     /**< Pointer to the startup code */   \
	extern unsigned int __START05[];     /**< Pointer to the startup code */   \
	extern unsigned int __START06[];     /**< Pointer to the startup code */   \
    extern unsigned int __START07[];     /**< Pointer to the startup code */   \
	extern unsigned int __START10[];     /**< Pointer to the startup code */   \
	extern unsigned int __START11[];     /**< Pointer to the startup code */   \
	extern unsigned int __START12[];     /**< Pointer to the startup code */   \
	extern unsigned int __START13[];     /**< Pointer to the startup code */   \
	extern unsigned int __START14[];     /**< Pointer to the startup code */   \
	extern unsigned int __START15[];     /**< Pointer to the startup code */   \
	extern unsigned int __START16[];     /**< Pointer to the startup code */   \
	extern unsigned int __START17[];     /**< Pointer to the startup code */    \
	extern unsigned int __START20[];     /**< Pointer to the startup code */   \
	extern unsigned int __START21[];     /**< Pointer to the startup code */   \
	extern unsigned int __START22[];     /**< Pointer to the startup code */   \
	extern unsigned int __START23[];     /**< Pointer to the startup code */   \
	extern unsigned int __START24[];     /**< Pointer to the startup code */   \
	extern unsigned int __START25[];     /**< Pointer to the startup code */   \
	extern unsigned int __START26[];     /**< Pointer to the startup code */   \
	extern unsigned int __START27[];     /**< Pointer to the startup code */    \
	extern unsigned int __START30[];     /**< Pointer to the startup code */   \
	extern unsigned int __START31[];     /**< Pointer to the startup code */   \
	extern unsigned int __START32[];     /**< Pointer to the startup code */   \
	extern unsigned int __START33[];     /**< Pointer to the startup code */   \
	extern unsigned int __START34[];     /**< Pointer to the startup code */   \
	extern unsigned int __START35[];     /**< Pointer to the startup code */   \
	extern unsigned int __START36[];     /**< Pointer to the startup code */   \
	extern unsigned int __START37[];     /**< Pointer to the startup code */   \
	extern unsigned int __START40[];     /**< Pointer to the startup code */   \
	extern unsigned int __START41[];     /**< Pointer to the startup code */   \
	extern unsigned int __START42[];     /**< Pointer to the startup code */   \
	extern unsigned int __START43[];     /**< Pointer to the startup code */   \
	extern unsigned int __START44[];     /**< Pointer to the startup code */   \
	extern unsigned int __START45[];     /**< Pointer to the startup code */   \
	extern unsigned int __START46[];     /**< Pointer to the startup code */   \
	extern unsigned int __START47[];     /**< Pointer to the startup code */   \
	extern unsigned int __START50[];     /**< Pointer to the startup code */   \
	extern unsigned int __START51[];     /**< Pointer to the startup code */   \
	extern unsigned int __START52[];     /**< Pointer to the startup code */   \
	extern unsigned int __START53[];     /**< Pointer to the startup code */   \
	extern unsigned int __START54[];     /**< Pointer to the startup code */   \
	extern unsigned int __START55[];     /**< Pointer to the startup code */   \
	extern unsigned int __START56[];     /**< Pointer to the startup code */   \
	extern unsigned int __START57[];     /**< Pointer to the startup code */    \
	extern unsigned int __ENABLE_INDIVIDUAL_C_INIT_CPU0;        /**< Enable Individual C init CPU0 */ \
	extern unsigned int __ENABLE_INDIVIDUAL_C_INIT_CPU1;        /**< Enable Individual C init CPU1 */ \
	extern unsigned int __ENABLE_INDIVIDUAL_C_INIT_CPU2;        /**< Enable Individual C init CPU2 */ \
	extern unsigned int __ENABLE_INDIVIDUAL_C_INIT_CPU3;        /**< Enable Individual C init CPU3 */ \
	extern unsigned int __ENABLE_INDIVIDUAL_C_INIT_CPU4;        /**< Enable Individual C init CPU4 */ \
	extern unsigned int __ENABLE_INDIVIDUAL_C_INIT_CPU5;         /**< Enable Individual C init CPU5 */  \
	extern unsigned int __TRAPTABHV_CPU00[]; /**< trap table */ \
	extern unsigned int __TRAPTABHV_CPU10[]; /**< trap table */ \
	extern unsigned int __TRAPTABHV_CPU20[]; /**< trap table */ \
	extern unsigned int __TRAPTABHV_CPU30[]; /**< trap table */ \
	extern unsigned int __TRAPTABHV_CPU40[]; /**< trap table */ \
	extern unsigned int __TRAPTABHV_CPU50[]; /**< trap table */

/*End: Common definitions ************************************************ */
/*Start: Core 0 definitions ********************************************** */

/*C extern defintions */
#define IFX_SSW_CORE_LINKER_SYMBOLS(cpu,vm)                                        \
		__asm("\t .extern __USTACK"#cpu#vm);         /**< user stack end is required as asm to be used with setreg macro */ \
    extern unsigned int __ISTACK##cpu##vm[];      /**< interrupt stack end */       \
    extern unsigned int __INTTAB_CPU##cpu##vm[];  /**< Interrupt vector table */    \
    extern unsigned int __TRAPTAB_CPU##cpu##vm[]; /**< trap table */                \
    extern unsigned int __CSA##cpu##vm[];         /**< context save area 1 begin */ \
    extern unsigned int __CSA##cpu##vm##_END[];   /**< context save area 1 begin */

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


#define IFX_SSW_INLINE   static inline
#define IFX_SSW_NULL_PTR ((void *)0x0U)

#define IFX_SSW_WEAK     __attribute__ ((weak))
#define IFX_SSW_NOINLINE __attribute__((noinline))
/******************************************************************************/
/*----------------------------   TASKING Intrinsics  -------------------------*/
/******************************************************************************/

/* Assembly function to configure the Stack pointer and jump to core start */
#define Ifx_Ssw_Start(stackPtr, funcPtr) __Ifx_Ssw_Start(stackPtr, funcPtr)

#define __Ifx_Ssw_Start(stackPtr, funcPtr) \
	    __asm("movh.a a10,#@his("#stackPtr")\n" \
	          "\tlea a10,[a10]@los("#stackPtr") \n " \
	          "\tdsync\n" \
			  "\tmovh.a a15,#@his("#funcPtr")\n" \
			  "\tlea a15,[a15]@los("#funcPtr")\n" \
			  "\tji a15");

#define Ifx_Ssw_Barrier() __asm("":::"memory");

#define Ifx_Ssw_debug() __debug();

#define Ifx_Ssw_MTCR(reg, val) __mtcr(reg, val);

#define Ifx_Ssw_MFCR(reg)      __mfcr(reg);

#if defined(__CORE_TC18__)
#define Ifx_Ssw_HVCALL(hvcno) __hvcall(hvcno)
#define Ifx_Ssw_RFH() __asm("rfh " : : : "memory")
#else
#define Ifx_Ssw_HVCALL(hvcno) \
switch (hvcno) \
{ \
case 1: \
{__asm volatile (".word 0x004010AD");}\
break; \
case 2: \
{__asm volatile (".word 0x004020AD");}\
break; \
case 3: \
{__asm volatile (".word 0x004030AD");}\
break; \
case 4: \
{__asm volatile (".word 0x004040AD");}\
break; \
case 5: \
{__asm volatile (".word 0x004050AD");}\
break; \
case 6: \
{__asm volatile (".word 0x004060AD");}\
break; \
case 7: \
{__asm volatile (".word 0x004070AD");}\
break; \
}
#define Ifx_Ssw_RFH() \
__asm volatile (".word 0x05C0000D");
#endif

IFX_SSW_INLINE void Ifx_Ssw_NOP(void)
{
    __nop();
}


IFX_SSW_INLINE void Ifx_Ssw_DSYNC(void)
{
    __dsync();
}


IFX_SSW_INLINE void Ifx_Ssw_ISYNC(void)
{
    __isync();
}


IFX_SSW_INLINE unsigned int Ifx_Ssw_MINU(unsigned int a, unsigned int b)
{
    return __minu(a, b);
}

IFX_SSW_INLINE unsigned int Ifx_Ssw_getD15(void)
{
    unsigned int var;
    __asm(" mov\t %0, d15" : "=d" (var));
    return var;
}

/* Inline function to set return address*/
IFX_SSW_INLINE void Ifx_Ssw_setA11(void *Addr)
{
    __asm("mov.aa a11, %0": : "a" (Addr) :"a11");
}

#define Ifx_Ssw_CLZ(a)                     __clz(a)

#define Ifx_Ssw___setAddressReg(aReg, val) \
    {__asm(" movh.a\t "#aReg ",#@his("#val ")\n lea\t "#aReg ",["#aReg "]@los("#val ")"); }

#define Ifx_Ssw_setAddressReg(regNum, val) Ifx_Ssw___setAddressReg(regNum, val)

IFX_SSW_INLINE void Ifx_Ssw_moveToDataParam0(unsigned int var)
{
    __asm("mov d2, %0" ::"d" (var));
}


IFX_SSW_INLINE unsigned int Ifx_Ssw_getDataParam0(void)
{
    unsigned int var;
    __asm(" mov\t %0, d2" : "=d" (var));
    return var;
}


IFX_SSW_INLINE void Ifx_Ssw_jumpToFunction(void *fun)
{
    __asm("ji %0" ::"a" (fun));
}


IFX_SSW_INLINE void Ifx_Ssw_jumpToFunctionWithLink(void *fun)
{
    __asm("jli %0" ::"a" (fun));
}


IFX_SSW_INLINE void Ifx_Ssw_jumpBackToLink(void)
{
    __asm("ji a11");
}


IFX_SSW_INLINE void Ifx_Ssw_C_InitInline(void)
{
    extern void _c_init(void);
    _c_init();                  /* initialize data */
}

IFX_SSW_INLINE void Ifx_Ssw_infiniteLoop(void)
{
    __asm("1: loopu\t 1p");
}
#endif /* IFX_SSW_COMPILERSTASKING_H */
