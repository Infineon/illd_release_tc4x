/**

\page lld_dosanddont_enumUsage Usage of enums
	\section convention_in_std enum convention in microcontroller /Std drivers
 <SPAN style="font-family:courier;font-size:small;">[link: \ref convention_in_std]</SPAN>


	\todo Discuss and agree on the enum naming convention

        In case an enum represents a register bitfield value, then the following rules apply:
        - The enum type shall have an explicit name. The name shall not include register or bitfield short names. This is to abstract the setting when passed as a parameter to a function in the same way the function APIs names does.
        - Each enum member shall define explicitly an enum value with '='.
        - The enum documentation shall state for which register bitfield the enum has been defined with "Definition for <ModuleType>.<REGISTER NAME>.B.<BITFIELDNAME>", this to avoid misuse of the enum.
        - Each of the member shall have a documentation, that explain to users what is the enum for without reading the user manual.
        - Only enum defined in the current Std or base drivers shall be used.

        Correct:
        \code
        // File Std/IfxQspi.h

        // QSPI controller mode
        // Definition for Ifx_QSPI.GLOBALCON.B.MS
        typedef enum
        {
            IfxQspi_Mode_master     = 0,   // QSPI in "master" mode
            IfxQspi_Mode_pwmOverSpi = 1,   // QSPI in "PWM over SPI" mode
            IfxQspi_Mode_slave      = 2    // QSPI in "slave" mode
        } IfxQspi_Mode;

        void IfxQspi_foo(IfxQSPI* module)
        {
            if (module->GLOBALCON.B.MS != IfxQspi_Mode_slave)
            { //...
            }
            else
            { // ...
            }
        }

        \endcode

        Wrong:
        \code
        // File 1_SrvSw/If/SscIf.h

        // SSC operation modes
        typedef enum
        {
            SscIf_Mode_master,     // Master mode
            SscIf_Mode_slave,      // Slave mode
            SscIf_Mode_undefined   // Undefined mode
        } SscIf_Mode;

        // File Std/IfxQspi.h

        // QSPI controller mode
        typedef enum
        {
            IfxQspi_GLOBALCON_MS_master = 0,            // Corresponds with GLOBALCON.B.MS == 0
            IfxQspi_GLOBALCON_MS_pwmOverSpi,            // Corresponds with GLOBALCON.B.MS == 1
            IfxQspi_GLOBALCON_MS_slave                  // Corresponds with GLOBALCON.B.MS == 2
        } IfxQspi_GLOBALCON_MS;

        void IfxQspi_foo(IfxQSPI* module)
        {
            if (module->GLOBALCON.B.MS != SscIf_Mode_slave)
            { //...
            }
            else
            { // ...
            }
        }

        \endcode


	\section enum_in_std Usage of enums in microcontroller interface drivers
 <SPAN style="font-family:courier;font-size:small;">[link: \ref enum_in_std]</SPAN>


        The code dependencies shall be limited to the microcontroller HAL and service software interface /1_SrvSw/If, therefore only enums from this files can be used.

        \code
        // File 1_SrvSw/If/SscIf.h

        // SSC operation modes
        typedef enum
        {
            SscIf_Mode_master,     // Master mode
            SscIf_Mode_slave,      // Slave mode
            SscIf_Mode_undefined   // Undefined mode
        } SscIf_Mode;

        // File Ssc/IfxQspi_Ssc.h

        // QSPI controller mode
        // Definition for Ifx_QSPI.GLOBALCON.B.MS
        typedef enum
        {
            IfxQspi_Mode_master     = 0,   // QSPI in "master" mode
            IfxQspi_Mode_pwmOverSpi = 1,   // QSPI in "PWM over SPI" mode
            IfxQspi_Mode_slave      = 2    // QSPI in "slave" mode
        } IfxQspi_Mode;



        SscIf_Mode IfxQspi_Ssc_foo(void)
        {
            SscIf_Mode mode;
            switch ( IfxQspi_getMode(&MODULE_QSPI0))
            {
            case IfxQspi_Mode_master:
                mode = SscIf_Mode_master;
                break;
            case IfxQspi_Mode_slave:
                mode = IfxQspi_Mode_slave;
                break;
            default:
                mode = SscIf_Mode_undefined;
                break;
            }
        }
        \endcode

	\section enumIndex Enum name with index
 <SPAN style="font-family:courier;font-size:small;">[link: \ref enumIndex]</SPAN>

	Do not use left zero padding for enum names, because the highest index number can not be assumed to be fixed.

	Correct:
	\code
		typedef enum
        {
            Dma_Channel_0      = 0,
            Dma_Channel_1      = 1,
            Dma_Channel_2      = 2,
            Dma_Channel_3      = 3
        } IfxQspi_Mode;
	\endcode

	Wrong:
	\code
		typedef enum
        {
            Dma_Channel_00      = 0,
            Dma_Channel_01      = 1,
            Dma_Channel_02      = 2,
            Dma_Channel_03      = 3
        } IfxQspi_Mode;
	\endcode

	\section enumPrefix Enum members shall be prefixed with the enum type
 <SPAN style="font-family:courier;font-size:small;">[link: \ref enumPrefix]</SPAN>


	Correct:
	\code
		typedef enum
		{
			IfxDma_Channel_0 = 0,
		} IfxDma_Channel;
	\endcode

	Wrong(<SPAN style="font-family:courier">IfxDma_Channel<SPAN style="color:red">Id</SPAN></SPAN>):
	\code
		typedef enum
		{
			Dma_Channel_0 = 0,
		} IfxDma_ChannelId;
	\endcode




[\ref lld_dosanddont_optimisation "Previous page"]



 */
