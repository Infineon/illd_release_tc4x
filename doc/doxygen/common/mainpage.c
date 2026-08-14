/** \mainpage IFX Low Level Drivers

\section introduction Introduction

The aim of the IFX Low Level Driver library (iLLD) is to provide access and configuration functions for the integrated peripherals of Infineon microcontrollers - from a simple timer register access up to 3 phases PWM driver for inverter applications. Together with SFR header files they are a fundamental part of the infrastructure for tests and applications which are developed by several teams at IFX ATV.

All drivers follow the same coding style to ensure a common "Look&Feel". The application interfaces (APIs) are defined and implemented by Hardware/Software experts, already tested pre-silicon with a virtual prototype or in RTL simulations, and then shared by all teams which are involved in programming software:

\image html "lld_usage.png" "iLLD Usage at Infineon"

This cross usage model should not only help to reduce development efforts, but also improve the quality/reliability of the drivers.

The strict iLLD coding guidelines allow layering of drivers for multi-dimensional system scenarios. There is no dependency between the peripheral drivers. Optionally they can be isolated from the library and provided as a separate package (e.g. for application notes delivered to customers).

iLLDs are currently planned for Aurix and Aurix 2G derivatives.

Each derivative has its own set of iLLD sources, which are located in GIT. Versionized packages are also distributed via MyICP.


\section toc Table Of Contents

  \li \subpage lld_structure
  \li \subpage lld_api
  \li \subpage lld_conventions
  \li \subpage lld_codingRules
  \li \subpage lld_doxygenRules
  \li \subpage lld_filesAndConfig
  \li \subpage lld_versioning
  \li \subpage lld_dosanddont

[\ref lld_structure "Next page"]

*/

/**
* \defgroup IfxLld iLLD
*/
