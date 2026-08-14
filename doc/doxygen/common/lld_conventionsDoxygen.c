/**
	\page lld_doxygenRules Doxygen rules

	\section ucRootGroup Microcontroller root group
	The microcontroller documentation root group is IfxLld. The group is defined in the file info.dox located in the microcontroller derivative root directory.

	Example:
	\code
	* \defgroup IfxLld TC27x B-Step Microcontroller
	\endcode

	\section moduleGroup Modules group
	Module's group names have the follwing syntax: '\\defgroup IfxLld_\<Module\>'.
	The group is direct child of the \ref ucRootGroup.

v	\<Module\> is the module short name in with the 1st letter upper case and then lower case. The group name is defined in the Ifx<Module>_regdef.h file. Example:
	\code
	 * \defgroup IfxLld_Dma DMA
	 * \ingroup IfxLld
	\endcode

	The following groups are also defined in the Ifx<Module>_regdef.h file for each modules:
	- IfxLld_<Module>_Bitfields : Bitfield macro definition
	- IfxLld_<Module>_Union     : module union types
	- IfxLld_<Module>_Struct    : module struct types

	\section moduleStdGroup Module standard driver group
	Module's standard driver group have the follwing syntax: '\\defgroup IfxLld_<Module>_Std'.
	The group is direct child of the \ref moduleGroup.

	Example:
	\code
	 * \defgroup IfxLld_Asclin_Std Basic functionality
	 * \ingroup IfxLld_Asclin
	\endcode


	\section moduleInterfaceGroup Module interface driver group
	Module's interface driver group have the follwing syntax: '\\defgroup IfxLld_\<Module\>_\<Interface\>'.
	The group is direct child of the \ref moduleGroup.

	\<Interface\> is the interface driver name.

	Example:
	\code
	 * \defgroup IfxLld_Asclin_AscIf ASC interface driver
	 * Implements the standard ASC interface
	 * \ingroup IfxLld_Asclin
	\endcode

	\section generalRules General rules
	- As group name are global names, a group name shall start with the parent group name.
	- Group names are 1st letter upper case, then camel case, group levels are separated by underscore

	Example:
        -    |--IfxLld
        -    | |--IfxLld_Dma
        -    | | |--IfxLld_Dma_Std
        -    | |   |--IfxLld_Dma_Std_ChannelTransaction
        -    | | |--IfxLld_Dma_Dma


	\section docReturnValue Documentation of return values
	The return value shall be documented using \\return when docuementation is provided for a single case.

	The return value shall be documented using \\retval when docuementation is provided for a multiple case.

	Example (single case):
	\code
	 * \return Return the raw converted analog value.
	\endcode
	Output:
	 * \return Return the raw converted analog value.

	Example (multiple case):
	\code
	 * \retval TRUE in case of success
	 * \retval FALSE in case of error
	\endcode
	Output:
	 * \retval TRUE in case of success
	 * \retval FALSE in case of error


	\section parameterDocumentation
	Documentation shall provide range for parameters when not entirely defined.

	Example:
	\code
		// \param transferCount Number of transaction, Range=[0,32]
		 IFX_INLINE void IfxDma_setChannelTransaction(Ifx_DMA* dma,IfxDma_ChannelId channelId, uint32 transferCount)
		 { ... }
	\endcode

[\ref lld_dosanddont_if "Previous page"] [\ref lld_filesAndConfig "Next page"]

*/
