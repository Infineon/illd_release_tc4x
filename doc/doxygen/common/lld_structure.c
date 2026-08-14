/** \page lld_structure General Structure of iLLDs

We can basically differ between two types of iLLDs:

\section unifunctional Unifunctional Peripheral Drivers

Unifunctional peripheral drivers are simple modules where the target peripheral is able to carry out one type of functionality.

Example: VADC peripheral for analog-to-digital conversion. Multican for CAN protocol communication, DMA for DMA functionality, etc.

\image html "unifunctional.png" Unifunctional Peripheral Driver

\section multifunctional Multifunctional Peripheral Drivers

These kind of peripheral drivers are complex to handle, and here the target peripheral can carry out multiple functionalities ("use cases").

Example: AscLin peripheral can be configured as a common UART, but also as a LIN or even a SPI.\n
GTM TOM/ATOM can be used as PWM generator, complex waveform generator and any generic timer, etc.

\image html "multifunctional.png" Multifunctional Peripheral Driver


\section lldcontent Content of Peripheral Drivers

iLLDs consist of following components:
  \li Peripheral Register Memory Map (SFR header file)
  \li a Standard Layer with (verbose) access functions to SFRs which are changed during application runtime
  \li an Interface Layer with configuration and handling functions\n
      Multiple Interface Layers could be available if the peripheral is used for different purposes.
  \li Pinmaps to configure I/O multiplexers



\section configdata Configuration Data Structures

A configuration structure, which is part of an interface layer, holds the parameters to configure the driver. Depending on the iLLD and its associated peripheral there could be multiple levels of configuration data structures. As in case of VADC there could be data structure to configure the VADC module, a structure for the configuring the group and another for the channels.

The data structure shall be defined in a memory optimised way considering the structures are non-packed in the memory map. All the structure elements shall be organised in a way that they are ordered in the descending order of their physical memory size.

<B>Usage:</B> In normal cases configuration data structures are locally stored (on the stack) inside specific initialization routines. They can also be placed in the flash/ROM


<B>Example for a configuration struct:</B>
\code
typedef struct
{
    const IfxVadc_Adc        *module;                   /**< \brief Specifies pointer to the IfxVadc_Adc module handle */
    IfxVadc_GroupId           groupId;                  /**< \brief Specifies the group/kernel id */
    IfxVadc_GroupId           master;                   /**< \brief Specifies the master group if own group is different master slave is configured */
    IfxVadc_Adc_ArbiterConfig arbiter;                  /**< \brief Specifies arbiter configuration */
    IfxVadc_Adc_ClassConfig   inputClass[IFXVADC_NUMBER_OF_INPUTCLASS]; /**< \brief Specifies conversion settings one and two */
    IfxVadc_Adc_ScanConfig    scanRequest;              /**< \brief Specifies scan mode configuration */
    IfxVadc_Adc_QueueConfig   queueRequest;             /**< \brief Specifies queued mode configuration */
    IfxVadc_Adc_ScanConfig    backgroundScanReq;        /**< \brief Specifies back ground scan configuration */
    boolean                   disablePostCalibration;   /**< \brief Specifies if calibration after conversion (post calibration) should be disabled */
} IfxVadc_Adc_GroupConfig;
\endcode

\section runtimevars Runtime Variables (Handles)

Runtime variables are usually stored in so called "handles". This structure is separated from the configuration structure mentioned above (because such structures are only needed during initialization phase).

Handles are used to reference resources of a peripheral by interface functions without unnecessary calculation or parameter passing overhead. A handle struct contains at least a pointer to the base address of the peripheral which should be accessed, pointers to peripheral subcomponents where required, and/or indices (such as a channel or timer number).

Handles are to be instantiated per instance of the used peripheral. Higher SW layers store  knows number of instances required for the intended application and it reserves the memory for these many data structures.

The data structure must be made to be available in the DMI RAM of the Cpu from which lld API calls are more frequently done.

<B>Example for an handle:</B>
\code
typedef struct
{
    IfxVadc_Adc     module;               /**< \brief The VADC handle structure */
    Ifx_VADC_G     *group;                /**< \brief Pointer to the group registers */
    IfxVadc_GroupId groupId;              /**< \brief Specifies the group index */
} IfxVadc_Adc_Group;
\endcode


[\ref introduction "Previous page"] [\ref lld_api "Next page"]
*/
