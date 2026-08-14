/**

\page lld_dosanddont_namingConvention Naming convention
	\section enum Enum
 <SPAN style="font-family:courier;font-size:small;">[link: \ref enum]</SPAN>

        Enumeration items must be prefixed with the enumeration type.

        Correct:
        \code
        typedef enum
        {
            IfxDma_ChannelPriority_low = 0,
            IfxDma_ChannelPriority_medium,
            IfxDma_ChannelPriority_high
        } IfxDma_ChannelPriority;
        \endcode
        Wrong (<SPAN style="font-family:courier">IfxDma_ChannelPriority<SPAN style="color:red">Select</SPAN></SPAN>):
        \code
        typedef enum
        {
            IfxDma_ChannelPriority_low = 0,
            IfxDma_ChannelPriority_medium,
            IfxDma_ChannelPriority_high
        } IfxDma_ChannelPrioritySelect;
        \endcode



	\section directoryName Directory name
 <SPAN style="font-family:courier;font-size:small;">[link: \ref directoryName]</SPAN>

        Dirtectory shall have the same name as the driver name without the Ifx prefix.

            Correct:
            - Dma
                - Dma
                    - IfxDma.c
                    - IfxDma.h

            Wrong:
            - Dma
                - <SPAN style="color:red">Interface</SPAN>
                    - IfxDma.c
                    - IfxDma.h


	\section parameter Function's parameter & struct members
 <SPAN style="font-family:courier;font-size:small;">[link: \ref parameter]</SPAN>

	Function parameter are not doing an action done but does set values for confiuguration, then there is no verb in the name.

	Correct:
	\code
	typedef struct
	{
		boolean                             hardwareRequestEnabled;                // \brief Enabling the hardware channel request
	} IfxDma_Dma_ChannelConfig;
	\endcode

	Wrong(<SPAN style="font-family:courier"><SPAN style="color:red">enable</SPAN>HardwareRequest</SPAN>):
	\code
	typedef struct
	{
		boolean                             enableHardwareRequest;                // \brief Enabling the hardware channel request
	} IfxDma_Dma_ChannelConfig;
	\endcode

	\section staticFunctionNames Static function names shall also be prefixed
 <SPAN style="font-family:courier;font-size:small;">[link: \ref staticFunctionNames]</SPAN>


	Correct:
	\code
	static void IfxDma_Dma_configureTransactionSet(Ifx_DMA_CH* channel, IfxDma_Dma_ChannelConfig* config)
	\endcode

	Wrong:
	\code
	static void configureTransactionSet(Ifx_DMA_CH* channel, IfxDma_Dma_ChannelConfig* config)
	\endcode

	\section parameterhandle Do not explicitely use 'handle' in the parameter name
 <SPAN style="font-family:courier;font-size:small;">[link: \ref parameterhandle]</SPAN>

	Remove the name �handle� from the parameter�s name, even we hnow that it is an handle. It does not add information but increase the source code length.

	Correct:
	\code
	IFX_EXTERN void IfxDma_Dma_initChannelConfig(IfxDma_Dma_ChannelConfig* config, IfxDma_Dma* dma);
	\endcode

	Wrong(<SPAN style="font-family:courier">dma<SPAN style="color:red">Handle</SPAN></SPAN>):
	\code
	IFX_EXTERN void IfxDma_Dma_initChannelConfig(IfxDma_Dma_ChannelConfig* config, IfxDma_Dma* dmaHandle);
	\endcode


[\ref lld_dosanddont "Previous page"] [\ref lld_dosanddont_codingRules "Next page"]

 */
