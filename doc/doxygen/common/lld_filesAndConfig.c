/** \page lld_filesAndConfig Files and Configuration

\section folders Folder structure

Starting from <B>src/Libraries/</B>:
    <li> <B>iLLD</B> contains the iLLD files for all derivatives
            <ol>
            <li> Inside <B>src/Libraries/iLLD/<DUT>/Tricore</B>:
            <li> <B>_Impl</B>  contains derivative specific configuration which could also be adapted by the user
            <li> <B>_PinMap</B>  contains I/O configurations in pin tables
            <li> <B><module></B> contains the actual peripheral driver
            <li> Inside <B>src/Libraries/iLLD/<DUT>/CpuGeneric</B>:
            <li> <B>_Lib</B> contains derivative dependent library functions
            </ol>
    <li> <B>Infra</B> contains the header files for all derivatives, compiler specific files and application start-up software files for Aurix2G derivatives
            <ol>
            <li> Inside <B>src/Libraries/Infra/Platform/Compilers</B> contains the compiler specific files
            <li> Inside <B>src/Libraries/Infra/Sfr/<DUT></B> contains the header files
            <li> Inside <B>src/Libraries/Infra/Ssw/<DUT></B> contains the application start-up software files
            </ol>
    <li> <B>Service</B> contains  derivative independent service software sources

    <li> <B>VERIF_DUT</B> stands for the derivative which should be selected


\section ifxCfgH Ifx_Cfg.h

Please create a configuration file with the name "Ifx_Cfg.h" in your application to
configure the iLLD library components.

Currently it only requires to select the external oscillator frequency (XTAL)
and the desired system frequency.

In addition, this file allows you to specify how assertions should be print out.

Minimal Ifx_Cfg.h file:
\code
#ifndef IFX_CFG_H
#define IFX_CFG_H

// XTAL/PLL frequency
#define IFX_CFG_SCU_XTAL_FREQUENCY    (20000000)
#define IFX_CFG_SCU_PLL_FREQUENCY    (200000000)

// Assertions
#define IFX_ASSERT(level, expr)

#endif /* IFX_CFG_H */
\endcode

The configuration macros mentioned below can be overridden in Ifx_Cfg.h:
\li IFX_CFG_DISABLE_DEFAULT_INTRINSICS - IFX_CFG_DISABLE_DEFAULT_INTRINSICS shall be defined in Ifx_Cfg.h to disable the default intrinsics provided For Ex. NOP,CRC
\li IFX_CFG_USE_COMPILER_DEFAULT_LINKER - IFX_CFG_USE_COMPILER_DEFAULT_LINKER shall be defined in Ifx_Cfg.h to use the default compiler provided linker varaibles and startup
\li IFX_USE_SW_MANAGED_INT - IFX_USE_SW_MANAGED_INT shall be defined in Ifx_Cfg.h to use the software based interrupts
SCU related Macros:
\li IFX_CFG_SCU_XTAL_FREQUENCY - IFX_CFG_SCU_XTAL_FREQUENCY shall be defined to respective XTAL frequency in Ifx_Cfg.h
\li IFX_CFG_SCU_PLL_FREQUENCY - IFX_CFG_SCU_PLL_FREQUENCY shall be defined to desired PLL frequency in Ifx_Cfg.h
\li IFX_CFG_SCU_PLL1_FREQUENCY - IFX_CFG_SCU_PLL1_FREQUENCY shall be defined to desired PLL1 frequency in Ifx_Cfg.h
\li IFX_CFG_SCU_PLL2_FREQUENCY - IFX_CFG_SCU_PLL2_FREQUENCY shall be defined to desired PLL2 frequency in Ifx_Cfg.h
\li <B>Applicable for only Aurix2G devices</B>:
\li Application Start-up related Macros:
\li IFX_CFG_SSW_ENABLE_TRICOREx (x=0-5) - IFX_CFG_SSW_ENABLE_TRICOREx shall be defined to 0 in Ifx_Cfg.h to disable the CPUx.
\li IFX_CFG_SSW_ENABLE_TRICOREx_PCACHE (x=0-5) - IFX_CFG_SSW_ENABLE_TRICOREx_PCACHE shall be defined to 0 in Ifx_Cfg.h to disable the PCACHE of CPUx
\li IFX_CFG_SSW_ENABLE_TRICOREx_DCACHE (x=0-5) - IFX_CFG_SSW_ENABLE_TRICOREx_DCACHE shall be defined to 0 in Ifx_Cfg.h to disable the DCACHE of CPUx

Example for Assertion output via printf:
\code
#ifdef  __cplusplus
extern "C" {
#endif
// defined in main.c
extern const char* verboseLevelStr[6];

#define IFX_ASSERT(level, expr) (((expr) || (level > IFX_VERBOSE_LEVEL_ERROR)) ? ((void)0) : (void)printf("[ASSERT:%s] '%s' in %s:%d (function '%s')\n", verboseLevelStr[level], #expr, __FILE__, __LINE__, __func__))

#endif
\endcode


And in your main.c file (or somewhere else):

\code
//! this global array is used by IFX_ASSERT of iLLDs
const char* verboseLevelStr[6] = {
    "OFF",
    "FAILURE",
    "ERROR",
    "WARNING",
    "INFO",
    "DEBUG"
};
\endcode


\section minimalSetup Minimal Set of Driver sources

If you prefer to use (resp. compile) only a minimal set of drivers for your application, please add at least following "infrastructural resources":

        \li <B>src/Libraries/Infra/Sfr/<DUT></B> directory
    \li <B>src/Libraries/iLLD/<DUT>/CpuGeneric/_Lib</B> directory
    \li <B>src/Libraries/Service</B> directory
    \li CPU driver: <B>src/Libraries/iLLD/<DUT>/Tricore/Cpu</B> and <B>src/Libraries/iLLD/TC4xx/Tricore/_Impl/IfxCpu_cfg.*</B>
    \li DMA driver: <B>src/Libraries/iLLD/<DUT>/CpuGeneric/Dma</B> and <B>src/Libraries/iLLD/TC4xx/CpuGeneric/_Impl/IfxDma_cfg.*</B>
    \li Port driver: <B>src/Libraries/iLLD/<DUT>/CpuGeneric/Port</B>, <B>src/Libraries/iLLD/TC4xx/CpuGeneric/_Impl/IfxPort_cfg.*</B> and <B>src/Libraries/iLLD/TC4xx/CpuGeneric/_PinMap/IfxPort_PinMap.*</B>
    \li SCU driver: <B>src/Libraries/iLLD/<DUT>/Tricore/Scu</B> and <B>src/Libraries/iLLD/TC4xx/Tricore/_Impl/IfxScu_cfg.*</B>
    \li Src driver: <B>src/Libraries/iLLD/<DUT>/CpuGeneric/Src</B> and <B>src/Libraries/iLLD/TC4xx/CpuGeneric/_Impl/IfxSrc_cfg.*</B>
    \li Stm driver: <B>src/Libraries/iLLD/<DUT>/Tricore/Stm</B> and <B>src/Libraries/iLLD/TC4xx/Tricore/_Impl/IfxStm_cfg.*</B>

Whenever additional drivers should be added, you typically have to copy following files/directories:

    \li <B>src/Libraries/iLLD/<DUT>/<Tricore>/<driver></B>
    \li <B>src/Libraries/iLLD/TC4xx/<core>/_Impl/<driver>_cfg.*</B>
    \li <B>src/Libraries/iLLD/TC4xx/<core>/_PinMap/<driver>_cfg.*</B>


\li For more information you can refer the BIFACES User Manual.

[\ref lld_doxygenRules "Previous page"] [\ref lld_versioning "Next page"]


*/
