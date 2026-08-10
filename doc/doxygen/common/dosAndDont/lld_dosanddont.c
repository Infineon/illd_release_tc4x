/**
\page lld_dosanddont Do's and don't

-# \subpage lld_dosanddont_namingConvention
-# \subpage lld_dosanddont_codingRules
-# \subpage lld_dosanddont_documentation
-# \subpage lld_dosanddont_optimisation
-# \subpage lld_dosanddont_enumUsage



[\ref lld_versioning "Previous page"] [\ref lld_dosanddont_namingConvention "Next page"]


\page lld_dosanddont_codingRules Coding rules

	\section typeAssumption Type assumption
 <SPAN style="font-family:courier;font-size:small;">[link: \ref typeAssumption]</SPAN>

	Bitfield values should not be assumed as Boolean.

	Correct:
	\code
	IFX_INLINE boolean IfxDma_getChannelPatternDetectionOldValue(Ifx_DMA* dma,IfxDma_ChannelId channelId)
	{
		return dma->CH[channelId].CHCSR.B.LXO != 0;
	}
	\endcode

	Wrong:
	\code
	IFX_INLINE boolean IfxDma_getChannelPatternDetectionOldValue(Ifx_DMA* dma,IfxDma_ChannelId channelId)
	{
		return dma->CH[channelId].CHCSR.B.LXO;
	}
	\endcode


	\section variableNmaes Variable names
 <SPAN style="font-family:courier;font-size:small;">[link: \ref variableNmaes]</SPAN>

		Use explicit names for variable.
		Example:
		With
		\code
			Ifx_DMA*       dma;
			dma->source = 0x123;
		\endcode
		the code can be easier understand than with
		\code
			Ifx_DMA*       baseAddr;
			baseAddr->source = 0x123;
		\endcode

	\section numbers Avoid numbers, use constant instead
 <SPAN style="font-family:courier;font-size:small;">[link: \ref numbers]</SPAN>


	Correct:
	\code
	#define IFXDMA_DMA_ENABLE_SHADOW_ADDRESS (2) // Position of the shadow address enable bit

	static void IfxDma_Dma_configureTransactionSet(Ifx_DMA_CH* channel, IfxDma_Dma_ChannelConfig* config)
	{
		...
		if( config->shadowControl & (1 << IFXDMA_DMA_ENABLE_SHADOW_ADDRESS) )
		{
			channel->SHADR.U = config->shadowAddress;
		}
	}
	\endcode

	Wrong:
	\code
	static void IfxDma_Dma_configureTransactionSet(Ifx_DMA_CH* channel, IfxDma_Dma_ChannelConfig* config)
	{
		...
		if( config->shadowControl & (1 << 2) )
		{
			channel->SHADR.U = config->shadowAddress;
		}
	}
	\endcode

	. Example(1 << 2) below


[\ref lld_dosanddont_namingConvention "Previous page"] [\ref lld_dosanddont_documentation "Next page"]

\page lld_dosanddont_documentation Documentation

	\section theSame Avoid 'the same' in documentation
 <SPAN style="font-family:courier;font-size:small;">[link: \ref theSame]</SPAN>

	Correct:
	\code
	    boolean                             channelInterrupt;                     // \brief Determines the setting of the channel transfer interrupt flag and interrupt service request
	\endcode

	Wrong(<SPAN style="font-family:courier"><SPAN style="color:red">for the same</SPAN></SPAN>):
	\code
	    boolean                             channelInterrupt;                     // \brief Determines the setting of the channel transfer interrupt flag and interrupt service request for the same
	\endcode



[\ref lld_dosanddont_codingRules "Previous page"] [\ref lld_dosanddont_optimisation "Next page"]


*/
