/**
\page lld_dosanddont_commonApis  APIs common to many module drivers

    \section lld_dosanddont_commonApis_getSrc <modue>_get<Interrupt>Src()
	For each interrupt service request control register, an API that returns the register address shall be available. The API syntax is as follow:
	volatile Ifx_SRC_SRCR* <driverName>_get<Interrupt>Src(<ModuleType>*module);

	Example: The transmit interrupt of the QSPI driver has the following API:

	volatile Ifx_SRC_SRCR*  IfxQspi_getTransmitSrc(Ifx_QSPI* module);



    \section lld_dosanddont_commonApis_get_index <modue>_getIndex()
    The API Ifx<Module>_getIndex(Ifx_<MODULE>* module) shall be implemented in the file Ifx<Module>.c/h and use an array define in Ifx<Module>_cfg.c/h;

    Example:

    In file Ifxcpu.h
    \code
    IFX_EXTERN IfxCpu_ResourceCpu IfxCpu_getIndex(Ifx_CPU* cpu);
    \endcode

    In file Ifxcpu.c
    \code
    // brief Return cpu index
    //
    // \param cpu Specifies cpu module
    //
    // \return Return cpu index.
    //
    IfxCpu_ResourceCpu IfxCpu_getIndex(Ifx_CPU* cpu)
    {
        IfxCpu_ResourceCpu result = IfxCpu_ResourceCpu_none, index;
        for (index = 0; index < IFXCPU_COUNT; index++)
        {
            if (IfxCpu_cfg_indexMap[index].module == cpu)
            {
                result = IfxCpu_cfg_indexMap[index].index;
                break;
            }
        }
        return result;
    }

    \endcode

    In file Ifxcpu_cfg.h
    \code
    // List of the available CPU resources
    typedef enum
    {
        IfxCpu_ResourceCpu_0 = 0,                               // CPU 0
        IfxCpu_ResourceCpu_1,                                   // CPU 1
        IfxCpu_ResourceCpu_2,                                   // CPU 2
        IfxCpu_ResourceCpu_none                                 // None of the CPU
    } IfxCpu_ResourceCpu;

    IFX_EXTERN IfxCpu_ResourceCpu IfxCpu_getIndex(Ifx_CPU* cpu);
    \endcode

    In file Ifxcpu_cfg.c
    \code
    const IfxModule_IndexMap IfxCpu_cfg_indexMap[IFXCPU_COUNT] =
    {
        {&MODULE_CPU0, IfxCpu_ResourceCpu_0},
        {&MODULE_CPU1, IfxCpu_ResourceCpu_1},
        {&MODULE_CPU2, IfxCpu_ResourceCpu_2},
    };
    \endcode



[\ref lld_codingRules_codeChecking "Previous page"] [\ref lld_doxygenRules "Next page"]



 */
