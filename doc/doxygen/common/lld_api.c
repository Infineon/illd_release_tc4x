/** \page lld_api iLLD APIs

This section provides the generic overview of APIs required for a iLLD

\section lldinitapi iLLD Init APIs

iLLDs which need the user configuration data, shall declare the data type for configuration. These data structures are instantiated by the higher level software. Following are the requirements for the driver.

\section lldcfgapi Initialization of configuration data structure

Any driver which uses the configuration data structure shall provide an interface to initialize these data structure elements to their default values. Main used case of such implementation is, when a driver is upgraded with an additional configuration parameter, such initialization would provide correct value to the variable so that the driver works correctly when used with legacy application software which used the previous version of the driver. The API shall be made as one instance in the flash but shall be able to function on any number of identical peripherals.

Data structure shall be instantiated per HW instance for which the driver is targeted

The generic prototype shall be as\n
  <B>\<Driver Prefix\>_initConfig(\<Driver Prefix\>_Config *cfg);</B>\n
where Driver Prefix example is IfxVadc or IfxGtmTom_Pwm.

\section driverinit Driver Initialization

The iLLD shall provide an API to initialize the driver peripheral based on the user configuration. Configuration data shall be previously initialized to default values with init config interface. The API shall be made as one instance in the flash but shall be able to function on any number of identical peripherals.

The driver initialization API shall initialize the peripheral registers to make the peripheral to work as drivers functionality. This API shall also initialize the driver internal data structure to their required init values.

The generic prototype shall be as\n
  <B>\<Driver Prefix\>_init(\<Driver Prefix\>_Handle *handle, \<Driver Prefix\>_Config *cfg);</B>\n
where Driver Prefix example is IfxVadc or IfxGtmTom_Pwm.

\section driverdeinit Driver De-Initialization

iLLD may provide an API to reset the driver to default reset state and to make to consume least power. The API shall be made as one instance in the flash but shall be able to function on any number of identical peripherals.
The generic prototype shall be as\n
  <B>\<Driver Prefix\>_deInit(\<Driver Prefix\>_Handle *handle);</B>\n
where Driver Prefix example is IfxVadc or IfxGtmTom_Pwm.

\section funct_api iLLD functional APIs

iLLD shall provide API for each of the needed functionality the user may use. The API shall be made as one instance in the flash but shall be able to function on any number of identical peripherals. For each of the peripherals instances the parameter passed will be deferring.

The generic prototype shall be as\n
  <B>\<Driver Prefix\>_\<functionality\>(\<Driver Prefix\>_Handle *handle);</B>
where Driver Prefix example is IfxVadc or IfxGtmTom_Pwm.

\section lld_internal iLLD internal methods

For better modularisation readability reasons the driver implementations shall use the internal static functions. In such cases the function definitions shall be defined in the similar way as iLLD functional APIs


[\ref lld_structure "Previous page"] [\ref lld_conventions "Next page"]
*/
