/**
\page lld_codingRules Coding rules

-# \subpage lld_codingRules_codeFormating
-# \subpage lld_codingRules_general
-# \subpage lld_codingRules_codeChecking
-# \subpage lld_dosanddont_commonApis

[\ref lld_conventions "Previous page"] [\ref lld_codingRules_codeFormating "Next page"]

\page lld_codingRules_general General rules

    \section curlyBraces Always use curly braces for if, for, while, do, ...

	Correct:
	\code
	static void IfxDma_Dma_configureTransactionSet(Ifx_DMA_CH* channel, IfxDma_Dma_ChannelConfig* config)
	{
		...
		if( config->shadowControl != 0)
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
		if( config->shadowControl != 0)
			channel->SHADR.U = config->shadowAddress;
	}
	\endcode




[\ref lld_codingRules_codeFormating "Previous page"] [\ref lld_codingRules_codeChecking "Next page"]




\page lld_codingRules_codeChecking  Code checking
    \section parameterCheck Parameter check
	In case the parameter can not be checked by the compiler for valid values, it shall be checked using the assertion function.

	Example:
	\code
		IFX_INLINE void IfxDma_setChannelTransaction(Ifx_DMA* dma,IfxDma_ChannelId channelId, uint32 transferCount)
		{
		IFX_ASSERT(VERBOSE_LEVEL_ERROR,transferCount < 32);
		}
	\endcode





[\ref lld_codingRules_general "Previous page"] [\ref lld_dosanddont_commonApis "Next page"]




 */
