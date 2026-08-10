/**
\page lld_dosanddont_optimisation Optimisation
	\section moduleRegisterAccessByArray Module register access (array)
 <SPAN style="font-family:courier;font-size:small;">[link: \ref moduleRegisterAccessByArray]</SPAN>

        Code should be optimised by using array index instead of if..else.

        Correct:
        \code
            dma->BLK[index]. ...
        \endcode

        Wrong:
        \code
            if( moveEngine == IfxDma_MoveEngine_1 )
            {
                dma->BLK1. ...
            }
            else
            {
                dma->BLK0. ...
            }
        \endcode

        In case the array is not available in the module structure definition, please request for implementation. The reasons could be:
        - it has been forgotten to build the array during the register header file generation
        - the module address map does not currently supports the array access

	\section moduleRegisterAccess Module register access (read modify write)
 <SPAN style="font-family:courier;font-size:small;">[link: \ref moduleRegisterAccess]</SPAN>

        Runtime optimisation should be done by utilizing a local variable when more than one bitfield of a register is to be modified.

        Correct:
        \code
        IFX_INLINE void IfxDma_setChannelSourceIncrementStep(Ifx_DMA* dma,IfxDma_ChannelId channelId, IfxDma_ChannelIncrementStep incStep, IfxDma_ChannelIncrementDirection direction, IfxDma_ChannelIncrementCircular size)
        {
            Ifx_DMA_BLK_ME_ADICR adicr;
            adicr.U = dma->CH[channelId].ADICR.U;
            adicr.B.SMF = incStep;
            adicr.B.INCS = direction;
            adicr.B.CBLS = size;
            dma->CH[channelId].ADICR.U = adicr.U;
        }
        \endcode

        Wrong:
        \code
        IFX_INLINE void IfxDma_setChannelSourceIncrementStep(Ifx_DMA* dma,IfxDma_ChannelId channelId, IfxDma_ChannelIncrementStep incStep, IfxDma_ChannelIncrementDirection direction, IfxDma_ChannelIncrementCircular size)
        {
            dma->CH[channelId].ADICR.B.SMF = incStep;
            dma->CH[channelId].ADICR.B.INCS = direction;
            dma->CH[channelId].ADICR.B.CBLS = size;
        }
        \endcode

[\ref lld_dosanddont_documentation "Previous page"] [\ref lld_dosanddont_enumUsage "Next page"]



 */
