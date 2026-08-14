/** \page lld_conventions Naming Conventions

This section provides the naming convention to be followed during development.

As general rule all the "exported" types/definitions/class/objects (i.e. Function, enum, typedef, constant, variable, ...) should start with the filename + underscore "_".

Example: in file IfxScuWdt.c/h the function shall be:
  \li IfxScuWdt_enableEndinit()
  \li IfxScuWdt_disableEndinit()


\section files iLLD Files

Ifx\<HW Module name\>[\<HW Sub module name\>][_SW Driver if special][sub SW module name].c/h

Example:
  \li 1) With HW module only without sub-module: IfxPort.c/.h
  \li 2)	With HW module and sub-module: IfxScuWdt.c/.h
  \li 3)	With HW module sub-module and SW driver: IfxGtmTom_Pwm.c/.h
  \li 4)	With HW module sub-module and SW driver + SW sub module: IfxGtmTom_PwmHl.c/.h (only if it makes sense to split the 10:files to make it modular)

Important things to check during review/ or with static code check tools:
  \li 1)	Prefix: Ifx (in title case)
  \li 2)	\<module name\>[\<HW Sub module name\>] (in camel case)
  \li 3)	[_SW Driver if special] (an underscore to separate and title case SW driver name)
  \li 4)	.c and .h in the small case


\section types Data Types
<B>typedef \<standard type\> Ifx\<HW Module name\>[\<HW Sub module name\>][_SW Driver if special]_\<user type name\>;</B>

\<Standard type\> structure/union/enum definitions with its elements, and other C data types

Example:
\code
typedef struct
{
    uint32  pllFreqInHz;
    uint32  stepFreqInHz;
    uint8   stepPerIn_uSec;
    uint8   pDivider;
    uint8   nDivider;
    uint8   k2Divider;
} IfxScu_Pll_Config;
\endcode

Important things to check:
  \li 1) Points 1 to 3 for filenames
  \li 2) _\<user type name \>: an underscore to separate with the rest and Camel case letters (first letter also capital).


\section struct Structures

To define structure types the convention shall be followed as in type defines above.

For structure elements simple name with camel case letters with first letter small shall be used.

Refer to the example for naming convention for type defines


\section enum Enumerated Types
To define enum types the convention shall be followed as in type defines above.

For enum elements following naming convention to be followed:\n
<B>Ifx\<HW Module name\>[\<HW Sub module name\>][_SW Driver if special]_\<Enum Name\>_\<Enum element\></B>

\<Enum element\> camel case letter
\<Enum Name\> Camel case letter

Example:
\code
typedef enum {
    IfxDma_ChannelPriority_low = 0,
    IfxDma_ChannelPriority_medium,
    IfxDma_ChannelPriority_high
} IfxDma_ChannelPriority;
\endcode

Important things to check:
  \li 1) Points 1 to 3 for filenames
  \li 2) _\<Enum Element\>: an underscore to separate with the rest and Camel case letters (first letter lower case).



\section defines #define Constants or Macros

 <B>#define IFX\<MODULE\>[\<HW SUB MODULE NAME\>][_SW DRIVER]_\<FUNCTIONALITY NAME\></B>

\<FUNCTIONALITY NAME\>: Meaningful name to represent the functionality. With "_" to separate words

Example:
\code
#define IFXSCUCCU_PLL_FREE_RUNNING_FREQ (100000000U)
\endcode

Important things to check:
  \li 1) all capital letters


\section function Functions

All exported functions:
  <B>Ifx\<HW Module name\>[\<HW Sub module name\>][_SW Driver if special]_\<Functionality\></B>

Example:

\code
   IfxGtmTom_Pwm_setDutyCycle(..)
\endcode

Important things to check:
  \li 1) Points 1 to 3 for filenames
  \li 2)_\<Functionality\>: an underscore to separate and Camel case letters with first letter small. (Convention used with object oriented programming). Functionality shall start with the main action (verb) to be fulfilled with the interface.

For example:
  \li An interface to set pin level high, the function name is setPinHigh.
  \li An interface to read the result of ADC conversion is readResult
  \li An interface to send the data byte over communication peripheral sendByte

\section parameter Function's parameter & struct members
Function parameter are not doing an action done but does set values for confiuguration, then there is no verb in the name.

Examples:
\code
typedef struct
{
    boolean                             hardwareRequestEnabled;                // \brief Enabling the hardware channel request
} IfxDma_Dma_ChannelConfig;
\endcode

\section inline Inline Functions

All inline functions as:\n
  <B>IFX_INLINE \<function definition\></B>

Shall follow the naming conventions as in Functions


\section standard Infineon definitions for Standard Data Types

Located in \ref Cpu/Std/Platform_Types.h


[\ref lld_api "Previous page"] [\ref lld_codingRules "Next page"]
*/
