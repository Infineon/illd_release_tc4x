How to configure the VM0-STMx for interrupt generation for the Hypervisor Scheduler
1. In the Ifx_Cfg_Hv.c configure the values in IfxHvx_StmConfig structure with required values

How to adapt the intrinsics for Hypervisor Demo
1. IfxHv_Intrinsics.h new files is added which contians the wrapper for intrinsics
2. Include the project specific intrinsics and the map the Hypervisor Demo intrinsics to the project specific one
   Example: #define IFXHV_SETA11 Ifx__setA11
   In the above the seta11 macro is mapped to the iLLD intrinsic

How to configure the WTU related APIs
1. In the Ifx_Cfg_Hv.c wrapper hooks provided for disabling CPUx watchdog and System watchdog
2. Include the project implementation of WTU APIs in Ifx_Cfg_Hv.c and call the functions in IfxHv_disableCpuWatchdog and IfxHv_disableSystemWatchdog
   In the Hypervisor Demo, these APIs are mapped to iLLD WTU driver
