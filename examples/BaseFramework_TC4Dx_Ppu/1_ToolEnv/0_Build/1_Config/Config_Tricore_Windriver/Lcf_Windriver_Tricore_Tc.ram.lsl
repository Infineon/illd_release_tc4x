
-Xgenerate-copytables

LCF_CSA0_SIZE    = 8k;
LCF_USTACK0_SIZE = 2k;
LCF_ISTACK0_SIZE = 1k;

LCF_CSA1_SIZE    = 8k;
LCF_USTACK1_SIZE = 2k;
LCF_ISTACK1_SIZE = 1k;

LCF_CSA2_SIZE    = 8k;
LCF_USTACK2_SIZE = 2k;
LCF_ISTACK2_SIZE = 1k;

LCF_CSA3_SIZE    = 8k;
LCF_USTACK3_SIZE = 2k;
LCF_ISTACK3_SIZE = 1k;

LCF_CSA4_SIZE    = 8k;
LCF_USTACK4_SIZE = 2k;
LCF_ISTACK4_SIZE = 1k;

LCF_CSA5_SIZE    = 8k;
LCF_USTACK5_SIZE = 2k;
LCF_ISTACK5_SIZE = 1k;

LCF_HEAP_SIZE = 4k;

LCF_PPU_FLASH_SIZE  = 1M;
LCF_PPU_LMURAM_SIZE = 512k;
LCF_PPU_CSM_SIZE    = 512k;

LCF_DSPR5_START = 0x20000000;
LCF_DSPR5_SIZE  = 240k;

LCF_DSPR4_START = 0x30000000;
LCF_DSPR4_SIZE  = 240k;

LCF_DSPR3_START = 0x40000000;
LCF_DSPR3_SIZE  = 240k;

LCF_DSPR2_START = 0x50000000;
LCF_DSPR2_SIZE  = 240k;

LCF_DSPR1_START = 0x60000000;
LCF_DSPR1_SIZE  = 240k;

LCF_DSPR0_START = 0x70000000;
LCF_DSPR0_SIZE  = 240k;

LCF_CSA5_OFFSET    = (LCF_DSPR5_SIZE - 1k - LCF_CSA5_SIZE);
LCF_ISTACK5_OFFSET = (LCF_CSA5_OFFSET - 256 - LCF_ISTACK5_SIZE);
LCF_USTACK5_OFFSET = (LCF_ISTACK5_OFFSET - 256 - LCF_USTACK5_SIZE);

LCF_CSA4_OFFSET    = (LCF_DSPR4_SIZE - 1k - LCF_CSA4_SIZE);
LCF_ISTACK4_OFFSET = (LCF_CSA4_OFFSET - 256 - LCF_ISTACK4_SIZE);
LCF_USTACK4_OFFSET = (LCF_ISTACK4_OFFSET - 256 - LCF_USTACK4_SIZE);

LCF_CSA3_OFFSET    = (LCF_DSPR3_SIZE - 1k - LCF_CSA3_SIZE);
LCF_ISTACK3_OFFSET = (LCF_CSA3_OFFSET - 256 - LCF_ISTACK3_SIZE);
LCF_USTACK3_OFFSET = (LCF_ISTACK3_OFFSET - 256 - LCF_USTACK3_SIZE);

LCF_CSA2_OFFSET    = (LCF_DSPR2_SIZE - 1k - LCF_CSA2_SIZE);
LCF_ISTACK2_OFFSET = (LCF_CSA2_OFFSET - 256 - LCF_ISTACK2_SIZE);
LCF_USTACK2_OFFSET = (LCF_ISTACK2_OFFSET - 256 - LCF_USTACK2_SIZE);

LCF_CSA1_OFFSET    = (LCF_DSPR1_SIZE - 1k - LCF_CSA1_SIZE);
LCF_ISTACK1_OFFSET = (LCF_CSA1_OFFSET - 256 - LCF_ISTACK1_SIZE);
LCF_USTACK1_OFFSET = (LCF_ISTACK1_OFFSET - 256 - LCF_USTACK1_SIZE);

LCF_CSA0_OFFSET    = (LCF_DSPR0_SIZE - 1k - LCF_CSA0_SIZE);
LCF_ISTACK0_OFFSET = (LCF_CSA0_OFFSET - 256 - LCF_ISTACK0_SIZE);
LCF_USTACK0_OFFSET = (LCF_ISTACK0_OFFSET - 256 - LCF_USTACK0_SIZE);

LCF_HEAP0_OFFSET = (LCF_USTACK0_OFFSET - LCF_HEAP_SIZE);
LCF_HEAP1_OFFSET = (LCF_USTACK1_OFFSET - LCF_HEAP_SIZE);
LCF_HEAP2_OFFSET = (LCF_USTACK2_OFFSET - LCF_HEAP_SIZE);
LCF_HEAP3_OFFSET = (LCF_USTACK3_OFFSET - LCF_HEAP_SIZE);
LCF_HEAP4_OFFSET = (LCF_USTACK4_OFFSET - LCF_HEAP_SIZE);
LCF_HEAP5_OFFSET = (LCF_USTACK5_OFFSET - LCF_HEAP_SIZE);

LCF_INTVEC0_START  = 0x9007E000;
LCF_INTVEC1_START  = 0x900FE000;
LCF_INTVEC2_START  = 0x9017E000;
LCF_INTVEC3_START  = 0x901FE000;
LCF_INTVEC4_START  = 0x9027E000;
LCF_INTVEC5_START  = 0x902FE000;


__INTTAB_CPU0 = LCF_INTVEC0_START;
__INTTAB_CPU1 = LCF_INTVEC1_START;
__INTTAB_CPU2 = LCF_INTVEC2_START;
__INTTAB_CPU3 = LCF_INTVEC3_START;
__INTTAB_CPU4 = LCF_INTVEC4_START;
__INTTAB_CPU5 = LCF_INTVEC5_START;

LCF_TRAPVEC0_START = 0x90000100;
LCF_TRAPVEC1_START = 0x90080100;
LCF_TRAPVEC2_START = 0x90100100;
LCF_TRAPVEC3_START = 0x90180100;
LCF_TRAPVEC4_START = 0x90200100;
LCF_TRAPVEC5_START = 0x90280100;

LCF_STARTPTR_CPU0 = 0x90000000;
LCF_STARTPTR_CPU1 = 0x90080000;
LCF_STARTPTR_CPU2 = 0x90100000;
LCF_STARTPTR_CPU3 = 0x90180000;
LCF_STARTPTR_CPU4 = 0x90200000;
LCF_STARTPTR_CPU5 = 0x90280000;

LCF_STARTPTR_NC_CPU0 = 0xB0000000;
LCF_STARTPTR_NC_CPU1 = 0xB0080000;
LCF_STARTPTR_NC_CPU2 = 0xB0100000;
LCF_STARTPTR_NC_CPU3 = 0xB0180000;
LCF_STARTPTR_NC_CPU4 = 0xB0200000;
LCF_STARTPTR_NC_CPU5 = 0xB0280000;

RESET = LCF_STARTPTR_NC_CPU0;

MEMORY
{
    dsram5: org = 0x20000000, len = 240K
    psram5: org = 0x20100000, len = 64K


    dsram4: org = 0x30000000, len = 240K
    psram4: org = 0x30100000, len = 64K


    dsram3: org = 0x40000000, len = 240K
    psram3: org = 0x40100000, len = 64K


    dsram2: org = 0x50000000, len = 240K
    psram2: org = 0x50100000, len = 64K


    dsram1: org = 0x60000000, len = 240K
    psram1: org = 0x60100000, len = 64K


    dsram0: org = 0x70000000, len = 240K
    psram0: org = 0x70100000, len = 64K

    psram_local: org = 0xc0000000, len = 64K

    pfls0: org = 0x80000000, len = 4M
    pfls0_nc: org = 0xa0000000, len = 4M

    pfls1: org = 0x80400000, len = 4M
    pfls1_nc: org = 0xa0400000, len = 4M

    pfls2: org = 0x80800000, len = 2M
    pfls2_nc: org = 0xa0800000, len = 2M

    pfls3: org = 0x80a00000, len = 4M
    pfls3_nc: org = 0xa0a00000, len = 4M

    pfls4: org = 0x80e00000, len = 4M
    pfls4_nc: org = 0xa0e00000, len = 4M

    pfls5: org = 0x81200000, len = 2M - 512k
    pfls5_nc: org = 0xa1200000, len = 2M - 512k

    ucb: org = 0xae400000, len = 80K

    cpu0_dlmu: org = 0x90000000, len = 512K
    cpu0_dlmu_nc: org = 0xb0000000, len = 512K

    cpu1_dlmu: org = 0x90080000, len = 512K
    cpu1_dlmu_nc: org = 0xb0080000, len = 512K

    cpu2_dlmu: org = 0x90100000, len = 512K
    cpu2_dlmu_nc: org = 0xb0100000, len = 512K

    cpu3_dlmu: org = 0x90180000, len = 512K
    cpu3_dlmu_nc: org = 0xb0180000, len = 512K

    cpu4_dlmu: org = 0x90200000, len = 512K
    cpu4_dlmu_nc: org = 0xb0200000, len = 512K

    cpu5_dlmu: org = 0x90280000, len = 512K
    cpu5_dlmu_nc: org = 0xb0280000, len = 512K

    lmuram: org = 0x90400000, len = 5M - 512K - 1M
    lmuram_nc: org = 0xb0400000, len = 5M - 512K - 1M
	
    ppu_lmuram : org = 0x90880000, len = 512k
    ppu_lmuram_nc : org = 0xb0880000, len = 512k  

    ppu_csm : org = 0x92080000, len = 512k
    ppu_csm_nc : org = 0xb2080000, len = 512k
    
    ppu_code : org = 0x90780000, len = 1M
    ppu_code_nc : org = 0xB0780000, len = 1M 
}

SECTIONS
{
/* Sections located at absolute fixed address */
/* Fixed memory Allocations for stack memory and CSA */
    /* CPU5 Stack and CSA defines */
    CPU5.ustack BIND(LCF_DSPR5_START + LCF_USTACK5_OFFSET) :
    { __USTACK5_END = . ;    . = . + LCF_USTACK5_SIZE;    __USTACK5 = . ; }
    
    CPU5.istack BIND(LCF_DSPR5_START + LCF_ISTACK5_OFFSET):
    { __ISTACK5_END = . ;    . = . + LCF_ISTACK5_SIZE;    __ISTACK5 = . ; }
    
    CPU5.csa BIND(LCF_DSPR5_START + LCF_CSA5_OFFSET):
    { __CSA5 = . ;    . = . + LCF_CSA5_SIZE;    __CSA5_END = . ; }

    /* CPU4 Stack and CSA defines */
    CPU4.ustack BIND(LCF_DSPR4_START + LCF_USTACK4_OFFSET) :
    { __USTACK4_END = . ;    . = . + LCF_USTACK4_SIZE;    __USTACK4 = . ; }
    
    CPU4.istack BIND(LCF_DSPR4_START + LCF_ISTACK4_OFFSET):
    { __ISTACK4_END = . ;    . = . + LCF_ISTACK4_SIZE;    __ISTACK4 = . ; }
    
    CPU4.csa BIND(LCF_DSPR4_START + LCF_CSA4_OFFSET):
    { __CSA4 = . ;    . = . + LCF_CSA4_SIZE;    __CSA4_END = . ; }

    /* CPU3 Stack and CSA defines */
    CPU3.ustack BIND(LCF_DSPR3_START + LCF_USTACK3_OFFSET) :
    { __USTACK3_END = . ;    . = . + LCF_USTACK3_SIZE;    __USTACK3 = . ; }
    
    CPU3.istack BIND(LCF_DSPR3_START + LCF_ISTACK3_OFFSET):
    { __ISTACK3_END = . ;    . = . + LCF_ISTACK3_SIZE;    __ISTACK3 = . ; }
    
    CPU3.csa BIND(LCF_DSPR3_START + LCF_CSA3_OFFSET):
    { __CSA3 = . ;    . = . + LCF_CSA3_SIZE;    __CSA3_END = . ; }

    /* CPU2 Stack and CSA defines */
    CPU2.ustack BIND(LCF_DSPR2_START + LCF_USTACK2_OFFSET) :
    { __USTACK2_END = . ;    . = . + LCF_USTACK2_SIZE;    __USTACK2 = . ; }
    
    CPU2.istack BIND(LCF_DSPR2_START + LCF_ISTACK2_OFFSET):
    { __ISTACK2_END = . ;    . = . + LCF_ISTACK2_SIZE;    __ISTACK2 = . ; }
    
    CPU2.csa BIND(LCF_DSPR2_START + LCF_CSA2_OFFSET):
    { __CSA2 = . ;    . = . + LCF_CSA2_SIZE;    __CSA2_END = . ; }

    /* CPU1 Stack and CSA defines */
    CPU1.ustack BIND(LCF_DSPR1_START + LCF_USTACK1_OFFSET) :
    { __USTACK1_END = . ;    . = . + LCF_USTACK1_SIZE;    __USTACK1 = . ; }
    
    CPU1.istack BIND(LCF_DSPR1_START + LCF_ISTACK1_OFFSET):
    { __ISTACK1_END = . ;    . = . + LCF_ISTACK1_SIZE;    __ISTACK1 = . ; }
    
    CPU1.csa BIND(LCF_DSPR1_START + LCF_CSA1_OFFSET):
    { __CSA1 = . ;    . = . + LCF_CSA1_SIZE;    __CSA1_END = . ; }

    /* CPU0 Stack and CSA defines */
    CPU0.ustack BIND(LCF_DSPR0_START + LCF_USTACK0_OFFSET) :
    { __USTACK0_END = . ;    . = . + LCF_USTACK0_SIZE;    __USTACK0 = . ; }
    
    CPU0.istack BIND(LCF_DSPR0_START + LCF_ISTACK0_OFFSET):
    { __ISTACK0_END = . ;    . = . + LCF_ISTACK0_SIZE;    __ISTACK0 = . ; }
    
    CPU0.csa BIND(LCF_DSPR0_START + LCF_CSA0_OFFSET):
    { __CSA0 = . ;    . = . + LCF_CSA0_SIZE;    __CSA0_END = . ; }

    __SP_END = __USTACK0_END;

    /*Fixed memory Allocations for _START*/
    .start_tc0 (TEXT) LOAD(LCF_STARTPTR_CPU0) BIND(LCF_STARTPTR_NC_CPU0) : { __ENABLE_INDIVIDUAL_C_INIT_CPU0 = 0; KEEP (*(.start)) .= 0xB0000020; } =0x800 > cpu0_dlmu_nc
    .interface_const (CONST) BIND(0x90000020) : { __IF_CONST = .; KEEP (*(.interface_const)) } > cpu0_dlmu

    /*Fixed memory Allocations for Trap Vector Table*/
    .traptab_tc0 (TEXT) BIND(LCF_TRAPVEC0_START) : { __TRAPTAB_CPU0 = .; KEEP (*(.traptab_cpu0)) .= ALIGN(0x100); } > cpu0_dlmu
    .traptab_tc1 (TEXT) BIND(LCF_TRAPVEC1_START) : { __TRAPTAB_CPU1 = .; KEEP (*(.traptab_cpu1)) .= ALIGN(0x100); } > cpu1_dlmu
    .traptab_tc2 (TEXT) BIND(LCF_TRAPVEC2_START) : { __TRAPTAB_CPU2 = .; KEEP (*(.traptab_cpu2)) .= ALIGN(0x100); } > cpu2_dlmu
    .traptab_tc3 (TEXT) BIND(LCF_TRAPVEC3_START) : { __TRAPTAB_CPU3 = .; KEEP (*(.traptab_cpu3)) .= ALIGN(0x100); } > cpu3_dlmu
    .traptab_tc4 (TEXT) BIND(LCF_TRAPVEC4_START) : { __TRAPTAB_CPU4 = .; KEEP (*(.traptab_cpu4)) .= ALIGN(0x100); } > cpu4_dlmu
    .traptab_tc5 (TEXT) BIND(LCF_TRAPVEC5_START) : { __TRAPTAB_CPU5 = .; KEEP (*(.traptab_cpu5)) .= ALIGN(0x100); } > cpu5_dlmu

    /*Fixed memory Allocations for _START CPU1 to 5 */
    .start_tc1 (TEXT) LOAD(LCF_STARTPTR_CPU1) BIND(LCF_STARTPTR_NC_CPU1) : { __ENABLE_INDIVIDUAL_C_INIT_CPU1 = 0; KEEP (*(.start_cpu1)) } =0x800 > cpu1_dlmu_nc
    .start_tc2 (TEXT) LOAD(LCF_STARTPTR_CPU2) BIND(LCF_STARTPTR_NC_CPU2) : { __ENABLE_INDIVIDUAL_C_INIT_CPU2 = 0; KEEP (*(.start_cpu2)) } =0x800 > cpu2_dlmu_nc
    .start_tc3 (TEXT) LOAD(LCF_STARTPTR_CPU3) BIND(LCF_STARTPTR_NC_CPU3) : { __ENABLE_INDIVIDUAL_C_INIT_CPU3 = 0; KEEP (*(.start_cpu3)) } =0x800 > cpu3_dlmu_nc
    .start_tc4 (TEXT) LOAD(LCF_STARTPTR_CPU4) BIND(LCF_STARTPTR_NC_CPU4) : { __ENABLE_INDIVIDUAL_C_INIT_CPU4 = 0; KEEP (*(.start_cpu4)) } =0x800 > cpu4_dlmu_nc
    .start_tc5 (TEXT) LOAD(LCF_STARTPTR_CPU5) BIND(LCF_STARTPTR_NC_CPU5) : { __ENABLE_INDIVIDUAL_C_INIT_CPU5 = 0; KEEP (*(.start_cpu5)) } =0x800 > cpu5_dlmu_nc
    __START0 = LCF_STARTPTR_NC_CPU0;
    __START1 = LCF_STARTPTR_NC_CPU1;
    __START2 = LCF_STARTPTR_NC_CPU2;
    __START3 = LCF_STARTPTR_NC_CPU3;
    __START4 = LCF_STARTPTR_NC_CPU4;
    __START5 = LCF_STARTPTR_NC_CPU5;

    /*Fixed memory Allocations for BMHD*/
    .bmhd_0_org 0xae404800 (CONST) : { KEEP(*(.bmhd_0_orig)) } > ucb
    .bmhd_1_org 0xae405000 (CONST) : { KEEP(*(.bmhd_1_orig)) } > ucb
    .bmhd_2_org 0xae405800 (CONST) : { KEEP(*(.bmhd_2_orig)) } > ucb
    .bmhd_3_org 0xae406000 (CONST) : { KEEP(*(.bmhd_3_orig)) } > ucb
    .usercfg_0_org 0xae408800 (CONST) : { KEEP(*(.usercfg_0_orig)) } > ucb
    .usercfg_0_cpy 0xae409000 (CONST) : { KEEP(*(.usercfg_0_copy)) } > ucb

    /*Near Absolute Addressable Data Sections*/
    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        .zdata_tc5 (DATA) :
        {
            "*Ifx_Ssw_Tc5.*" (.zdata)
            "*Cpu5_Main.*" (.zdata)
            *(.zdata_cpu5)
        }
        .zbss_tc5 (BSS) :
        {
            "*Ifx_Ssw_Tc5.*" (.zbss)
            "*Cpu5_Main.*" (.zbss)
            *(.zbss_cpu5)
        }
    } > dsram5

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        .zdata_tc4 (DATA) :
        {
            "*Ifx_Ssw_Tc4.*" (.zdata)
            "*Cpu4_Main.*" (.zdata)
            *(.zdata_cpu4)
        }
        .zbss_tc4 (BSS) :
        {
            "*Ifx_Ssw_Tc4.*" (.zbss)
            "*Cpu4_Main.*" (.zbss)
            *(.zbss_cpu4)
        }
    } > dsram4

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        .zdata_tc3 (DATA) :
        {
            "*Ifx_Ssw_Tc3.*" (.zdata)
            "*Cpu3_Main.*" (.zdata)
            *(.zdata_cpu3)
        }
        .zbss_tc3 (BSS) :
        {
            "*Ifx_Ssw_Tc3.*" (.zbss)
            "*Cpu3_Main.*" (.zbss)
            *(.zbss_cpu3)
        }
    } > dsram3

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        .zdata_tc2 (DATA) :
        {
            "*Ifx_Ssw_Tc2.*" (.zdata)
            "*Cpu2_Main.*" (.zdata)
            *(.zdata_cpu2)
        }
        .zbss_tc2 (BSS) :
        {
            "*Ifx_Ssw_Tc2.*" (.zbss)
            "*Cpu2_Main.*" (.zbss)
            *(.zbss_cpu2)
        }
    } > dsram2

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        .zdata_tc1 (DATA) :
        {
            "*Ifx_Ssw_Tc1.*" (.zdata)
            "*Cpu1_Main.*" (.zdata)
            *(.zdata_cpu1)
        }
        .zbss_tc1 (BSS) :
        {
            "*Ifx_Ssw_Tc1.*" (.zbss)
            "*Cpu1_Main.*" (.zbss)
            *(.zbss_cpu1)
        }
    } > dsram1

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        .zdata_tc0 (DATA) :
        {
            "*Ifx_Ssw_Tc0.*" (.zdata)
            "*Cpu0_Main.*" (.zdata)
            *(.zdata_cpu0)
        }
        .zbss_tc0 (BSS) :
        {
            "*Ifx_Ssw_Tc0.*" (.zbss)
            "*Cpu0_Main.*" (.zbss)
            *(.zbss_cpu0)
        }
    } > dsram0

    /*Near Absolute Data, selectable by toolchain*/
    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        .zdata (DATA) :
        {
            *(.zdata.dsprInit.cpu0.32bit)
            *(.zdata.dsprInit.cpu0.16bit)
            *(.zdata.dsprInit.cpu0.8bit)
            *(.zdata)
        }
        
        .zdata_powerOn (DATA) :
        {
            *(.zdata.dsprPowerOnInit.cpu0.32bit)
            *(.zdata.dsprPowerOnInit.cpu0.16bit)
            *(.zdata.dsprPowerOnInit.cpu0.8bit)
        }
        
        .zbss (BSS) :
        {
            *(.zbss.dsprClearOnInit.cpu0.32bit)
            *(.zbss.dsprClearOnInit.cpu0.16bit)
            *(.zbss.dsprClearOnInit.cpu0.8bit)
            *(.zbss)
        }
        
        .zbss_powerOn (BSS) :
        {
            *(.zbss.dsprPowerOnClear.cpu0.32bit)
            *(.zbss.dsprPowerOnClear.cpu0.16bit)
            *(.zbss.dsprPowerOnClear.cpu0.8bit)
        }
        
        .zbss_noClear (BSS) :
        {
            *(.zbss.dsprNoInit.cpu0.32bit)
            *(.zbss.dsprNoInit.cpu0.16bit)
            *(.zbss.dsprNoInit.cpu0.8bit)
        }
    /*Un comment one of the below statements to enable CpuX DMI RAM to hold global variables*/
    } > dsram0
/*    } > dsram1 */
/*    } > dsram2 */
/*    } > dsram3 */
/*    } > dsram4 */
/*    } > dsram5 */

    /*Relative A0/A1/A8/A9 Addressable Sections*/
    /*Relative A0 Addressable Data, selectable with patterns and user defined sections*/
    /*Note: A0 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A0 Addressable Data, selectable by toolchain*/
    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        .sdata (DATA) :
        {
            *(.sdata)
        }
        
        .sbss (BSS) :
        {
            *(.sbss)
        }
        
        _SMALL_DATA_ = SIZEOF(.sdata) ? ADDR(.sdata) : (ADDR(.sdata) & 0xF0000000) + 32k ;
        __A0_MEM = _SMALL_DATA_;
    /*Un comment one of the below statements to enable CpuX DMI RAM to hold global variables*/
    } > dsram0
/*    } > dsram1 */
/*    } > dsram2 */
/*    } > dsram3 */
/*    } > dsram4 */
/*    } > dsram5 */

    /*Relative A1 Addressable Const, selectable with patterns and user defined sections*/
    /*Note: A1 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A1 Addressable Const, selectable by toolchain*/
    GROUP :
    {
        .zrodata (CONST) :
        {
            *Ifx_Ssw_Tc0.* (.zrodata)
            *Ifx_Ssw_Tc1.* (.zrodata)
            *Ifx_Ssw_Tc2.* (.zrodata)
            *Ifx_Ssw_Tc3.* (.zrodata)
            *Ifx_Ssw_Tc4.* (.zrodata)
            *Ifx_Ssw_Tc5.* (.zrodata)
            *Cpu0_Main.* (.zrodata)
            *Cpu1_Main.* (.zrodata)
            *Cpu2_Main.* (.zrodata)
            *Cpu3_Main.* (.zrodata)
            *Cpu4_Main.* (.zrodata)
            *Cpu5_Main.* (.zrodata)
            *(.zrodata.const.cpu0.32bit)
            *(.zrodata.const.cpu0.16bit)
            *(.zrodata.const.cpu0.8bit)
            *(.zrodata.config.cpu0.32bit)
            *(.zrodata.config.cpu0.16bit)
            *(.zrodata.config.cpu0.8bit)
            *(.zrodata_cpu0)
            *(.zrodata_cpu1)
            *(.zrodata_cpu2)
            *(.zrodata_cpu3)
            *(.zrodata_cpu4)
            *(.zrodata_cpu5)
            *(.zrodata)
        }

        .srodata (CONST) :
        {
            *(.srodata)
            *(.ldata)
            *(.lbss)    /*Workaround to get rid of linker warning for external const definitions*/
        }
        _LITERAL_DATA_ = SIZEOF(.srodata) ? ADDR(.srodata) : (ADDR(.srodata) & 0xF0000000) + 32k ;
        __A1_MEM = _LITERAL_DATA_;
    /*Un comment one of the below statements to enable CpuX specific Pfls to hold global constants*/
    } > cpu0_dlmu
/*    } > cpu1_dlmu */
/*    } > cpu2_dlmu */
/*    } > cpu3_dlmu */
/*    } > cpu4_dlmu */
/*    } > cpu5_dlmu */

    /*LMU memory sections*/
    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        /*DLMU Near Sections*/
        .zlmudata (DATA) :
        {
            *(.zlmudata)
        }
        
        .zlmubss (BSS) :
        {
            *(.zlmubss)
        }

        /*DLMU0 Sections*/
        CPU0.lmudata (DATA) :
        {
            *(.lmudata_cpu0)
        }
        CPU0.lmubss :
        {
            *(.lmubss_cpu0)    
        }
    } > cpu0_dlmu

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        /*DLMU1 Sections*/
        CPU1.lmudata (DATA) :
        {
            *(.lmudata_cpu1)
        }
        CPU1.lmubss :
        {
            *(.lmubss_cpu1)    
        }
    } > cpu1_dlmu

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        /*DLMU2 Sections*/
        CPU2.lmudata (DATA) :
        {
            *(.lmudata_cpu2)
        }
        CPU2.lmubss :
        {
            *(.lmubss_cpu2)    
        }
    } > cpu2_dlmu

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        /*DLMU3 Sections*/
        CPU3.lmudata (DATA) :
        {
            *(.lmudata_cpu3)
        }
        CPU3.lmubss :
        {
            *(.lmubss_cpu3)    
        }
    } > cpu3_dlmu

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        /*DLMU4 Sections*/
        CPU4.lmudata (DATA) :
        {
            *(.lmudata_cpu4)
        }
        CPU4.lmubss :
        {
            *(.lmubss_cpu4)    
        }
    } > cpu4_dlmu

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        /*DLMU5 Sections*/
        CPU5.lmudata (DATA) :
        {
            *(.lmudata_cpu5)
        }
        CPU5.lmubss :
        {
            *(.lmubss_cpu5)    
        }
    } > cpu5_dlmu

    /*Relative A9 Addressable Data, selectable with patterns and user defined sections*/
    GROUP LOAD(> cpu0_dlmu) COPYTABLE: 
    {            
        .a9data (DATA) :
        {
            *(.data_a9)
        }
        
        .a9bss (BSS) :
        {
            *(.bss_a9)
        }
        __A9_MEM = SIZEOF(.a9data) > 0 ? ADDR(.a9data) : SIZEOF(.a9bss) > 0 ? ADDR(.a9bss): (ADDR(.a9data) & 0xF0000000) + 32k ;
    } > lmuram

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        .lmudata (DATA) :
        {
            *(.lmudata)
        }
        
        .lmubss (BSS) :
        {
            *(.lmubss)
        }
    } > lmuram
	
    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        .ppu_lmuram  :
        {
            . = ALIGN(4);
            __PPU_LMURAM_START = .;
            . += LCF_PPU_LMURAM_SIZE;
            __PPU_LMURAM_END = .;
        }
    } > ppu_lmuram_nc
	
    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        .ppu_csm :
        {
        . = ALIGN(4);
        __PPU_CSM_START = .;
        . += LCF_PPU_CSM_SIZE;
        __PPU_CSM_END = .;
        }
    } > ppu_csm_nc
    
    GROUP LOAD(> cpu0_dlmu) :
    {
        .ppu_code :
        {
        __PPU_IF_CONSTANTS = .;
        __PPU_CODE_START = .;
        . += LCF_PPU_FLASH_SIZE;
        __PPU_CODE_END = .;
        }
    } > ppu_code

    /*Relative A8 Addressable Const, selectable with patterns and user defined sections*/
    GROUP :
    {
        .rodata_a8 :
        {
            *(.rodata_a8)
        }
    /*Un comment one of the below statements to enable CpuX specific Pfls to hold global constants*/
    } > cpu0_dlmu
/*    } > cpu1_dlmu */
/*    } > cpu2_dlmu */
/*    } > cpu3_dlmu */
/*    } > cpu4_dlmu */
/*    } > cpu5_dlmu */

    __A8_MEM = SIZEOF(.rodata_a8) ? ADDR(.rodata_a8) : (ADDR(.rodata_a8) & 0xF0000000) + 32k ;
    
    /*Far Data / Far Const Sections, selectable with patterns and user defined sections*/
    /*Far Data Sections, selectable with patterns and user defined sections*/
    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        CPU5.data (DATA) :
        {
            "*Ifx_Ssw_Tc5.*" (.data)
            "*Cpu5_Main.*" (.data)
            *(.data_cpu5)
        }
        CPU5.bss (BSS) :
        {
            "*Ifx_Ssw_Tc5.*" (.bss)
            "*Cpu5_Main.*" (.bss)
            *(.bss_cpu5)
        }
    } > dsram5

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        CPU4.data (DATA) :
        {
            "*Ifx_Ssw_Tc4.*" (.data)
            "*Cpu4_Main.*" (.data)
            *(.data_cpu4)
        }
        CPU4.bss (BSS) :
        {
            "*Ifx_Ssw_Tc4.*" (.bss)
            "*Cpu4_Main.*" (.bss)
            *(.bss_cpu4)
        }
    } > dsram4

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        CPU3.data (DATA) :
        {
            "*Ifx_Ssw_Tc3.*" (.data)
            "*Cpu3_Main.*" (.data)
            *(.data_cpu3)
        }
        CPU3.bss (BSS) :
        {
            "*Ifx_Ssw_Tc3.*" (.bss)
            "*Cpu3_Main.*" (.bss)
            *(.bss_cpu3)
        }
    } > dsram3

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        CPU2.data (DATA) :
        {
            "*Ifx_Ssw_Tc2.*" (.data)
            "*Cpu2_Main.*" (.data)
            *(.data_cpu2)
        }
        CPU2.bss (BSS) :
        {
            "*Ifx_Ssw_Tc2.*" (.bss)
            "*Cpu2_Main.*" (.bss)
            *(.bss_cpu2)
        }
    } > dsram2

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        CPU1.data (DATA) :
        {
            "*Ifx_Ssw_Tc1.*" (.data)
            "*Cpu1_Main.*" (.data)
            *(.data_cpu1)
        }
        CPU1.bss (BSS) :
        {
            "*Ifx_Ssw_Tc1.*" (.bss)
            "*Cpu1_Main.*" (.bss)
            *(.bss_cpu1)
        }
    } > dsram1

    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        CPU0.data (DATA) :
        {
            "*Ifx_Ssw_Tc0.*" (.data)
            "*Cpu0_Main.*" (.data)
            *(.data_cpu0)
        }
        CPU0.bss (BSS) :
        {
            "*Ifx_Ssw_Tc0.*" (.bss)
            "*Cpu0_Main.*" (.bss)
            *(.bss_cpu0)
        }
    } > dsram0

    /*Far Data Sections, selectable by toolchain*/
    GROUP LOAD(> cpu0_dlmu) COPYTABLE :
    {
        .data (DATA) :
        {
            *(.data.farDsprInit.cpu0.32bit)
            *(.data.farDsprInit.cpu0.16bit)
            *(.data.farDsprInit.cpu0.8bit)
            *(.data)
        }
        
        .bss (BSS) :
        {
            *(.bss.farDsprClearOnInit.cpu0.32bit)
            *(.bss.farDsprClearOnInit.cpu0.16bit)
            *(.bss.farDsprClearOnInit.cpu0.8bit)
            *(.bss)
        }
        
        .bss_noClear (BSS) :
        {
            *(.bss.farDsprNoInit.cpu0.32bit)
            *(.bss.farDsprNoInit.cpu0.16bit)
            *(.bss.farDsprNoInit.cpu0.8bit)
        }
        
        .heap  :
        {
            . = ALIGN(4);
            __HEAP = .;
            __HEAP_START = .;
            __HEAP_END = . + LCF_HEAP_SIZE;
        }
    /*Un comment one of the below statements to enable CpuX DMI RAM to hold global variables*/
    } > dsram0
/*    } > dsram1 */
/*    } > dsram2 */
/*    } > dsram3 */
/*    } > dsram4 */
/*    } > dsram5 */

    /* Far Const Sections, selectable with patterns and user defined sections */
    /* CPU0 Const Sections */
    CPU0.rodata (CONST) :
    {
        "*Ifx_Ssw_Tc0.*" (.rodata)
        "*Cpu0_Main.*" (.rodata)
        *(.rodata_cpu0)
    } > cpu0_dlmu

    /* CPU1 Const Sections */
    CPU1.rodata (CONST) :
    {
        "*Ifx_Ssw_Tc1.*" (.rodata)
        "*Cpu1_Main.*" (.rodata)
        *(.rodata_cpu1)
    } > cpu1_dlmu

    /* CPU2 Const Sections */
    CPU2.rodata (CONST) :
    {
        "*Ifx_Ssw_Tc2.*" (.rodata)
        "*Cpu2_Main.*" (.rodata)
        *(.rodata_cpu2)
    } > cpu2_dlmu

    /* CPU3 Const Sections */
    CPU3.rodata (CONST) :
    {
        "*Ifx_Ssw_Tc3.*" (.rodata)
        "*Cpu3_Main.*" (.rodata)
        *(.rodata_cpu3)
    } > cpu3_dlmu

    /* CPU4 Const Sections */
    CPU4.rodata (CONST) :
    {
        "*Ifx_Ssw_Tc4.*" (.rodata)
        "*Cpu4_Main.*" (.rodata)
        *(.rodata_cpu4)
    } > cpu4_dlmu

    /* CPU5 Const Sections */
    CPU5.rodata (CONST) :
    {
        "*Ifx_Ssw_Tc5.*" (.rodata)
        "*Cpu5_Main.*" (.rodata)
        *(.rodata_cpu5)
    } > cpu5_dlmu

    /*Far Const Sections, selectable by toolchain*/
    GROUP :
    {
        .rodata (CONST) :
        {
            *(.rodata)
            *(.rodata.farConst.cpu0.32bit)
            *(.rodata.farConst.cpu0.16bit)
            *(.rodata.farConst.cpu0.8bit)
        }
        
        .copytable (CONST) :
        {
            __DATA_ROM = .;
        }
    /*Un comment one of the below statements to enable CpuX pfls to hold global constants*/
    } > cpu0_dlmu
/*    } > cpu1_dlmu */
/*    } > cpu2_dlmu */
/*    } > cpu3_dlmu */
/*    } > cpu4_dlmu */
/*    } > cpu5_dlmu */

    /*Code selections*/
    /*Code Sections, selectable with patterns and user defined sections*/
    /* CPU0 Code Sections */
    CPU0.text (TEXT) :
    {
        . = ALIGN(2);
        "*Ifx_Ssw_Tc0.*" (.text)
        "*Cpu0_Main.*" (.text)
        *(.text_cpu0)
    } > cpu0_dlmu
    
    CPU0.psram_text (TEXT) LOAD(> cpu0_dlmu) COPYTABLE :
    {
        . = ALIGN(2);
        *(.psram_text_cpu0)
        *(.cpu0_psram)
    } > psram0

    /* CPU1 Code Sections */
    CPU1.text (TEXT) :
    {
        . = ALIGN(2);
        "*Ifx_Ssw_Tc1.*" (.text)
        "*Cpu1_Main.*" (.text)
        *(.text_cpu1)
    } > cpu1_dlmu
    
    CPU1.psram_text (TEXT) LOAD(> cpu0_dlmu) COPYTABLE :
    {
        . = ALIGN(2);
        *(.psram_text_cpu1)
        *(.cpu1_psram)
    } > psram1

    /* CPU2 Code Sections */
    CPU2.text (TEXT) :
    {
        . = ALIGN(2);
        "*Ifx_Ssw_Tc2.*" (.text)
        "*Cpu2_Main.*" (.text)
        *(.text_cpu2)
    } > cpu2_dlmu
    
    CPU2.psram_text (TEXT) LOAD(> cpu0_dlmu) COPYTABLE :
    {
        . = ALIGN(2);
        *(.psram_text_cpu2)
        *(.cpu2_psram)
    } > psram2

    /* CPU3 Code Sections */
    CPU3.text (TEXT) :
    {
        . = ALIGN(2);
        "*Ifx_Ssw_Tc3.*" (.text)
        "*Cpu3_Main.*" (.text)
        *(.text_cpu3)
    } > cpu3_dlmu
    
    CPU3.psram_text (TEXT) LOAD(> cpu0_dlmu) COPYTABLE :
    {
        . = ALIGN(2);
        *(.psram_text_cpu3)
        *(.cpu3_psram)
    } > psram3

    /* CPU4 Code Sections */
    CPU4.text (TEXT) :
    {
        . = ALIGN(2);
        "*Ifx_Ssw_Tc4.*" (.text)
        "*Cpu4_Main.*" (.text)
        *(.text_cpu4)
    } > cpu4_dlmu
    
    CPU4.psram_text (TEXT) LOAD(> cpu0_dlmu) COPYTABLE :
    {
        . = ALIGN(2);
        *(.psram_text_cpu4)
        *(.cpu4_psram)
    } > psram4

    /* CPU5 Code Sections */
    CPU5.text (TEXT) :
    {
        . = ALIGN(2);
        "*Ifx_Ssw_Tc5.*" (.text)
        "*Cpu5_Main.*" (.text)
        *(.text_cpu5)
    } > cpu5_dlmu
    
    CPU5.psram_text (TEXT) LOAD(> cpu0_dlmu) COPYTABLE :
    {
        . = ALIGN(2);
        *(.psram_text_cpu5)
        *(.cpu5_psram)
    } > psram5

    /*Code Sections, selectable by toolchain*/
    GROUP :
    {
        .text (TEXT) :
        {
            . = ALIGN(2);
            *(.text)
            *(.text.fast.pfls.cpu0)
            *(.text.slow.pfls.cpu0)
            *(.text.5ms.pfls.cpu0)
            *(.text.10ms.pfls.cpu0)
            *(.text.callout.pfls.cpu0)
            *(.frame_info)
            *(.init)
            *(.fini)
        }
        
        .ctors (CONST) ALIGN(4) :
        {
            ctordtor.o(.ctors)
            *(.ctors)
        }
        .dtors (CONST) ALIGN(4) :
        {
            ctordtor.o(.dtors)
            *(.dtors)
        }
    /*Un comment one of the below statements to enable CpuX DMI RAM to hold functions*/
    } > cpu0_dlmu
/*    } > cpu1_dlmu */
/*    } > cpu2_dlmu */
/*    } > cpu3_dlmu */
/*    } > cpu4_dlmu */
/*    } > cpu5_dlmu */

    /* CPU0 Interrupt Vector Table */
    .inttab_tc0_000 (TEXT) BIND(__INTTAB_CPU0 + 0x0000) : {KEEP (*(.inttab0.intvec.0  )) } > cpu0_dlmu
    .inttab_tc0_001 (TEXT) BIND(__INTTAB_CPU0 + 0x0020) : {KEEP (*(.inttab0.intvec.1  )) } > cpu0_dlmu
    .inttab_tc0_002 (TEXT) BIND(__INTTAB_CPU0 + 0x0040) : {KEEP (*(.inttab0.intvec.2  )) } > cpu0_dlmu
    .inttab_tc0_003 (TEXT) BIND(__INTTAB_CPU0 + 0x0060) : {KEEP (*(.inttab0.intvec.3  )) } > cpu0_dlmu
    .inttab_tc0_004 (TEXT) BIND(__INTTAB_CPU0 + 0x0080) : {KEEP (*(.inttab0.intvec.4  )) } > cpu0_dlmu
    .inttab_tc0_005 (TEXT) BIND(__INTTAB_CPU0 + 0x00A0) : {KEEP (*(.inttab0.intvec.5  )) } > cpu0_dlmu
    .inttab_tc0_006 (TEXT) BIND(__INTTAB_CPU0 + 0x00C0) : {KEEP (*(.inttab0.intvec.6  )) } > cpu0_dlmu
    .inttab_tc0_007 (TEXT) BIND(__INTTAB_CPU0 + 0x00E0) : {KEEP (*(.inttab0.intvec.7  )) } > cpu0_dlmu
    .inttab_tc0_008 (TEXT) BIND(__INTTAB_CPU0 + 0x0100) : {KEEP (*(.inttab0.intvec.8  )) } > cpu0_dlmu
    .inttab_tc0_009 (TEXT) BIND(__INTTAB_CPU0 + 0x0120) : {KEEP (*(.inttab0.intvec.9  )) } > cpu0_dlmu
    .inttab_tc0_00A (TEXT) BIND(__INTTAB_CPU0 + 0x0140) : {KEEP (*(.inttab0.intvec.10 )) } > cpu0_dlmu
    .inttab_tc0_00B (TEXT) BIND(__INTTAB_CPU0 + 0x0160) : {KEEP (*(.inttab0.intvec.11 )) } > cpu0_dlmu
    .inttab_tc0_00C (TEXT) BIND(__INTTAB_CPU0 + 0x0180) : {KEEP (*(.inttab0.intvec.12 )) } > cpu0_dlmu
    .inttab_tc0_00D (TEXT) BIND(__INTTAB_CPU0 + 0x01A0) : {KEEP (*(.inttab0.intvec.13 )) } > cpu0_dlmu
    .inttab_tc0_00E (TEXT) BIND(__INTTAB_CPU0 + 0x01C0) : {KEEP (*(.inttab0.intvec.14 )) } > cpu0_dlmu
    .inttab_tc0_00F (TEXT) BIND(__INTTAB_CPU0 + 0x01E0) : {KEEP (*(.inttab0.intvec.15 )) } > cpu0_dlmu
    .inttab_tc0_010 (TEXT) BIND(__INTTAB_CPU0 + 0x0200) : {KEEP (*(.inttab0.intvec.16 )) } > cpu0_dlmu
    .inttab_tc0_011 (TEXT) BIND(__INTTAB_CPU0 + 0x0220) : {KEEP (*(.inttab0.intvec.17 )) } > cpu0_dlmu
    .inttab_tc0_012 (TEXT) BIND(__INTTAB_CPU0 + 0x0240) : {KEEP (*(.inttab0.intvec.18 )) } > cpu0_dlmu
    .inttab_tc0_013 (TEXT) BIND(__INTTAB_CPU0 + 0x0260) : {KEEP (*(.inttab0.intvec.19 )) } > cpu0_dlmu
    .inttab_tc0_014 (TEXT) BIND(__INTTAB_CPU0 + 0x0280) : {KEEP (*(.inttab0.intvec.20 )) } > cpu0_dlmu
    .inttab_tc0_015 (TEXT) BIND(__INTTAB_CPU0 + 0x02A0) : {KEEP (*(.inttab0.intvec.21 )) } > cpu0_dlmu
    .inttab_tc0_016 (TEXT) BIND(__INTTAB_CPU0 + 0x02C0) : {KEEP (*(.inttab0.intvec.22 )) } > cpu0_dlmu
    .inttab_tc0_017 (TEXT) BIND(__INTTAB_CPU0 + 0x02E0) : {KEEP (*(.inttab0.intvec.23 )) } > cpu0_dlmu
    .inttab_tc0_018 (TEXT) BIND(__INTTAB_CPU0 + 0x0300) : {KEEP (*(.inttab0.intvec.24 )) } > cpu0_dlmu
    .inttab_tc0_019 (TEXT) BIND(__INTTAB_CPU0 + 0x0320) : {KEEP (*(.inttab0.intvec.25 )) } > cpu0_dlmu
    .inttab_tc0_01A (TEXT) BIND(__INTTAB_CPU0 + 0x0340) : {KEEP (*(.inttab0.intvec.26 )) } > cpu0_dlmu
    .inttab_tc0_01B (TEXT) BIND(__INTTAB_CPU0 + 0x0360) : {KEEP (*(.inttab0.intvec.27 )) } > cpu0_dlmu
    .inttab_tc0_01C (TEXT) BIND(__INTTAB_CPU0 + 0x0380) : {KEEP (*(.inttab0.intvec.28 )) } > cpu0_dlmu
    .inttab_tc0_01D (TEXT) BIND(__INTTAB_CPU0 + 0x03A0) : {KEEP (*(.inttab0.intvec.29 )) } > cpu0_dlmu
    .inttab_tc0_01E (TEXT) BIND(__INTTAB_CPU0 + 0x03C0) : {KEEP (*(.inttab0.intvec.30 )) } > cpu0_dlmu
    .inttab_tc0_01F (TEXT) BIND(__INTTAB_CPU0 + 0x03E0) : {KEEP (*(.inttab0.intvec.31 )) } > cpu0_dlmu
    .inttab_tc0_020 (TEXT) BIND(__INTTAB_CPU0 + 0x0400) : {KEEP (*(.inttab0.intvec.32 )) } > cpu0_dlmu
    .inttab_tc0_021 (TEXT) BIND(__INTTAB_CPU0 + 0x0420) : {KEEP (*(.inttab0.intvec.33 )) } > cpu0_dlmu
    .inttab_tc0_022 (TEXT) BIND(__INTTAB_CPU0 + 0x0440) : {KEEP (*(.inttab0.intvec.34 )) } > cpu0_dlmu
    .inttab_tc0_023 (TEXT) BIND(__INTTAB_CPU0 + 0x0460) : {KEEP (*(.inttab0.intvec.35 )) } > cpu0_dlmu
    .inttab_tc0_024 (TEXT) BIND(__INTTAB_CPU0 + 0x0480) : {KEEP (*(.inttab0.intvec.36 )) } > cpu0_dlmu
    .inttab_tc0_025 (TEXT) BIND(__INTTAB_CPU0 + 0x04A0) : {KEEP (*(.inttab0.intvec.37 )) } > cpu0_dlmu
    .inttab_tc0_026 (TEXT) BIND(__INTTAB_CPU0 + 0x04C0) : {KEEP (*(.inttab0.intvec.38 )) } > cpu0_dlmu
    .inttab_tc0_027 (TEXT) BIND(__INTTAB_CPU0 + 0x04E0) : {KEEP (*(.inttab0.intvec.39 )) } > cpu0_dlmu
    .inttab_tc0_028 (TEXT) BIND(__INTTAB_CPU0 + 0x0500) : {KEEP (*(.inttab0.intvec.40 )) } > cpu0_dlmu
    .inttab_tc0_029 (TEXT) BIND(__INTTAB_CPU0 + 0x0520) : {KEEP (*(.inttab0.intvec.41 )) } > cpu0_dlmu
    .inttab_tc0_02A (TEXT) BIND(__INTTAB_CPU0 + 0x0540) : {KEEP (*(.inttab0.intvec.42 )) } > cpu0_dlmu
    .inttab_tc0_02B (TEXT) BIND(__INTTAB_CPU0 + 0x0560) : {KEEP (*(.inttab0.intvec.43 )) } > cpu0_dlmu
    .inttab_tc0_02C (TEXT) BIND(__INTTAB_CPU0 + 0x0580) : {KEEP (*(.inttab0.intvec.44 )) } > cpu0_dlmu
    .inttab_tc0_02D (TEXT) BIND(__INTTAB_CPU0 + 0x05A0) : {KEEP (*(.inttab0.intvec.45 )) } > cpu0_dlmu
    .inttab_tc0_02E (TEXT) BIND(__INTTAB_CPU0 + 0x05C0) : {KEEP (*(.inttab0.intvec.46 )) } > cpu0_dlmu
    .inttab_tc0_02F (TEXT) BIND(__INTTAB_CPU0 + 0x05E0) : {KEEP (*(.inttab0.intvec.47 )) } > cpu0_dlmu
    .inttab_tc0_030 (TEXT) BIND(__INTTAB_CPU0 + 0x0600) : {KEEP (*(.inttab0.intvec.48 )) } > cpu0_dlmu
    .inttab_tc0_031 (TEXT) BIND(__INTTAB_CPU0 + 0x0620) : {KEEP (*(.inttab0.intvec.49 )) } > cpu0_dlmu
    .inttab_tc0_032 (TEXT) BIND(__INTTAB_CPU0 + 0x0640) : {KEEP (*(.inttab0.intvec.50 )) } > cpu0_dlmu
    .inttab_tc0_033 (TEXT) BIND(__INTTAB_CPU0 + 0x0660) : {KEEP (*(.inttab0.intvec.51 )) } > cpu0_dlmu
    .inttab_tc0_034 (TEXT) BIND(__INTTAB_CPU0 + 0x0680) : {KEEP (*(.inttab0.intvec.52 )) } > cpu0_dlmu
    .inttab_tc0_035 (TEXT) BIND(__INTTAB_CPU0 + 0x06A0) : {KEEP (*(.inttab0.intvec.53 )) } > cpu0_dlmu
    .inttab_tc0_036 (TEXT) BIND(__INTTAB_CPU0 + 0x06C0) : {KEEP (*(.inttab0.intvec.54 )) } > cpu0_dlmu
    .inttab_tc0_037 (TEXT) BIND(__INTTAB_CPU0 + 0x06E0) : {KEEP (*(.inttab0.intvec.55 )) } > cpu0_dlmu
    .inttab_tc0_038 (TEXT) BIND(__INTTAB_CPU0 + 0x0700) : {KEEP (*(.inttab0.intvec.56 )) } > cpu0_dlmu
    .inttab_tc0_039 (TEXT) BIND(__INTTAB_CPU0 + 0x0720) : {KEEP (*(.inttab0.intvec.57 )) } > cpu0_dlmu
    .inttab_tc0_03A (TEXT) BIND(__INTTAB_CPU0 + 0x0740) : {KEEP (*(.inttab0.intvec.58 )) } > cpu0_dlmu
    .inttab_tc0_03B (TEXT) BIND(__INTTAB_CPU0 + 0x0760) : {KEEP (*(.inttab0.intvec.59 )) } > cpu0_dlmu
    .inttab_tc0_03C (TEXT) BIND(__INTTAB_CPU0 + 0x0780) : {KEEP (*(.inttab0.intvec.60 )) } > cpu0_dlmu
    .inttab_tc0_03D (TEXT) BIND(__INTTAB_CPU0 + 0x07A0) : {KEEP (*(.inttab0.intvec.61 )) } > cpu0_dlmu
    .inttab_tc0_03E (TEXT) BIND(__INTTAB_CPU0 + 0x07C0) : {KEEP (*(.inttab0.intvec.62 )) } > cpu0_dlmu
    .inttab_tc0_03F (TEXT) BIND(__INTTAB_CPU0 + 0x07E0) : {KEEP (*(.inttab0.intvec.63 )) } > cpu0_dlmu
    .inttab_tc0_040 (TEXT) BIND(__INTTAB_CPU0 + 0x0800) : {KEEP (*(.inttab0.intvec.64 )) } > cpu0_dlmu
    .inttab_tc0_041 (TEXT) BIND(__INTTAB_CPU0 + 0x0820) : {KEEP (*(.inttab0.intvec.65 )) } > cpu0_dlmu
    .inttab_tc0_042 (TEXT) BIND(__INTTAB_CPU0 + 0x0840) : {KEEP (*(.inttab0.intvec.66 )) } > cpu0_dlmu
    .inttab_tc0_043 (TEXT) BIND(__INTTAB_CPU0 + 0x0860) : {KEEP (*(.inttab0.intvec.67 )) } > cpu0_dlmu
    .inttab_tc0_044 (TEXT) BIND(__INTTAB_CPU0 + 0x0880) : {KEEP (*(.inttab0.intvec.68 )) } > cpu0_dlmu
    .inttab_tc0_045 (TEXT) BIND(__INTTAB_CPU0 + 0x08A0) : {KEEP (*(.inttab0.intvec.69 )) } > cpu0_dlmu
    .inttab_tc0_046 (TEXT) BIND(__INTTAB_CPU0 + 0x08C0) : {KEEP (*(.inttab0.intvec.70 )) } > cpu0_dlmu
    .inttab_tc0_047 (TEXT) BIND(__INTTAB_CPU0 + 0x08E0) : {KEEP (*(.inttab0.intvec.71 )) } > cpu0_dlmu
    .inttab_tc0_048 (TEXT) BIND(__INTTAB_CPU0 + 0x0900) : {KEEP (*(.inttab0.intvec.72 )) } > cpu0_dlmu
    .inttab_tc0_049 (TEXT) BIND(__INTTAB_CPU0 + 0x0920) : {KEEP (*(.inttab0.intvec.73 )) } > cpu0_dlmu
    .inttab_tc0_04A (TEXT) BIND(__INTTAB_CPU0 + 0x0940) : {KEEP (*(.inttab0.intvec.74 )) } > cpu0_dlmu
    .inttab_tc0_04B (TEXT) BIND(__INTTAB_CPU0 + 0x0960) : {KEEP (*(.inttab0.intvec.75 )) } > cpu0_dlmu
    .inttab_tc0_04C (TEXT) BIND(__INTTAB_CPU0 + 0x0980) : {KEEP (*(.inttab0.intvec.76 )) } > cpu0_dlmu
    .inttab_tc0_04D (TEXT) BIND(__INTTAB_CPU0 + 0x09A0) : {KEEP (*(.inttab0.intvec.77 )) } > cpu0_dlmu
    .inttab_tc0_04E (TEXT) BIND(__INTTAB_CPU0 + 0x09C0) : {KEEP (*(.inttab0.intvec.78 )) } > cpu0_dlmu
    .inttab_tc0_04F (TEXT) BIND(__INTTAB_CPU0 + 0x09E0) : {KEEP (*(.inttab0.intvec.79 )) } > cpu0_dlmu
    .inttab_tc0_050 (TEXT) BIND(__INTTAB_CPU0 + 0x0A00) : {KEEP (*(.inttab0.intvec.80 )) } > cpu0_dlmu
    .inttab_tc0_051 (TEXT) BIND(__INTTAB_CPU0 + 0x0A20) : {KEEP (*(.inttab0.intvec.81 )) } > cpu0_dlmu
    .inttab_tc0_052 (TEXT) BIND(__INTTAB_CPU0 + 0x0A40) : {KEEP (*(.inttab0.intvec.82 )) } > cpu0_dlmu
    .inttab_tc0_053 (TEXT) BIND(__INTTAB_CPU0 + 0x0A60) : {KEEP (*(.inttab0.intvec.83 )) } > cpu0_dlmu
    .inttab_tc0_054 (TEXT) BIND(__INTTAB_CPU0 + 0x0A80) : {KEEP (*(.inttab0.intvec.84 )) } > cpu0_dlmu
    .inttab_tc0_055 (TEXT) BIND(__INTTAB_CPU0 + 0x0AA0) : {KEEP (*(.inttab0.intvec.85 )) } > cpu0_dlmu
    .inttab_tc0_056 (TEXT) BIND(__INTTAB_CPU0 + 0x0AC0) : {KEEP (*(.inttab0.intvec.86 )) } > cpu0_dlmu
    .inttab_tc0_057 (TEXT) BIND(__INTTAB_CPU0 + 0x0AE0) : {KEEP (*(.inttab0.intvec.87 )) } > cpu0_dlmu
    .inttab_tc0_058 (TEXT) BIND(__INTTAB_CPU0 + 0x0B00) : {KEEP (*(.inttab0.intvec.88 )) } > cpu0_dlmu
    .inttab_tc0_059 (TEXT) BIND(__INTTAB_CPU0 + 0x0B20) : {KEEP (*(.inttab0.intvec.89 )) } > cpu0_dlmu
    .inttab_tc0_05A (TEXT) BIND(__INTTAB_CPU0 + 0x0B40) : {KEEP (*(.inttab0.intvec.90 )) } > cpu0_dlmu
    .inttab_tc0_05B (TEXT) BIND(__INTTAB_CPU0 + 0x0B60) : {KEEP (*(.inttab0.intvec.91 )) } > cpu0_dlmu
    .inttab_tc0_05C (TEXT) BIND(__INTTAB_CPU0 + 0x0B80) : {KEEP (*(.inttab0.intvec.92 )) } > cpu0_dlmu
    .inttab_tc0_05D (TEXT) BIND(__INTTAB_CPU0 + 0x0BA0) : {KEEP (*(.inttab0.intvec.93 )) } > cpu0_dlmu
    .inttab_tc0_05E (TEXT) BIND(__INTTAB_CPU0 + 0x0BC0) : {KEEP (*(.inttab0.intvec.94 )) } > cpu0_dlmu
    .inttab_tc0_05F (TEXT) BIND(__INTTAB_CPU0 + 0x0BE0) : {KEEP (*(.inttab0.intvec.95 )) } > cpu0_dlmu
    .inttab_tc0_060 (TEXT) BIND(__INTTAB_CPU0 + 0x0C00) : {KEEP (*(.inttab0.intvec.96 )) } > cpu0_dlmu
    .inttab_tc0_061 (TEXT) BIND(__INTTAB_CPU0 + 0x0C20) : {KEEP (*(.inttab0.intvec.97 )) } > cpu0_dlmu
    .inttab_tc0_062 (TEXT) BIND(__INTTAB_CPU0 + 0x0C40) : {KEEP (*(.inttab0.intvec.98 )) } > cpu0_dlmu
    .inttab_tc0_063 (TEXT) BIND(__INTTAB_CPU0 + 0x0C60) : {KEEP (*(.inttab0.intvec.99 )) } > cpu0_dlmu
    .inttab_tc0_064 (TEXT) BIND(__INTTAB_CPU0 + 0x0C80) : {KEEP (*(.inttab0.intvec.100)) } > cpu0_dlmu
    .inttab_tc0_065 (TEXT) BIND(__INTTAB_CPU0 + 0x0CA0) : {KEEP (*(.inttab0.intvec.101)) } > cpu0_dlmu
    .inttab_tc0_066 (TEXT) BIND(__INTTAB_CPU0 + 0x0CC0) : {KEEP (*(.inttab0.intvec.102)) } > cpu0_dlmu
    .inttab_tc0_067 (TEXT) BIND(__INTTAB_CPU0 + 0x0CE0) : {KEEP (*(.inttab0.intvec.103)) } > cpu0_dlmu
    .inttab_tc0_068 (TEXT) BIND(__INTTAB_CPU0 + 0x0D00) : {KEEP (*(.inttab0.intvec.104)) } > cpu0_dlmu
    .inttab_tc0_069 (TEXT) BIND(__INTTAB_CPU0 + 0x0D20) : {KEEP (*(.inttab0.intvec.105)) } > cpu0_dlmu
    .inttab_tc0_06A (TEXT) BIND(__INTTAB_CPU0 + 0x0D40) : {KEEP (*(.inttab0.intvec.106)) } > cpu0_dlmu
    .inttab_tc0_06B (TEXT) BIND(__INTTAB_CPU0 + 0x0D60) : {KEEP (*(.inttab0.intvec.107)) } > cpu0_dlmu
    .inttab_tc0_06C (TEXT) BIND(__INTTAB_CPU0 + 0x0D80) : {KEEP (*(.inttab0.intvec.108)) } > cpu0_dlmu
    .inttab_tc0_06D (TEXT) BIND(__INTTAB_CPU0 + 0x0DA0) : {KEEP (*(.inttab0.intvec.109)) } > cpu0_dlmu
    .inttab_tc0_06E (TEXT) BIND(__INTTAB_CPU0 + 0x0DC0) : {KEEP (*(.inttab0.intvec.110)) } > cpu0_dlmu
    .inttab_tc0_06F (TEXT) BIND(__INTTAB_CPU0 + 0x0DE0) : {KEEP (*(.inttab0.intvec.111)) } > cpu0_dlmu
    .inttab_tc0_070 (TEXT) BIND(__INTTAB_CPU0 + 0x0E00) : {KEEP (*(.inttab0.intvec.112)) } > cpu0_dlmu
    .inttab_tc0_071 (TEXT) BIND(__INTTAB_CPU0 + 0x0E20) : {KEEP (*(.inttab0.intvec.113)) } > cpu0_dlmu
    .inttab_tc0_072 (TEXT) BIND(__INTTAB_CPU0 + 0x0E40) : {KEEP (*(.inttab0.intvec.114)) } > cpu0_dlmu
    .inttab_tc0_073 (TEXT) BIND(__INTTAB_CPU0 + 0x0E60) : {KEEP (*(.inttab0.intvec.115)) } > cpu0_dlmu
    .inttab_tc0_074 (TEXT) BIND(__INTTAB_CPU0 + 0x0E80) : {KEEP (*(.inttab0.intvec.116)) } > cpu0_dlmu
    .inttab_tc0_075 (TEXT) BIND(__INTTAB_CPU0 + 0x0EA0) : {KEEP (*(.inttab0.intvec.117)) } > cpu0_dlmu
    .inttab_tc0_076 (TEXT) BIND(__INTTAB_CPU0 + 0x0EC0) : {KEEP (*(.inttab0.intvec.118)) } > cpu0_dlmu
    .inttab_tc0_077 (TEXT) BIND(__INTTAB_CPU0 + 0x0EE0) : {KEEP (*(.inttab0.intvec.119)) } > cpu0_dlmu
    .inttab_tc0_078 (TEXT) BIND(__INTTAB_CPU0 + 0x0F00) : {KEEP (*(.inttab0.intvec.120)) } > cpu0_dlmu
    .inttab_tc0_079 (TEXT) BIND(__INTTAB_CPU0 + 0x0F20) : {KEEP (*(.inttab0.intvec.121)) } > cpu0_dlmu
    .inttab_tc0_07A (TEXT) BIND(__INTTAB_CPU0 + 0x0F40) : {KEEP (*(.inttab0.intvec.122)) } > cpu0_dlmu
    .inttab_tc0_07B (TEXT) BIND(__INTTAB_CPU0 + 0x0F60) : {KEEP (*(.inttab0.intvec.123)) } > cpu0_dlmu
    .inttab_tc0_07C (TEXT) BIND(__INTTAB_CPU0 + 0x0F80) : {KEEP (*(.inttab0.intvec.124)) } > cpu0_dlmu
    .inttab_tc0_07D (TEXT) BIND(__INTTAB_CPU0 + 0x0FA0) : {KEEP (*(.inttab0.intvec.125)) } > cpu0_dlmu
    .inttab_tc0_07E (TEXT) BIND(__INTTAB_CPU0 + 0x0FC0) : {KEEP (*(.inttab0.intvec.126)) } > cpu0_dlmu
    .inttab_tc0_07F (TEXT) BIND(__INTTAB_CPU0 + 0x0FE0) : {KEEP (*(.inttab0.intvec.127)) } > cpu0_dlmu
    .inttab_tc0_080 (TEXT) BIND(__INTTAB_CPU0 + 0x1000) : {KEEP (*(.inttab0.intvec.128)) } > cpu0_dlmu
    .inttab_tc0_081 (TEXT) BIND(__INTTAB_CPU0 + 0x1020) : {KEEP (*(.inttab0.intvec.129)) } > cpu0_dlmu
    .inttab_tc0_082 (TEXT) BIND(__INTTAB_CPU0 + 0x1040) : {KEEP (*(.inttab0.intvec.130)) } > cpu0_dlmu
    .inttab_tc0_083 (TEXT) BIND(__INTTAB_CPU0 + 0x1060) : {KEEP (*(.inttab0.intvec.131)) } > cpu0_dlmu
    .inttab_tc0_084 (TEXT) BIND(__INTTAB_CPU0 + 0x1080) : {KEEP (*(.inttab0.intvec.132)) } > cpu0_dlmu
    .inttab_tc0_085 (TEXT) BIND(__INTTAB_CPU0 + 0x10A0) : {KEEP (*(.inttab0.intvec.133)) } > cpu0_dlmu
    .inttab_tc0_086 (TEXT) BIND(__INTTAB_CPU0 + 0x10C0) : {KEEP (*(.inttab0.intvec.134)) } > cpu0_dlmu
    .inttab_tc0_087 (TEXT) BIND(__INTTAB_CPU0 + 0x10E0) : {KEEP (*(.inttab0.intvec.135)) } > cpu0_dlmu
    .inttab_tc0_088 (TEXT) BIND(__INTTAB_CPU0 + 0x1100) : {KEEP (*(.inttab0.intvec.136)) } > cpu0_dlmu
    .inttab_tc0_089 (TEXT) BIND(__INTTAB_CPU0 + 0x1120) : {KEEP (*(.inttab0.intvec.137)) } > cpu0_dlmu
    .inttab_tc0_08A (TEXT) BIND(__INTTAB_CPU0 + 0x1140) : {KEEP (*(.inttab0.intvec.138)) } > cpu0_dlmu
    .inttab_tc0_08B (TEXT) BIND(__INTTAB_CPU0 + 0x1160) : {KEEP (*(.inttab0.intvec.139)) } > cpu0_dlmu
    .inttab_tc0_08C (TEXT) BIND(__INTTAB_CPU0 + 0x1180) : {KEEP (*(.inttab0.intvec.140)) } > cpu0_dlmu
    .inttab_tc0_08D (TEXT) BIND(__INTTAB_CPU0 + 0x11A0) : {KEEP (*(.inttab0.intvec.141)) } > cpu0_dlmu
    .inttab_tc0_08E (TEXT) BIND(__INTTAB_CPU0 + 0x11C0) : {KEEP (*(.inttab0.intvec.142)) } > cpu0_dlmu
    .inttab_tc0_08F (TEXT) BIND(__INTTAB_CPU0 + 0x11E0) : {KEEP (*(.inttab0.intvec.143)) } > cpu0_dlmu
    .inttab_tc0_090 (TEXT) BIND(__INTTAB_CPU0 + 0x1200) : {KEEP (*(.inttab0.intvec.144)) } > cpu0_dlmu
    .inttab_tc0_091 (TEXT) BIND(__INTTAB_CPU0 + 0x1220) : {KEEP (*(.inttab0.intvec.145)) } > cpu0_dlmu
    .inttab_tc0_092 (TEXT) BIND(__INTTAB_CPU0 + 0x1240) : {KEEP (*(.inttab0.intvec.146)) } > cpu0_dlmu
    .inttab_tc0_093 (TEXT) BIND(__INTTAB_CPU0 + 0x1260) : {KEEP (*(.inttab0.intvec.147)) } > cpu0_dlmu
    .inttab_tc0_094 (TEXT) BIND(__INTTAB_CPU0 + 0x1280) : {KEEP (*(.inttab0.intvec.148)) } > cpu0_dlmu
    .inttab_tc0_095 (TEXT) BIND(__INTTAB_CPU0 + 0x12A0) : {KEEP (*(.inttab0.intvec.149)) } > cpu0_dlmu
    .inttab_tc0_096 (TEXT) BIND(__INTTAB_CPU0 + 0x12C0) : {KEEP (*(.inttab0.intvec.150)) } > cpu0_dlmu
    .inttab_tc0_097 (TEXT) BIND(__INTTAB_CPU0 + 0x12E0) : {KEEP (*(.inttab0.intvec.151)) } > cpu0_dlmu
    .inttab_tc0_098 (TEXT) BIND(__INTTAB_CPU0 + 0x1300) : {KEEP (*(.inttab0.intvec.152)) } > cpu0_dlmu
    .inttab_tc0_099 (TEXT) BIND(__INTTAB_CPU0 + 0x1320) : {KEEP (*(.inttab0.intvec.153)) } > cpu0_dlmu
    .inttab_tc0_09A (TEXT) BIND(__INTTAB_CPU0 + 0x1340) : {KEEP (*(.inttab0.intvec.154)) } > cpu0_dlmu
    .inttab_tc0_09B (TEXT) BIND(__INTTAB_CPU0 + 0x1360) : {KEEP (*(.inttab0.intvec.155)) } > cpu0_dlmu
    .inttab_tc0_09C (TEXT) BIND(__INTTAB_CPU0 + 0x1380) : {KEEP (*(.inttab0.intvec.156)) } > cpu0_dlmu
    .inttab_tc0_09D (TEXT) BIND(__INTTAB_CPU0 + 0x13A0) : {KEEP (*(.inttab0.intvec.157)) } > cpu0_dlmu
    .inttab_tc0_09E (TEXT) BIND(__INTTAB_CPU0 + 0x13C0) : {KEEP (*(.inttab0.intvec.158)) } > cpu0_dlmu
    .inttab_tc0_09F (TEXT) BIND(__INTTAB_CPU0 + 0x13E0) : {KEEP (*(.inttab0.intvec.159)) } > cpu0_dlmu
    .inttab_tc0_0A0 (TEXT) BIND(__INTTAB_CPU0 + 0x1400) : {KEEP (*(.inttab0.intvec.160)) } > cpu0_dlmu
    .inttab_tc0_0A1 (TEXT) BIND(__INTTAB_CPU0 + 0x1420) : {KEEP (*(.inttab0.intvec.161)) } > cpu0_dlmu
    .inttab_tc0_0A2 (TEXT) BIND(__INTTAB_CPU0 + 0x1440) : {KEEP (*(.inttab0.intvec.162)) } > cpu0_dlmu
    .inttab_tc0_0A3 (TEXT) BIND(__INTTAB_CPU0 + 0x1460) : {KEEP (*(.inttab0.intvec.163)) } > cpu0_dlmu
    .inttab_tc0_0A4 (TEXT) BIND(__INTTAB_CPU0 + 0x1480) : {KEEP (*(.inttab0.intvec.164)) } > cpu0_dlmu
    .inttab_tc0_0A5 (TEXT) BIND(__INTTAB_CPU0 + 0x14A0) : {KEEP (*(.inttab0.intvec.165)) } > cpu0_dlmu
    .inttab_tc0_0A6 (TEXT) BIND(__INTTAB_CPU0 + 0x14C0) : {KEEP (*(.inttab0.intvec.166)) } > cpu0_dlmu
    .inttab_tc0_0A7 (TEXT) BIND(__INTTAB_CPU0 + 0x14E0) : {KEEP (*(.inttab0.intvec.167)) } > cpu0_dlmu
    .inttab_tc0_0A8 (TEXT) BIND(__INTTAB_CPU0 + 0x1500) : {KEEP (*(.inttab0.intvec.168)) } > cpu0_dlmu
    .inttab_tc0_0A9 (TEXT) BIND(__INTTAB_CPU0 + 0x1520) : {KEEP (*(.inttab0.intvec.169)) } > cpu0_dlmu
    .inttab_tc0_0AA (TEXT) BIND(__INTTAB_CPU0 + 0x1540) : {KEEP (*(.inttab0.intvec.170)) } > cpu0_dlmu
    .inttab_tc0_0AB (TEXT) BIND(__INTTAB_CPU0 + 0x1560) : {KEEP (*(.inttab0.intvec.171)) } > cpu0_dlmu
    .inttab_tc0_0AC (TEXT) BIND(__INTTAB_CPU0 + 0x1580) : {KEEP (*(.inttab0.intvec.172)) } > cpu0_dlmu
    .inttab_tc0_0AD (TEXT) BIND(__INTTAB_CPU0 + 0x15A0) : {KEEP (*(.inttab0.intvec.173)) } > cpu0_dlmu
    .inttab_tc0_0AE (TEXT) BIND(__INTTAB_CPU0 + 0x15C0) : {KEEP (*(.inttab0.intvec.174)) } > cpu0_dlmu
    .inttab_tc0_0AF (TEXT) BIND(__INTTAB_CPU0 + 0x15E0) : {KEEP (*(.inttab0.intvec.175)) } > cpu0_dlmu
    .inttab_tc0_0B0 (TEXT) BIND(__INTTAB_CPU0 + 0x1600) : {KEEP (*(.inttab0.intvec.176)) } > cpu0_dlmu
    .inttab_tc0_0B1 (TEXT) BIND(__INTTAB_CPU0 + 0x1620) : {KEEP (*(.inttab0.intvec.177)) } > cpu0_dlmu
    .inttab_tc0_0B2 (TEXT) BIND(__INTTAB_CPU0 + 0x1640) : {KEEP (*(.inttab0.intvec.178)) } > cpu0_dlmu
    .inttab_tc0_0B3 (TEXT) BIND(__INTTAB_CPU0 + 0x1660) : {KEEP (*(.inttab0.intvec.179)) } > cpu0_dlmu
    .inttab_tc0_0B4 (TEXT) BIND(__INTTAB_CPU0 + 0x1680) : {KEEP (*(.inttab0.intvec.180)) } > cpu0_dlmu
    .inttab_tc0_0B5 (TEXT) BIND(__INTTAB_CPU0 + 0x16A0) : {KEEP (*(.inttab0.intvec.181)) } > cpu0_dlmu
    .inttab_tc0_0B6 (TEXT) BIND(__INTTAB_CPU0 + 0x16C0) : {KEEP (*(.inttab0.intvec.182)) } > cpu0_dlmu
    .inttab_tc0_0B7 (TEXT) BIND(__INTTAB_CPU0 + 0x16E0) : {KEEP (*(.inttab0.intvec.183)) } > cpu0_dlmu
    .inttab_tc0_0B8 (TEXT) BIND(__INTTAB_CPU0 + 0x1700) : {KEEP (*(.inttab0.intvec.184)) } > cpu0_dlmu
    .inttab_tc0_0B9 (TEXT) BIND(__INTTAB_CPU0 + 0x1720) : {KEEP (*(.inttab0.intvec.185)) } > cpu0_dlmu
    .inttab_tc0_0BA (TEXT) BIND(__INTTAB_CPU0 + 0x1740) : {KEEP (*(.inttab0.intvec.186)) } > cpu0_dlmu
    .inttab_tc0_0BB (TEXT) BIND(__INTTAB_CPU0 + 0x1760) : {KEEP (*(.inttab0.intvec.187)) } > cpu0_dlmu
    .inttab_tc0_0BC (TEXT) BIND(__INTTAB_CPU0 + 0x1780) : {KEEP (*(.inttab0.intvec.188)) } > cpu0_dlmu
    .inttab_tc0_0BD (TEXT) BIND(__INTTAB_CPU0 + 0x17A0) : {KEEP (*(.inttab0.intvec.189)) } > cpu0_dlmu
    .inttab_tc0_0BE (TEXT) BIND(__INTTAB_CPU0 + 0x17C0) : {KEEP (*(.inttab0.intvec.190)) } > cpu0_dlmu
    .inttab_tc0_0BF (TEXT) BIND(__INTTAB_CPU0 + 0x17E0) : {KEEP (*(.inttab0.intvec.191)) } > cpu0_dlmu
    .inttab_tc0_0C0 (TEXT) BIND(__INTTAB_CPU0 + 0x1800) : {KEEP (*(.inttab0.intvec.192)) } > cpu0_dlmu
    .inttab_tc0_0C1 (TEXT) BIND(__INTTAB_CPU0 + 0x1820) : {KEEP (*(.inttab0.intvec.193)) } > cpu0_dlmu
    .inttab_tc0_0C2 (TEXT) BIND(__INTTAB_CPU0 + 0x1840) : {KEEP (*(.inttab0.intvec.194)) } > cpu0_dlmu
    .inttab_tc0_0C3 (TEXT) BIND(__INTTAB_CPU0 + 0x1860) : {KEEP (*(.inttab0.intvec.195)) } > cpu0_dlmu
    .inttab_tc0_0C4 (TEXT) BIND(__INTTAB_CPU0 + 0x1880) : {KEEP (*(.inttab0.intvec.196)) } > cpu0_dlmu
    .inttab_tc0_0C5 (TEXT) BIND(__INTTAB_CPU0 + 0x18A0) : {KEEP (*(.inttab0.intvec.197)) } > cpu0_dlmu
    .inttab_tc0_0C6 (TEXT) BIND(__INTTAB_CPU0 + 0x18C0) : {KEEP (*(.inttab0.intvec.198)) } > cpu0_dlmu
    .inttab_tc0_0C7 (TEXT) BIND(__INTTAB_CPU0 + 0x18E0) : {KEEP (*(.inttab0.intvec.199)) } > cpu0_dlmu
    .inttab_tc0_0C8 (TEXT) BIND(__INTTAB_CPU0 + 0x1900) : {KEEP (*(.inttab0.intvec.200)) } > cpu0_dlmu
    .inttab_tc0_0C9 (TEXT) BIND(__INTTAB_CPU0 + 0x1920) : {KEEP (*(.inttab0.intvec.201)) } > cpu0_dlmu
    .inttab_tc0_0CA (TEXT) BIND(__INTTAB_CPU0 + 0x1940) : {KEEP (*(.inttab0.intvec.202)) } > cpu0_dlmu
    .inttab_tc0_0CB (TEXT) BIND(__INTTAB_CPU0 + 0x1960) : {KEEP (*(.inttab0.intvec.203)) } > cpu0_dlmu
    .inttab_tc0_0CC (TEXT) BIND(__INTTAB_CPU0 + 0x1980) : {KEEP (*(.inttab0.intvec.204)) } > cpu0_dlmu
    .inttab_tc0_0CD (TEXT) BIND(__INTTAB_CPU0 + 0x19A0) : {KEEP (*(.inttab0.intvec.205)) } > cpu0_dlmu
    .inttab_tc0_0CE (TEXT) BIND(__INTTAB_CPU0 + 0x19C0) : {KEEP (*(.inttab0.intvec.206)) } > cpu0_dlmu
    .inttab_tc0_0CF (TEXT) BIND(__INTTAB_CPU0 + 0x19E0) : {KEEP (*(.inttab0.intvec.207)) } > cpu0_dlmu
    .inttab_tc0_0D0 (TEXT) BIND(__INTTAB_CPU0 + 0x1A00) : {KEEP (*(.inttab0.intvec.208)) } > cpu0_dlmu
    .inttab_tc0_0D1 (TEXT) BIND(__INTTAB_CPU0 + 0x1A20) : {KEEP (*(.inttab0.intvec.209)) } > cpu0_dlmu
    .inttab_tc0_0D2 (TEXT) BIND(__INTTAB_CPU0 + 0x1A40) : {KEEP (*(.inttab0.intvec.210)) } > cpu0_dlmu
    .inttab_tc0_0D3 (TEXT) BIND(__INTTAB_CPU0 + 0x1A60) : {KEEP (*(.inttab0.intvec.211)) } > cpu0_dlmu
    .inttab_tc0_0D4 (TEXT) BIND(__INTTAB_CPU0 + 0x1A80) : {KEEP (*(.inttab0.intvec.212)) } > cpu0_dlmu
    .inttab_tc0_0D5 (TEXT) BIND(__INTTAB_CPU0 + 0x1AA0) : {KEEP (*(.inttab0.intvec.213)) } > cpu0_dlmu
    .inttab_tc0_0D6 (TEXT) BIND(__INTTAB_CPU0 + 0x1AC0) : {KEEP (*(.inttab0.intvec.214)) } > cpu0_dlmu
    .inttab_tc0_0D7 (TEXT) BIND(__INTTAB_CPU0 + 0x1AE0) : {KEEP (*(.inttab0.intvec.215)) } > cpu0_dlmu
    .inttab_tc0_0D8 (TEXT) BIND(__INTTAB_CPU0 + 0x1B00) : {KEEP (*(.inttab0.intvec.216)) } > cpu0_dlmu
    .inttab_tc0_0D9 (TEXT) BIND(__INTTAB_CPU0 + 0x1B20) : {KEEP (*(.inttab0.intvec.217)) } > cpu0_dlmu
    .inttab_tc0_0DA (TEXT) BIND(__INTTAB_CPU0 + 0x1B40) : {KEEP (*(.inttab0.intvec.218)) } > cpu0_dlmu
    .inttab_tc0_0DB (TEXT) BIND(__INTTAB_CPU0 + 0x1B60) : {KEEP (*(.inttab0.intvec.219)) } > cpu0_dlmu
    .inttab_tc0_0DC (TEXT) BIND(__INTTAB_CPU0 + 0x1B80) : {KEEP (*(.inttab0.intvec.220)) } > cpu0_dlmu
    .inttab_tc0_0DD (TEXT) BIND(__INTTAB_CPU0 + 0x1BA0) : {KEEP (*(.inttab0.intvec.221)) } > cpu0_dlmu
    .inttab_tc0_0DE (TEXT) BIND(__INTTAB_CPU0 + 0x1BC0) : {KEEP (*(.inttab0.intvec.222)) } > cpu0_dlmu
    .inttab_tc0_0DF (TEXT) BIND(__INTTAB_CPU0 + 0x1BE0) : {KEEP (*(.inttab0.intvec.223)) } > cpu0_dlmu
    .inttab_tc0_0E0 (TEXT) BIND(__INTTAB_CPU0 + 0x1C00) : {KEEP (*(.inttab0.intvec.224)) } > cpu0_dlmu
    .inttab_tc0_0E1 (TEXT) BIND(__INTTAB_CPU0 + 0x1C20) : {KEEP (*(.inttab0.intvec.225)) } > cpu0_dlmu
    .inttab_tc0_0E2 (TEXT) BIND(__INTTAB_CPU0 + 0x1C40) : {KEEP (*(.inttab0.intvec.226)) } > cpu0_dlmu
    .inttab_tc0_0E3 (TEXT) BIND(__INTTAB_CPU0 + 0x1C60) : {KEEP (*(.inttab0.intvec.227)) } > cpu0_dlmu
    .inttab_tc0_0E4 (TEXT) BIND(__INTTAB_CPU0 + 0x1C80) : {KEEP (*(.inttab0.intvec.228)) } > cpu0_dlmu
    .inttab_tc0_0E5 (TEXT) BIND(__INTTAB_CPU0 + 0x1CA0) : {KEEP (*(.inttab0.intvec.229)) } > cpu0_dlmu
    .inttab_tc0_0E6 (TEXT) BIND(__INTTAB_CPU0 + 0x1CC0) : {KEEP (*(.inttab0.intvec.230)) } > cpu0_dlmu
    .inttab_tc0_0E7 (TEXT) BIND(__INTTAB_CPU0 + 0x1CE0) : {KEEP (*(.inttab0.intvec.231)) } > cpu0_dlmu
    .inttab_tc0_0E8 (TEXT) BIND(__INTTAB_CPU0 + 0x1D00) : {KEEP (*(.inttab0.intvec.232)) } > cpu0_dlmu
    .inttab_tc0_0E9 (TEXT) BIND(__INTTAB_CPU0 + 0x1D20) : {KEEP (*(.inttab0.intvec.233)) } > cpu0_dlmu
    .inttab_tc0_0EA (TEXT) BIND(__INTTAB_CPU0 + 0x1D40) : {KEEP (*(.inttab0.intvec.234)) } > cpu0_dlmu
    .inttab_tc0_0EB (TEXT) BIND(__INTTAB_CPU0 + 0x1D60) : {KEEP (*(.inttab0.intvec.235)) } > cpu0_dlmu
    .inttab_tc0_0EC (TEXT) BIND(__INTTAB_CPU0 + 0x1D80) : {KEEP (*(.inttab0.intvec.236)) } > cpu0_dlmu
    .inttab_tc0_0ED (TEXT) BIND(__INTTAB_CPU0 + 0x1DA0) : {KEEP (*(.inttab0.intvec.237)) } > cpu0_dlmu
    .inttab_tc0_0EE (TEXT) BIND(__INTTAB_CPU0 + 0x1DC0) : {KEEP (*(.inttab0.intvec.238)) } > cpu0_dlmu
    .inttab_tc0_0EF (TEXT) BIND(__INTTAB_CPU0 + 0x1DE0) : {KEEP (*(.inttab0.intvec.239)) } > cpu0_dlmu
    .inttab_tc0_0F0 (TEXT) BIND(__INTTAB_CPU0 + 0x1E00) : {KEEP (*(.inttab0.intvec.240)) } > cpu0_dlmu
    .inttab_tc0_0F1 (TEXT) BIND(__INTTAB_CPU0 + 0x1E20) : {KEEP (*(.inttab0.intvec.241)) } > cpu0_dlmu
    .inttab_tc0_0F2 (TEXT) BIND(__INTTAB_CPU0 + 0x1E40) : {KEEP (*(.inttab0.intvec.242)) } > cpu0_dlmu
    .inttab_tc0_0F3 (TEXT) BIND(__INTTAB_CPU0 + 0x1E60) : {KEEP (*(.inttab0.intvec.243)) } > cpu0_dlmu
    .inttab_tc0_0F4 (TEXT) BIND(__INTTAB_CPU0 + 0x1E80) : {KEEP (*(.inttab0.intvec.244)) } > cpu0_dlmu
    .inttab_tc0_0F5 (TEXT) BIND(__INTTAB_CPU0 + 0x1EA0) : {KEEP (*(.inttab0.intvec.245)) } > cpu0_dlmu
    .inttab_tc0_0F6 (TEXT) BIND(__INTTAB_CPU0 + 0x1EC0) : {KEEP (*(.inttab0.intvec.246)) } > cpu0_dlmu
    .inttab_tc0_0F7 (TEXT) BIND(__INTTAB_CPU0 + 0x1EE0) : {KEEP (*(.inttab0.intvec.247)) } > cpu0_dlmu
    .inttab_tc0_0F8 (TEXT) BIND(__INTTAB_CPU0 + 0x1F00) : {KEEP (*(.inttab0.intvec.248)) } > cpu0_dlmu
    .inttab_tc0_0F9 (TEXT) BIND(__INTTAB_CPU0 + 0x1F20) : {KEEP (*(.inttab0.intvec.249)) } > cpu0_dlmu
    .inttab_tc0_0FA (TEXT) BIND(__INTTAB_CPU0 + 0x1F40) : {KEEP (*(.inttab0.intvec.250)) } > cpu0_dlmu
    .inttab_tc0_0FB (TEXT) BIND(__INTTAB_CPU0 + 0x1F60) : {KEEP (*(.inttab0.intvec.251)) } > cpu0_dlmu
    .inttab_tc0_0FC (TEXT) BIND(__INTTAB_CPU0 + 0x1F80) : {KEEP (*(.inttab0.intvec.252)) } > cpu0_dlmu
    .inttab_tc0_0FD (TEXT) BIND(__INTTAB_CPU0 + 0x1FA0) : {KEEP (*(.inttab0.intvec.253)) } > cpu0_dlmu
    .inttab_tc0_0FE (TEXT) BIND(__INTTAB_CPU0 + 0x1FC0) : {KEEP (*(.inttab0.intvec.254)) } > cpu0_dlmu
    .inttab_tc0_0FF (TEXT) BIND(__INTTAB_CPU0 + 0x1FE0) : {KEEP (*(.inttab0.intvec.255)) } > cpu0_dlmu

    /* CPU1 Interrupt Vector Table */
    .inttab_tc1_000 (TEXT) BIND(__INTTAB_CPU1 + 0x0000) : {KEEP (*(.inttab1.intvec.0  )) } > cpu1_dlmu
    .inttab_tc1_001 (TEXT) BIND(__INTTAB_CPU1 + 0x0020) : {KEEP (*(.inttab1.intvec.1  )) } > cpu1_dlmu
    .inttab_tc1_002 (TEXT) BIND(__INTTAB_CPU1 + 0x0040) : {KEEP (*(.inttab1.intvec.2  )) } > cpu1_dlmu
    .inttab_tc1_003 (TEXT) BIND(__INTTAB_CPU1 + 0x0060) : {KEEP (*(.inttab1.intvec.3  )) } > cpu1_dlmu
    .inttab_tc1_004 (TEXT) BIND(__INTTAB_CPU1 + 0x0080) : {KEEP (*(.inttab1.intvec.4  )) } > cpu1_dlmu
    .inttab_tc1_005 (TEXT) BIND(__INTTAB_CPU1 + 0x00A0) : {KEEP (*(.inttab1.intvec.5  )) } > cpu1_dlmu
    .inttab_tc1_006 (TEXT) BIND(__INTTAB_CPU1 + 0x00C0) : {KEEP (*(.inttab1.intvec.6  )) } > cpu1_dlmu
    .inttab_tc1_007 (TEXT) BIND(__INTTAB_CPU1 + 0x00E0) : {KEEP (*(.inttab1.intvec.7  )) } > cpu1_dlmu
    .inttab_tc1_008 (TEXT) BIND(__INTTAB_CPU1 + 0x0100) : {KEEP (*(.inttab1.intvec.8  )) } > cpu1_dlmu
    .inttab_tc1_009 (TEXT) BIND(__INTTAB_CPU1 + 0x0120) : {KEEP (*(.inttab1.intvec.9  )) } > cpu1_dlmu
    .inttab_tc1_00A (TEXT) BIND(__INTTAB_CPU1 + 0x0140) : {KEEP (*(.inttab1.intvec.10 )) } > cpu1_dlmu
    .inttab_tc1_00B (TEXT) BIND(__INTTAB_CPU1 + 0x0160) : {KEEP (*(.inttab1.intvec.11 )) } > cpu1_dlmu
    .inttab_tc1_00C (TEXT) BIND(__INTTAB_CPU1 + 0x0180) : {KEEP (*(.inttab1.intvec.12 )) } > cpu1_dlmu
    .inttab_tc1_00D (TEXT) BIND(__INTTAB_CPU1 + 0x01A0) : {KEEP (*(.inttab1.intvec.13 )) } > cpu1_dlmu
    .inttab_tc1_00E (TEXT) BIND(__INTTAB_CPU1 + 0x01C0) : {KEEP (*(.inttab1.intvec.14 )) } > cpu1_dlmu
    .inttab_tc1_00F (TEXT) BIND(__INTTAB_CPU1 + 0x01E0) : {KEEP (*(.inttab1.intvec.15 )) } > cpu1_dlmu
    .inttab_tc1_010 (TEXT) BIND(__INTTAB_CPU1 + 0x0200) : {KEEP (*(.inttab1.intvec.16 )) } > cpu1_dlmu
    .inttab_tc1_011 (TEXT) BIND(__INTTAB_CPU1 + 0x0220) : {KEEP (*(.inttab1.intvec.17 )) } > cpu1_dlmu
    .inttab_tc1_012 (TEXT) BIND(__INTTAB_CPU1 + 0x0240) : {KEEP (*(.inttab1.intvec.18 )) } > cpu1_dlmu
    .inttab_tc1_013 (TEXT) BIND(__INTTAB_CPU1 + 0x0260) : {KEEP (*(.inttab1.intvec.19 )) } > cpu1_dlmu
    .inttab_tc1_014 (TEXT) BIND(__INTTAB_CPU1 + 0x0280) : {KEEP (*(.inttab1.intvec.20 )) } > cpu1_dlmu
    .inttab_tc1_015 (TEXT) BIND(__INTTAB_CPU1 + 0x02A0) : {KEEP (*(.inttab1.intvec.21 )) } > cpu1_dlmu
    .inttab_tc1_016 (TEXT) BIND(__INTTAB_CPU1 + 0x02C0) : {KEEP (*(.inttab1.intvec.22 )) } > cpu1_dlmu
    .inttab_tc1_017 (TEXT) BIND(__INTTAB_CPU1 + 0x02E0) : {KEEP (*(.inttab1.intvec.23 )) } > cpu1_dlmu
    .inttab_tc1_018 (TEXT) BIND(__INTTAB_CPU1 + 0x0300) : {KEEP (*(.inttab1.intvec.24 )) } > cpu1_dlmu
    .inttab_tc1_019 (TEXT) BIND(__INTTAB_CPU1 + 0x0320) : {KEEP (*(.inttab1.intvec.25 )) } > cpu1_dlmu
    .inttab_tc1_01A (TEXT) BIND(__INTTAB_CPU1 + 0x0340) : {KEEP (*(.inttab1.intvec.26 )) } > cpu1_dlmu
    .inttab_tc1_01B (TEXT) BIND(__INTTAB_CPU1 + 0x0360) : {KEEP (*(.inttab1.intvec.27 )) } > cpu1_dlmu
    .inttab_tc1_01C (TEXT) BIND(__INTTAB_CPU1 + 0x0380) : {KEEP (*(.inttab1.intvec.28 )) } > cpu1_dlmu
    .inttab_tc1_01D (TEXT) BIND(__INTTAB_CPU1 + 0x03A0) : {KEEP (*(.inttab1.intvec.29 )) } > cpu1_dlmu
    .inttab_tc1_01E (TEXT) BIND(__INTTAB_CPU1 + 0x03C0) : {KEEP (*(.inttab1.intvec.30 )) } > cpu1_dlmu
    .inttab_tc1_01F (TEXT) BIND(__INTTAB_CPU1 + 0x03E0) : {KEEP (*(.inttab1.intvec.31 )) } > cpu1_dlmu
    .inttab_tc1_020 (TEXT) BIND(__INTTAB_CPU1 + 0x0400) : {KEEP (*(.inttab1.intvec.32 )) } > cpu1_dlmu
    .inttab_tc1_021 (TEXT) BIND(__INTTAB_CPU1 + 0x0420) : {KEEP (*(.inttab1.intvec.33 )) } > cpu1_dlmu
    .inttab_tc1_022 (TEXT) BIND(__INTTAB_CPU1 + 0x0440) : {KEEP (*(.inttab1.intvec.34 )) } > cpu1_dlmu
    .inttab_tc1_023 (TEXT) BIND(__INTTAB_CPU1 + 0x0460) : {KEEP (*(.inttab1.intvec.35 )) } > cpu1_dlmu
    .inttab_tc1_024 (TEXT) BIND(__INTTAB_CPU1 + 0x0480) : {KEEP (*(.inttab1.intvec.36 )) } > cpu1_dlmu
    .inttab_tc1_025 (TEXT) BIND(__INTTAB_CPU1 + 0x04A0) : {KEEP (*(.inttab1.intvec.37 )) } > cpu1_dlmu
    .inttab_tc1_026 (TEXT) BIND(__INTTAB_CPU1 + 0x04C0) : {KEEP (*(.inttab1.intvec.38 )) } > cpu1_dlmu
    .inttab_tc1_027 (TEXT) BIND(__INTTAB_CPU1 + 0x04E0) : {KEEP (*(.inttab1.intvec.39 )) } > cpu1_dlmu
    .inttab_tc1_028 (TEXT) BIND(__INTTAB_CPU1 + 0x0500) : {KEEP (*(.inttab1.intvec.40 )) } > cpu1_dlmu
    .inttab_tc1_029 (TEXT) BIND(__INTTAB_CPU1 + 0x0520) : {KEEP (*(.inttab1.intvec.41 )) } > cpu1_dlmu
    .inttab_tc1_02A (TEXT) BIND(__INTTAB_CPU1 + 0x0540) : {KEEP (*(.inttab1.intvec.42 )) } > cpu1_dlmu
    .inttab_tc1_02B (TEXT) BIND(__INTTAB_CPU1 + 0x0560) : {KEEP (*(.inttab1.intvec.43 )) } > cpu1_dlmu
    .inttab_tc1_02C (TEXT) BIND(__INTTAB_CPU1 + 0x0580) : {KEEP (*(.inttab1.intvec.44 )) } > cpu1_dlmu
    .inttab_tc1_02D (TEXT) BIND(__INTTAB_CPU1 + 0x05A0) : {KEEP (*(.inttab1.intvec.45 )) } > cpu1_dlmu
    .inttab_tc1_02E (TEXT) BIND(__INTTAB_CPU1 + 0x05C0) : {KEEP (*(.inttab1.intvec.46 )) } > cpu1_dlmu
    .inttab_tc1_02F (TEXT) BIND(__INTTAB_CPU1 + 0x05E0) : {KEEP (*(.inttab1.intvec.47 )) } > cpu1_dlmu
    .inttab_tc1_030 (TEXT) BIND(__INTTAB_CPU1 + 0x0600) : {KEEP (*(.inttab1.intvec.48 )) } > cpu1_dlmu
    .inttab_tc1_031 (TEXT) BIND(__INTTAB_CPU1 + 0x0620) : {KEEP (*(.inttab1.intvec.49 )) } > cpu1_dlmu
    .inttab_tc1_032 (TEXT) BIND(__INTTAB_CPU1 + 0x0640) : {KEEP (*(.inttab1.intvec.50 )) } > cpu1_dlmu
    .inttab_tc1_033 (TEXT) BIND(__INTTAB_CPU1 + 0x0660) : {KEEP (*(.inttab1.intvec.51 )) } > cpu1_dlmu
    .inttab_tc1_034 (TEXT) BIND(__INTTAB_CPU1 + 0x0680) : {KEEP (*(.inttab1.intvec.52 )) } > cpu1_dlmu
    .inttab_tc1_035 (TEXT) BIND(__INTTAB_CPU1 + 0x06A0) : {KEEP (*(.inttab1.intvec.53 )) } > cpu1_dlmu
    .inttab_tc1_036 (TEXT) BIND(__INTTAB_CPU1 + 0x06C0) : {KEEP (*(.inttab1.intvec.54 )) } > cpu1_dlmu
    .inttab_tc1_037 (TEXT) BIND(__INTTAB_CPU1 + 0x06E0) : {KEEP (*(.inttab1.intvec.55 )) } > cpu1_dlmu
    .inttab_tc1_038 (TEXT) BIND(__INTTAB_CPU1 + 0x0700) : {KEEP (*(.inttab1.intvec.56 )) } > cpu1_dlmu
    .inttab_tc1_039 (TEXT) BIND(__INTTAB_CPU1 + 0x0720) : {KEEP (*(.inttab1.intvec.57 )) } > cpu1_dlmu
    .inttab_tc1_03A (TEXT) BIND(__INTTAB_CPU1 + 0x0740) : {KEEP (*(.inttab1.intvec.58 )) } > cpu1_dlmu
    .inttab_tc1_03B (TEXT) BIND(__INTTAB_CPU1 + 0x0760) : {KEEP (*(.inttab1.intvec.59 )) } > cpu1_dlmu
    .inttab_tc1_03C (TEXT) BIND(__INTTAB_CPU1 + 0x0780) : {KEEP (*(.inttab1.intvec.60 )) } > cpu1_dlmu
    .inttab_tc1_03D (TEXT) BIND(__INTTAB_CPU1 + 0x07A0) : {KEEP (*(.inttab1.intvec.61 )) } > cpu1_dlmu
    .inttab_tc1_03E (TEXT) BIND(__INTTAB_CPU1 + 0x07C0) : {KEEP (*(.inttab1.intvec.62 )) } > cpu1_dlmu
    .inttab_tc1_03F (TEXT) BIND(__INTTAB_CPU1 + 0x07E0) : {KEEP (*(.inttab1.intvec.63 )) } > cpu1_dlmu
    .inttab_tc1_040 (TEXT) BIND(__INTTAB_CPU1 + 0x0800) : {KEEP (*(.inttab1.intvec.64 )) } > cpu1_dlmu
    .inttab_tc1_041 (TEXT) BIND(__INTTAB_CPU1 + 0x0820) : {KEEP (*(.inttab1.intvec.65 )) } > cpu1_dlmu
    .inttab_tc1_042 (TEXT) BIND(__INTTAB_CPU1 + 0x0840) : {KEEP (*(.inttab1.intvec.66 )) } > cpu1_dlmu
    .inttab_tc1_043 (TEXT) BIND(__INTTAB_CPU1 + 0x0860) : {KEEP (*(.inttab1.intvec.67 )) } > cpu1_dlmu
    .inttab_tc1_044 (TEXT) BIND(__INTTAB_CPU1 + 0x0880) : {KEEP (*(.inttab1.intvec.68 )) } > cpu1_dlmu
    .inttab_tc1_045 (TEXT) BIND(__INTTAB_CPU1 + 0x08A0) : {KEEP (*(.inttab1.intvec.69 )) } > cpu1_dlmu
    .inttab_tc1_046 (TEXT) BIND(__INTTAB_CPU1 + 0x08C0) : {KEEP (*(.inttab1.intvec.70 )) } > cpu1_dlmu
    .inttab_tc1_047 (TEXT) BIND(__INTTAB_CPU1 + 0x08E0) : {KEEP (*(.inttab1.intvec.71 )) } > cpu1_dlmu
    .inttab_tc1_048 (TEXT) BIND(__INTTAB_CPU1 + 0x0900) : {KEEP (*(.inttab1.intvec.72 )) } > cpu1_dlmu
    .inttab_tc1_049 (TEXT) BIND(__INTTAB_CPU1 + 0x0920) : {KEEP (*(.inttab1.intvec.73 )) } > cpu1_dlmu
    .inttab_tc1_04A (TEXT) BIND(__INTTAB_CPU1 + 0x0940) : {KEEP (*(.inttab1.intvec.74 )) } > cpu1_dlmu
    .inttab_tc1_04B (TEXT) BIND(__INTTAB_CPU1 + 0x0960) : {KEEP (*(.inttab1.intvec.75 )) } > cpu1_dlmu
    .inttab_tc1_04C (TEXT) BIND(__INTTAB_CPU1 + 0x0980) : {KEEP (*(.inttab1.intvec.76 )) } > cpu1_dlmu
    .inttab_tc1_04D (TEXT) BIND(__INTTAB_CPU1 + 0x09A0) : {KEEP (*(.inttab1.intvec.77 )) } > cpu1_dlmu
    .inttab_tc1_04E (TEXT) BIND(__INTTAB_CPU1 + 0x09C0) : {KEEP (*(.inttab1.intvec.78 )) } > cpu1_dlmu
    .inttab_tc1_04F (TEXT) BIND(__INTTAB_CPU1 + 0x09E0) : {KEEP (*(.inttab1.intvec.79 )) } > cpu1_dlmu
    .inttab_tc1_050 (TEXT) BIND(__INTTAB_CPU1 + 0x0A00) : {KEEP (*(.inttab1.intvec.80 )) } > cpu1_dlmu
    .inttab_tc1_051 (TEXT) BIND(__INTTAB_CPU1 + 0x0A20) : {KEEP (*(.inttab1.intvec.81 )) } > cpu1_dlmu
    .inttab_tc1_052 (TEXT) BIND(__INTTAB_CPU1 + 0x0A40) : {KEEP (*(.inttab1.intvec.82 )) } > cpu1_dlmu
    .inttab_tc1_053 (TEXT) BIND(__INTTAB_CPU1 + 0x0A60) : {KEEP (*(.inttab1.intvec.83 )) } > cpu1_dlmu
    .inttab_tc1_054 (TEXT) BIND(__INTTAB_CPU1 + 0x0A80) : {KEEP (*(.inttab1.intvec.84 )) } > cpu1_dlmu
    .inttab_tc1_055 (TEXT) BIND(__INTTAB_CPU1 + 0x0AA0) : {KEEP (*(.inttab1.intvec.85 )) } > cpu1_dlmu
    .inttab_tc1_056 (TEXT) BIND(__INTTAB_CPU1 + 0x0AC0) : {KEEP (*(.inttab1.intvec.86 )) } > cpu1_dlmu
    .inttab_tc1_057 (TEXT) BIND(__INTTAB_CPU1 + 0x0AE0) : {KEEP (*(.inttab1.intvec.87 )) } > cpu1_dlmu
    .inttab_tc1_058 (TEXT) BIND(__INTTAB_CPU1 + 0x0B00) : {KEEP (*(.inttab1.intvec.88 )) } > cpu1_dlmu
    .inttab_tc1_059 (TEXT) BIND(__INTTAB_CPU1 + 0x0B20) : {KEEP (*(.inttab1.intvec.89 )) } > cpu1_dlmu
    .inttab_tc1_05A (TEXT) BIND(__INTTAB_CPU1 + 0x0B40) : {KEEP (*(.inttab1.intvec.90 )) } > cpu1_dlmu
    .inttab_tc1_05B (TEXT) BIND(__INTTAB_CPU1 + 0x0B60) : {KEEP (*(.inttab1.intvec.91 )) } > cpu1_dlmu
    .inttab_tc1_05C (TEXT) BIND(__INTTAB_CPU1 + 0x0B80) : {KEEP (*(.inttab1.intvec.92 )) } > cpu1_dlmu
    .inttab_tc1_05D (TEXT) BIND(__INTTAB_CPU1 + 0x0BA0) : {KEEP (*(.inttab1.intvec.93 )) } > cpu1_dlmu
    .inttab_tc1_05E (TEXT) BIND(__INTTAB_CPU1 + 0x0BC0) : {KEEP (*(.inttab1.intvec.94 )) } > cpu1_dlmu
    .inttab_tc1_05F (TEXT) BIND(__INTTAB_CPU1 + 0x0BE0) : {KEEP (*(.inttab1.intvec.95 )) } > cpu1_dlmu
    .inttab_tc1_060 (TEXT) BIND(__INTTAB_CPU1 + 0x0C00) : {KEEP (*(.inttab1.intvec.96 )) } > cpu1_dlmu
    .inttab_tc1_061 (TEXT) BIND(__INTTAB_CPU1 + 0x0C20) : {KEEP (*(.inttab1.intvec.97 )) } > cpu1_dlmu
    .inttab_tc1_062 (TEXT) BIND(__INTTAB_CPU1 + 0x0C40) : {KEEP (*(.inttab1.intvec.98 )) } > cpu1_dlmu
    .inttab_tc1_063 (TEXT) BIND(__INTTAB_CPU1 + 0x0C60) : {KEEP (*(.inttab1.intvec.99 )) } > cpu1_dlmu
    .inttab_tc1_064 (TEXT) BIND(__INTTAB_CPU1 + 0x0C80) : {KEEP (*(.inttab1.intvec.100)) } > cpu1_dlmu
    .inttab_tc1_065 (TEXT) BIND(__INTTAB_CPU1 + 0x0CA0) : {KEEP (*(.inttab1.intvec.101)) } > cpu1_dlmu
    .inttab_tc1_066 (TEXT) BIND(__INTTAB_CPU1 + 0x0CC0) : {KEEP (*(.inttab1.intvec.102)) } > cpu1_dlmu
    .inttab_tc1_067 (TEXT) BIND(__INTTAB_CPU1 + 0x0CE0) : {KEEP (*(.inttab1.intvec.103)) } > cpu1_dlmu
    .inttab_tc1_068 (TEXT) BIND(__INTTAB_CPU1 + 0x0D00) : {KEEP (*(.inttab1.intvec.104)) } > cpu1_dlmu
    .inttab_tc1_069 (TEXT) BIND(__INTTAB_CPU1 + 0x0D20) : {KEEP (*(.inttab1.intvec.105)) } > cpu1_dlmu
    .inttab_tc1_06A (TEXT) BIND(__INTTAB_CPU1 + 0x0D40) : {KEEP (*(.inttab1.intvec.106)) } > cpu1_dlmu
    .inttab_tc1_06B (TEXT) BIND(__INTTAB_CPU1 + 0x0D60) : {KEEP (*(.inttab1.intvec.107)) } > cpu1_dlmu
    .inttab_tc1_06C (TEXT) BIND(__INTTAB_CPU1 + 0x0D80) : {KEEP (*(.inttab1.intvec.108)) } > cpu1_dlmu
    .inttab_tc1_06D (TEXT) BIND(__INTTAB_CPU1 + 0x0DA0) : {KEEP (*(.inttab1.intvec.109)) } > cpu1_dlmu
    .inttab_tc1_06E (TEXT) BIND(__INTTAB_CPU1 + 0x0DC0) : {KEEP (*(.inttab1.intvec.110)) } > cpu1_dlmu
    .inttab_tc1_06F (TEXT) BIND(__INTTAB_CPU1 + 0x0DE0) : {KEEP (*(.inttab1.intvec.111)) } > cpu1_dlmu
    .inttab_tc1_070 (TEXT) BIND(__INTTAB_CPU1 + 0x0E00) : {KEEP (*(.inttab1.intvec.112)) } > cpu1_dlmu
    .inttab_tc1_071 (TEXT) BIND(__INTTAB_CPU1 + 0x0E20) : {KEEP (*(.inttab1.intvec.113)) } > cpu1_dlmu
    .inttab_tc1_072 (TEXT) BIND(__INTTAB_CPU1 + 0x0E40) : {KEEP (*(.inttab1.intvec.114)) } > cpu1_dlmu
    .inttab_tc1_073 (TEXT) BIND(__INTTAB_CPU1 + 0x0E60) : {KEEP (*(.inttab1.intvec.115)) } > cpu1_dlmu
    .inttab_tc1_074 (TEXT) BIND(__INTTAB_CPU1 + 0x0E80) : {KEEP (*(.inttab1.intvec.116)) } > cpu1_dlmu
    .inttab_tc1_075 (TEXT) BIND(__INTTAB_CPU1 + 0x0EA0) : {KEEP (*(.inttab1.intvec.117)) } > cpu1_dlmu
    .inttab_tc1_076 (TEXT) BIND(__INTTAB_CPU1 + 0x0EC0) : {KEEP (*(.inttab1.intvec.118)) } > cpu1_dlmu
    .inttab_tc1_077 (TEXT) BIND(__INTTAB_CPU1 + 0x0EE0) : {KEEP (*(.inttab1.intvec.119)) } > cpu1_dlmu
    .inttab_tc1_078 (TEXT) BIND(__INTTAB_CPU1 + 0x0F00) : {KEEP (*(.inttab1.intvec.120)) } > cpu1_dlmu
    .inttab_tc1_079 (TEXT) BIND(__INTTAB_CPU1 + 0x0F20) : {KEEP (*(.inttab1.intvec.121)) } > cpu1_dlmu
    .inttab_tc1_07A (TEXT) BIND(__INTTAB_CPU1 + 0x0F40) : {KEEP (*(.inttab1.intvec.122)) } > cpu1_dlmu
    .inttab_tc1_07B (TEXT) BIND(__INTTAB_CPU1 + 0x0F60) : {KEEP (*(.inttab1.intvec.123)) } > cpu1_dlmu
    .inttab_tc1_07C (TEXT) BIND(__INTTAB_CPU1 + 0x0F80) : {KEEP (*(.inttab1.intvec.124)) } > cpu1_dlmu
    .inttab_tc1_07D (TEXT) BIND(__INTTAB_CPU1 + 0x0FA0) : {KEEP (*(.inttab1.intvec.125)) } > cpu1_dlmu
    .inttab_tc1_07E (TEXT) BIND(__INTTAB_CPU1 + 0x0FC0) : {KEEP (*(.inttab1.intvec.126)) } > cpu1_dlmu
    .inttab_tc1_07F (TEXT) BIND(__INTTAB_CPU1 + 0x0FE0) : {KEEP (*(.inttab1.intvec.127)) } > cpu1_dlmu
    .inttab_tc1_080 (TEXT) BIND(__INTTAB_CPU1 + 0x1000) : {KEEP (*(.inttab1.intvec.128)) } > cpu1_dlmu
    .inttab_tc1_081 (TEXT) BIND(__INTTAB_CPU1 + 0x1020) : {KEEP (*(.inttab1.intvec.129)) } > cpu1_dlmu
    .inttab_tc1_082 (TEXT) BIND(__INTTAB_CPU1 + 0x1040) : {KEEP (*(.inttab1.intvec.130)) } > cpu1_dlmu
    .inttab_tc1_083 (TEXT) BIND(__INTTAB_CPU1 + 0x1060) : {KEEP (*(.inttab1.intvec.131)) } > cpu1_dlmu
    .inttab_tc1_084 (TEXT) BIND(__INTTAB_CPU1 + 0x1080) : {KEEP (*(.inttab1.intvec.132)) } > cpu1_dlmu
    .inttab_tc1_085 (TEXT) BIND(__INTTAB_CPU1 + 0x10A0) : {KEEP (*(.inttab1.intvec.133)) } > cpu1_dlmu
    .inttab_tc1_086 (TEXT) BIND(__INTTAB_CPU1 + 0x10C0) : {KEEP (*(.inttab1.intvec.134)) } > cpu1_dlmu
    .inttab_tc1_087 (TEXT) BIND(__INTTAB_CPU1 + 0x10E0) : {KEEP (*(.inttab1.intvec.135)) } > cpu1_dlmu
    .inttab_tc1_088 (TEXT) BIND(__INTTAB_CPU1 + 0x1100) : {KEEP (*(.inttab1.intvec.136)) } > cpu1_dlmu
    .inttab_tc1_089 (TEXT) BIND(__INTTAB_CPU1 + 0x1120) : {KEEP (*(.inttab1.intvec.137)) } > cpu1_dlmu
    .inttab_tc1_08A (TEXT) BIND(__INTTAB_CPU1 + 0x1140) : {KEEP (*(.inttab1.intvec.138)) } > cpu1_dlmu
    .inttab_tc1_08B (TEXT) BIND(__INTTAB_CPU1 + 0x1160) : {KEEP (*(.inttab1.intvec.139)) } > cpu1_dlmu
    .inttab_tc1_08C (TEXT) BIND(__INTTAB_CPU1 + 0x1180) : {KEEP (*(.inttab1.intvec.140)) } > cpu1_dlmu
    .inttab_tc1_08D (TEXT) BIND(__INTTAB_CPU1 + 0x11A0) : {KEEP (*(.inttab1.intvec.141)) } > cpu1_dlmu
    .inttab_tc1_08E (TEXT) BIND(__INTTAB_CPU1 + 0x11C0) : {KEEP (*(.inttab1.intvec.142)) } > cpu1_dlmu
    .inttab_tc1_08F (TEXT) BIND(__INTTAB_CPU1 + 0x11E0) : {KEEP (*(.inttab1.intvec.143)) } > cpu1_dlmu
    .inttab_tc1_090 (TEXT) BIND(__INTTAB_CPU1 + 0x1200) : {KEEP (*(.inttab1.intvec.144)) } > cpu1_dlmu
    .inttab_tc1_091 (TEXT) BIND(__INTTAB_CPU1 + 0x1220) : {KEEP (*(.inttab1.intvec.145)) } > cpu1_dlmu
    .inttab_tc1_092 (TEXT) BIND(__INTTAB_CPU1 + 0x1240) : {KEEP (*(.inttab1.intvec.146)) } > cpu1_dlmu
    .inttab_tc1_093 (TEXT) BIND(__INTTAB_CPU1 + 0x1260) : {KEEP (*(.inttab1.intvec.147)) } > cpu1_dlmu
    .inttab_tc1_094 (TEXT) BIND(__INTTAB_CPU1 + 0x1280) : {KEEP (*(.inttab1.intvec.148)) } > cpu1_dlmu
    .inttab_tc1_095 (TEXT) BIND(__INTTAB_CPU1 + 0x12A0) : {KEEP (*(.inttab1.intvec.149)) } > cpu1_dlmu
    .inttab_tc1_096 (TEXT) BIND(__INTTAB_CPU1 + 0x12C0) : {KEEP (*(.inttab1.intvec.150)) } > cpu1_dlmu
    .inttab_tc1_097 (TEXT) BIND(__INTTAB_CPU1 + 0x12E0) : {KEEP (*(.inttab1.intvec.151)) } > cpu1_dlmu
    .inttab_tc1_098 (TEXT) BIND(__INTTAB_CPU1 + 0x1300) : {KEEP (*(.inttab1.intvec.152)) } > cpu1_dlmu
    .inttab_tc1_099 (TEXT) BIND(__INTTAB_CPU1 + 0x1320) : {KEEP (*(.inttab1.intvec.153)) } > cpu1_dlmu
    .inttab_tc1_09A (TEXT) BIND(__INTTAB_CPU1 + 0x1340) : {KEEP (*(.inttab1.intvec.154)) } > cpu1_dlmu
    .inttab_tc1_09B (TEXT) BIND(__INTTAB_CPU1 + 0x1360) : {KEEP (*(.inttab1.intvec.155)) } > cpu1_dlmu
    .inttab_tc1_09C (TEXT) BIND(__INTTAB_CPU1 + 0x1380) : {KEEP (*(.inttab1.intvec.156)) } > cpu1_dlmu
    .inttab_tc1_09D (TEXT) BIND(__INTTAB_CPU1 + 0x13A0) : {KEEP (*(.inttab1.intvec.157)) } > cpu1_dlmu
    .inttab_tc1_09E (TEXT) BIND(__INTTAB_CPU1 + 0x13C0) : {KEEP (*(.inttab1.intvec.158)) } > cpu1_dlmu
    .inttab_tc1_09F (TEXT) BIND(__INTTAB_CPU1 + 0x13E0) : {KEEP (*(.inttab1.intvec.159)) } > cpu1_dlmu
    .inttab_tc1_0A0 (TEXT) BIND(__INTTAB_CPU1 + 0x1400) : {KEEP (*(.inttab1.intvec.160)) } > cpu1_dlmu
    .inttab_tc1_0A1 (TEXT) BIND(__INTTAB_CPU1 + 0x1420) : {KEEP (*(.inttab1.intvec.161)) } > cpu1_dlmu
    .inttab_tc1_0A2 (TEXT) BIND(__INTTAB_CPU1 + 0x1440) : {KEEP (*(.inttab1.intvec.162)) } > cpu1_dlmu
    .inttab_tc1_0A3 (TEXT) BIND(__INTTAB_CPU1 + 0x1460) : {KEEP (*(.inttab1.intvec.163)) } > cpu1_dlmu
    .inttab_tc1_0A4 (TEXT) BIND(__INTTAB_CPU1 + 0x1480) : {KEEP (*(.inttab1.intvec.164)) } > cpu1_dlmu
    .inttab_tc1_0A5 (TEXT) BIND(__INTTAB_CPU1 + 0x14A0) : {KEEP (*(.inttab1.intvec.165)) } > cpu1_dlmu
    .inttab_tc1_0A6 (TEXT) BIND(__INTTAB_CPU1 + 0x14C0) : {KEEP (*(.inttab1.intvec.166)) } > cpu1_dlmu
    .inttab_tc1_0A7 (TEXT) BIND(__INTTAB_CPU1 + 0x14E0) : {KEEP (*(.inttab1.intvec.167)) } > cpu1_dlmu
    .inttab_tc1_0A8 (TEXT) BIND(__INTTAB_CPU1 + 0x1500) : {KEEP (*(.inttab1.intvec.168)) } > cpu1_dlmu
    .inttab_tc1_0A9 (TEXT) BIND(__INTTAB_CPU1 + 0x1520) : {KEEP (*(.inttab1.intvec.169)) } > cpu1_dlmu
    .inttab_tc1_0AA (TEXT) BIND(__INTTAB_CPU1 + 0x1540) : {KEEP (*(.inttab1.intvec.170)) } > cpu1_dlmu
    .inttab_tc1_0AB (TEXT) BIND(__INTTAB_CPU1 + 0x1560) : {KEEP (*(.inttab1.intvec.171)) } > cpu1_dlmu
    .inttab_tc1_0AC (TEXT) BIND(__INTTAB_CPU1 + 0x1580) : {KEEP (*(.inttab1.intvec.172)) } > cpu1_dlmu
    .inttab_tc1_0AD (TEXT) BIND(__INTTAB_CPU1 + 0x15A0) : {KEEP (*(.inttab1.intvec.173)) } > cpu1_dlmu
    .inttab_tc1_0AE (TEXT) BIND(__INTTAB_CPU1 + 0x15C0) : {KEEP (*(.inttab1.intvec.174)) } > cpu1_dlmu
    .inttab_tc1_0AF (TEXT) BIND(__INTTAB_CPU1 + 0x15E0) : {KEEP (*(.inttab1.intvec.175)) } > cpu1_dlmu
    .inttab_tc1_0B0 (TEXT) BIND(__INTTAB_CPU1 + 0x1600) : {KEEP (*(.inttab1.intvec.176)) } > cpu1_dlmu
    .inttab_tc1_0B1 (TEXT) BIND(__INTTAB_CPU1 + 0x1620) : {KEEP (*(.inttab1.intvec.177)) } > cpu1_dlmu
    .inttab_tc1_0B2 (TEXT) BIND(__INTTAB_CPU1 + 0x1640) : {KEEP (*(.inttab1.intvec.178)) } > cpu1_dlmu
    .inttab_tc1_0B3 (TEXT) BIND(__INTTAB_CPU1 + 0x1660) : {KEEP (*(.inttab1.intvec.179)) } > cpu1_dlmu
    .inttab_tc1_0B4 (TEXT) BIND(__INTTAB_CPU1 + 0x1680) : {KEEP (*(.inttab1.intvec.180)) } > cpu1_dlmu
    .inttab_tc1_0B5 (TEXT) BIND(__INTTAB_CPU1 + 0x16A0) : {KEEP (*(.inttab1.intvec.181)) } > cpu1_dlmu
    .inttab_tc1_0B6 (TEXT) BIND(__INTTAB_CPU1 + 0x16C0) : {KEEP (*(.inttab1.intvec.182)) } > cpu1_dlmu
    .inttab_tc1_0B7 (TEXT) BIND(__INTTAB_CPU1 + 0x16E0) : {KEEP (*(.inttab1.intvec.183)) } > cpu1_dlmu
    .inttab_tc1_0B8 (TEXT) BIND(__INTTAB_CPU1 + 0x1700) : {KEEP (*(.inttab1.intvec.184)) } > cpu1_dlmu
    .inttab_tc1_0B9 (TEXT) BIND(__INTTAB_CPU1 + 0x1720) : {KEEP (*(.inttab1.intvec.185)) } > cpu1_dlmu
    .inttab_tc1_0BA (TEXT) BIND(__INTTAB_CPU1 + 0x1740) : {KEEP (*(.inttab1.intvec.186)) } > cpu1_dlmu
    .inttab_tc1_0BB (TEXT) BIND(__INTTAB_CPU1 + 0x1760) : {KEEP (*(.inttab1.intvec.187)) } > cpu1_dlmu
    .inttab_tc1_0BC (TEXT) BIND(__INTTAB_CPU1 + 0x1780) : {KEEP (*(.inttab1.intvec.188)) } > cpu1_dlmu
    .inttab_tc1_0BD (TEXT) BIND(__INTTAB_CPU1 + 0x17A0) : {KEEP (*(.inttab1.intvec.189)) } > cpu1_dlmu
    .inttab_tc1_0BE (TEXT) BIND(__INTTAB_CPU1 + 0x17C0) : {KEEP (*(.inttab1.intvec.190)) } > cpu1_dlmu
    .inttab_tc1_0BF (TEXT) BIND(__INTTAB_CPU1 + 0x17E0) : {KEEP (*(.inttab1.intvec.191)) } > cpu1_dlmu
    .inttab_tc1_0C0 (TEXT) BIND(__INTTAB_CPU1 + 0x1800) : {KEEP (*(.inttab1.intvec.192)) } > cpu1_dlmu
    .inttab_tc1_0C1 (TEXT) BIND(__INTTAB_CPU1 + 0x1820) : {KEEP (*(.inttab1.intvec.193)) } > cpu1_dlmu
    .inttab_tc1_0C2 (TEXT) BIND(__INTTAB_CPU1 + 0x1840) : {KEEP (*(.inttab1.intvec.194)) } > cpu1_dlmu
    .inttab_tc1_0C3 (TEXT) BIND(__INTTAB_CPU1 + 0x1860) : {KEEP (*(.inttab1.intvec.195)) } > cpu1_dlmu
    .inttab_tc1_0C4 (TEXT) BIND(__INTTAB_CPU1 + 0x1880) : {KEEP (*(.inttab1.intvec.196)) } > cpu1_dlmu
    .inttab_tc1_0C5 (TEXT) BIND(__INTTAB_CPU1 + 0x18A0) : {KEEP (*(.inttab1.intvec.197)) } > cpu1_dlmu
    .inttab_tc1_0C6 (TEXT) BIND(__INTTAB_CPU1 + 0x18C0) : {KEEP (*(.inttab1.intvec.198)) } > cpu1_dlmu
    .inttab_tc1_0C7 (TEXT) BIND(__INTTAB_CPU1 + 0x18E0) : {KEEP (*(.inttab1.intvec.199)) } > cpu1_dlmu
    .inttab_tc1_0C8 (TEXT) BIND(__INTTAB_CPU1 + 0x1900) : {KEEP (*(.inttab1.intvec.200)) } > cpu1_dlmu
    .inttab_tc1_0C9 (TEXT) BIND(__INTTAB_CPU1 + 0x1920) : {KEEP (*(.inttab1.intvec.201)) } > cpu1_dlmu
    .inttab_tc1_0CA (TEXT) BIND(__INTTAB_CPU1 + 0x1940) : {KEEP (*(.inttab1.intvec.202)) } > cpu1_dlmu
    .inttab_tc1_0CB (TEXT) BIND(__INTTAB_CPU1 + 0x1960) : {KEEP (*(.inttab1.intvec.203)) } > cpu1_dlmu
    .inttab_tc1_0CC (TEXT) BIND(__INTTAB_CPU1 + 0x1980) : {KEEP (*(.inttab1.intvec.204)) } > cpu1_dlmu
    .inttab_tc1_0CD (TEXT) BIND(__INTTAB_CPU1 + 0x19A0) : {KEEP (*(.inttab1.intvec.205)) } > cpu1_dlmu
    .inttab_tc1_0CE (TEXT) BIND(__INTTAB_CPU1 + 0x19C0) : {KEEP (*(.inttab1.intvec.206)) } > cpu1_dlmu
    .inttab_tc1_0CF (TEXT) BIND(__INTTAB_CPU1 + 0x19E0) : {KEEP (*(.inttab1.intvec.207)) } > cpu1_dlmu
    .inttab_tc1_0D0 (TEXT) BIND(__INTTAB_CPU1 + 0x1A00) : {KEEP (*(.inttab1.intvec.208)) } > cpu1_dlmu
    .inttab_tc1_0D1 (TEXT) BIND(__INTTAB_CPU1 + 0x1A20) : {KEEP (*(.inttab1.intvec.209)) } > cpu1_dlmu
    .inttab_tc1_0D2 (TEXT) BIND(__INTTAB_CPU1 + 0x1A40) : {KEEP (*(.inttab1.intvec.210)) } > cpu1_dlmu
    .inttab_tc1_0D3 (TEXT) BIND(__INTTAB_CPU1 + 0x1A60) : {KEEP (*(.inttab1.intvec.211)) } > cpu1_dlmu
    .inttab_tc1_0D4 (TEXT) BIND(__INTTAB_CPU1 + 0x1A80) : {KEEP (*(.inttab1.intvec.212)) } > cpu1_dlmu
    .inttab_tc1_0D5 (TEXT) BIND(__INTTAB_CPU1 + 0x1AA0) : {KEEP (*(.inttab1.intvec.213)) } > cpu1_dlmu
    .inttab_tc1_0D6 (TEXT) BIND(__INTTAB_CPU1 + 0x1AC0) : {KEEP (*(.inttab1.intvec.214)) } > cpu1_dlmu
    .inttab_tc1_0D7 (TEXT) BIND(__INTTAB_CPU1 + 0x1AE0) : {KEEP (*(.inttab1.intvec.215)) } > cpu1_dlmu
    .inttab_tc1_0D8 (TEXT) BIND(__INTTAB_CPU1 + 0x1B00) : {KEEP (*(.inttab1.intvec.216)) } > cpu1_dlmu
    .inttab_tc1_0D9 (TEXT) BIND(__INTTAB_CPU1 + 0x1B20) : {KEEP (*(.inttab1.intvec.217)) } > cpu1_dlmu
    .inttab_tc1_0DA (TEXT) BIND(__INTTAB_CPU1 + 0x1B40) : {KEEP (*(.inttab1.intvec.218)) } > cpu1_dlmu
    .inttab_tc1_0DB (TEXT) BIND(__INTTAB_CPU1 + 0x1B60) : {KEEP (*(.inttab1.intvec.219)) } > cpu1_dlmu
    .inttab_tc1_0DC (TEXT) BIND(__INTTAB_CPU1 + 0x1B80) : {KEEP (*(.inttab1.intvec.220)) } > cpu1_dlmu
    .inttab_tc1_0DD (TEXT) BIND(__INTTAB_CPU1 + 0x1BA0) : {KEEP (*(.inttab1.intvec.221)) } > cpu1_dlmu
    .inttab_tc1_0DE (TEXT) BIND(__INTTAB_CPU1 + 0x1BC0) : {KEEP (*(.inttab1.intvec.222)) } > cpu1_dlmu
    .inttab_tc1_0DF (TEXT) BIND(__INTTAB_CPU1 + 0x1BE0) : {KEEP (*(.inttab1.intvec.223)) } > cpu1_dlmu
    .inttab_tc1_0E0 (TEXT) BIND(__INTTAB_CPU1 + 0x1C00) : {KEEP (*(.inttab1.intvec.224)) } > cpu1_dlmu
    .inttab_tc1_0E1 (TEXT) BIND(__INTTAB_CPU1 + 0x1C20) : {KEEP (*(.inttab1.intvec.225)) } > cpu1_dlmu
    .inttab_tc1_0E2 (TEXT) BIND(__INTTAB_CPU1 + 0x1C40) : {KEEP (*(.inttab1.intvec.226)) } > cpu1_dlmu
    .inttab_tc1_0E3 (TEXT) BIND(__INTTAB_CPU1 + 0x1C60) : {KEEP (*(.inttab1.intvec.227)) } > cpu1_dlmu
    .inttab_tc1_0E4 (TEXT) BIND(__INTTAB_CPU1 + 0x1C80) : {KEEP (*(.inttab1.intvec.228)) } > cpu1_dlmu
    .inttab_tc1_0E5 (TEXT) BIND(__INTTAB_CPU1 + 0x1CA0) : {KEEP (*(.inttab1.intvec.229)) } > cpu1_dlmu
    .inttab_tc1_0E6 (TEXT) BIND(__INTTAB_CPU1 + 0x1CC0) : {KEEP (*(.inttab1.intvec.230)) } > cpu1_dlmu
    .inttab_tc1_0E7 (TEXT) BIND(__INTTAB_CPU1 + 0x1CE0) : {KEEP (*(.inttab1.intvec.231)) } > cpu1_dlmu
    .inttab_tc1_0E8 (TEXT) BIND(__INTTAB_CPU1 + 0x1D00) : {KEEP (*(.inttab1.intvec.232)) } > cpu1_dlmu
    .inttab_tc1_0E9 (TEXT) BIND(__INTTAB_CPU1 + 0x1D20) : {KEEP (*(.inttab1.intvec.233)) } > cpu1_dlmu
    .inttab_tc1_0EA (TEXT) BIND(__INTTAB_CPU1 + 0x1D40) : {KEEP (*(.inttab1.intvec.234)) } > cpu1_dlmu
    .inttab_tc1_0EB (TEXT) BIND(__INTTAB_CPU1 + 0x1D60) : {KEEP (*(.inttab1.intvec.235)) } > cpu1_dlmu
    .inttab_tc1_0EC (TEXT) BIND(__INTTAB_CPU1 + 0x1D80) : {KEEP (*(.inttab1.intvec.236)) } > cpu1_dlmu
    .inttab_tc1_0ED (TEXT) BIND(__INTTAB_CPU1 + 0x1DA0) : {KEEP (*(.inttab1.intvec.237)) } > cpu1_dlmu
    .inttab_tc1_0EE (TEXT) BIND(__INTTAB_CPU1 + 0x1DC0) : {KEEP (*(.inttab1.intvec.238)) } > cpu1_dlmu
    .inttab_tc1_0EF (TEXT) BIND(__INTTAB_CPU1 + 0x1DE0) : {KEEP (*(.inttab1.intvec.239)) } > cpu1_dlmu
    .inttab_tc1_0F0 (TEXT) BIND(__INTTAB_CPU1 + 0x1E00) : {KEEP (*(.inttab1.intvec.240)) } > cpu1_dlmu
    .inttab_tc1_0F1 (TEXT) BIND(__INTTAB_CPU1 + 0x1E20) : {KEEP (*(.inttab1.intvec.241)) } > cpu1_dlmu
    .inttab_tc1_0F2 (TEXT) BIND(__INTTAB_CPU1 + 0x1E40) : {KEEP (*(.inttab1.intvec.242)) } > cpu1_dlmu
    .inttab_tc1_0F3 (TEXT) BIND(__INTTAB_CPU1 + 0x1E60) : {KEEP (*(.inttab1.intvec.243)) } > cpu1_dlmu
    .inttab_tc1_0F4 (TEXT) BIND(__INTTAB_CPU1 + 0x1E80) : {KEEP (*(.inttab1.intvec.244)) } > cpu1_dlmu
    .inttab_tc1_0F5 (TEXT) BIND(__INTTAB_CPU1 + 0x1EA0) : {KEEP (*(.inttab1.intvec.245)) } > cpu1_dlmu
    .inttab_tc1_0F6 (TEXT) BIND(__INTTAB_CPU1 + 0x1EC0) : {KEEP (*(.inttab1.intvec.246)) } > cpu1_dlmu
    .inttab_tc1_0F7 (TEXT) BIND(__INTTAB_CPU1 + 0x1EE0) : {KEEP (*(.inttab1.intvec.247)) } > cpu1_dlmu
    .inttab_tc1_0F8 (TEXT) BIND(__INTTAB_CPU1 + 0x1F00) : {KEEP (*(.inttab1.intvec.248)) } > cpu1_dlmu
    .inttab_tc1_0F9 (TEXT) BIND(__INTTAB_CPU1 + 0x1F20) : {KEEP (*(.inttab1.intvec.249)) } > cpu1_dlmu
    .inttab_tc1_0FA (TEXT) BIND(__INTTAB_CPU1 + 0x1F40) : {KEEP (*(.inttab1.intvec.250)) } > cpu1_dlmu
    .inttab_tc1_0FB (TEXT) BIND(__INTTAB_CPU1 + 0x1F60) : {KEEP (*(.inttab1.intvec.251)) } > cpu1_dlmu
    .inttab_tc1_0FC (TEXT) BIND(__INTTAB_CPU1 + 0x1F80) : {KEEP (*(.inttab1.intvec.252)) } > cpu1_dlmu
    .inttab_tc1_0FD (TEXT) BIND(__INTTAB_CPU1 + 0x1FA0) : {KEEP (*(.inttab1.intvec.253)) } > cpu1_dlmu
    .inttab_tc1_0FE (TEXT) BIND(__INTTAB_CPU1 + 0x1FC0) : {KEEP (*(.inttab1.intvec.254)) } > cpu1_dlmu
    .inttab_tc1_0FF (TEXT) BIND(__INTTAB_CPU1 + 0x1FE0) : {KEEP (*(.inttab1.intvec.255)) } > cpu1_dlmu

    /* CPU2 Interrupt Vector Table */
    .inttab_tc2_000 (TEXT) BIND(__INTTAB_CPU2 + 0x0000) : {KEEP (*(.inttab2.intvec.0  )) } > cpu2_dlmu
    .inttab_tc2_001 (TEXT) BIND(__INTTAB_CPU2 + 0x0020) : {KEEP (*(.inttab2.intvec.1  )) } > cpu2_dlmu
    .inttab_tc2_002 (TEXT) BIND(__INTTAB_CPU2 + 0x0040) : {KEEP (*(.inttab2.intvec.2  )) } > cpu2_dlmu
    .inttab_tc2_003 (TEXT) BIND(__INTTAB_CPU2 + 0x0060) : {KEEP (*(.inttab2.intvec.3  )) } > cpu2_dlmu
    .inttab_tc2_004 (TEXT) BIND(__INTTAB_CPU2 + 0x0080) : {KEEP (*(.inttab2.intvec.4  )) } > cpu2_dlmu
    .inttab_tc2_005 (TEXT) BIND(__INTTAB_CPU2 + 0x00A0) : {KEEP (*(.inttab2.intvec.5  )) } > cpu2_dlmu
    .inttab_tc2_006 (TEXT) BIND(__INTTAB_CPU2 + 0x00C0) : {KEEP (*(.inttab2.intvec.6  )) } > cpu2_dlmu
    .inttab_tc2_007 (TEXT) BIND(__INTTAB_CPU2 + 0x00E0) : {KEEP (*(.inttab2.intvec.7  )) } > cpu2_dlmu
    .inttab_tc2_008 (TEXT) BIND(__INTTAB_CPU2 + 0x0100) : {KEEP (*(.inttab2.intvec.8  )) } > cpu2_dlmu
    .inttab_tc2_009 (TEXT) BIND(__INTTAB_CPU2 + 0x0120) : {KEEP (*(.inttab2.intvec.9  )) } > cpu2_dlmu
    .inttab_tc2_00A (TEXT) BIND(__INTTAB_CPU2 + 0x0140) : {KEEP (*(.inttab2.intvec.10 )) } > cpu2_dlmu
    .inttab_tc2_00B (TEXT) BIND(__INTTAB_CPU2 + 0x0160) : {KEEP (*(.inttab2.intvec.11 )) } > cpu2_dlmu
    .inttab_tc2_00C (TEXT) BIND(__INTTAB_CPU2 + 0x0180) : {KEEP (*(.inttab2.intvec.12 )) } > cpu2_dlmu
    .inttab_tc2_00D (TEXT) BIND(__INTTAB_CPU2 + 0x01A0) : {KEEP (*(.inttab2.intvec.13 )) } > cpu2_dlmu
    .inttab_tc2_00E (TEXT) BIND(__INTTAB_CPU2 + 0x01C0) : {KEEP (*(.inttab2.intvec.14 )) } > cpu2_dlmu
    .inttab_tc2_00F (TEXT) BIND(__INTTAB_CPU2 + 0x01E0) : {KEEP (*(.inttab2.intvec.15 )) } > cpu2_dlmu
    .inttab_tc2_010 (TEXT) BIND(__INTTAB_CPU2 + 0x0200) : {KEEP (*(.inttab2.intvec.16 )) } > cpu2_dlmu
    .inttab_tc2_011 (TEXT) BIND(__INTTAB_CPU2 + 0x0220) : {KEEP (*(.inttab2.intvec.17 )) } > cpu2_dlmu
    .inttab_tc2_012 (TEXT) BIND(__INTTAB_CPU2 + 0x0240) : {KEEP (*(.inttab2.intvec.18 )) } > cpu2_dlmu
    .inttab_tc2_013 (TEXT) BIND(__INTTAB_CPU2 + 0x0260) : {KEEP (*(.inttab2.intvec.19 )) } > cpu2_dlmu
    .inttab_tc2_014 (TEXT) BIND(__INTTAB_CPU2 + 0x0280) : {KEEP (*(.inttab2.intvec.20 )) } > cpu2_dlmu
    .inttab_tc2_015 (TEXT) BIND(__INTTAB_CPU2 + 0x02A0) : {KEEP (*(.inttab2.intvec.21 )) } > cpu2_dlmu
    .inttab_tc2_016 (TEXT) BIND(__INTTAB_CPU2 + 0x02C0) : {KEEP (*(.inttab2.intvec.22 )) } > cpu2_dlmu
    .inttab_tc2_017 (TEXT) BIND(__INTTAB_CPU2 + 0x02E0) : {KEEP (*(.inttab2.intvec.23 )) } > cpu2_dlmu
    .inttab_tc2_018 (TEXT) BIND(__INTTAB_CPU2 + 0x0300) : {KEEP (*(.inttab2.intvec.24 )) } > cpu2_dlmu
    .inttab_tc2_019 (TEXT) BIND(__INTTAB_CPU2 + 0x0320) : {KEEP (*(.inttab2.intvec.25 )) } > cpu2_dlmu
    .inttab_tc2_01A (TEXT) BIND(__INTTAB_CPU2 + 0x0340) : {KEEP (*(.inttab2.intvec.26 )) } > cpu2_dlmu
    .inttab_tc2_01B (TEXT) BIND(__INTTAB_CPU2 + 0x0360) : {KEEP (*(.inttab2.intvec.27 )) } > cpu2_dlmu
    .inttab_tc2_01C (TEXT) BIND(__INTTAB_CPU2 + 0x0380) : {KEEP (*(.inttab2.intvec.28 )) } > cpu2_dlmu
    .inttab_tc2_01D (TEXT) BIND(__INTTAB_CPU2 + 0x03A0) : {KEEP (*(.inttab2.intvec.29 )) } > cpu2_dlmu
    .inttab_tc2_01E (TEXT) BIND(__INTTAB_CPU2 + 0x03C0) : {KEEP (*(.inttab2.intvec.30 )) } > cpu2_dlmu
    .inttab_tc2_01F (TEXT) BIND(__INTTAB_CPU2 + 0x03E0) : {KEEP (*(.inttab2.intvec.31 )) } > cpu2_dlmu
    .inttab_tc2_020 (TEXT) BIND(__INTTAB_CPU2 + 0x0400) : {KEEP (*(.inttab2.intvec.32 )) } > cpu2_dlmu
    .inttab_tc2_021 (TEXT) BIND(__INTTAB_CPU2 + 0x0420) : {KEEP (*(.inttab2.intvec.33 )) } > cpu2_dlmu
    .inttab_tc2_022 (TEXT) BIND(__INTTAB_CPU2 + 0x0440) : {KEEP (*(.inttab2.intvec.34 )) } > cpu2_dlmu
    .inttab_tc2_023 (TEXT) BIND(__INTTAB_CPU2 + 0x0460) : {KEEP (*(.inttab2.intvec.35 )) } > cpu2_dlmu
    .inttab_tc2_024 (TEXT) BIND(__INTTAB_CPU2 + 0x0480) : {KEEP (*(.inttab2.intvec.36 )) } > cpu2_dlmu
    .inttab_tc2_025 (TEXT) BIND(__INTTAB_CPU2 + 0x04A0) : {KEEP (*(.inttab2.intvec.37 )) } > cpu2_dlmu
    .inttab_tc2_026 (TEXT) BIND(__INTTAB_CPU2 + 0x04C0) : {KEEP (*(.inttab2.intvec.38 )) } > cpu2_dlmu
    .inttab_tc2_027 (TEXT) BIND(__INTTAB_CPU2 + 0x04E0) : {KEEP (*(.inttab2.intvec.39 )) } > cpu2_dlmu
    .inttab_tc2_028 (TEXT) BIND(__INTTAB_CPU2 + 0x0500) : {KEEP (*(.inttab2.intvec.40 )) } > cpu2_dlmu
    .inttab_tc2_029 (TEXT) BIND(__INTTAB_CPU2 + 0x0520) : {KEEP (*(.inttab2.intvec.41 )) } > cpu2_dlmu
    .inttab_tc2_02A (TEXT) BIND(__INTTAB_CPU2 + 0x0540) : {KEEP (*(.inttab2.intvec.42 )) } > cpu2_dlmu
    .inttab_tc2_02B (TEXT) BIND(__INTTAB_CPU2 + 0x0560) : {KEEP (*(.inttab2.intvec.43 )) } > cpu2_dlmu
    .inttab_tc2_02C (TEXT) BIND(__INTTAB_CPU2 + 0x0580) : {KEEP (*(.inttab2.intvec.44 )) } > cpu2_dlmu
    .inttab_tc2_02D (TEXT) BIND(__INTTAB_CPU2 + 0x05A0) : {KEEP (*(.inttab2.intvec.45 )) } > cpu2_dlmu
    .inttab_tc2_02E (TEXT) BIND(__INTTAB_CPU2 + 0x05C0) : {KEEP (*(.inttab2.intvec.46 )) } > cpu2_dlmu
    .inttab_tc2_02F (TEXT) BIND(__INTTAB_CPU2 + 0x05E0) : {KEEP (*(.inttab2.intvec.47 )) } > cpu2_dlmu
    .inttab_tc2_030 (TEXT) BIND(__INTTAB_CPU2 + 0x0600) : {KEEP (*(.inttab2.intvec.48 )) } > cpu2_dlmu
    .inttab_tc2_031 (TEXT) BIND(__INTTAB_CPU2 + 0x0620) : {KEEP (*(.inttab2.intvec.49 )) } > cpu2_dlmu
    .inttab_tc2_032 (TEXT) BIND(__INTTAB_CPU2 + 0x0640) : {KEEP (*(.inttab2.intvec.50 )) } > cpu2_dlmu
    .inttab_tc2_033 (TEXT) BIND(__INTTAB_CPU2 + 0x0660) : {KEEP (*(.inttab2.intvec.51 )) } > cpu2_dlmu
    .inttab_tc2_034 (TEXT) BIND(__INTTAB_CPU2 + 0x0680) : {KEEP (*(.inttab2.intvec.52 )) } > cpu2_dlmu
    .inttab_tc2_035 (TEXT) BIND(__INTTAB_CPU2 + 0x06A0) : {KEEP (*(.inttab2.intvec.53 )) } > cpu2_dlmu
    .inttab_tc2_036 (TEXT) BIND(__INTTAB_CPU2 + 0x06C0) : {KEEP (*(.inttab2.intvec.54 )) } > cpu2_dlmu
    .inttab_tc2_037 (TEXT) BIND(__INTTAB_CPU2 + 0x06E0) : {KEEP (*(.inttab2.intvec.55 )) } > cpu2_dlmu
    .inttab_tc2_038 (TEXT) BIND(__INTTAB_CPU2 + 0x0700) : {KEEP (*(.inttab2.intvec.56 )) } > cpu2_dlmu
    .inttab_tc2_039 (TEXT) BIND(__INTTAB_CPU2 + 0x0720) : {KEEP (*(.inttab2.intvec.57 )) } > cpu2_dlmu
    .inttab_tc2_03A (TEXT) BIND(__INTTAB_CPU2 + 0x0740) : {KEEP (*(.inttab2.intvec.58 )) } > cpu2_dlmu
    .inttab_tc2_03B (TEXT) BIND(__INTTAB_CPU2 + 0x0760) : {KEEP (*(.inttab2.intvec.59 )) } > cpu2_dlmu
    .inttab_tc2_03C (TEXT) BIND(__INTTAB_CPU2 + 0x0780) : {KEEP (*(.inttab2.intvec.60 )) } > cpu2_dlmu
    .inttab_tc2_03D (TEXT) BIND(__INTTAB_CPU2 + 0x07A0) : {KEEP (*(.inttab2.intvec.61 )) } > cpu2_dlmu
    .inttab_tc2_03E (TEXT) BIND(__INTTAB_CPU2 + 0x07C0) : {KEEP (*(.inttab2.intvec.62 )) } > cpu2_dlmu
    .inttab_tc2_03F (TEXT) BIND(__INTTAB_CPU2 + 0x07E0) : {KEEP (*(.inttab2.intvec.63 )) } > cpu2_dlmu
    .inttab_tc2_040 (TEXT) BIND(__INTTAB_CPU2 + 0x0800) : {KEEP (*(.inttab2.intvec.64 )) } > cpu2_dlmu
    .inttab_tc2_041 (TEXT) BIND(__INTTAB_CPU2 + 0x0820) : {KEEP (*(.inttab2.intvec.65 )) } > cpu2_dlmu
    .inttab_tc2_042 (TEXT) BIND(__INTTAB_CPU2 + 0x0840) : {KEEP (*(.inttab2.intvec.66 )) } > cpu2_dlmu
    .inttab_tc2_043 (TEXT) BIND(__INTTAB_CPU2 + 0x0860) : {KEEP (*(.inttab2.intvec.67 )) } > cpu2_dlmu
    .inttab_tc2_044 (TEXT) BIND(__INTTAB_CPU2 + 0x0880) : {KEEP (*(.inttab2.intvec.68 )) } > cpu2_dlmu
    .inttab_tc2_045 (TEXT) BIND(__INTTAB_CPU2 + 0x08A0) : {KEEP (*(.inttab2.intvec.69 )) } > cpu2_dlmu
    .inttab_tc2_046 (TEXT) BIND(__INTTAB_CPU2 + 0x08C0) : {KEEP (*(.inttab2.intvec.70 )) } > cpu2_dlmu
    .inttab_tc2_047 (TEXT) BIND(__INTTAB_CPU2 + 0x08E0) : {KEEP (*(.inttab2.intvec.71 )) } > cpu2_dlmu
    .inttab_tc2_048 (TEXT) BIND(__INTTAB_CPU2 + 0x0900) : {KEEP (*(.inttab2.intvec.72 )) } > cpu2_dlmu
    .inttab_tc2_049 (TEXT) BIND(__INTTAB_CPU2 + 0x0920) : {KEEP (*(.inttab2.intvec.73 )) } > cpu2_dlmu
    .inttab_tc2_04A (TEXT) BIND(__INTTAB_CPU2 + 0x0940) : {KEEP (*(.inttab2.intvec.74 )) } > cpu2_dlmu
    .inttab_tc2_04B (TEXT) BIND(__INTTAB_CPU2 + 0x0960) : {KEEP (*(.inttab2.intvec.75 )) } > cpu2_dlmu
    .inttab_tc2_04C (TEXT) BIND(__INTTAB_CPU2 + 0x0980) : {KEEP (*(.inttab2.intvec.76 )) } > cpu2_dlmu
    .inttab_tc2_04D (TEXT) BIND(__INTTAB_CPU2 + 0x09A0) : {KEEP (*(.inttab2.intvec.77 )) } > cpu2_dlmu
    .inttab_tc2_04E (TEXT) BIND(__INTTAB_CPU2 + 0x09C0) : {KEEP (*(.inttab2.intvec.78 )) } > cpu2_dlmu
    .inttab_tc2_04F (TEXT) BIND(__INTTAB_CPU2 + 0x09E0) : {KEEP (*(.inttab2.intvec.79 )) } > cpu2_dlmu
    .inttab_tc2_050 (TEXT) BIND(__INTTAB_CPU2 + 0x0A00) : {KEEP (*(.inttab2.intvec.80 )) } > cpu2_dlmu
    .inttab_tc2_051 (TEXT) BIND(__INTTAB_CPU2 + 0x0A20) : {KEEP (*(.inttab2.intvec.81 )) } > cpu2_dlmu
    .inttab_tc2_052 (TEXT) BIND(__INTTAB_CPU2 + 0x0A40) : {KEEP (*(.inttab2.intvec.82 )) } > cpu2_dlmu
    .inttab_tc2_053 (TEXT) BIND(__INTTAB_CPU2 + 0x0A60) : {KEEP (*(.inttab2.intvec.83 )) } > cpu2_dlmu
    .inttab_tc2_054 (TEXT) BIND(__INTTAB_CPU2 + 0x0A80) : {KEEP (*(.inttab2.intvec.84 )) } > cpu2_dlmu
    .inttab_tc2_055 (TEXT) BIND(__INTTAB_CPU2 + 0x0AA0) : {KEEP (*(.inttab2.intvec.85 )) } > cpu2_dlmu
    .inttab_tc2_056 (TEXT) BIND(__INTTAB_CPU2 + 0x0AC0) : {KEEP (*(.inttab2.intvec.86 )) } > cpu2_dlmu
    .inttab_tc2_057 (TEXT) BIND(__INTTAB_CPU2 + 0x0AE0) : {KEEP (*(.inttab2.intvec.87 )) } > cpu2_dlmu
    .inttab_tc2_058 (TEXT) BIND(__INTTAB_CPU2 + 0x0B00) : {KEEP (*(.inttab2.intvec.88 )) } > cpu2_dlmu
    .inttab_tc2_059 (TEXT) BIND(__INTTAB_CPU2 + 0x0B20) : {KEEP (*(.inttab2.intvec.89 )) } > cpu2_dlmu
    .inttab_tc2_05A (TEXT) BIND(__INTTAB_CPU2 + 0x0B40) : {KEEP (*(.inttab2.intvec.90 )) } > cpu2_dlmu
    .inttab_tc2_05B (TEXT) BIND(__INTTAB_CPU2 + 0x0B60) : {KEEP (*(.inttab2.intvec.91 )) } > cpu2_dlmu
    .inttab_tc2_05C (TEXT) BIND(__INTTAB_CPU2 + 0x0B80) : {KEEP (*(.inttab2.intvec.92 )) } > cpu2_dlmu
    .inttab_tc2_05D (TEXT) BIND(__INTTAB_CPU2 + 0x0BA0) : {KEEP (*(.inttab2.intvec.93 )) } > cpu2_dlmu
    .inttab_tc2_05E (TEXT) BIND(__INTTAB_CPU2 + 0x0BC0) : {KEEP (*(.inttab2.intvec.94 )) } > cpu2_dlmu
    .inttab_tc2_05F (TEXT) BIND(__INTTAB_CPU2 + 0x0BE0) : {KEEP (*(.inttab2.intvec.95 )) } > cpu2_dlmu
    .inttab_tc2_060 (TEXT) BIND(__INTTAB_CPU2 + 0x0C00) : {KEEP (*(.inttab2.intvec.96 )) } > cpu2_dlmu
    .inttab_tc2_061 (TEXT) BIND(__INTTAB_CPU2 + 0x0C20) : {KEEP (*(.inttab2.intvec.97 )) } > cpu2_dlmu
    .inttab_tc2_062 (TEXT) BIND(__INTTAB_CPU2 + 0x0C40) : {KEEP (*(.inttab2.intvec.98 )) } > cpu2_dlmu
    .inttab_tc2_063 (TEXT) BIND(__INTTAB_CPU2 + 0x0C60) : {KEEP (*(.inttab2.intvec.99 )) } > cpu2_dlmu
    .inttab_tc2_064 (TEXT) BIND(__INTTAB_CPU2 + 0x0C80) : {KEEP (*(.inttab2.intvec.100)) } > cpu2_dlmu
    .inttab_tc2_065 (TEXT) BIND(__INTTAB_CPU2 + 0x0CA0) : {KEEP (*(.inttab2.intvec.101)) } > cpu2_dlmu
    .inttab_tc2_066 (TEXT) BIND(__INTTAB_CPU2 + 0x0CC0) : {KEEP (*(.inttab2.intvec.102)) } > cpu2_dlmu
    .inttab_tc2_067 (TEXT) BIND(__INTTAB_CPU2 + 0x0CE0) : {KEEP (*(.inttab2.intvec.103)) } > cpu2_dlmu
    .inttab_tc2_068 (TEXT) BIND(__INTTAB_CPU2 + 0x0D00) : {KEEP (*(.inttab2.intvec.104)) } > cpu2_dlmu
    .inttab_tc2_069 (TEXT) BIND(__INTTAB_CPU2 + 0x0D20) : {KEEP (*(.inttab2.intvec.105)) } > cpu2_dlmu
    .inttab_tc2_06A (TEXT) BIND(__INTTAB_CPU2 + 0x0D40) : {KEEP (*(.inttab2.intvec.106)) } > cpu2_dlmu
    .inttab_tc2_06B (TEXT) BIND(__INTTAB_CPU2 + 0x0D60) : {KEEP (*(.inttab2.intvec.107)) } > cpu2_dlmu
    .inttab_tc2_06C (TEXT) BIND(__INTTAB_CPU2 + 0x0D80) : {KEEP (*(.inttab2.intvec.108)) } > cpu2_dlmu
    .inttab_tc2_06D (TEXT) BIND(__INTTAB_CPU2 + 0x0DA0) : {KEEP (*(.inttab2.intvec.109)) } > cpu2_dlmu
    .inttab_tc2_06E (TEXT) BIND(__INTTAB_CPU2 + 0x0DC0) : {KEEP (*(.inttab2.intvec.110)) } > cpu2_dlmu
    .inttab_tc2_06F (TEXT) BIND(__INTTAB_CPU2 + 0x0DE0) : {KEEP (*(.inttab2.intvec.111)) } > cpu2_dlmu
    .inttab_tc2_070 (TEXT) BIND(__INTTAB_CPU2 + 0x0E00) : {KEEP (*(.inttab2.intvec.112)) } > cpu2_dlmu
    .inttab_tc2_071 (TEXT) BIND(__INTTAB_CPU2 + 0x0E20) : {KEEP (*(.inttab2.intvec.113)) } > cpu2_dlmu
    .inttab_tc2_072 (TEXT) BIND(__INTTAB_CPU2 + 0x0E40) : {KEEP (*(.inttab2.intvec.114)) } > cpu2_dlmu
    .inttab_tc2_073 (TEXT) BIND(__INTTAB_CPU2 + 0x0E60) : {KEEP (*(.inttab2.intvec.115)) } > cpu2_dlmu
    .inttab_tc2_074 (TEXT) BIND(__INTTAB_CPU2 + 0x0E80) : {KEEP (*(.inttab2.intvec.116)) } > cpu2_dlmu
    .inttab_tc2_075 (TEXT) BIND(__INTTAB_CPU2 + 0x0EA0) : {KEEP (*(.inttab2.intvec.117)) } > cpu2_dlmu
    .inttab_tc2_076 (TEXT) BIND(__INTTAB_CPU2 + 0x0EC0) : {KEEP (*(.inttab2.intvec.118)) } > cpu2_dlmu
    .inttab_tc2_077 (TEXT) BIND(__INTTAB_CPU2 + 0x0EE0) : {KEEP (*(.inttab2.intvec.119)) } > cpu2_dlmu
    .inttab_tc2_078 (TEXT) BIND(__INTTAB_CPU2 + 0x0F00) : {KEEP (*(.inttab2.intvec.120)) } > cpu2_dlmu
    .inttab_tc2_079 (TEXT) BIND(__INTTAB_CPU2 + 0x0F20) : {KEEP (*(.inttab2.intvec.121)) } > cpu2_dlmu
    .inttab_tc2_07A (TEXT) BIND(__INTTAB_CPU2 + 0x0F40) : {KEEP (*(.inttab2.intvec.122)) } > cpu2_dlmu
    .inttab_tc2_07B (TEXT) BIND(__INTTAB_CPU2 + 0x0F60) : {KEEP (*(.inttab2.intvec.123)) } > cpu2_dlmu
    .inttab_tc2_07C (TEXT) BIND(__INTTAB_CPU2 + 0x0F80) : {KEEP (*(.inttab2.intvec.124)) } > cpu2_dlmu
    .inttab_tc2_07D (TEXT) BIND(__INTTAB_CPU2 + 0x0FA0) : {KEEP (*(.inttab2.intvec.125)) } > cpu2_dlmu
    .inttab_tc2_07E (TEXT) BIND(__INTTAB_CPU2 + 0x0FC0) : {KEEP (*(.inttab2.intvec.126)) } > cpu2_dlmu
    .inttab_tc2_07F (TEXT) BIND(__INTTAB_CPU2 + 0x0FE0) : {KEEP (*(.inttab2.intvec.127)) } > cpu2_dlmu
    .inttab_tc2_080 (TEXT) BIND(__INTTAB_CPU2 + 0x1000) : {KEEP (*(.inttab2.intvec.128)) } > cpu2_dlmu
    .inttab_tc2_081 (TEXT) BIND(__INTTAB_CPU2 + 0x1020) : {KEEP (*(.inttab2.intvec.129)) } > cpu2_dlmu
    .inttab_tc2_082 (TEXT) BIND(__INTTAB_CPU2 + 0x1040) : {KEEP (*(.inttab2.intvec.130)) } > cpu2_dlmu
    .inttab_tc2_083 (TEXT) BIND(__INTTAB_CPU2 + 0x1060) : {KEEP (*(.inttab2.intvec.131)) } > cpu2_dlmu
    .inttab_tc2_084 (TEXT) BIND(__INTTAB_CPU2 + 0x1080) : {KEEP (*(.inttab2.intvec.132)) } > cpu2_dlmu
    .inttab_tc2_085 (TEXT) BIND(__INTTAB_CPU2 + 0x10A0) : {KEEP (*(.inttab2.intvec.133)) } > cpu2_dlmu
    .inttab_tc2_086 (TEXT) BIND(__INTTAB_CPU2 + 0x10C0) : {KEEP (*(.inttab2.intvec.134)) } > cpu2_dlmu
    .inttab_tc2_087 (TEXT) BIND(__INTTAB_CPU2 + 0x10E0) : {KEEP (*(.inttab2.intvec.135)) } > cpu2_dlmu
    .inttab_tc2_088 (TEXT) BIND(__INTTAB_CPU2 + 0x1100) : {KEEP (*(.inttab2.intvec.136)) } > cpu2_dlmu
    .inttab_tc2_089 (TEXT) BIND(__INTTAB_CPU2 + 0x1120) : {KEEP (*(.inttab2.intvec.137)) } > cpu2_dlmu
    .inttab_tc2_08A (TEXT) BIND(__INTTAB_CPU2 + 0x1140) : {KEEP (*(.inttab2.intvec.138)) } > cpu2_dlmu
    .inttab_tc2_08B (TEXT) BIND(__INTTAB_CPU2 + 0x1160) : {KEEP (*(.inttab2.intvec.139)) } > cpu2_dlmu
    .inttab_tc2_08C (TEXT) BIND(__INTTAB_CPU2 + 0x1180) : {KEEP (*(.inttab2.intvec.140)) } > cpu2_dlmu
    .inttab_tc2_08D (TEXT) BIND(__INTTAB_CPU2 + 0x11A0) : {KEEP (*(.inttab2.intvec.141)) } > cpu2_dlmu
    .inttab_tc2_08E (TEXT) BIND(__INTTAB_CPU2 + 0x11C0) : {KEEP (*(.inttab2.intvec.142)) } > cpu2_dlmu
    .inttab_tc2_08F (TEXT) BIND(__INTTAB_CPU2 + 0x11E0) : {KEEP (*(.inttab2.intvec.143)) } > cpu2_dlmu
    .inttab_tc2_090 (TEXT) BIND(__INTTAB_CPU2 + 0x1200) : {KEEP (*(.inttab2.intvec.144)) } > cpu2_dlmu
    .inttab_tc2_091 (TEXT) BIND(__INTTAB_CPU2 + 0x1220) : {KEEP (*(.inttab2.intvec.145)) } > cpu2_dlmu
    .inttab_tc2_092 (TEXT) BIND(__INTTAB_CPU2 + 0x1240) : {KEEP (*(.inttab2.intvec.146)) } > cpu2_dlmu
    .inttab_tc2_093 (TEXT) BIND(__INTTAB_CPU2 + 0x1260) : {KEEP (*(.inttab2.intvec.147)) } > cpu2_dlmu
    .inttab_tc2_094 (TEXT) BIND(__INTTAB_CPU2 + 0x1280) : {KEEP (*(.inttab2.intvec.148)) } > cpu2_dlmu
    .inttab_tc2_095 (TEXT) BIND(__INTTAB_CPU2 + 0x12A0) : {KEEP (*(.inttab2.intvec.149)) } > cpu2_dlmu
    .inttab_tc2_096 (TEXT) BIND(__INTTAB_CPU2 + 0x12C0) : {KEEP (*(.inttab2.intvec.150)) } > cpu2_dlmu
    .inttab_tc2_097 (TEXT) BIND(__INTTAB_CPU2 + 0x12E0) : {KEEP (*(.inttab2.intvec.151)) } > cpu2_dlmu
    .inttab_tc2_098 (TEXT) BIND(__INTTAB_CPU2 + 0x1300) : {KEEP (*(.inttab2.intvec.152)) } > cpu2_dlmu
    .inttab_tc2_099 (TEXT) BIND(__INTTAB_CPU2 + 0x1320) : {KEEP (*(.inttab2.intvec.153)) } > cpu2_dlmu
    .inttab_tc2_09A (TEXT) BIND(__INTTAB_CPU2 + 0x1340) : {KEEP (*(.inttab2.intvec.154)) } > cpu2_dlmu
    .inttab_tc2_09B (TEXT) BIND(__INTTAB_CPU2 + 0x1360) : {KEEP (*(.inttab2.intvec.155)) } > cpu2_dlmu
    .inttab_tc2_09C (TEXT) BIND(__INTTAB_CPU2 + 0x1380) : {KEEP (*(.inttab2.intvec.156)) } > cpu2_dlmu
    .inttab_tc2_09D (TEXT) BIND(__INTTAB_CPU2 + 0x13A0) : {KEEP (*(.inttab2.intvec.157)) } > cpu2_dlmu
    .inttab_tc2_09E (TEXT) BIND(__INTTAB_CPU2 + 0x13C0) : {KEEP (*(.inttab2.intvec.158)) } > cpu2_dlmu
    .inttab_tc2_09F (TEXT) BIND(__INTTAB_CPU2 + 0x13E0) : {KEEP (*(.inttab2.intvec.159)) } > cpu2_dlmu
    .inttab_tc2_0A0 (TEXT) BIND(__INTTAB_CPU2 + 0x1400) : {KEEP (*(.inttab2.intvec.160)) } > cpu2_dlmu
    .inttab_tc2_0A1 (TEXT) BIND(__INTTAB_CPU2 + 0x1420) : {KEEP (*(.inttab2.intvec.161)) } > cpu2_dlmu
    .inttab_tc2_0A2 (TEXT) BIND(__INTTAB_CPU2 + 0x1440) : {KEEP (*(.inttab2.intvec.162)) } > cpu2_dlmu
    .inttab_tc2_0A3 (TEXT) BIND(__INTTAB_CPU2 + 0x1460) : {KEEP (*(.inttab2.intvec.163)) } > cpu2_dlmu
    .inttab_tc2_0A4 (TEXT) BIND(__INTTAB_CPU2 + 0x1480) : {KEEP (*(.inttab2.intvec.164)) } > cpu2_dlmu
    .inttab_tc2_0A5 (TEXT) BIND(__INTTAB_CPU2 + 0x14A0) : {KEEP (*(.inttab2.intvec.165)) } > cpu2_dlmu
    .inttab_tc2_0A6 (TEXT) BIND(__INTTAB_CPU2 + 0x14C0) : {KEEP (*(.inttab2.intvec.166)) } > cpu2_dlmu
    .inttab_tc2_0A7 (TEXT) BIND(__INTTAB_CPU2 + 0x14E0) : {KEEP (*(.inttab2.intvec.167)) } > cpu2_dlmu
    .inttab_tc2_0A8 (TEXT) BIND(__INTTAB_CPU2 + 0x1500) : {KEEP (*(.inttab2.intvec.168)) } > cpu2_dlmu
    .inttab_tc2_0A9 (TEXT) BIND(__INTTAB_CPU2 + 0x1520) : {KEEP (*(.inttab2.intvec.169)) } > cpu2_dlmu
    .inttab_tc2_0AA (TEXT) BIND(__INTTAB_CPU2 + 0x1540) : {KEEP (*(.inttab2.intvec.170)) } > cpu2_dlmu
    .inttab_tc2_0AB (TEXT) BIND(__INTTAB_CPU2 + 0x1560) : {KEEP (*(.inttab2.intvec.171)) } > cpu2_dlmu
    .inttab_tc2_0AC (TEXT) BIND(__INTTAB_CPU2 + 0x1580) : {KEEP (*(.inttab2.intvec.172)) } > cpu2_dlmu
    .inttab_tc2_0AD (TEXT) BIND(__INTTAB_CPU2 + 0x15A0) : {KEEP (*(.inttab2.intvec.173)) } > cpu2_dlmu
    .inttab_tc2_0AE (TEXT) BIND(__INTTAB_CPU2 + 0x15C0) : {KEEP (*(.inttab2.intvec.174)) } > cpu2_dlmu
    .inttab_tc2_0AF (TEXT) BIND(__INTTAB_CPU2 + 0x15E0) : {KEEP (*(.inttab2.intvec.175)) } > cpu2_dlmu
    .inttab_tc2_0B0 (TEXT) BIND(__INTTAB_CPU2 + 0x1600) : {KEEP (*(.inttab2.intvec.176)) } > cpu2_dlmu
    .inttab_tc2_0B1 (TEXT) BIND(__INTTAB_CPU2 + 0x1620) : {KEEP (*(.inttab2.intvec.177)) } > cpu2_dlmu
    .inttab_tc2_0B2 (TEXT) BIND(__INTTAB_CPU2 + 0x1640) : {KEEP (*(.inttab2.intvec.178)) } > cpu2_dlmu
    .inttab_tc2_0B3 (TEXT) BIND(__INTTAB_CPU2 + 0x1660) : {KEEP (*(.inttab2.intvec.179)) } > cpu2_dlmu
    .inttab_tc2_0B4 (TEXT) BIND(__INTTAB_CPU2 + 0x1680) : {KEEP (*(.inttab2.intvec.180)) } > cpu2_dlmu
    .inttab_tc2_0B5 (TEXT) BIND(__INTTAB_CPU2 + 0x16A0) : {KEEP (*(.inttab2.intvec.181)) } > cpu2_dlmu
    .inttab_tc2_0B6 (TEXT) BIND(__INTTAB_CPU2 + 0x16C0) : {KEEP (*(.inttab2.intvec.182)) } > cpu2_dlmu
    .inttab_tc2_0B7 (TEXT) BIND(__INTTAB_CPU2 + 0x16E0) : {KEEP (*(.inttab2.intvec.183)) } > cpu2_dlmu
    .inttab_tc2_0B8 (TEXT) BIND(__INTTAB_CPU2 + 0x1700) : {KEEP (*(.inttab2.intvec.184)) } > cpu2_dlmu
    .inttab_tc2_0B9 (TEXT) BIND(__INTTAB_CPU2 + 0x1720) : {KEEP (*(.inttab2.intvec.185)) } > cpu2_dlmu
    .inttab_tc2_0BA (TEXT) BIND(__INTTAB_CPU2 + 0x1740) : {KEEP (*(.inttab2.intvec.186)) } > cpu2_dlmu
    .inttab_tc2_0BB (TEXT) BIND(__INTTAB_CPU2 + 0x1760) : {KEEP (*(.inttab2.intvec.187)) } > cpu2_dlmu
    .inttab_tc2_0BC (TEXT) BIND(__INTTAB_CPU2 + 0x1780) : {KEEP (*(.inttab2.intvec.188)) } > cpu2_dlmu
    .inttab_tc2_0BD (TEXT) BIND(__INTTAB_CPU2 + 0x17A0) : {KEEP (*(.inttab2.intvec.189)) } > cpu2_dlmu
    .inttab_tc2_0BE (TEXT) BIND(__INTTAB_CPU2 + 0x17C0) : {KEEP (*(.inttab2.intvec.190)) } > cpu2_dlmu
    .inttab_tc2_0BF (TEXT) BIND(__INTTAB_CPU2 + 0x17E0) : {KEEP (*(.inttab2.intvec.191)) } > cpu2_dlmu
    .inttab_tc2_0C0 (TEXT) BIND(__INTTAB_CPU2 + 0x1800) : {KEEP (*(.inttab2.intvec.192)) } > cpu2_dlmu
    .inttab_tc2_0C1 (TEXT) BIND(__INTTAB_CPU2 + 0x1820) : {KEEP (*(.inttab2.intvec.193)) } > cpu2_dlmu
    .inttab_tc2_0C2 (TEXT) BIND(__INTTAB_CPU2 + 0x1840) : {KEEP (*(.inttab2.intvec.194)) } > cpu2_dlmu
    .inttab_tc2_0C3 (TEXT) BIND(__INTTAB_CPU2 + 0x1860) : {KEEP (*(.inttab2.intvec.195)) } > cpu2_dlmu
    .inttab_tc2_0C4 (TEXT) BIND(__INTTAB_CPU2 + 0x1880) : {KEEP (*(.inttab2.intvec.196)) } > cpu2_dlmu
    .inttab_tc2_0C5 (TEXT) BIND(__INTTAB_CPU2 + 0x18A0) : {KEEP (*(.inttab2.intvec.197)) } > cpu2_dlmu
    .inttab_tc2_0C6 (TEXT) BIND(__INTTAB_CPU2 + 0x18C0) : {KEEP (*(.inttab2.intvec.198)) } > cpu2_dlmu
    .inttab_tc2_0C7 (TEXT) BIND(__INTTAB_CPU2 + 0x18E0) : {KEEP (*(.inttab2.intvec.199)) } > cpu2_dlmu
    .inttab_tc2_0C8 (TEXT) BIND(__INTTAB_CPU2 + 0x1900) : {KEEP (*(.inttab2.intvec.200)) } > cpu2_dlmu
    .inttab_tc2_0C9 (TEXT) BIND(__INTTAB_CPU2 + 0x1920) : {KEEP (*(.inttab2.intvec.201)) } > cpu2_dlmu
    .inttab_tc2_0CA (TEXT) BIND(__INTTAB_CPU2 + 0x1940) : {KEEP (*(.inttab2.intvec.202)) } > cpu2_dlmu
    .inttab_tc2_0CB (TEXT) BIND(__INTTAB_CPU2 + 0x1960) : {KEEP (*(.inttab2.intvec.203)) } > cpu2_dlmu
    .inttab_tc2_0CC (TEXT) BIND(__INTTAB_CPU2 + 0x1980) : {KEEP (*(.inttab2.intvec.204)) } > cpu2_dlmu
    .inttab_tc2_0CD (TEXT) BIND(__INTTAB_CPU2 + 0x19A0) : {KEEP (*(.inttab2.intvec.205)) } > cpu2_dlmu
    .inttab_tc2_0CE (TEXT) BIND(__INTTAB_CPU2 + 0x19C0) : {KEEP (*(.inttab2.intvec.206)) } > cpu2_dlmu
    .inttab_tc2_0CF (TEXT) BIND(__INTTAB_CPU2 + 0x19E0) : {KEEP (*(.inttab2.intvec.207)) } > cpu2_dlmu
    .inttab_tc2_0D0 (TEXT) BIND(__INTTAB_CPU2 + 0x1A00) : {KEEP (*(.inttab2.intvec.208)) } > cpu2_dlmu
    .inttab_tc2_0D1 (TEXT) BIND(__INTTAB_CPU2 + 0x1A20) : {KEEP (*(.inttab2.intvec.209)) } > cpu2_dlmu
    .inttab_tc2_0D2 (TEXT) BIND(__INTTAB_CPU2 + 0x1A40) : {KEEP (*(.inttab2.intvec.210)) } > cpu2_dlmu
    .inttab_tc2_0D3 (TEXT) BIND(__INTTAB_CPU2 + 0x1A60) : {KEEP (*(.inttab2.intvec.211)) } > cpu2_dlmu
    .inttab_tc2_0D4 (TEXT) BIND(__INTTAB_CPU2 + 0x1A80) : {KEEP (*(.inttab2.intvec.212)) } > cpu2_dlmu
    .inttab_tc2_0D5 (TEXT) BIND(__INTTAB_CPU2 + 0x1AA0) : {KEEP (*(.inttab2.intvec.213)) } > cpu2_dlmu
    .inttab_tc2_0D6 (TEXT) BIND(__INTTAB_CPU2 + 0x1AC0) : {KEEP (*(.inttab2.intvec.214)) } > cpu2_dlmu
    .inttab_tc2_0D7 (TEXT) BIND(__INTTAB_CPU2 + 0x1AE0) : {KEEP (*(.inttab2.intvec.215)) } > cpu2_dlmu
    .inttab_tc2_0D8 (TEXT) BIND(__INTTAB_CPU2 + 0x1B00) : {KEEP (*(.inttab2.intvec.216)) } > cpu2_dlmu
    .inttab_tc2_0D9 (TEXT) BIND(__INTTAB_CPU2 + 0x1B20) : {KEEP (*(.inttab2.intvec.217)) } > cpu2_dlmu
    .inttab_tc2_0DA (TEXT) BIND(__INTTAB_CPU2 + 0x1B40) : {KEEP (*(.inttab2.intvec.218)) } > cpu2_dlmu
    .inttab_tc2_0DB (TEXT) BIND(__INTTAB_CPU2 + 0x1B60) : {KEEP (*(.inttab2.intvec.219)) } > cpu2_dlmu
    .inttab_tc2_0DC (TEXT) BIND(__INTTAB_CPU2 + 0x1B80) : {KEEP (*(.inttab2.intvec.220)) } > cpu2_dlmu
    .inttab_tc2_0DD (TEXT) BIND(__INTTAB_CPU2 + 0x1BA0) : {KEEP (*(.inttab2.intvec.221)) } > cpu2_dlmu
    .inttab_tc2_0DE (TEXT) BIND(__INTTAB_CPU2 + 0x1BC0) : {KEEP (*(.inttab2.intvec.222)) } > cpu2_dlmu
    .inttab_tc2_0DF (TEXT) BIND(__INTTAB_CPU2 + 0x1BE0) : {KEEP (*(.inttab2.intvec.223)) } > cpu2_dlmu
    .inttab_tc2_0E0 (TEXT) BIND(__INTTAB_CPU2 + 0x1C00) : {KEEP (*(.inttab2.intvec.224)) } > cpu2_dlmu
    .inttab_tc2_0E1 (TEXT) BIND(__INTTAB_CPU2 + 0x1C20) : {KEEP (*(.inttab2.intvec.225)) } > cpu2_dlmu
    .inttab_tc2_0E2 (TEXT) BIND(__INTTAB_CPU2 + 0x1C40) : {KEEP (*(.inttab2.intvec.226)) } > cpu2_dlmu
    .inttab_tc2_0E3 (TEXT) BIND(__INTTAB_CPU2 + 0x1C60) : {KEEP (*(.inttab2.intvec.227)) } > cpu2_dlmu
    .inttab_tc2_0E4 (TEXT) BIND(__INTTAB_CPU2 + 0x1C80) : {KEEP (*(.inttab2.intvec.228)) } > cpu2_dlmu
    .inttab_tc2_0E5 (TEXT) BIND(__INTTAB_CPU2 + 0x1CA0) : {KEEP (*(.inttab2.intvec.229)) } > cpu2_dlmu
    .inttab_tc2_0E6 (TEXT) BIND(__INTTAB_CPU2 + 0x1CC0) : {KEEP (*(.inttab2.intvec.230)) } > cpu2_dlmu
    .inttab_tc2_0E7 (TEXT) BIND(__INTTAB_CPU2 + 0x1CE0) : {KEEP (*(.inttab2.intvec.231)) } > cpu2_dlmu
    .inttab_tc2_0E8 (TEXT) BIND(__INTTAB_CPU2 + 0x1D00) : {KEEP (*(.inttab2.intvec.232)) } > cpu2_dlmu
    .inttab_tc2_0E9 (TEXT) BIND(__INTTAB_CPU2 + 0x1D20) : {KEEP (*(.inttab2.intvec.233)) } > cpu2_dlmu
    .inttab_tc2_0EA (TEXT) BIND(__INTTAB_CPU2 + 0x1D40) : {KEEP (*(.inttab2.intvec.234)) } > cpu2_dlmu
    .inttab_tc2_0EB (TEXT) BIND(__INTTAB_CPU2 + 0x1D60) : {KEEP (*(.inttab2.intvec.235)) } > cpu2_dlmu
    .inttab_tc2_0EC (TEXT) BIND(__INTTAB_CPU2 + 0x1D80) : {KEEP (*(.inttab2.intvec.236)) } > cpu2_dlmu
    .inttab_tc2_0ED (TEXT) BIND(__INTTAB_CPU2 + 0x1DA0) : {KEEP (*(.inttab2.intvec.237)) } > cpu2_dlmu
    .inttab_tc2_0EE (TEXT) BIND(__INTTAB_CPU2 + 0x1DC0) : {KEEP (*(.inttab2.intvec.238)) } > cpu2_dlmu
    .inttab_tc2_0EF (TEXT) BIND(__INTTAB_CPU2 + 0x1DE0) : {KEEP (*(.inttab2.intvec.239)) } > cpu2_dlmu
    .inttab_tc2_0F0 (TEXT) BIND(__INTTAB_CPU2 + 0x1E00) : {KEEP (*(.inttab2.intvec.240)) } > cpu2_dlmu
    .inttab_tc2_0F1 (TEXT) BIND(__INTTAB_CPU2 + 0x1E20) : {KEEP (*(.inttab2.intvec.241)) } > cpu2_dlmu
    .inttab_tc2_0F2 (TEXT) BIND(__INTTAB_CPU2 + 0x1E40) : {KEEP (*(.inttab2.intvec.242)) } > cpu2_dlmu
    .inttab_tc2_0F3 (TEXT) BIND(__INTTAB_CPU2 + 0x1E60) : {KEEP (*(.inttab2.intvec.243)) } > cpu2_dlmu
    .inttab_tc2_0F4 (TEXT) BIND(__INTTAB_CPU2 + 0x1E80) : {KEEP (*(.inttab2.intvec.244)) } > cpu2_dlmu
    .inttab_tc2_0F5 (TEXT) BIND(__INTTAB_CPU2 + 0x1EA0) : {KEEP (*(.inttab2.intvec.245)) } > cpu2_dlmu
    .inttab_tc2_0F6 (TEXT) BIND(__INTTAB_CPU2 + 0x1EC0) : {KEEP (*(.inttab2.intvec.246)) } > cpu2_dlmu
    .inttab_tc2_0F7 (TEXT) BIND(__INTTAB_CPU2 + 0x1EE0) : {KEEP (*(.inttab2.intvec.247)) } > cpu2_dlmu
    .inttab_tc2_0F8 (TEXT) BIND(__INTTAB_CPU2 + 0x1F00) : {KEEP (*(.inttab2.intvec.248)) } > cpu2_dlmu
    .inttab_tc2_0F9 (TEXT) BIND(__INTTAB_CPU2 + 0x1F20) : {KEEP (*(.inttab2.intvec.249)) } > cpu2_dlmu
    .inttab_tc2_0FA (TEXT) BIND(__INTTAB_CPU2 + 0x1F40) : {KEEP (*(.inttab2.intvec.250)) } > cpu2_dlmu
    .inttab_tc2_0FB (TEXT) BIND(__INTTAB_CPU2 + 0x1F60) : {KEEP (*(.inttab2.intvec.251)) } > cpu2_dlmu
    .inttab_tc2_0FC (TEXT) BIND(__INTTAB_CPU2 + 0x1F80) : {KEEP (*(.inttab2.intvec.252)) } > cpu2_dlmu
    .inttab_tc2_0FD (TEXT) BIND(__INTTAB_CPU2 + 0x1FA0) : {KEEP (*(.inttab2.intvec.253)) } > cpu2_dlmu
    .inttab_tc2_0FE (TEXT) BIND(__INTTAB_CPU2 + 0x1FC0) : {KEEP (*(.inttab2.intvec.254)) } > cpu2_dlmu
    .inttab_tc2_0FF (TEXT) BIND(__INTTAB_CPU2 + 0x1FE0) : {KEEP (*(.inttab2.intvec.255)) } > cpu2_dlmu

    /* CPU3 Interrupt Vector Table */
    .inttab_tc3_000 (TEXT) BIND(__INTTAB_CPU3 + 0x0000) : {KEEP (*(.inttab3.intvec.0  )) } > cpu3_dlmu
    .inttab_tc3_001 (TEXT) BIND(__INTTAB_CPU3 + 0x0020) : {KEEP (*(.inttab3.intvec.1  )) } > cpu3_dlmu
    .inttab_tc3_002 (TEXT) BIND(__INTTAB_CPU3 + 0x0040) : {KEEP (*(.inttab3.intvec.2  )) } > cpu3_dlmu
    .inttab_tc3_003 (TEXT) BIND(__INTTAB_CPU3 + 0x0060) : {KEEP (*(.inttab3.intvec.3  )) } > cpu3_dlmu
    .inttab_tc3_004 (TEXT) BIND(__INTTAB_CPU3 + 0x0080) : {KEEP (*(.inttab3.intvec.4  )) } > cpu3_dlmu
    .inttab_tc3_005 (TEXT) BIND(__INTTAB_CPU3 + 0x00A0) : {KEEP (*(.inttab3.intvec.5  )) } > cpu3_dlmu
    .inttab_tc3_006 (TEXT) BIND(__INTTAB_CPU3 + 0x00C0) : {KEEP (*(.inttab3.intvec.6  )) } > cpu3_dlmu
    .inttab_tc3_007 (TEXT) BIND(__INTTAB_CPU3 + 0x00E0) : {KEEP (*(.inttab3.intvec.7  )) } > cpu3_dlmu
    .inttab_tc3_008 (TEXT) BIND(__INTTAB_CPU3 + 0x0100) : {KEEP (*(.inttab3.intvec.8  )) } > cpu3_dlmu
    .inttab_tc3_009 (TEXT) BIND(__INTTAB_CPU3 + 0x0120) : {KEEP (*(.inttab3.intvec.9  )) } > cpu3_dlmu
    .inttab_tc3_00A (TEXT) BIND(__INTTAB_CPU3 + 0x0140) : {KEEP (*(.inttab3.intvec.10 )) } > cpu3_dlmu
    .inttab_tc3_00B (TEXT) BIND(__INTTAB_CPU3 + 0x0160) : {KEEP (*(.inttab3.intvec.11 )) } > cpu3_dlmu
    .inttab_tc3_00C (TEXT) BIND(__INTTAB_CPU3 + 0x0180) : {KEEP (*(.inttab3.intvec.12 )) } > cpu3_dlmu
    .inttab_tc3_00D (TEXT) BIND(__INTTAB_CPU3 + 0x01A0) : {KEEP (*(.inttab3.intvec.13 )) } > cpu3_dlmu
    .inttab_tc3_00E (TEXT) BIND(__INTTAB_CPU3 + 0x01C0) : {KEEP (*(.inttab3.intvec.14 )) } > cpu3_dlmu
    .inttab_tc3_00F (TEXT) BIND(__INTTAB_CPU3 + 0x01E0) : {KEEP (*(.inttab3.intvec.15 )) } > cpu3_dlmu
    .inttab_tc3_010 (TEXT) BIND(__INTTAB_CPU3 + 0x0200) : {KEEP (*(.inttab3.intvec.16 )) } > cpu3_dlmu
    .inttab_tc3_011 (TEXT) BIND(__INTTAB_CPU3 + 0x0220) : {KEEP (*(.inttab3.intvec.17 )) } > cpu3_dlmu
    .inttab_tc3_012 (TEXT) BIND(__INTTAB_CPU3 + 0x0240) : {KEEP (*(.inttab3.intvec.18 )) } > cpu3_dlmu
    .inttab_tc3_013 (TEXT) BIND(__INTTAB_CPU3 + 0x0260) : {KEEP (*(.inttab3.intvec.19 )) } > cpu3_dlmu
    .inttab_tc3_014 (TEXT) BIND(__INTTAB_CPU3 + 0x0280) : {KEEP (*(.inttab3.intvec.20 )) } > cpu3_dlmu
    .inttab_tc3_015 (TEXT) BIND(__INTTAB_CPU3 + 0x02A0) : {KEEP (*(.inttab3.intvec.21 )) } > cpu3_dlmu
    .inttab_tc3_016 (TEXT) BIND(__INTTAB_CPU3 + 0x02C0) : {KEEP (*(.inttab3.intvec.22 )) } > cpu3_dlmu
    .inttab_tc3_017 (TEXT) BIND(__INTTAB_CPU3 + 0x02E0) : {KEEP (*(.inttab3.intvec.23 )) } > cpu3_dlmu
    .inttab_tc3_018 (TEXT) BIND(__INTTAB_CPU3 + 0x0300) : {KEEP (*(.inttab3.intvec.24 )) } > cpu3_dlmu
    .inttab_tc3_019 (TEXT) BIND(__INTTAB_CPU3 + 0x0320) : {KEEP (*(.inttab3.intvec.25 )) } > cpu3_dlmu
    .inttab_tc3_01A (TEXT) BIND(__INTTAB_CPU3 + 0x0340) : {KEEP (*(.inttab3.intvec.26 )) } > cpu3_dlmu
    .inttab_tc3_01B (TEXT) BIND(__INTTAB_CPU3 + 0x0360) : {KEEP (*(.inttab3.intvec.27 )) } > cpu3_dlmu
    .inttab_tc3_01C (TEXT) BIND(__INTTAB_CPU3 + 0x0380) : {KEEP (*(.inttab3.intvec.28 )) } > cpu3_dlmu
    .inttab_tc3_01D (TEXT) BIND(__INTTAB_CPU3 + 0x03A0) : {KEEP (*(.inttab3.intvec.29 )) } > cpu3_dlmu
    .inttab_tc3_01E (TEXT) BIND(__INTTAB_CPU3 + 0x03C0) : {KEEP (*(.inttab3.intvec.30 )) } > cpu3_dlmu
    .inttab_tc3_01F (TEXT) BIND(__INTTAB_CPU3 + 0x03E0) : {KEEP (*(.inttab3.intvec.31 )) } > cpu3_dlmu
    .inttab_tc3_020 (TEXT) BIND(__INTTAB_CPU3 + 0x0400) : {KEEP (*(.inttab3.intvec.32 )) } > cpu3_dlmu
    .inttab_tc3_021 (TEXT) BIND(__INTTAB_CPU3 + 0x0420) : {KEEP (*(.inttab3.intvec.33 )) } > cpu3_dlmu
    .inttab_tc3_022 (TEXT) BIND(__INTTAB_CPU3 + 0x0440) : {KEEP (*(.inttab3.intvec.34 )) } > cpu3_dlmu
    .inttab_tc3_023 (TEXT) BIND(__INTTAB_CPU3 + 0x0460) : {KEEP (*(.inttab3.intvec.35 )) } > cpu3_dlmu
    .inttab_tc3_024 (TEXT) BIND(__INTTAB_CPU3 + 0x0480) : {KEEP (*(.inttab3.intvec.36 )) } > cpu3_dlmu
    .inttab_tc3_025 (TEXT) BIND(__INTTAB_CPU3 + 0x04A0) : {KEEP (*(.inttab3.intvec.37 )) } > cpu3_dlmu
    .inttab_tc3_026 (TEXT) BIND(__INTTAB_CPU3 + 0x04C0) : {KEEP (*(.inttab3.intvec.38 )) } > cpu3_dlmu
    .inttab_tc3_027 (TEXT) BIND(__INTTAB_CPU3 + 0x04E0) : {KEEP (*(.inttab3.intvec.39 )) } > cpu3_dlmu
    .inttab_tc3_028 (TEXT) BIND(__INTTAB_CPU3 + 0x0500) : {KEEP (*(.inttab3.intvec.40 )) } > cpu3_dlmu
    .inttab_tc3_029 (TEXT) BIND(__INTTAB_CPU3 + 0x0520) : {KEEP (*(.inttab3.intvec.41 )) } > cpu3_dlmu
    .inttab_tc3_02A (TEXT) BIND(__INTTAB_CPU3 + 0x0540) : {KEEP (*(.inttab3.intvec.42 )) } > cpu3_dlmu
    .inttab_tc3_02B (TEXT) BIND(__INTTAB_CPU3 + 0x0560) : {KEEP (*(.inttab3.intvec.43 )) } > cpu3_dlmu
    .inttab_tc3_02C (TEXT) BIND(__INTTAB_CPU3 + 0x0580) : {KEEP (*(.inttab3.intvec.44 )) } > cpu3_dlmu
    .inttab_tc3_02D (TEXT) BIND(__INTTAB_CPU3 + 0x05A0) : {KEEP (*(.inttab3.intvec.45 )) } > cpu3_dlmu
    .inttab_tc3_02E (TEXT) BIND(__INTTAB_CPU3 + 0x05C0) : {KEEP (*(.inttab3.intvec.46 )) } > cpu3_dlmu
    .inttab_tc3_02F (TEXT) BIND(__INTTAB_CPU3 + 0x05E0) : {KEEP (*(.inttab3.intvec.47 )) } > cpu3_dlmu
    .inttab_tc3_030 (TEXT) BIND(__INTTAB_CPU3 + 0x0600) : {KEEP (*(.inttab3.intvec.48 )) } > cpu3_dlmu
    .inttab_tc3_031 (TEXT) BIND(__INTTAB_CPU3 + 0x0620) : {KEEP (*(.inttab3.intvec.49 )) } > cpu3_dlmu
    .inttab_tc3_032 (TEXT) BIND(__INTTAB_CPU3 + 0x0640) : {KEEP (*(.inttab3.intvec.50 )) } > cpu3_dlmu
    .inttab_tc3_033 (TEXT) BIND(__INTTAB_CPU3 + 0x0660) : {KEEP (*(.inttab3.intvec.51 )) } > cpu3_dlmu
    .inttab_tc3_034 (TEXT) BIND(__INTTAB_CPU3 + 0x0680) : {KEEP (*(.inttab3.intvec.52 )) } > cpu3_dlmu
    .inttab_tc3_035 (TEXT) BIND(__INTTAB_CPU3 + 0x06A0) : {KEEP (*(.inttab3.intvec.53 )) } > cpu3_dlmu
    .inttab_tc3_036 (TEXT) BIND(__INTTAB_CPU3 + 0x06C0) : {KEEP (*(.inttab3.intvec.54 )) } > cpu3_dlmu
    .inttab_tc3_037 (TEXT) BIND(__INTTAB_CPU3 + 0x06E0) : {KEEP (*(.inttab3.intvec.55 )) } > cpu3_dlmu
    .inttab_tc3_038 (TEXT) BIND(__INTTAB_CPU3 + 0x0700) : {KEEP (*(.inttab3.intvec.56 )) } > cpu3_dlmu
    .inttab_tc3_039 (TEXT) BIND(__INTTAB_CPU3 + 0x0720) : {KEEP (*(.inttab3.intvec.57 )) } > cpu3_dlmu
    .inttab_tc3_03A (TEXT) BIND(__INTTAB_CPU3 + 0x0740) : {KEEP (*(.inttab3.intvec.58 )) } > cpu3_dlmu
    .inttab_tc3_03B (TEXT) BIND(__INTTAB_CPU3 + 0x0760) : {KEEP (*(.inttab3.intvec.59 )) } > cpu3_dlmu
    .inttab_tc3_03C (TEXT) BIND(__INTTAB_CPU3 + 0x0780) : {KEEP (*(.inttab3.intvec.60 )) } > cpu3_dlmu
    .inttab_tc3_03D (TEXT) BIND(__INTTAB_CPU3 + 0x07A0) : {KEEP (*(.inttab3.intvec.61 )) } > cpu3_dlmu
    .inttab_tc3_03E (TEXT) BIND(__INTTAB_CPU3 + 0x07C0) : {KEEP (*(.inttab3.intvec.62 )) } > cpu3_dlmu
    .inttab_tc3_03F (TEXT) BIND(__INTTAB_CPU3 + 0x07E0) : {KEEP (*(.inttab3.intvec.63 )) } > cpu3_dlmu
    .inttab_tc3_040 (TEXT) BIND(__INTTAB_CPU3 + 0x0800) : {KEEP (*(.inttab3.intvec.64 )) } > cpu3_dlmu
    .inttab_tc3_041 (TEXT) BIND(__INTTAB_CPU3 + 0x0820) : {KEEP (*(.inttab3.intvec.65 )) } > cpu3_dlmu
    .inttab_tc3_042 (TEXT) BIND(__INTTAB_CPU3 + 0x0840) : {KEEP (*(.inttab3.intvec.66 )) } > cpu3_dlmu
    .inttab_tc3_043 (TEXT) BIND(__INTTAB_CPU3 + 0x0860) : {KEEP (*(.inttab3.intvec.67 )) } > cpu3_dlmu
    .inttab_tc3_044 (TEXT) BIND(__INTTAB_CPU3 + 0x0880) : {KEEP (*(.inttab3.intvec.68 )) } > cpu3_dlmu
    .inttab_tc3_045 (TEXT) BIND(__INTTAB_CPU3 + 0x08A0) : {KEEP (*(.inttab3.intvec.69 )) } > cpu3_dlmu
    .inttab_tc3_046 (TEXT) BIND(__INTTAB_CPU3 + 0x08C0) : {KEEP (*(.inttab3.intvec.70 )) } > cpu3_dlmu
    .inttab_tc3_047 (TEXT) BIND(__INTTAB_CPU3 + 0x08E0) : {KEEP (*(.inttab3.intvec.71 )) } > cpu3_dlmu
    .inttab_tc3_048 (TEXT) BIND(__INTTAB_CPU3 + 0x0900) : {KEEP (*(.inttab3.intvec.72 )) } > cpu3_dlmu
    .inttab_tc3_049 (TEXT) BIND(__INTTAB_CPU3 + 0x0920) : {KEEP (*(.inttab3.intvec.73 )) } > cpu3_dlmu
    .inttab_tc3_04A (TEXT) BIND(__INTTAB_CPU3 + 0x0940) : {KEEP (*(.inttab3.intvec.74 )) } > cpu3_dlmu
    .inttab_tc3_04B (TEXT) BIND(__INTTAB_CPU3 + 0x0960) : {KEEP (*(.inttab3.intvec.75 )) } > cpu3_dlmu
    .inttab_tc3_04C (TEXT) BIND(__INTTAB_CPU3 + 0x0980) : {KEEP (*(.inttab3.intvec.76 )) } > cpu3_dlmu
    .inttab_tc3_04D (TEXT) BIND(__INTTAB_CPU3 + 0x09A0) : {KEEP (*(.inttab3.intvec.77 )) } > cpu3_dlmu
    .inttab_tc3_04E (TEXT) BIND(__INTTAB_CPU3 + 0x09C0) : {KEEP (*(.inttab3.intvec.78 )) } > cpu3_dlmu
    .inttab_tc3_04F (TEXT) BIND(__INTTAB_CPU3 + 0x09E0) : {KEEP (*(.inttab3.intvec.79 )) } > cpu3_dlmu
    .inttab_tc3_050 (TEXT) BIND(__INTTAB_CPU3 + 0x0A00) : {KEEP (*(.inttab3.intvec.80 )) } > cpu3_dlmu
    .inttab_tc3_051 (TEXT) BIND(__INTTAB_CPU3 + 0x0A20) : {KEEP (*(.inttab3.intvec.81 )) } > cpu3_dlmu
    .inttab_tc3_052 (TEXT) BIND(__INTTAB_CPU3 + 0x0A40) : {KEEP (*(.inttab3.intvec.82 )) } > cpu3_dlmu
    .inttab_tc3_053 (TEXT) BIND(__INTTAB_CPU3 + 0x0A60) : {KEEP (*(.inttab3.intvec.83 )) } > cpu3_dlmu
    .inttab_tc3_054 (TEXT) BIND(__INTTAB_CPU3 + 0x0A80) : {KEEP (*(.inttab3.intvec.84 )) } > cpu3_dlmu
    .inttab_tc3_055 (TEXT) BIND(__INTTAB_CPU3 + 0x0AA0) : {KEEP (*(.inttab3.intvec.85 )) } > cpu3_dlmu
    .inttab_tc3_056 (TEXT) BIND(__INTTAB_CPU3 + 0x0AC0) : {KEEP (*(.inttab3.intvec.86 )) } > cpu3_dlmu
    .inttab_tc3_057 (TEXT) BIND(__INTTAB_CPU3 + 0x0AE0) : {KEEP (*(.inttab3.intvec.87 )) } > cpu3_dlmu
    .inttab_tc3_058 (TEXT) BIND(__INTTAB_CPU3 + 0x0B00) : {KEEP (*(.inttab3.intvec.88 )) } > cpu3_dlmu
    .inttab_tc3_059 (TEXT) BIND(__INTTAB_CPU3 + 0x0B20) : {KEEP (*(.inttab3.intvec.89 )) } > cpu3_dlmu
    .inttab_tc3_05A (TEXT) BIND(__INTTAB_CPU3 + 0x0B40) : {KEEP (*(.inttab3.intvec.90 )) } > cpu3_dlmu
    .inttab_tc3_05B (TEXT) BIND(__INTTAB_CPU3 + 0x0B60) : {KEEP (*(.inttab3.intvec.91 )) } > cpu3_dlmu
    .inttab_tc3_05C (TEXT) BIND(__INTTAB_CPU3 + 0x0B80) : {KEEP (*(.inttab3.intvec.92 )) } > cpu3_dlmu
    .inttab_tc3_05D (TEXT) BIND(__INTTAB_CPU3 + 0x0BA0) : {KEEP (*(.inttab3.intvec.93 )) } > cpu3_dlmu
    .inttab_tc3_05E (TEXT) BIND(__INTTAB_CPU3 + 0x0BC0) : {KEEP (*(.inttab3.intvec.94 )) } > cpu3_dlmu
    .inttab_tc3_05F (TEXT) BIND(__INTTAB_CPU3 + 0x0BE0) : {KEEP (*(.inttab3.intvec.95 )) } > cpu3_dlmu
    .inttab_tc3_060 (TEXT) BIND(__INTTAB_CPU3 + 0x0C00) : {KEEP (*(.inttab3.intvec.96 )) } > cpu3_dlmu
    .inttab_tc3_061 (TEXT) BIND(__INTTAB_CPU3 + 0x0C20) : {KEEP (*(.inttab3.intvec.97 )) } > cpu3_dlmu
    .inttab_tc3_062 (TEXT) BIND(__INTTAB_CPU3 + 0x0C40) : {KEEP (*(.inttab3.intvec.98 )) } > cpu3_dlmu
    .inttab_tc3_063 (TEXT) BIND(__INTTAB_CPU3 + 0x0C60) : {KEEP (*(.inttab3.intvec.99 )) } > cpu3_dlmu
    .inttab_tc3_064 (TEXT) BIND(__INTTAB_CPU3 + 0x0C80) : {KEEP (*(.inttab3.intvec.100)) } > cpu3_dlmu
    .inttab_tc3_065 (TEXT) BIND(__INTTAB_CPU3 + 0x0CA0) : {KEEP (*(.inttab3.intvec.101)) } > cpu3_dlmu
    .inttab_tc3_066 (TEXT) BIND(__INTTAB_CPU3 + 0x0CC0) : {KEEP (*(.inttab3.intvec.102)) } > cpu3_dlmu
    .inttab_tc3_067 (TEXT) BIND(__INTTAB_CPU3 + 0x0CE0) : {KEEP (*(.inttab3.intvec.103)) } > cpu3_dlmu
    .inttab_tc3_068 (TEXT) BIND(__INTTAB_CPU3 + 0x0D00) : {KEEP (*(.inttab3.intvec.104)) } > cpu3_dlmu
    .inttab_tc3_069 (TEXT) BIND(__INTTAB_CPU3 + 0x0D20) : {KEEP (*(.inttab3.intvec.105)) } > cpu3_dlmu
    .inttab_tc3_06A (TEXT) BIND(__INTTAB_CPU3 + 0x0D40) : {KEEP (*(.inttab3.intvec.106)) } > cpu3_dlmu
    .inttab_tc3_06B (TEXT) BIND(__INTTAB_CPU3 + 0x0D60) : {KEEP (*(.inttab3.intvec.107)) } > cpu3_dlmu
    .inttab_tc3_06C (TEXT) BIND(__INTTAB_CPU3 + 0x0D80) : {KEEP (*(.inttab3.intvec.108)) } > cpu3_dlmu
    .inttab_tc3_06D (TEXT) BIND(__INTTAB_CPU3 + 0x0DA0) : {KEEP (*(.inttab3.intvec.109)) } > cpu3_dlmu
    .inttab_tc3_06E (TEXT) BIND(__INTTAB_CPU3 + 0x0DC0) : {KEEP (*(.inttab3.intvec.110)) } > cpu3_dlmu
    .inttab_tc3_06F (TEXT) BIND(__INTTAB_CPU3 + 0x0DE0) : {KEEP (*(.inttab3.intvec.111)) } > cpu3_dlmu
    .inttab_tc3_070 (TEXT) BIND(__INTTAB_CPU3 + 0x0E00) : {KEEP (*(.inttab3.intvec.112)) } > cpu3_dlmu
    .inttab_tc3_071 (TEXT) BIND(__INTTAB_CPU3 + 0x0E20) : {KEEP (*(.inttab3.intvec.113)) } > cpu3_dlmu
    .inttab_tc3_072 (TEXT) BIND(__INTTAB_CPU3 + 0x0E40) : {KEEP (*(.inttab3.intvec.114)) } > cpu3_dlmu
    .inttab_tc3_073 (TEXT) BIND(__INTTAB_CPU3 + 0x0E60) : {KEEP (*(.inttab3.intvec.115)) } > cpu3_dlmu
    .inttab_tc3_074 (TEXT) BIND(__INTTAB_CPU3 + 0x0E80) : {KEEP (*(.inttab3.intvec.116)) } > cpu3_dlmu
    .inttab_tc3_075 (TEXT) BIND(__INTTAB_CPU3 + 0x0EA0) : {KEEP (*(.inttab3.intvec.117)) } > cpu3_dlmu
    .inttab_tc3_076 (TEXT) BIND(__INTTAB_CPU3 + 0x0EC0) : {KEEP (*(.inttab3.intvec.118)) } > cpu3_dlmu
    .inttab_tc3_077 (TEXT) BIND(__INTTAB_CPU3 + 0x0EE0) : {KEEP (*(.inttab3.intvec.119)) } > cpu3_dlmu
    .inttab_tc3_078 (TEXT) BIND(__INTTAB_CPU3 + 0x0F00) : {KEEP (*(.inttab3.intvec.120)) } > cpu3_dlmu
    .inttab_tc3_079 (TEXT) BIND(__INTTAB_CPU3 + 0x0F20) : {KEEP (*(.inttab3.intvec.121)) } > cpu3_dlmu
    .inttab_tc3_07A (TEXT) BIND(__INTTAB_CPU3 + 0x0F40) : {KEEP (*(.inttab3.intvec.122)) } > cpu3_dlmu
    .inttab_tc3_07B (TEXT) BIND(__INTTAB_CPU3 + 0x0F60) : {KEEP (*(.inttab3.intvec.123)) } > cpu3_dlmu
    .inttab_tc3_07C (TEXT) BIND(__INTTAB_CPU3 + 0x0F80) : {KEEP (*(.inttab3.intvec.124)) } > cpu3_dlmu
    .inttab_tc3_07D (TEXT) BIND(__INTTAB_CPU3 + 0x0FA0) : {KEEP (*(.inttab3.intvec.125)) } > cpu3_dlmu
    .inttab_tc3_07E (TEXT) BIND(__INTTAB_CPU3 + 0x0FC0) : {KEEP (*(.inttab3.intvec.126)) } > cpu3_dlmu
    .inttab_tc3_07F (TEXT) BIND(__INTTAB_CPU3 + 0x0FE0) : {KEEP (*(.inttab3.intvec.127)) } > cpu3_dlmu
    .inttab_tc3_080 (TEXT) BIND(__INTTAB_CPU3 + 0x1000) : {KEEP (*(.inttab3.intvec.128)) } > cpu3_dlmu
    .inttab_tc3_081 (TEXT) BIND(__INTTAB_CPU3 + 0x1020) : {KEEP (*(.inttab3.intvec.129)) } > cpu3_dlmu
    .inttab_tc3_082 (TEXT) BIND(__INTTAB_CPU3 + 0x1040) : {KEEP (*(.inttab3.intvec.130)) } > cpu3_dlmu
    .inttab_tc3_083 (TEXT) BIND(__INTTAB_CPU3 + 0x1060) : {KEEP (*(.inttab3.intvec.131)) } > cpu3_dlmu
    .inttab_tc3_084 (TEXT) BIND(__INTTAB_CPU3 + 0x1080) : {KEEP (*(.inttab3.intvec.132)) } > cpu3_dlmu
    .inttab_tc3_085 (TEXT) BIND(__INTTAB_CPU3 + 0x10A0) : {KEEP (*(.inttab3.intvec.133)) } > cpu3_dlmu
    .inttab_tc3_086 (TEXT) BIND(__INTTAB_CPU3 + 0x10C0) : {KEEP (*(.inttab3.intvec.134)) } > cpu3_dlmu
    .inttab_tc3_087 (TEXT) BIND(__INTTAB_CPU3 + 0x10E0) : {KEEP (*(.inttab3.intvec.135)) } > cpu3_dlmu
    .inttab_tc3_088 (TEXT) BIND(__INTTAB_CPU3 + 0x1100) : {KEEP (*(.inttab3.intvec.136)) } > cpu3_dlmu
    .inttab_tc3_089 (TEXT) BIND(__INTTAB_CPU3 + 0x1120) : {KEEP (*(.inttab3.intvec.137)) } > cpu3_dlmu
    .inttab_tc3_08A (TEXT) BIND(__INTTAB_CPU3 + 0x1140) : {KEEP (*(.inttab3.intvec.138)) } > cpu3_dlmu
    .inttab_tc3_08B (TEXT) BIND(__INTTAB_CPU3 + 0x1160) : {KEEP (*(.inttab3.intvec.139)) } > cpu3_dlmu
    .inttab_tc3_08C (TEXT) BIND(__INTTAB_CPU3 + 0x1180) : {KEEP (*(.inttab3.intvec.140)) } > cpu3_dlmu
    .inttab_tc3_08D (TEXT) BIND(__INTTAB_CPU3 + 0x11A0) : {KEEP (*(.inttab3.intvec.141)) } > cpu3_dlmu
    .inttab_tc3_08E (TEXT) BIND(__INTTAB_CPU3 + 0x11C0) : {KEEP (*(.inttab3.intvec.142)) } > cpu3_dlmu
    .inttab_tc3_08F (TEXT) BIND(__INTTAB_CPU3 + 0x11E0) : {KEEP (*(.inttab3.intvec.143)) } > cpu3_dlmu
    .inttab_tc3_090 (TEXT) BIND(__INTTAB_CPU3 + 0x1200) : {KEEP (*(.inttab3.intvec.144)) } > cpu3_dlmu
    .inttab_tc3_091 (TEXT) BIND(__INTTAB_CPU3 + 0x1220) : {KEEP (*(.inttab3.intvec.145)) } > cpu3_dlmu
    .inttab_tc3_092 (TEXT) BIND(__INTTAB_CPU3 + 0x1240) : {KEEP (*(.inttab3.intvec.146)) } > cpu3_dlmu
    .inttab_tc3_093 (TEXT) BIND(__INTTAB_CPU3 + 0x1260) : {KEEP (*(.inttab3.intvec.147)) } > cpu3_dlmu
    .inttab_tc3_094 (TEXT) BIND(__INTTAB_CPU3 + 0x1280) : {KEEP (*(.inttab3.intvec.148)) } > cpu3_dlmu
    .inttab_tc3_095 (TEXT) BIND(__INTTAB_CPU3 + 0x12A0) : {KEEP (*(.inttab3.intvec.149)) } > cpu3_dlmu
    .inttab_tc3_096 (TEXT) BIND(__INTTAB_CPU3 + 0x12C0) : {KEEP (*(.inttab3.intvec.150)) } > cpu3_dlmu
    .inttab_tc3_097 (TEXT) BIND(__INTTAB_CPU3 + 0x12E0) : {KEEP (*(.inttab3.intvec.151)) } > cpu3_dlmu
    .inttab_tc3_098 (TEXT) BIND(__INTTAB_CPU3 + 0x1300) : {KEEP (*(.inttab3.intvec.152)) } > cpu3_dlmu
    .inttab_tc3_099 (TEXT) BIND(__INTTAB_CPU3 + 0x1320) : {KEEP (*(.inttab3.intvec.153)) } > cpu3_dlmu
    .inttab_tc3_09A (TEXT) BIND(__INTTAB_CPU3 + 0x1340) : {KEEP (*(.inttab3.intvec.154)) } > cpu3_dlmu
    .inttab_tc3_09B (TEXT) BIND(__INTTAB_CPU3 + 0x1360) : {KEEP (*(.inttab3.intvec.155)) } > cpu3_dlmu
    .inttab_tc3_09C (TEXT) BIND(__INTTAB_CPU3 + 0x1380) : {KEEP (*(.inttab3.intvec.156)) } > cpu3_dlmu
    .inttab_tc3_09D (TEXT) BIND(__INTTAB_CPU3 + 0x13A0) : {KEEP (*(.inttab3.intvec.157)) } > cpu3_dlmu
    .inttab_tc3_09E (TEXT) BIND(__INTTAB_CPU3 + 0x13C0) : {KEEP (*(.inttab3.intvec.158)) } > cpu3_dlmu
    .inttab_tc3_09F (TEXT) BIND(__INTTAB_CPU3 + 0x13E0) : {KEEP (*(.inttab3.intvec.159)) } > cpu3_dlmu
    .inttab_tc3_0A0 (TEXT) BIND(__INTTAB_CPU3 + 0x1400) : {KEEP (*(.inttab3.intvec.160)) } > cpu3_dlmu
    .inttab_tc3_0A1 (TEXT) BIND(__INTTAB_CPU3 + 0x1420) : {KEEP (*(.inttab3.intvec.161)) } > cpu3_dlmu
    .inttab_tc3_0A2 (TEXT) BIND(__INTTAB_CPU3 + 0x1440) : {KEEP (*(.inttab3.intvec.162)) } > cpu3_dlmu
    .inttab_tc3_0A3 (TEXT) BIND(__INTTAB_CPU3 + 0x1460) : {KEEP (*(.inttab3.intvec.163)) } > cpu3_dlmu
    .inttab_tc3_0A4 (TEXT) BIND(__INTTAB_CPU3 + 0x1480) : {KEEP (*(.inttab3.intvec.164)) } > cpu3_dlmu
    .inttab_tc3_0A5 (TEXT) BIND(__INTTAB_CPU3 + 0x14A0) : {KEEP (*(.inttab3.intvec.165)) } > cpu3_dlmu
    .inttab_tc3_0A6 (TEXT) BIND(__INTTAB_CPU3 + 0x14C0) : {KEEP (*(.inttab3.intvec.166)) } > cpu3_dlmu
    .inttab_tc3_0A7 (TEXT) BIND(__INTTAB_CPU3 + 0x14E0) : {KEEP (*(.inttab3.intvec.167)) } > cpu3_dlmu
    .inttab_tc3_0A8 (TEXT) BIND(__INTTAB_CPU3 + 0x1500) : {KEEP (*(.inttab3.intvec.168)) } > cpu3_dlmu
    .inttab_tc3_0A9 (TEXT) BIND(__INTTAB_CPU3 + 0x1520) : {KEEP (*(.inttab3.intvec.169)) } > cpu3_dlmu
    .inttab_tc3_0AA (TEXT) BIND(__INTTAB_CPU3 + 0x1540) : {KEEP (*(.inttab3.intvec.170)) } > cpu3_dlmu
    .inttab_tc3_0AB (TEXT) BIND(__INTTAB_CPU3 + 0x1560) : {KEEP (*(.inttab3.intvec.171)) } > cpu3_dlmu
    .inttab_tc3_0AC (TEXT) BIND(__INTTAB_CPU3 + 0x1580) : {KEEP (*(.inttab3.intvec.172)) } > cpu3_dlmu
    .inttab_tc3_0AD (TEXT) BIND(__INTTAB_CPU3 + 0x15A0) : {KEEP (*(.inttab3.intvec.173)) } > cpu3_dlmu
    .inttab_tc3_0AE (TEXT) BIND(__INTTAB_CPU3 + 0x15C0) : {KEEP (*(.inttab3.intvec.174)) } > cpu3_dlmu
    .inttab_tc3_0AF (TEXT) BIND(__INTTAB_CPU3 + 0x15E0) : {KEEP (*(.inttab3.intvec.175)) } > cpu3_dlmu
    .inttab_tc3_0B0 (TEXT) BIND(__INTTAB_CPU3 + 0x1600) : {KEEP (*(.inttab3.intvec.176)) } > cpu3_dlmu
    .inttab_tc3_0B1 (TEXT) BIND(__INTTAB_CPU3 + 0x1620) : {KEEP (*(.inttab3.intvec.177)) } > cpu3_dlmu
    .inttab_tc3_0B2 (TEXT) BIND(__INTTAB_CPU3 + 0x1640) : {KEEP (*(.inttab3.intvec.178)) } > cpu3_dlmu
    .inttab_tc3_0B3 (TEXT) BIND(__INTTAB_CPU3 + 0x1660) : {KEEP (*(.inttab3.intvec.179)) } > cpu3_dlmu
    .inttab_tc3_0B4 (TEXT) BIND(__INTTAB_CPU3 + 0x1680) : {KEEP (*(.inttab3.intvec.180)) } > cpu3_dlmu
    .inttab_tc3_0B5 (TEXT) BIND(__INTTAB_CPU3 + 0x16A0) : {KEEP (*(.inttab3.intvec.181)) } > cpu3_dlmu
    .inttab_tc3_0B6 (TEXT) BIND(__INTTAB_CPU3 + 0x16C0) : {KEEP (*(.inttab3.intvec.182)) } > cpu3_dlmu
    .inttab_tc3_0B7 (TEXT) BIND(__INTTAB_CPU3 + 0x16E0) : {KEEP (*(.inttab3.intvec.183)) } > cpu3_dlmu
    .inttab_tc3_0B8 (TEXT) BIND(__INTTAB_CPU3 + 0x1700) : {KEEP (*(.inttab3.intvec.184)) } > cpu3_dlmu
    .inttab_tc3_0B9 (TEXT) BIND(__INTTAB_CPU3 + 0x1720) : {KEEP (*(.inttab3.intvec.185)) } > cpu3_dlmu
    .inttab_tc3_0BA (TEXT) BIND(__INTTAB_CPU3 + 0x1740) : {KEEP (*(.inttab3.intvec.186)) } > cpu3_dlmu
    .inttab_tc3_0BB (TEXT) BIND(__INTTAB_CPU3 + 0x1760) : {KEEP (*(.inttab3.intvec.187)) } > cpu3_dlmu
    .inttab_tc3_0BC (TEXT) BIND(__INTTAB_CPU3 + 0x1780) : {KEEP (*(.inttab3.intvec.188)) } > cpu3_dlmu
    .inttab_tc3_0BD (TEXT) BIND(__INTTAB_CPU3 + 0x17A0) : {KEEP (*(.inttab3.intvec.189)) } > cpu3_dlmu
    .inttab_tc3_0BE (TEXT) BIND(__INTTAB_CPU3 + 0x17C0) : {KEEP (*(.inttab3.intvec.190)) } > cpu3_dlmu
    .inttab_tc3_0BF (TEXT) BIND(__INTTAB_CPU3 + 0x17E0) : {KEEP (*(.inttab3.intvec.191)) } > cpu3_dlmu
    .inttab_tc3_0C0 (TEXT) BIND(__INTTAB_CPU3 + 0x1800) : {KEEP (*(.inttab3.intvec.192)) } > cpu3_dlmu
    .inttab_tc3_0C1 (TEXT) BIND(__INTTAB_CPU3 + 0x1820) : {KEEP (*(.inttab3.intvec.193)) } > cpu3_dlmu
    .inttab_tc3_0C2 (TEXT) BIND(__INTTAB_CPU3 + 0x1840) : {KEEP (*(.inttab3.intvec.194)) } > cpu3_dlmu
    .inttab_tc3_0C3 (TEXT) BIND(__INTTAB_CPU3 + 0x1860) : {KEEP (*(.inttab3.intvec.195)) } > cpu3_dlmu
    .inttab_tc3_0C4 (TEXT) BIND(__INTTAB_CPU3 + 0x1880) : {KEEP (*(.inttab3.intvec.196)) } > cpu3_dlmu
    .inttab_tc3_0C5 (TEXT) BIND(__INTTAB_CPU3 + 0x18A0) : {KEEP (*(.inttab3.intvec.197)) } > cpu3_dlmu
    .inttab_tc3_0C6 (TEXT) BIND(__INTTAB_CPU3 + 0x18C0) : {KEEP (*(.inttab3.intvec.198)) } > cpu3_dlmu
    .inttab_tc3_0C7 (TEXT) BIND(__INTTAB_CPU3 + 0x18E0) : {KEEP (*(.inttab3.intvec.199)) } > cpu3_dlmu
    .inttab_tc3_0C8 (TEXT) BIND(__INTTAB_CPU3 + 0x1900) : {KEEP (*(.inttab3.intvec.200)) } > cpu3_dlmu
    .inttab_tc3_0C9 (TEXT) BIND(__INTTAB_CPU3 + 0x1920) : {KEEP (*(.inttab3.intvec.201)) } > cpu3_dlmu
    .inttab_tc3_0CA (TEXT) BIND(__INTTAB_CPU3 + 0x1940) : {KEEP (*(.inttab3.intvec.202)) } > cpu3_dlmu
    .inttab_tc3_0CB (TEXT) BIND(__INTTAB_CPU3 + 0x1960) : {KEEP (*(.inttab3.intvec.203)) } > cpu3_dlmu
    .inttab_tc3_0CC (TEXT) BIND(__INTTAB_CPU3 + 0x1980) : {KEEP (*(.inttab3.intvec.204)) } > cpu3_dlmu
    .inttab_tc3_0CD (TEXT) BIND(__INTTAB_CPU3 + 0x19A0) : {KEEP (*(.inttab3.intvec.205)) } > cpu3_dlmu
    .inttab_tc3_0CE (TEXT) BIND(__INTTAB_CPU3 + 0x19C0) : {KEEP (*(.inttab3.intvec.206)) } > cpu3_dlmu
    .inttab_tc3_0CF (TEXT) BIND(__INTTAB_CPU3 + 0x19E0) : {KEEP (*(.inttab3.intvec.207)) } > cpu3_dlmu
    .inttab_tc3_0D0 (TEXT) BIND(__INTTAB_CPU3 + 0x1A00) : {KEEP (*(.inttab3.intvec.208)) } > cpu3_dlmu
    .inttab_tc3_0D1 (TEXT) BIND(__INTTAB_CPU3 + 0x1A20) : {KEEP (*(.inttab3.intvec.209)) } > cpu3_dlmu
    .inttab_tc3_0D2 (TEXT) BIND(__INTTAB_CPU3 + 0x1A40) : {KEEP (*(.inttab3.intvec.210)) } > cpu3_dlmu
    .inttab_tc3_0D3 (TEXT) BIND(__INTTAB_CPU3 + 0x1A60) : {KEEP (*(.inttab3.intvec.211)) } > cpu3_dlmu
    .inttab_tc3_0D4 (TEXT) BIND(__INTTAB_CPU3 + 0x1A80) : {KEEP (*(.inttab3.intvec.212)) } > cpu3_dlmu
    .inttab_tc3_0D5 (TEXT) BIND(__INTTAB_CPU3 + 0x1AA0) : {KEEP (*(.inttab3.intvec.213)) } > cpu3_dlmu
    .inttab_tc3_0D6 (TEXT) BIND(__INTTAB_CPU3 + 0x1AC0) : {KEEP (*(.inttab3.intvec.214)) } > cpu3_dlmu
    .inttab_tc3_0D7 (TEXT) BIND(__INTTAB_CPU3 + 0x1AE0) : {KEEP (*(.inttab3.intvec.215)) } > cpu3_dlmu
    .inttab_tc3_0D8 (TEXT) BIND(__INTTAB_CPU3 + 0x1B00) : {KEEP (*(.inttab3.intvec.216)) } > cpu3_dlmu
    .inttab_tc3_0D9 (TEXT) BIND(__INTTAB_CPU3 + 0x1B20) : {KEEP (*(.inttab3.intvec.217)) } > cpu3_dlmu
    .inttab_tc3_0DA (TEXT) BIND(__INTTAB_CPU3 + 0x1B40) : {KEEP (*(.inttab3.intvec.218)) } > cpu3_dlmu
    .inttab_tc3_0DB (TEXT) BIND(__INTTAB_CPU3 + 0x1B60) : {KEEP (*(.inttab3.intvec.219)) } > cpu3_dlmu
    .inttab_tc3_0DC (TEXT) BIND(__INTTAB_CPU3 + 0x1B80) : {KEEP (*(.inttab3.intvec.220)) } > cpu3_dlmu
    .inttab_tc3_0DD (TEXT) BIND(__INTTAB_CPU3 + 0x1BA0) : {KEEP (*(.inttab3.intvec.221)) } > cpu3_dlmu
    .inttab_tc3_0DE (TEXT) BIND(__INTTAB_CPU3 + 0x1BC0) : {KEEP (*(.inttab3.intvec.222)) } > cpu3_dlmu
    .inttab_tc3_0DF (TEXT) BIND(__INTTAB_CPU3 + 0x1BE0) : {KEEP (*(.inttab3.intvec.223)) } > cpu3_dlmu
    .inttab_tc3_0E0 (TEXT) BIND(__INTTAB_CPU3 + 0x1C00) : {KEEP (*(.inttab3.intvec.224)) } > cpu3_dlmu
    .inttab_tc3_0E1 (TEXT) BIND(__INTTAB_CPU3 + 0x1C20) : {KEEP (*(.inttab3.intvec.225)) } > cpu3_dlmu
    .inttab_tc3_0E2 (TEXT) BIND(__INTTAB_CPU3 + 0x1C40) : {KEEP (*(.inttab3.intvec.226)) } > cpu3_dlmu
    .inttab_tc3_0E3 (TEXT) BIND(__INTTAB_CPU3 + 0x1C60) : {KEEP (*(.inttab3.intvec.227)) } > cpu3_dlmu
    .inttab_tc3_0E4 (TEXT) BIND(__INTTAB_CPU3 + 0x1C80) : {KEEP (*(.inttab3.intvec.228)) } > cpu3_dlmu
    .inttab_tc3_0E5 (TEXT) BIND(__INTTAB_CPU3 + 0x1CA0) : {KEEP (*(.inttab3.intvec.229)) } > cpu3_dlmu
    .inttab_tc3_0E6 (TEXT) BIND(__INTTAB_CPU3 + 0x1CC0) : {KEEP (*(.inttab3.intvec.230)) } > cpu3_dlmu
    .inttab_tc3_0E7 (TEXT) BIND(__INTTAB_CPU3 + 0x1CE0) : {KEEP (*(.inttab3.intvec.231)) } > cpu3_dlmu
    .inttab_tc3_0E8 (TEXT) BIND(__INTTAB_CPU3 + 0x1D00) : {KEEP (*(.inttab3.intvec.232)) } > cpu3_dlmu
    .inttab_tc3_0E9 (TEXT) BIND(__INTTAB_CPU3 + 0x1D20) : {KEEP (*(.inttab3.intvec.233)) } > cpu3_dlmu
    .inttab_tc3_0EA (TEXT) BIND(__INTTAB_CPU3 + 0x1D40) : {KEEP (*(.inttab3.intvec.234)) } > cpu3_dlmu
    .inttab_tc3_0EB (TEXT) BIND(__INTTAB_CPU3 + 0x1D60) : {KEEP (*(.inttab3.intvec.235)) } > cpu3_dlmu
    .inttab_tc3_0EC (TEXT) BIND(__INTTAB_CPU3 + 0x1D80) : {KEEP (*(.inttab3.intvec.236)) } > cpu3_dlmu
    .inttab_tc3_0ED (TEXT) BIND(__INTTAB_CPU3 + 0x1DA0) : {KEEP (*(.inttab3.intvec.237)) } > cpu3_dlmu
    .inttab_tc3_0EE (TEXT) BIND(__INTTAB_CPU3 + 0x1DC0) : {KEEP (*(.inttab3.intvec.238)) } > cpu3_dlmu
    .inttab_tc3_0EF (TEXT) BIND(__INTTAB_CPU3 + 0x1DE0) : {KEEP (*(.inttab3.intvec.239)) } > cpu3_dlmu
    .inttab_tc3_0F0 (TEXT) BIND(__INTTAB_CPU3 + 0x1E00) : {KEEP (*(.inttab3.intvec.240)) } > cpu3_dlmu
    .inttab_tc3_0F1 (TEXT) BIND(__INTTAB_CPU3 + 0x1E20) : {KEEP (*(.inttab3.intvec.241)) } > cpu3_dlmu
    .inttab_tc3_0F2 (TEXT) BIND(__INTTAB_CPU3 + 0x1E40) : {KEEP (*(.inttab3.intvec.242)) } > cpu3_dlmu
    .inttab_tc3_0F3 (TEXT) BIND(__INTTAB_CPU3 + 0x1E60) : {KEEP (*(.inttab3.intvec.243)) } > cpu3_dlmu
    .inttab_tc3_0F4 (TEXT) BIND(__INTTAB_CPU3 + 0x1E80) : {KEEP (*(.inttab3.intvec.244)) } > cpu3_dlmu
    .inttab_tc3_0F5 (TEXT) BIND(__INTTAB_CPU3 + 0x1EA0) : {KEEP (*(.inttab3.intvec.245)) } > cpu3_dlmu
    .inttab_tc3_0F6 (TEXT) BIND(__INTTAB_CPU3 + 0x1EC0) : {KEEP (*(.inttab3.intvec.246)) } > cpu3_dlmu
    .inttab_tc3_0F7 (TEXT) BIND(__INTTAB_CPU3 + 0x1EE0) : {KEEP (*(.inttab3.intvec.247)) } > cpu3_dlmu
    .inttab_tc3_0F8 (TEXT) BIND(__INTTAB_CPU3 + 0x1F00) : {KEEP (*(.inttab3.intvec.248)) } > cpu3_dlmu
    .inttab_tc3_0F9 (TEXT) BIND(__INTTAB_CPU3 + 0x1F20) : {KEEP (*(.inttab3.intvec.249)) } > cpu3_dlmu
    .inttab_tc3_0FA (TEXT) BIND(__INTTAB_CPU3 + 0x1F40) : {KEEP (*(.inttab3.intvec.250)) } > cpu3_dlmu
    .inttab_tc3_0FB (TEXT) BIND(__INTTAB_CPU3 + 0x1F60) : {KEEP (*(.inttab3.intvec.251)) } > cpu3_dlmu
    .inttab_tc3_0FC (TEXT) BIND(__INTTAB_CPU3 + 0x1F80) : {KEEP (*(.inttab3.intvec.252)) } > cpu3_dlmu
    .inttab_tc3_0FD (TEXT) BIND(__INTTAB_CPU3 + 0x1FA0) : {KEEP (*(.inttab3.intvec.253)) } > cpu3_dlmu
    .inttab_tc3_0FE (TEXT) BIND(__INTTAB_CPU3 + 0x1FC0) : {KEEP (*(.inttab3.intvec.254)) } > cpu3_dlmu
    .inttab_tc3_0FF (TEXT) BIND(__INTTAB_CPU3 + 0x1FE0) : {KEEP (*(.inttab3.intvec.255)) } > cpu3_dlmu

    /* CPU4 Interrupt Vector Table */
    .inttab_tc4_000 (TEXT) BIND(__INTTAB_CPU4 + 0x0000) : {KEEP (*(.inttab4.intvec.0  )) } > cpu4_dlmu
    .inttab_tc4_001 (TEXT) BIND(__INTTAB_CPU4 + 0x0020) : {KEEP (*(.inttab4.intvec.1  )) } > cpu4_dlmu
    .inttab_tc4_002 (TEXT) BIND(__INTTAB_CPU4 + 0x0040) : {KEEP (*(.inttab4.intvec.2  )) } > cpu4_dlmu
    .inttab_tc4_003 (TEXT) BIND(__INTTAB_CPU4 + 0x0060) : {KEEP (*(.inttab4.intvec.3  )) } > cpu4_dlmu
    .inttab_tc4_004 (TEXT) BIND(__INTTAB_CPU4 + 0x0080) : {KEEP (*(.inttab4.intvec.4  )) } > cpu4_dlmu
    .inttab_tc4_005 (TEXT) BIND(__INTTAB_CPU4 + 0x00A0) : {KEEP (*(.inttab4.intvec.5  )) } > cpu4_dlmu
    .inttab_tc4_006 (TEXT) BIND(__INTTAB_CPU4 + 0x00C0) : {KEEP (*(.inttab4.intvec.6  )) } > cpu4_dlmu
    .inttab_tc4_007 (TEXT) BIND(__INTTAB_CPU4 + 0x00E0) : {KEEP (*(.inttab4.intvec.7  )) } > cpu4_dlmu
    .inttab_tc4_008 (TEXT) BIND(__INTTAB_CPU4 + 0x0100) : {KEEP (*(.inttab4.intvec.8  )) } > cpu4_dlmu
    .inttab_tc4_009 (TEXT) BIND(__INTTAB_CPU4 + 0x0120) : {KEEP (*(.inttab4.intvec.9  )) } > cpu4_dlmu
    .inttab_tc4_00A (TEXT) BIND(__INTTAB_CPU4 + 0x0140) : {KEEP (*(.inttab4.intvec.10 )) } > cpu4_dlmu
    .inttab_tc4_00B (TEXT) BIND(__INTTAB_CPU4 + 0x0160) : {KEEP (*(.inttab4.intvec.11 )) } > cpu4_dlmu
    .inttab_tc4_00C (TEXT) BIND(__INTTAB_CPU4 + 0x0180) : {KEEP (*(.inttab4.intvec.12 )) } > cpu4_dlmu
    .inttab_tc4_00D (TEXT) BIND(__INTTAB_CPU4 + 0x01A0) : {KEEP (*(.inttab4.intvec.13 )) } > cpu4_dlmu
    .inttab_tc4_00E (TEXT) BIND(__INTTAB_CPU4 + 0x01C0) : {KEEP (*(.inttab4.intvec.14 )) } > cpu4_dlmu
    .inttab_tc4_00F (TEXT) BIND(__INTTAB_CPU4 + 0x01E0) : {KEEP (*(.inttab4.intvec.15 )) } > cpu4_dlmu
    .inttab_tc4_010 (TEXT) BIND(__INTTAB_CPU4 + 0x0200) : {KEEP (*(.inttab4.intvec.16 )) } > cpu4_dlmu
    .inttab_tc4_011 (TEXT) BIND(__INTTAB_CPU4 + 0x0220) : {KEEP (*(.inttab4.intvec.17 )) } > cpu4_dlmu
    .inttab_tc4_012 (TEXT) BIND(__INTTAB_CPU4 + 0x0240) : {KEEP (*(.inttab4.intvec.18 )) } > cpu4_dlmu
    .inttab_tc4_013 (TEXT) BIND(__INTTAB_CPU4 + 0x0260) : {KEEP (*(.inttab4.intvec.19 )) } > cpu4_dlmu
    .inttab_tc4_014 (TEXT) BIND(__INTTAB_CPU4 + 0x0280) : {KEEP (*(.inttab4.intvec.20 )) } > cpu4_dlmu
    .inttab_tc4_015 (TEXT) BIND(__INTTAB_CPU4 + 0x02A0) : {KEEP (*(.inttab4.intvec.21 )) } > cpu4_dlmu
    .inttab_tc4_016 (TEXT) BIND(__INTTAB_CPU4 + 0x02C0) : {KEEP (*(.inttab4.intvec.22 )) } > cpu4_dlmu
    .inttab_tc4_017 (TEXT) BIND(__INTTAB_CPU4 + 0x02E0) : {KEEP (*(.inttab4.intvec.23 )) } > cpu4_dlmu
    .inttab_tc4_018 (TEXT) BIND(__INTTAB_CPU4 + 0x0300) : {KEEP (*(.inttab4.intvec.24 )) } > cpu4_dlmu
    .inttab_tc4_019 (TEXT) BIND(__INTTAB_CPU4 + 0x0320) : {KEEP (*(.inttab4.intvec.25 )) } > cpu4_dlmu
    .inttab_tc4_01A (TEXT) BIND(__INTTAB_CPU4 + 0x0340) : {KEEP (*(.inttab4.intvec.26 )) } > cpu4_dlmu
    .inttab_tc4_01B (TEXT) BIND(__INTTAB_CPU4 + 0x0360) : {KEEP (*(.inttab4.intvec.27 )) } > cpu4_dlmu
    .inttab_tc4_01C (TEXT) BIND(__INTTAB_CPU4 + 0x0380) : {KEEP (*(.inttab4.intvec.28 )) } > cpu4_dlmu
    .inttab_tc4_01D (TEXT) BIND(__INTTAB_CPU4 + 0x03A0) : {KEEP (*(.inttab4.intvec.29 )) } > cpu4_dlmu
    .inttab_tc4_01E (TEXT) BIND(__INTTAB_CPU4 + 0x03C0) : {KEEP (*(.inttab4.intvec.30 )) } > cpu4_dlmu
    .inttab_tc4_01F (TEXT) BIND(__INTTAB_CPU4 + 0x03E0) : {KEEP (*(.inttab4.intvec.31 )) } > cpu4_dlmu
    .inttab_tc4_020 (TEXT) BIND(__INTTAB_CPU4 + 0x0400) : {KEEP (*(.inttab4.intvec.32 )) } > cpu4_dlmu
    .inttab_tc4_021 (TEXT) BIND(__INTTAB_CPU4 + 0x0420) : {KEEP (*(.inttab4.intvec.33 )) } > cpu4_dlmu
    .inttab_tc4_022 (TEXT) BIND(__INTTAB_CPU4 + 0x0440) : {KEEP (*(.inttab4.intvec.34 )) } > cpu4_dlmu
    .inttab_tc4_023 (TEXT) BIND(__INTTAB_CPU4 + 0x0460) : {KEEP (*(.inttab4.intvec.35 )) } > cpu4_dlmu
    .inttab_tc4_024 (TEXT) BIND(__INTTAB_CPU4 + 0x0480) : {KEEP (*(.inttab4.intvec.36 )) } > cpu4_dlmu
    .inttab_tc4_025 (TEXT) BIND(__INTTAB_CPU4 + 0x04A0) : {KEEP (*(.inttab4.intvec.37 )) } > cpu4_dlmu
    .inttab_tc4_026 (TEXT) BIND(__INTTAB_CPU4 + 0x04C0) : {KEEP (*(.inttab4.intvec.38 )) } > cpu4_dlmu
    .inttab_tc4_027 (TEXT) BIND(__INTTAB_CPU4 + 0x04E0) : {KEEP (*(.inttab4.intvec.39 )) } > cpu4_dlmu
    .inttab_tc4_028 (TEXT) BIND(__INTTAB_CPU4 + 0x0500) : {KEEP (*(.inttab4.intvec.40 )) } > cpu4_dlmu
    .inttab_tc4_029 (TEXT) BIND(__INTTAB_CPU4 + 0x0520) : {KEEP (*(.inttab4.intvec.41 )) } > cpu4_dlmu
    .inttab_tc4_02A (TEXT) BIND(__INTTAB_CPU4 + 0x0540) : {KEEP (*(.inttab4.intvec.42 )) } > cpu4_dlmu
    .inttab_tc4_02B (TEXT) BIND(__INTTAB_CPU4 + 0x0560) : {KEEP (*(.inttab4.intvec.43 )) } > cpu4_dlmu
    .inttab_tc4_02C (TEXT) BIND(__INTTAB_CPU4 + 0x0580) : {KEEP (*(.inttab4.intvec.44 )) } > cpu4_dlmu
    .inttab_tc4_02D (TEXT) BIND(__INTTAB_CPU4 + 0x05A0) : {KEEP (*(.inttab4.intvec.45 )) } > cpu4_dlmu
    .inttab_tc4_02E (TEXT) BIND(__INTTAB_CPU4 + 0x05C0) : {KEEP (*(.inttab4.intvec.46 )) } > cpu4_dlmu
    .inttab_tc4_02F (TEXT) BIND(__INTTAB_CPU4 + 0x05E0) : {KEEP (*(.inttab4.intvec.47 )) } > cpu4_dlmu
    .inttab_tc4_030 (TEXT) BIND(__INTTAB_CPU4 + 0x0600) : {KEEP (*(.inttab4.intvec.48 )) } > cpu4_dlmu
    .inttab_tc4_031 (TEXT) BIND(__INTTAB_CPU4 + 0x0620) : {KEEP (*(.inttab4.intvec.49 )) } > cpu4_dlmu
    .inttab_tc4_032 (TEXT) BIND(__INTTAB_CPU4 + 0x0640) : {KEEP (*(.inttab4.intvec.50 )) } > cpu4_dlmu
    .inttab_tc4_033 (TEXT) BIND(__INTTAB_CPU4 + 0x0660) : {KEEP (*(.inttab4.intvec.51 )) } > cpu4_dlmu
    .inttab_tc4_034 (TEXT) BIND(__INTTAB_CPU4 + 0x0680) : {KEEP (*(.inttab4.intvec.52 )) } > cpu4_dlmu
    .inttab_tc4_035 (TEXT) BIND(__INTTAB_CPU4 + 0x06A0) : {KEEP (*(.inttab4.intvec.53 )) } > cpu4_dlmu
    .inttab_tc4_036 (TEXT) BIND(__INTTAB_CPU4 + 0x06C0) : {KEEP (*(.inttab4.intvec.54 )) } > cpu4_dlmu
    .inttab_tc4_037 (TEXT) BIND(__INTTAB_CPU4 + 0x06E0) : {KEEP (*(.inttab4.intvec.55 )) } > cpu4_dlmu
    .inttab_tc4_038 (TEXT) BIND(__INTTAB_CPU4 + 0x0700) : {KEEP (*(.inttab4.intvec.56 )) } > cpu4_dlmu
    .inttab_tc4_039 (TEXT) BIND(__INTTAB_CPU4 + 0x0720) : {KEEP (*(.inttab4.intvec.57 )) } > cpu4_dlmu
    .inttab_tc4_03A (TEXT) BIND(__INTTAB_CPU4 + 0x0740) : {KEEP (*(.inttab4.intvec.58 )) } > cpu4_dlmu
    .inttab_tc4_03B (TEXT) BIND(__INTTAB_CPU4 + 0x0760) : {KEEP (*(.inttab4.intvec.59 )) } > cpu4_dlmu
    .inttab_tc4_03C (TEXT) BIND(__INTTAB_CPU4 + 0x0780) : {KEEP (*(.inttab4.intvec.60 )) } > cpu4_dlmu
    .inttab_tc4_03D (TEXT) BIND(__INTTAB_CPU4 + 0x07A0) : {KEEP (*(.inttab4.intvec.61 )) } > cpu4_dlmu
    .inttab_tc4_03E (TEXT) BIND(__INTTAB_CPU4 + 0x07C0) : {KEEP (*(.inttab4.intvec.62 )) } > cpu4_dlmu
    .inttab_tc4_03F (TEXT) BIND(__INTTAB_CPU4 + 0x07E0) : {KEEP (*(.inttab4.intvec.63 )) } > cpu4_dlmu
    .inttab_tc4_040 (TEXT) BIND(__INTTAB_CPU4 + 0x0800) : {KEEP (*(.inttab4.intvec.64 )) } > cpu4_dlmu
    .inttab_tc4_041 (TEXT) BIND(__INTTAB_CPU4 + 0x0820) : {KEEP (*(.inttab4.intvec.65 )) } > cpu4_dlmu
    .inttab_tc4_042 (TEXT) BIND(__INTTAB_CPU4 + 0x0840) : {KEEP (*(.inttab4.intvec.66 )) } > cpu4_dlmu
    .inttab_tc4_043 (TEXT) BIND(__INTTAB_CPU4 + 0x0860) : {KEEP (*(.inttab4.intvec.67 )) } > cpu4_dlmu
    .inttab_tc4_044 (TEXT) BIND(__INTTAB_CPU4 + 0x0880) : {KEEP (*(.inttab4.intvec.68 )) } > cpu4_dlmu
    .inttab_tc4_045 (TEXT) BIND(__INTTAB_CPU4 + 0x08A0) : {KEEP (*(.inttab4.intvec.69 )) } > cpu4_dlmu
    .inttab_tc4_046 (TEXT) BIND(__INTTAB_CPU4 + 0x08C0) : {KEEP (*(.inttab4.intvec.70 )) } > cpu4_dlmu
    .inttab_tc4_047 (TEXT) BIND(__INTTAB_CPU4 + 0x08E0) : {KEEP (*(.inttab4.intvec.71 )) } > cpu4_dlmu
    .inttab_tc4_048 (TEXT) BIND(__INTTAB_CPU4 + 0x0900) : {KEEP (*(.inttab4.intvec.72 )) } > cpu4_dlmu
    .inttab_tc4_049 (TEXT) BIND(__INTTAB_CPU4 + 0x0920) : {KEEP (*(.inttab4.intvec.73 )) } > cpu4_dlmu
    .inttab_tc4_04A (TEXT) BIND(__INTTAB_CPU4 + 0x0940) : {KEEP (*(.inttab4.intvec.74 )) } > cpu4_dlmu
    .inttab_tc4_04B (TEXT) BIND(__INTTAB_CPU4 + 0x0960) : {KEEP (*(.inttab4.intvec.75 )) } > cpu4_dlmu
    .inttab_tc4_04C (TEXT) BIND(__INTTAB_CPU4 + 0x0980) : {KEEP (*(.inttab4.intvec.76 )) } > cpu4_dlmu
    .inttab_tc4_04D (TEXT) BIND(__INTTAB_CPU4 + 0x09A0) : {KEEP (*(.inttab4.intvec.77 )) } > cpu4_dlmu
    .inttab_tc4_04E (TEXT) BIND(__INTTAB_CPU4 + 0x09C0) : {KEEP (*(.inttab4.intvec.78 )) } > cpu4_dlmu
    .inttab_tc4_04F (TEXT) BIND(__INTTAB_CPU4 + 0x09E0) : {KEEP (*(.inttab4.intvec.79 )) } > cpu4_dlmu
    .inttab_tc4_050 (TEXT) BIND(__INTTAB_CPU4 + 0x0A00) : {KEEP (*(.inttab4.intvec.80 )) } > cpu4_dlmu
    .inttab_tc4_051 (TEXT) BIND(__INTTAB_CPU4 + 0x0A20) : {KEEP (*(.inttab4.intvec.81 )) } > cpu4_dlmu
    .inttab_tc4_052 (TEXT) BIND(__INTTAB_CPU4 + 0x0A40) : {KEEP (*(.inttab4.intvec.82 )) } > cpu4_dlmu
    .inttab_tc4_053 (TEXT) BIND(__INTTAB_CPU4 + 0x0A60) : {KEEP (*(.inttab4.intvec.83 )) } > cpu4_dlmu
    .inttab_tc4_054 (TEXT) BIND(__INTTAB_CPU4 + 0x0A80) : {KEEP (*(.inttab4.intvec.84 )) } > cpu4_dlmu
    .inttab_tc4_055 (TEXT) BIND(__INTTAB_CPU4 + 0x0AA0) : {KEEP (*(.inttab4.intvec.85 )) } > cpu4_dlmu
    .inttab_tc4_056 (TEXT) BIND(__INTTAB_CPU4 + 0x0AC0) : {KEEP (*(.inttab4.intvec.86 )) } > cpu4_dlmu
    .inttab_tc4_057 (TEXT) BIND(__INTTAB_CPU4 + 0x0AE0) : {KEEP (*(.inttab4.intvec.87 )) } > cpu4_dlmu
    .inttab_tc4_058 (TEXT) BIND(__INTTAB_CPU4 + 0x0B00) : {KEEP (*(.inttab4.intvec.88 )) } > cpu4_dlmu
    .inttab_tc4_059 (TEXT) BIND(__INTTAB_CPU4 + 0x0B20) : {KEEP (*(.inttab4.intvec.89 )) } > cpu4_dlmu
    .inttab_tc4_05A (TEXT) BIND(__INTTAB_CPU4 + 0x0B40) : {KEEP (*(.inttab4.intvec.90 )) } > cpu4_dlmu
    .inttab_tc4_05B (TEXT) BIND(__INTTAB_CPU4 + 0x0B60) : {KEEP (*(.inttab4.intvec.91 )) } > cpu4_dlmu
    .inttab_tc4_05C (TEXT) BIND(__INTTAB_CPU4 + 0x0B80) : {KEEP (*(.inttab4.intvec.92 )) } > cpu4_dlmu
    .inttab_tc4_05D (TEXT) BIND(__INTTAB_CPU4 + 0x0BA0) : {KEEP (*(.inttab4.intvec.93 )) } > cpu4_dlmu
    .inttab_tc4_05E (TEXT) BIND(__INTTAB_CPU4 + 0x0BC0) : {KEEP (*(.inttab4.intvec.94 )) } > cpu4_dlmu
    .inttab_tc4_05F (TEXT) BIND(__INTTAB_CPU4 + 0x0BE0) : {KEEP (*(.inttab4.intvec.95 )) } > cpu4_dlmu
    .inttab_tc4_060 (TEXT) BIND(__INTTAB_CPU4 + 0x0C00) : {KEEP (*(.inttab4.intvec.96 )) } > cpu4_dlmu
    .inttab_tc4_061 (TEXT) BIND(__INTTAB_CPU4 + 0x0C20) : {KEEP (*(.inttab4.intvec.97 )) } > cpu4_dlmu
    .inttab_tc4_062 (TEXT) BIND(__INTTAB_CPU4 + 0x0C40) : {KEEP (*(.inttab4.intvec.98 )) } > cpu4_dlmu
    .inttab_tc4_063 (TEXT) BIND(__INTTAB_CPU4 + 0x0C60) : {KEEP (*(.inttab4.intvec.99 )) } > cpu4_dlmu
    .inttab_tc4_064 (TEXT) BIND(__INTTAB_CPU4 + 0x0C80) : {KEEP (*(.inttab4.intvec.100)) } > cpu4_dlmu
    .inttab_tc4_065 (TEXT) BIND(__INTTAB_CPU4 + 0x0CA0) : {KEEP (*(.inttab4.intvec.101)) } > cpu4_dlmu
    .inttab_tc4_066 (TEXT) BIND(__INTTAB_CPU4 + 0x0CC0) : {KEEP (*(.inttab4.intvec.102)) } > cpu4_dlmu
    .inttab_tc4_067 (TEXT) BIND(__INTTAB_CPU4 + 0x0CE0) : {KEEP (*(.inttab4.intvec.103)) } > cpu4_dlmu
    .inttab_tc4_068 (TEXT) BIND(__INTTAB_CPU4 + 0x0D00) : {KEEP (*(.inttab4.intvec.104)) } > cpu4_dlmu
    .inttab_tc4_069 (TEXT) BIND(__INTTAB_CPU4 + 0x0D20) : {KEEP (*(.inttab4.intvec.105)) } > cpu4_dlmu
    .inttab_tc4_06A (TEXT) BIND(__INTTAB_CPU4 + 0x0D40) : {KEEP (*(.inttab4.intvec.106)) } > cpu4_dlmu
    .inttab_tc4_06B (TEXT) BIND(__INTTAB_CPU4 + 0x0D60) : {KEEP (*(.inttab4.intvec.107)) } > cpu4_dlmu
    .inttab_tc4_06C (TEXT) BIND(__INTTAB_CPU4 + 0x0D80) : {KEEP (*(.inttab4.intvec.108)) } > cpu4_dlmu
    .inttab_tc4_06D (TEXT) BIND(__INTTAB_CPU4 + 0x0DA0) : {KEEP (*(.inttab4.intvec.109)) } > cpu4_dlmu
    .inttab_tc4_06E (TEXT) BIND(__INTTAB_CPU4 + 0x0DC0) : {KEEP (*(.inttab4.intvec.110)) } > cpu4_dlmu
    .inttab_tc4_06F (TEXT) BIND(__INTTAB_CPU4 + 0x0DE0) : {KEEP (*(.inttab4.intvec.111)) } > cpu4_dlmu
    .inttab_tc4_070 (TEXT) BIND(__INTTAB_CPU4 + 0x0E00) : {KEEP (*(.inttab4.intvec.112)) } > cpu4_dlmu
    .inttab_tc4_071 (TEXT) BIND(__INTTAB_CPU4 + 0x0E20) : {KEEP (*(.inttab4.intvec.113)) } > cpu4_dlmu
    .inttab_tc4_072 (TEXT) BIND(__INTTAB_CPU4 + 0x0E40) : {KEEP (*(.inttab4.intvec.114)) } > cpu4_dlmu
    .inttab_tc4_073 (TEXT) BIND(__INTTAB_CPU4 + 0x0E60) : {KEEP (*(.inttab4.intvec.115)) } > cpu4_dlmu
    .inttab_tc4_074 (TEXT) BIND(__INTTAB_CPU4 + 0x0E80) : {KEEP (*(.inttab4.intvec.116)) } > cpu4_dlmu
    .inttab_tc4_075 (TEXT) BIND(__INTTAB_CPU4 + 0x0EA0) : {KEEP (*(.inttab4.intvec.117)) } > cpu4_dlmu
    .inttab_tc4_076 (TEXT) BIND(__INTTAB_CPU4 + 0x0EC0) : {KEEP (*(.inttab4.intvec.118)) } > cpu4_dlmu
    .inttab_tc4_077 (TEXT) BIND(__INTTAB_CPU4 + 0x0EE0) : {KEEP (*(.inttab4.intvec.119)) } > cpu4_dlmu
    .inttab_tc4_078 (TEXT) BIND(__INTTAB_CPU4 + 0x0F00) : {KEEP (*(.inttab4.intvec.120)) } > cpu4_dlmu
    .inttab_tc4_079 (TEXT) BIND(__INTTAB_CPU4 + 0x0F20) : {KEEP (*(.inttab4.intvec.121)) } > cpu4_dlmu
    .inttab_tc4_07A (TEXT) BIND(__INTTAB_CPU4 + 0x0F40) : {KEEP (*(.inttab4.intvec.122)) } > cpu4_dlmu
    .inttab_tc4_07B (TEXT) BIND(__INTTAB_CPU4 + 0x0F60) : {KEEP (*(.inttab4.intvec.123)) } > cpu4_dlmu
    .inttab_tc4_07C (TEXT) BIND(__INTTAB_CPU4 + 0x0F80) : {KEEP (*(.inttab4.intvec.124)) } > cpu4_dlmu
    .inttab_tc4_07D (TEXT) BIND(__INTTAB_CPU4 + 0x0FA0) : {KEEP (*(.inttab4.intvec.125)) } > cpu4_dlmu
    .inttab_tc4_07E (TEXT) BIND(__INTTAB_CPU4 + 0x0FC0) : {KEEP (*(.inttab4.intvec.126)) } > cpu4_dlmu
    .inttab_tc4_07F (TEXT) BIND(__INTTAB_CPU4 + 0x0FE0) : {KEEP (*(.inttab4.intvec.127)) } > cpu4_dlmu
    .inttab_tc4_080 (TEXT) BIND(__INTTAB_CPU4 + 0x1000) : {KEEP (*(.inttab4.intvec.128)) } > cpu4_dlmu
    .inttab_tc4_081 (TEXT) BIND(__INTTAB_CPU4 + 0x1020) : {KEEP (*(.inttab4.intvec.129)) } > cpu4_dlmu
    .inttab_tc4_082 (TEXT) BIND(__INTTAB_CPU4 + 0x1040) : {KEEP (*(.inttab4.intvec.130)) } > cpu4_dlmu
    .inttab_tc4_083 (TEXT) BIND(__INTTAB_CPU4 + 0x1060) : {KEEP (*(.inttab4.intvec.131)) } > cpu4_dlmu
    .inttab_tc4_084 (TEXT) BIND(__INTTAB_CPU4 + 0x1080) : {KEEP (*(.inttab4.intvec.132)) } > cpu4_dlmu
    .inttab_tc4_085 (TEXT) BIND(__INTTAB_CPU4 + 0x10A0) : {KEEP (*(.inttab4.intvec.133)) } > cpu4_dlmu
    .inttab_tc4_086 (TEXT) BIND(__INTTAB_CPU4 + 0x10C0) : {KEEP (*(.inttab4.intvec.134)) } > cpu4_dlmu
    .inttab_tc4_087 (TEXT) BIND(__INTTAB_CPU4 + 0x10E0) : {KEEP (*(.inttab4.intvec.135)) } > cpu4_dlmu
    .inttab_tc4_088 (TEXT) BIND(__INTTAB_CPU4 + 0x1100) : {KEEP (*(.inttab4.intvec.136)) } > cpu4_dlmu
    .inttab_tc4_089 (TEXT) BIND(__INTTAB_CPU4 + 0x1120) : {KEEP (*(.inttab4.intvec.137)) } > cpu4_dlmu
    .inttab_tc4_08A (TEXT) BIND(__INTTAB_CPU4 + 0x1140) : {KEEP (*(.inttab4.intvec.138)) } > cpu4_dlmu
    .inttab_tc4_08B (TEXT) BIND(__INTTAB_CPU4 + 0x1160) : {KEEP (*(.inttab4.intvec.139)) } > cpu4_dlmu
    .inttab_tc4_08C (TEXT) BIND(__INTTAB_CPU4 + 0x1180) : {KEEP (*(.inttab4.intvec.140)) } > cpu4_dlmu
    .inttab_tc4_08D (TEXT) BIND(__INTTAB_CPU4 + 0x11A0) : {KEEP (*(.inttab4.intvec.141)) } > cpu4_dlmu
    .inttab_tc4_08E (TEXT) BIND(__INTTAB_CPU4 + 0x11C0) : {KEEP (*(.inttab4.intvec.142)) } > cpu4_dlmu
    .inttab_tc4_08F (TEXT) BIND(__INTTAB_CPU4 + 0x11E0) : {KEEP (*(.inttab4.intvec.143)) } > cpu4_dlmu
    .inttab_tc4_090 (TEXT) BIND(__INTTAB_CPU4 + 0x1200) : {KEEP (*(.inttab4.intvec.144)) } > cpu4_dlmu
    .inttab_tc4_091 (TEXT) BIND(__INTTAB_CPU4 + 0x1220) : {KEEP (*(.inttab4.intvec.145)) } > cpu4_dlmu
    .inttab_tc4_092 (TEXT) BIND(__INTTAB_CPU4 + 0x1240) : {KEEP (*(.inttab4.intvec.146)) } > cpu4_dlmu
    .inttab_tc4_093 (TEXT) BIND(__INTTAB_CPU4 + 0x1260) : {KEEP (*(.inttab4.intvec.147)) } > cpu4_dlmu
    .inttab_tc4_094 (TEXT) BIND(__INTTAB_CPU4 + 0x1280) : {KEEP (*(.inttab4.intvec.148)) } > cpu4_dlmu
    .inttab_tc4_095 (TEXT) BIND(__INTTAB_CPU4 + 0x12A0) : {KEEP (*(.inttab4.intvec.149)) } > cpu4_dlmu
    .inttab_tc4_096 (TEXT) BIND(__INTTAB_CPU4 + 0x12C0) : {KEEP (*(.inttab4.intvec.150)) } > cpu4_dlmu
    .inttab_tc4_097 (TEXT) BIND(__INTTAB_CPU4 + 0x12E0) : {KEEP (*(.inttab4.intvec.151)) } > cpu4_dlmu
    .inttab_tc4_098 (TEXT) BIND(__INTTAB_CPU4 + 0x1300) : {KEEP (*(.inttab4.intvec.152)) } > cpu4_dlmu
    .inttab_tc4_099 (TEXT) BIND(__INTTAB_CPU4 + 0x1320) : {KEEP (*(.inttab4.intvec.153)) } > cpu4_dlmu
    .inttab_tc4_09A (TEXT) BIND(__INTTAB_CPU4 + 0x1340) : {KEEP (*(.inttab4.intvec.154)) } > cpu4_dlmu
    .inttab_tc4_09B (TEXT) BIND(__INTTAB_CPU4 + 0x1360) : {KEEP (*(.inttab4.intvec.155)) } > cpu4_dlmu
    .inttab_tc4_09C (TEXT) BIND(__INTTAB_CPU4 + 0x1380) : {KEEP (*(.inttab4.intvec.156)) } > cpu4_dlmu
    .inttab_tc4_09D (TEXT) BIND(__INTTAB_CPU4 + 0x13A0) : {KEEP (*(.inttab4.intvec.157)) } > cpu4_dlmu
    .inttab_tc4_09E (TEXT) BIND(__INTTAB_CPU4 + 0x13C0) : {KEEP (*(.inttab4.intvec.158)) } > cpu4_dlmu
    .inttab_tc4_09F (TEXT) BIND(__INTTAB_CPU4 + 0x13E0) : {KEEP (*(.inttab4.intvec.159)) } > cpu4_dlmu
    .inttab_tc4_0A0 (TEXT) BIND(__INTTAB_CPU4 + 0x1400) : {KEEP (*(.inttab4.intvec.160)) } > cpu4_dlmu
    .inttab_tc4_0A1 (TEXT) BIND(__INTTAB_CPU4 + 0x1420) : {KEEP (*(.inttab4.intvec.161)) } > cpu4_dlmu
    .inttab_tc4_0A2 (TEXT) BIND(__INTTAB_CPU4 + 0x1440) : {KEEP (*(.inttab4.intvec.162)) } > cpu4_dlmu
    .inttab_tc4_0A3 (TEXT) BIND(__INTTAB_CPU4 + 0x1460) : {KEEP (*(.inttab4.intvec.163)) } > cpu4_dlmu
    .inttab_tc4_0A4 (TEXT) BIND(__INTTAB_CPU4 + 0x1480) : {KEEP (*(.inttab4.intvec.164)) } > cpu4_dlmu
    .inttab_tc4_0A5 (TEXT) BIND(__INTTAB_CPU4 + 0x14A0) : {KEEP (*(.inttab4.intvec.165)) } > cpu4_dlmu
    .inttab_tc4_0A6 (TEXT) BIND(__INTTAB_CPU4 + 0x14C0) : {KEEP (*(.inttab4.intvec.166)) } > cpu4_dlmu
    .inttab_tc4_0A7 (TEXT) BIND(__INTTAB_CPU4 + 0x14E0) : {KEEP (*(.inttab4.intvec.167)) } > cpu4_dlmu
    .inttab_tc4_0A8 (TEXT) BIND(__INTTAB_CPU4 + 0x1500) : {KEEP (*(.inttab4.intvec.168)) } > cpu4_dlmu
    .inttab_tc4_0A9 (TEXT) BIND(__INTTAB_CPU4 + 0x1520) : {KEEP (*(.inttab4.intvec.169)) } > cpu4_dlmu
    .inttab_tc4_0AA (TEXT) BIND(__INTTAB_CPU4 + 0x1540) : {KEEP (*(.inttab4.intvec.170)) } > cpu4_dlmu
    .inttab_tc4_0AB (TEXT) BIND(__INTTAB_CPU4 + 0x1560) : {KEEP (*(.inttab4.intvec.171)) } > cpu4_dlmu
    .inttab_tc4_0AC (TEXT) BIND(__INTTAB_CPU4 + 0x1580) : {KEEP (*(.inttab4.intvec.172)) } > cpu4_dlmu
    .inttab_tc4_0AD (TEXT) BIND(__INTTAB_CPU4 + 0x15A0) : {KEEP (*(.inttab4.intvec.173)) } > cpu4_dlmu
    .inttab_tc4_0AE (TEXT) BIND(__INTTAB_CPU4 + 0x15C0) : {KEEP (*(.inttab4.intvec.174)) } > cpu4_dlmu
    .inttab_tc4_0AF (TEXT) BIND(__INTTAB_CPU4 + 0x15E0) : {KEEP (*(.inttab4.intvec.175)) } > cpu4_dlmu
    .inttab_tc4_0B0 (TEXT) BIND(__INTTAB_CPU4 + 0x1600) : {KEEP (*(.inttab4.intvec.176)) } > cpu4_dlmu
    .inttab_tc4_0B1 (TEXT) BIND(__INTTAB_CPU4 + 0x1620) : {KEEP (*(.inttab4.intvec.177)) } > cpu4_dlmu
    .inttab_tc4_0B2 (TEXT) BIND(__INTTAB_CPU4 + 0x1640) : {KEEP (*(.inttab4.intvec.178)) } > cpu4_dlmu
    .inttab_tc4_0B3 (TEXT) BIND(__INTTAB_CPU4 + 0x1660) : {KEEP (*(.inttab4.intvec.179)) } > cpu4_dlmu
    .inttab_tc4_0B4 (TEXT) BIND(__INTTAB_CPU4 + 0x1680) : {KEEP (*(.inttab4.intvec.180)) } > cpu4_dlmu
    .inttab_tc4_0B5 (TEXT) BIND(__INTTAB_CPU4 + 0x16A0) : {KEEP (*(.inttab4.intvec.181)) } > cpu4_dlmu
    .inttab_tc4_0B6 (TEXT) BIND(__INTTAB_CPU4 + 0x16C0) : {KEEP (*(.inttab4.intvec.182)) } > cpu4_dlmu
    .inttab_tc4_0B7 (TEXT) BIND(__INTTAB_CPU4 + 0x16E0) : {KEEP (*(.inttab4.intvec.183)) } > cpu4_dlmu
    .inttab_tc4_0B8 (TEXT) BIND(__INTTAB_CPU4 + 0x1700) : {KEEP (*(.inttab4.intvec.184)) } > cpu4_dlmu
    .inttab_tc4_0B9 (TEXT) BIND(__INTTAB_CPU4 + 0x1720) : {KEEP (*(.inttab4.intvec.185)) } > cpu4_dlmu
    .inttab_tc4_0BA (TEXT) BIND(__INTTAB_CPU4 + 0x1740) : {KEEP (*(.inttab4.intvec.186)) } > cpu4_dlmu
    .inttab_tc4_0BB (TEXT) BIND(__INTTAB_CPU4 + 0x1760) : {KEEP (*(.inttab4.intvec.187)) } > cpu4_dlmu
    .inttab_tc4_0BC (TEXT) BIND(__INTTAB_CPU4 + 0x1780) : {KEEP (*(.inttab4.intvec.188)) } > cpu4_dlmu
    .inttab_tc4_0BD (TEXT) BIND(__INTTAB_CPU4 + 0x17A0) : {KEEP (*(.inttab4.intvec.189)) } > cpu4_dlmu
    .inttab_tc4_0BE (TEXT) BIND(__INTTAB_CPU4 + 0x17C0) : {KEEP (*(.inttab4.intvec.190)) } > cpu4_dlmu
    .inttab_tc4_0BF (TEXT) BIND(__INTTAB_CPU4 + 0x17E0) : {KEEP (*(.inttab4.intvec.191)) } > cpu4_dlmu
    .inttab_tc4_0C0 (TEXT) BIND(__INTTAB_CPU4 + 0x1800) : {KEEP (*(.inttab4.intvec.192)) } > cpu4_dlmu
    .inttab_tc4_0C1 (TEXT) BIND(__INTTAB_CPU4 + 0x1820) : {KEEP (*(.inttab4.intvec.193)) } > cpu4_dlmu
    .inttab_tc4_0C2 (TEXT) BIND(__INTTAB_CPU4 + 0x1840) : {KEEP (*(.inttab4.intvec.194)) } > cpu4_dlmu
    .inttab_tc4_0C3 (TEXT) BIND(__INTTAB_CPU4 + 0x1860) : {KEEP (*(.inttab4.intvec.195)) } > cpu4_dlmu
    .inttab_tc4_0C4 (TEXT) BIND(__INTTAB_CPU4 + 0x1880) : {KEEP (*(.inttab4.intvec.196)) } > cpu4_dlmu
    .inttab_tc4_0C5 (TEXT) BIND(__INTTAB_CPU4 + 0x18A0) : {KEEP (*(.inttab4.intvec.197)) } > cpu4_dlmu
    .inttab_tc4_0C6 (TEXT) BIND(__INTTAB_CPU4 + 0x18C0) : {KEEP (*(.inttab4.intvec.198)) } > cpu4_dlmu
    .inttab_tc4_0C7 (TEXT) BIND(__INTTAB_CPU4 + 0x18E0) : {KEEP (*(.inttab4.intvec.199)) } > cpu4_dlmu
    .inttab_tc4_0C8 (TEXT) BIND(__INTTAB_CPU4 + 0x1900) : {KEEP (*(.inttab4.intvec.200)) } > cpu4_dlmu
    .inttab_tc4_0C9 (TEXT) BIND(__INTTAB_CPU4 + 0x1920) : {KEEP (*(.inttab4.intvec.201)) } > cpu4_dlmu
    .inttab_tc4_0CA (TEXT) BIND(__INTTAB_CPU4 + 0x1940) : {KEEP (*(.inttab4.intvec.202)) } > cpu4_dlmu
    .inttab_tc4_0CB (TEXT) BIND(__INTTAB_CPU4 + 0x1960) : {KEEP (*(.inttab4.intvec.203)) } > cpu4_dlmu
    .inttab_tc4_0CC (TEXT) BIND(__INTTAB_CPU4 + 0x1980) : {KEEP (*(.inttab4.intvec.204)) } > cpu4_dlmu
    .inttab_tc4_0CD (TEXT) BIND(__INTTAB_CPU4 + 0x19A0) : {KEEP (*(.inttab4.intvec.205)) } > cpu4_dlmu
    .inttab_tc4_0CE (TEXT) BIND(__INTTAB_CPU4 + 0x19C0) : {KEEP (*(.inttab4.intvec.206)) } > cpu4_dlmu
    .inttab_tc4_0CF (TEXT) BIND(__INTTAB_CPU4 + 0x19E0) : {KEEP (*(.inttab4.intvec.207)) } > cpu4_dlmu
    .inttab_tc4_0D0 (TEXT) BIND(__INTTAB_CPU4 + 0x1A00) : {KEEP (*(.inttab4.intvec.208)) } > cpu4_dlmu
    .inttab_tc4_0D1 (TEXT) BIND(__INTTAB_CPU4 + 0x1A20) : {KEEP (*(.inttab4.intvec.209)) } > cpu4_dlmu
    .inttab_tc4_0D2 (TEXT) BIND(__INTTAB_CPU4 + 0x1A40) : {KEEP (*(.inttab4.intvec.210)) } > cpu4_dlmu
    .inttab_tc4_0D3 (TEXT) BIND(__INTTAB_CPU4 + 0x1A60) : {KEEP (*(.inttab4.intvec.211)) } > cpu4_dlmu
    .inttab_tc4_0D4 (TEXT) BIND(__INTTAB_CPU4 + 0x1A80) : {KEEP (*(.inttab4.intvec.212)) } > cpu4_dlmu
    .inttab_tc4_0D5 (TEXT) BIND(__INTTAB_CPU4 + 0x1AA0) : {KEEP (*(.inttab4.intvec.213)) } > cpu4_dlmu
    .inttab_tc4_0D6 (TEXT) BIND(__INTTAB_CPU4 + 0x1AC0) : {KEEP (*(.inttab4.intvec.214)) } > cpu4_dlmu
    .inttab_tc4_0D7 (TEXT) BIND(__INTTAB_CPU4 + 0x1AE0) : {KEEP (*(.inttab4.intvec.215)) } > cpu4_dlmu
    .inttab_tc4_0D8 (TEXT) BIND(__INTTAB_CPU4 + 0x1B00) : {KEEP (*(.inttab4.intvec.216)) } > cpu4_dlmu
    .inttab_tc4_0D9 (TEXT) BIND(__INTTAB_CPU4 + 0x1B20) : {KEEP (*(.inttab4.intvec.217)) } > cpu4_dlmu
    .inttab_tc4_0DA (TEXT) BIND(__INTTAB_CPU4 + 0x1B40) : {KEEP (*(.inttab4.intvec.218)) } > cpu4_dlmu
    .inttab_tc4_0DB (TEXT) BIND(__INTTAB_CPU4 + 0x1B60) : {KEEP (*(.inttab4.intvec.219)) } > cpu4_dlmu
    .inttab_tc4_0DC (TEXT) BIND(__INTTAB_CPU4 + 0x1B80) : {KEEP (*(.inttab4.intvec.220)) } > cpu4_dlmu
    .inttab_tc4_0DD (TEXT) BIND(__INTTAB_CPU4 + 0x1BA0) : {KEEP (*(.inttab4.intvec.221)) } > cpu4_dlmu
    .inttab_tc4_0DE (TEXT) BIND(__INTTAB_CPU4 + 0x1BC0) : {KEEP (*(.inttab4.intvec.222)) } > cpu4_dlmu
    .inttab_tc4_0DF (TEXT) BIND(__INTTAB_CPU4 + 0x1BE0) : {KEEP (*(.inttab4.intvec.223)) } > cpu4_dlmu
    .inttab_tc4_0E0 (TEXT) BIND(__INTTAB_CPU4 + 0x1C00) : {KEEP (*(.inttab4.intvec.224)) } > cpu4_dlmu
    .inttab_tc4_0E1 (TEXT) BIND(__INTTAB_CPU4 + 0x1C20) : {KEEP (*(.inttab4.intvec.225)) } > cpu4_dlmu
    .inttab_tc4_0E2 (TEXT) BIND(__INTTAB_CPU4 + 0x1C40) : {KEEP (*(.inttab4.intvec.226)) } > cpu4_dlmu
    .inttab_tc4_0E3 (TEXT) BIND(__INTTAB_CPU4 + 0x1C60) : {KEEP (*(.inttab4.intvec.227)) } > cpu4_dlmu
    .inttab_tc4_0E4 (TEXT) BIND(__INTTAB_CPU4 + 0x1C80) : {KEEP (*(.inttab4.intvec.228)) } > cpu4_dlmu
    .inttab_tc4_0E5 (TEXT) BIND(__INTTAB_CPU4 + 0x1CA0) : {KEEP (*(.inttab4.intvec.229)) } > cpu4_dlmu
    .inttab_tc4_0E6 (TEXT) BIND(__INTTAB_CPU4 + 0x1CC0) : {KEEP (*(.inttab4.intvec.230)) } > cpu4_dlmu
    .inttab_tc4_0E7 (TEXT) BIND(__INTTAB_CPU4 + 0x1CE0) : {KEEP (*(.inttab4.intvec.231)) } > cpu4_dlmu
    .inttab_tc4_0E8 (TEXT) BIND(__INTTAB_CPU4 + 0x1D00) : {KEEP (*(.inttab4.intvec.232)) } > cpu4_dlmu
    .inttab_tc4_0E9 (TEXT) BIND(__INTTAB_CPU4 + 0x1D20) : {KEEP (*(.inttab4.intvec.233)) } > cpu4_dlmu
    .inttab_tc4_0EA (TEXT) BIND(__INTTAB_CPU4 + 0x1D40) : {KEEP (*(.inttab4.intvec.234)) } > cpu4_dlmu
    .inttab_tc4_0EB (TEXT) BIND(__INTTAB_CPU4 + 0x1D60) : {KEEP (*(.inttab4.intvec.235)) } > cpu4_dlmu
    .inttab_tc4_0EC (TEXT) BIND(__INTTAB_CPU4 + 0x1D80) : {KEEP (*(.inttab4.intvec.236)) } > cpu4_dlmu
    .inttab_tc4_0ED (TEXT) BIND(__INTTAB_CPU4 + 0x1DA0) : {KEEP (*(.inttab4.intvec.237)) } > cpu4_dlmu
    .inttab_tc4_0EE (TEXT) BIND(__INTTAB_CPU4 + 0x1DC0) : {KEEP (*(.inttab4.intvec.238)) } > cpu4_dlmu
    .inttab_tc4_0EF (TEXT) BIND(__INTTAB_CPU4 + 0x1DE0) : {KEEP (*(.inttab4.intvec.239)) } > cpu4_dlmu
    .inttab_tc4_0F0 (TEXT) BIND(__INTTAB_CPU4 + 0x1E00) : {KEEP (*(.inttab4.intvec.240)) } > cpu4_dlmu
    .inttab_tc4_0F1 (TEXT) BIND(__INTTAB_CPU4 + 0x1E20) : {KEEP (*(.inttab4.intvec.241)) } > cpu4_dlmu
    .inttab_tc4_0F2 (TEXT) BIND(__INTTAB_CPU4 + 0x1E40) : {KEEP (*(.inttab4.intvec.242)) } > cpu4_dlmu
    .inttab_tc4_0F3 (TEXT) BIND(__INTTAB_CPU4 + 0x1E60) : {KEEP (*(.inttab4.intvec.243)) } > cpu4_dlmu
    .inttab_tc4_0F4 (TEXT) BIND(__INTTAB_CPU4 + 0x1E80) : {KEEP (*(.inttab4.intvec.244)) } > cpu4_dlmu
    .inttab_tc4_0F5 (TEXT) BIND(__INTTAB_CPU4 + 0x1EA0) : {KEEP (*(.inttab4.intvec.245)) } > cpu4_dlmu
    .inttab_tc4_0F6 (TEXT) BIND(__INTTAB_CPU4 + 0x1EC0) : {KEEP (*(.inttab4.intvec.246)) } > cpu4_dlmu
    .inttab_tc4_0F7 (TEXT) BIND(__INTTAB_CPU4 + 0x1EE0) : {KEEP (*(.inttab4.intvec.247)) } > cpu4_dlmu
    .inttab_tc4_0F8 (TEXT) BIND(__INTTAB_CPU4 + 0x1F00) : {KEEP (*(.inttab4.intvec.248)) } > cpu4_dlmu
    .inttab_tc4_0F9 (TEXT) BIND(__INTTAB_CPU4 + 0x1F20) : {KEEP (*(.inttab4.intvec.249)) } > cpu4_dlmu
    .inttab_tc4_0FA (TEXT) BIND(__INTTAB_CPU4 + 0x1F40) : {KEEP (*(.inttab4.intvec.250)) } > cpu4_dlmu
    .inttab_tc4_0FB (TEXT) BIND(__INTTAB_CPU4 + 0x1F60) : {KEEP (*(.inttab4.intvec.251)) } > cpu4_dlmu
    .inttab_tc4_0FC (TEXT) BIND(__INTTAB_CPU4 + 0x1F80) : {KEEP (*(.inttab4.intvec.252)) } > cpu4_dlmu
    .inttab_tc4_0FD (TEXT) BIND(__INTTAB_CPU4 + 0x1FA0) : {KEEP (*(.inttab4.intvec.253)) } > cpu4_dlmu
    .inttab_tc4_0FE (TEXT) BIND(__INTTAB_CPU4 + 0x1FC0) : {KEEP (*(.inttab4.intvec.254)) } > cpu4_dlmu
    .inttab_tc4_0FF (TEXT) BIND(__INTTAB_CPU4 + 0x1FE0) : {KEEP (*(.inttab4.intvec.255)) } > cpu4_dlmu

    /* CPU5 Interrupt Vector Table */
    .inttab_tc5_000 (TEXT) BIND(__INTTAB_CPU5 + 0x0000) : {KEEP (*(.inttab5.intvec.0  )) } > cpu5_dlmu
    .inttab_tc5_001 (TEXT) BIND(__INTTAB_CPU5 + 0x0020) : {KEEP (*(.inttab5.intvec.1  )) } > cpu5_dlmu
    .inttab_tc5_002 (TEXT) BIND(__INTTAB_CPU5 + 0x0040) : {KEEP (*(.inttab5.intvec.2  )) } > cpu5_dlmu
    .inttab_tc5_003 (TEXT) BIND(__INTTAB_CPU5 + 0x0060) : {KEEP (*(.inttab5.intvec.3  )) } > cpu5_dlmu
    .inttab_tc5_004 (TEXT) BIND(__INTTAB_CPU5 + 0x0080) : {KEEP (*(.inttab5.intvec.4  )) } > cpu5_dlmu
    .inttab_tc5_005 (TEXT) BIND(__INTTAB_CPU5 + 0x00A0) : {KEEP (*(.inttab5.intvec.5  )) } > cpu5_dlmu
    .inttab_tc5_006 (TEXT) BIND(__INTTAB_CPU5 + 0x00C0) : {KEEP (*(.inttab5.intvec.6  )) } > cpu5_dlmu
    .inttab_tc5_007 (TEXT) BIND(__INTTAB_CPU5 + 0x00E0) : {KEEP (*(.inttab5.intvec.7  )) } > cpu5_dlmu
    .inttab_tc5_008 (TEXT) BIND(__INTTAB_CPU5 + 0x0100) : {KEEP (*(.inttab5.intvec.8  )) } > cpu5_dlmu
    .inttab_tc5_009 (TEXT) BIND(__INTTAB_CPU5 + 0x0120) : {KEEP (*(.inttab5.intvec.9  )) } > cpu5_dlmu
    .inttab_tc5_00A (TEXT) BIND(__INTTAB_CPU5 + 0x0140) : {KEEP (*(.inttab5.intvec.10 )) } > cpu5_dlmu
    .inttab_tc5_00B (TEXT) BIND(__INTTAB_CPU5 + 0x0160) : {KEEP (*(.inttab5.intvec.11 )) } > cpu5_dlmu
    .inttab_tc5_00C (TEXT) BIND(__INTTAB_CPU5 + 0x0180) : {KEEP (*(.inttab5.intvec.12 )) } > cpu5_dlmu
    .inttab_tc5_00D (TEXT) BIND(__INTTAB_CPU5 + 0x01A0) : {KEEP (*(.inttab5.intvec.13 )) } > cpu5_dlmu
    .inttab_tc5_00E (TEXT) BIND(__INTTAB_CPU5 + 0x01C0) : {KEEP (*(.inttab5.intvec.14 )) } > cpu5_dlmu
    .inttab_tc5_00F (TEXT) BIND(__INTTAB_CPU5 + 0x01E0) : {KEEP (*(.inttab5.intvec.15 )) } > cpu5_dlmu
    .inttab_tc5_010 (TEXT) BIND(__INTTAB_CPU5 + 0x0200) : {KEEP (*(.inttab5.intvec.16 )) } > cpu5_dlmu
    .inttab_tc5_011 (TEXT) BIND(__INTTAB_CPU5 + 0x0220) : {KEEP (*(.inttab5.intvec.17 )) } > cpu5_dlmu
    .inttab_tc5_012 (TEXT) BIND(__INTTAB_CPU5 + 0x0240) : {KEEP (*(.inttab5.intvec.18 )) } > cpu5_dlmu
    .inttab_tc5_013 (TEXT) BIND(__INTTAB_CPU5 + 0x0260) : {KEEP (*(.inttab5.intvec.19 )) } > cpu5_dlmu
    .inttab_tc5_014 (TEXT) BIND(__INTTAB_CPU5 + 0x0280) : {KEEP (*(.inttab5.intvec.20 )) } > cpu5_dlmu
    .inttab_tc5_015 (TEXT) BIND(__INTTAB_CPU5 + 0x02A0) : {KEEP (*(.inttab5.intvec.21 )) } > cpu5_dlmu
    .inttab_tc5_016 (TEXT) BIND(__INTTAB_CPU5 + 0x02C0) : {KEEP (*(.inttab5.intvec.22 )) } > cpu5_dlmu
    .inttab_tc5_017 (TEXT) BIND(__INTTAB_CPU5 + 0x02E0) : {KEEP (*(.inttab5.intvec.23 )) } > cpu5_dlmu
    .inttab_tc5_018 (TEXT) BIND(__INTTAB_CPU5 + 0x0300) : {KEEP (*(.inttab5.intvec.24 )) } > cpu5_dlmu
    .inttab_tc5_019 (TEXT) BIND(__INTTAB_CPU5 + 0x0320) : {KEEP (*(.inttab5.intvec.25 )) } > cpu5_dlmu
    .inttab_tc5_01A (TEXT) BIND(__INTTAB_CPU5 + 0x0340) : {KEEP (*(.inttab5.intvec.26 )) } > cpu5_dlmu
    .inttab_tc5_01B (TEXT) BIND(__INTTAB_CPU5 + 0x0360) : {KEEP (*(.inttab5.intvec.27 )) } > cpu5_dlmu
    .inttab_tc5_01C (TEXT) BIND(__INTTAB_CPU5 + 0x0380) : {KEEP (*(.inttab5.intvec.28 )) } > cpu5_dlmu
    .inttab_tc5_01D (TEXT) BIND(__INTTAB_CPU5 + 0x03A0) : {KEEP (*(.inttab5.intvec.29 )) } > cpu5_dlmu
    .inttab_tc5_01E (TEXT) BIND(__INTTAB_CPU5 + 0x03C0) : {KEEP (*(.inttab5.intvec.30 )) } > cpu5_dlmu
    .inttab_tc5_01F (TEXT) BIND(__INTTAB_CPU5 + 0x03E0) : {KEEP (*(.inttab5.intvec.31 )) } > cpu5_dlmu
    .inttab_tc5_020 (TEXT) BIND(__INTTAB_CPU5 + 0x0400) : {KEEP (*(.inttab5.intvec.32 )) } > cpu5_dlmu
    .inttab_tc5_021 (TEXT) BIND(__INTTAB_CPU5 + 0x0420) : {KEEP (*(.inttab5.intvec.33 )) } > cpu5_dlmu
    .inttab_tc5_022 (TEXT) BIND(__INTTAB_CPU5 + 0x0440) : {KEEP (*(.inttab5.intvec.34 )) } > cpu5_dlmu
    .inttab_tc5_023 (TEXT) BIND(__INTTAB_CPU5 + 0x0460) : {KEEP (*(.inttab5.intvec.35 )) } > cpu5_dlmu
    .inttab_tc5_024 (TEXT) BIND(__INTTAB_CPU5 + 0x0480) : {KEEP (*(.inttab5.intvec.36 )) } > cpu5_dlmu
    .inttab_tc5_025 (TEXT) BIND(__INTTAB_CPU5 + 0x04A0) : {KEEP (*(.inttab5.intvec.37 )) } > cpu5_dlmu
    .inttab_tc5_026 (TEXT) BIND(__INTTAB_CPU5 + 0x04C0) : {KEEP (*(.inttab5.intvec.38 )) } > cpu5_dlmu
    .inttab_tc5_027 (TEXT) BIND(__INTTAB_CPU5 + 0x04E0) : {KEEP (*(.inttab5.intvec.39 )) } > cpu5_dlmu
    .inttab_tc5_028 (TEXT) BIND(__INTTAB_CPU5 + 0x0500) : {KEEP (*(.inttab5.intvec.40 )) } > cpu5_dlmu
    .inttab_tc5_029 (TEXT) BIND(__INTTAB_CPU5 + 0x0520) : {KEEP (*(.inttab5.intvec.41 )) } > cpu5_dlmu
    .inttab_tc5_02A (TEXT) BIND(__INTTAB_CPU5 + 0x0540) : {KEEP (*(.inttab5.intvec.42 )) } > cpu5_dlmu
    .inttab_tc5_02B (TEXT) BIND(__INTTAB_CPU5 + 0x0560) : {KEEP (*(.inttab5.intvec.43 )) } > cpu5_dlmu
    .inttab_tc5_02C (TEXT) BIND(__INTTAB_CPU5 + 0x0580) : {KEEP (*(.inttab5.intvec.44 )) } > cpu5_dlmu
    .inttab_tc5_02D (TEXT) BIND(__INTTAB_CPU5 + 0x05A0) : {KEEP (*(.inttab5.intvec.45 )) } > cpu5_dlmu
    .inttab_tc5_02E (TEXT) BIND(__INTTAB_CPU5 + 0x05C0) : {KEEP (*(.inttab5.intvec.46 )) } > cpu5_dlmu
    .inttab_tc5_02F (TEXT) BIND(__INTTAB_CPU5 + 0x05E0) : {KEEP (*(.inttab5.intvec.47 )) } > cpu5_dlmu
    .inttab_tc5_030 (TEXT) BIND(__INTTAB_CPU5 + 0x0600) : {KEEP (*(.inttab5.intvec.48 )) } > cpu5_dlmu
    .inttab_tc5_031 (TEXT) BIND(__INTTAB_CPU5 + 0x0620) : {KEEP (*(.inttab5.intvec.49 )) } > cpu5_dlmu
    .inttab_tc5_032 (TEXT) BIND(__INTTAB_CPU5 + 0x0640) : {KEEP (*(.inttab5.intvec.50 )) } > cpu5_dlmu
    .inttab_tc5_033 (TEXT) BIND(__INTTAB_CPU5 + 0x0660) : {KEEP (*(.inttab5.intvec.51 )) } > cpu5_dlmu
    .inttab_tc5_034 (TEXT) BIND(__INTTAB_CPU5 + 0x0680) : {KEEP (*(.inttab5.intvec.52 )) } > cpu5_dlmu
    .inttab_tc5_035 (TEXT) BIND(__INTTAB_CPU5 + 0x06A0) : {KEEP (*(.inttab5.intvec.53 )) } > cpu5_dlmu
    .inttab_tc5_036 (TEXT) BIND(__INTTAB_CPU5 + 0x06C0) : {KEEP (*(.inttab5.intvec.54 )) } > cpu5_dlmu
    .inttab_tc5_037 (TEXT) BIND(__INTTAB_CPU5 + 0x06E0) : {KEEP (*(.inttab5.intvec.55 )) } > cpu5_dlmu
    .inttab_tc5_038 (TEXT) BIND(__INTTAB_CPU5 + 0x0700) : {KEEP (*(.inttab5.intvec.56 )) } > cpu5_dlmu
    .inttab_tc5_039 (TEXT) BIND(__INTTAB_CPU5 + 0x0720) : {KEEP (*(.inttab5.intvec.57 )) } > cpu5_dlmu
    .inttab_tc5_03A (TEXT) BIND(__INTTAB_CPU5 + 0x0740) : {KEEP (*(.inttab5.intvec.58 )) } > cpu5_dlmu
    .inttab_tc5_03B (TEXT) BIND(__INTTAB_CPU5 + 0x0760) : {KEEP (*(.inttab5.intvec.59 )) } > cpu5_dlmu
    .inttab_tc5_03C (TEXT) BIND(__INTTAB_CPU5 + 0x0780) : {KEEP (*(.inttab5.intvec.60 )) } > cpu5_dlmu
    .inttab_tc5_03D (TEXT) BIND(__INTTAB_CPU5 + 0x07A0) : {KEEP (*(.inttab5.intvec.61 )) } > cpu5_dlmu
    .inttab_tc5_03E (TEXT) BIND(__INTTAB_CPU5 + 0x07C0) : {KEEP (*(.inttab5.intvec.62 )) } > cpu5_dlmu
    .inttab_tc5_03F (TEXT) BIND(__INTTAB_CPU5 + 0x07E0) : {KEEP (*(.inttab5.intvec.63 )) } > cpu5_dlmu
    .inttab_tc5_040 (TEXT) BIND(__INTTAB_CPU5 + 0x0800) : {KEEP (*(.inttab5.intvec.64 )) } > cpu5_dlmu
    .inttab_tc5_041 (TEXT) BIND(__INTTAB_CPU5 + 0x0820) : {KEEP (*(.inttab5.intvec.65 )) } > cpu5_dlmu
    .inttab_tc5_042 (TEXT) BIND(__INTTAB_CPU5 + 0x0840) : {KEEP (*(.inttab5.intvec.66 )) } > cpu5_dlmu
    .inttab_tc5_043 (TEXT) BIND(__INTTAB_CPU5 + 0x0860) : {KEEP (*(.inttab5.intvec.67 )) } > cpu5_dlmu
    .inttab_tc5_044 (TEXT) BIND(__INTTAB_CPU5 + 0x0880) : {KEEP (*(.inttab5.intvec.68 )) } > cpu5_dlmu
    .inttab_tc5_045 (TEXT) BIND(__INTTAB_CPU5 + 0x08A0) : {KEEP (*(.inttab5.intvec.69 )) } > cpu5_dlmu
    .inttab_tc5_046 (TEXT) BIND(__INTTAB_CPU5 + 0x08C0) : {KEEP (*(.inttab5.intvec.70 )) } > cpu5_dlmu
    .inttab_tc5_047 (TEXT) BIND(__INTTAB_CPU5 + 0x08E0) : {KEEP (*(.inttab5.intvec.71 )) } > cpu5_dlmu
    .inttab_tc5_048 (TEXT) BIND(__INTTAB_CPU5 + 0x0900) : {KEEP (*(.inttab5.intvec.72 )) } > cpu5_dlmu
    .inttab_tc5_049 (TEXT) BIND(__INTTAB_CPU5 + 0x0920) : {KEEP (*(.inttab5.intvec.73 )) } > cpu5_dlmu
    .inttab_tc5_04A (TEXT) BIND(__INTTAB_CPU5 + 0x0940) : {KEEP (*(.inttab5.intvec.74 )) } > cpu5_dlmu
    .inttab_tc5_04B (TEXT) BIND(__INTTAB_CPU5 + 0x0960) : {KEEP (*(.inttab5.intvec.75 )) } > cpu5_dlmu
    .inttab_tc5_04C (TEXT) BIND(__INTTAB_CPU5 + 0x0980) : {KEEP (*(.inttab5.intvec.76 )) } > cpu5_dlmu
    .inttab_tc5_04D (TEXT) BIND(__INTTAB_CPU5 + 0x09A0) : {KEEP (*(.inttab5.intvec.77 )) } > cpu5_dlmu
    .inttab_tc5_04E (TEXT) BIND(__INTTAB_CPU5 + 0x09C0) : {KEEP (*(.inttab5.intvec.78 )) } > cpu5_dlmu
    .inttab_tc5_04F (TEXT) BIND(__INTTAB_CPU5 + 0x09E0) : {KEEP (*(.inttab5.intvec.79 )) } > cpu5_dlmu
    .inttab_tc5_050 (TEXT) BIND(__INTTAB_CPU5 + 0x0A00) : {KEEP (*(.inttab5.intvec.80 )) } > cpu5_dlmu
    .inttab_tc5_051 (TEXT) BIND(__INTTAB_CPU5 + 0x0A20) : {KEEP (*(.inttab5.intvec.81 )) } > cpu5_dlmu
    .inttab_tc5_052 (TEXT) BIND(__INTTAB_CPU5 + 0x0A40) : {KEEP (*(.inttab5.intvec.82 )) } > cpu5_dlmu
    .inttab_tc5_053 (TEXT) BIND(__INTTAB_CPU5 + 0x0A60) : {KEEP (*(.inttab5.intvec.83 )) } > cpu5_dlmu
    .inttab_tc5_054 (TEXT) BIND(__INTTAB_CPU5 + 0x0A80) : {KEEP (*(.inttab5.intvec.84 )) } > cpu5_dlmu
    .inttab_tc5_055 (TEXT) BIND(__INTTAB_CPU5 + 0x0AA0) : {KEEP (*(.inttab5.intvec.85 )) } > cpu5_dlmu
    .inttab_tc5_056 (TEXT) BIND(__INTTAB_CPU5 + 0x0AC0) : {KEEP (*(.inttab5.intvec.86 )) } > cpu5_dlmu
    .inttab_tc5_057 (TEXT) BIND(__INTTAB_CPU5 + 0x0AE0) : {KEEP (*(.inttab5.intvec.87 )) } > cpu5_dlmu
    .inttab_tc5_058 (TEXT) BIND(__INTTAB_CPU5 + 0x0B00) : {KEEP (*(.inttab5.intvec.88 )) } > cpu5_dlmu
    .inttab_tc5_059 (TEXT) BIND(__INTTAB_CPU5 + 0x0B20) : {KEEP (*(.inttab5.intvec.89 )) } > cpu5_dlmu
    .inttab_tc5_05A (TEXT) BIND(__INTTAB_CPU5 + 0x0B40) : {KEEP (*(.inttab5.intvec.90 )) } > cpu5_dlmu
    .inttab_tc5_05B (TEXT) BIND(__INTTAB_CPU5 + 0x0B60) : {KEEP (*(.inttab5.intvec.91 )) } > cpu5_dlmu
    .inttab_tc5_05C (TEXT) BIND(__INTTAB_CPU5 + 0x0B80) : {KEEP (*(.inttab5.intvec.92 )) } > cpu5_dlmu
    .inttab_tc5_05D (TEXT) BIND(__INTTAB_CPU5 + 0x0BA0) : {KEEP (*(.inttab5.intvec.93 )) } > cpu5_dlmu
    .inttab_tc5_05E (TEXT) BIND(__INTTAB_CPU5 + 0x0BC0) : {KEEP (*(.inttab5.intvec.94 )) } > cpu5_dlmu
    .inttab_tc5_05F (TEXT) BIND(__INTTAB_CPU5 + 0x0BE0) : {KEEP (*(.inttab5.intvec.95 )) } > cpu5_dlmu
    .inttab_tc5_060 (TEXT) BIND(__INTTAB_CPU5 + 0x0C00) : {KEEP (*(.inttab5.intvec.96 )) } > cpu5_dlmu
    .inttab_tc5_061 (TEXT) BIND(__INTTAB_CPU5 + 0x0C20) : {KEEP (*(.inttab5.intvec.97 )) } > cpu5_dlmu
    .inttab_tc5_062 (TEXT) BIND(__INTTAB_CPU5 + 0x0C40) : {KEEP (*(.inttab5.intvec.98 )) } > cpu5_dlmu
    .inttab_tc5_063 (TEXT) BIND(__INTTAB_CPU5 + 0x0C60) : {KEEP (*(.inttab5.intvec.99 )) } > cpu5_dlmu
    .inttab_tc5_064 (TEXT) BIND(__INTTAB_CPU5 + 0x0C80) : {KEEP (*(.inttab5.intvec.100)) } > cpu5_dlmu
    .inttab_tc5_065 (TEXT) BIND(__INTTAB_CPU5 + 0x0CA0) : {KEEP (*(.inttab5.intvec.101)) } > cpu5_dlmu
    .inttab_tc5_066 (TEXT) BIND(__INTTAB_CPU5 + 0x0CC0) : {KEEP (*(.inttab5.intvec.102)) } > cpu5_dlmu
    .inttab_tc5_067 (TEXT) BIND(__INTTAB_CPU5 + 0x0CE0) : {KEEP (*(.inttab5.intvec.103)) } > cpu5_dlmu
    .inttab_tc5_068 (TEXT) BIND(__INTTAB_CPU5 + 0x0D00) : {KEEP (*(.inttab5.intvec.104)) } > cpu5_dlmu
    .inttab_tc5_069 (TEXT) BIND(__INTTAB_CPU5 + 0x0D20) : {KEEP (*(.inttab5.intvec.105)) } > cpu5_dlmu
    .inttab_tc5_06A (TEXT) BIND(__INTTAB_CPU5 + 0x0D40) : {KEEP (*(.inttab5.intvec.106)) } > cpu5_dlmu
    .inttab_tc5_06B (TEXT) BIND(__INTTAB_CPU5 + 0x0D60) : {KEEP (*(.inttab5.intvec.107)) } > cpu5_dlmu
    .inttab_tc5_06C (TEXT) BIND(__INTTAB_CPU5 + 0x0D80) : {KEEP (*(.inttab5.intvec.108)) } > cpu5_dlmu
    .inttab_tc5_06D (TEXT) BIND(__INTTAB_CPU5 + 0x0DA0) : {KEEP (*(.inttab5.intvec.109)) } > cpu5_dlmu
    .inttab_tc5_06E (TEXT) BIND(__INTTAB_CPU5 + 0x0DC0) : {KEEP (*(.inttab5.intvec.110)) } > cpu5_dlmu
    .inttab_tc5_06F (TEXT) BIND(__INTTAB_CPU5 + 0x0DE0) : {KEEP (*(.inttab5.intvec.111)) } > cpu5_dlmu
    .inttab_tc5_070 (TEXT) BIND(__INTTAB_CPU5 + 0x0E00) : {KEEP (*(.inttab5.intvec.112)) } > cpu5_dlmu
    .inttab_tc5_071 (TEXT) BIND(__INTTAB_CPU5 + 0x0E20) : {KEEP (*(.inttab5.intvec.113)) } > cpu5_dlmu
    .inttab_tc5_072 (TEXT) BIND(__INTTAB_CPU5 + 0x0E40) : {KEEP (*(.inttab5.intvec.114)) } > cpu5_dlmu
    .inttab_tc5_073 (TEXT) BIND(__INTTAB_CPU5 + 0x0E60) : {KEEP (*(.inttab5.intvec.115)) } > cpu5_dlmu
    .inttab_tc5_074 (TEXT) BIND(__INTTAB_CPU5 + 0x0E80) : {KEEP (*(.inttab5.intvec.116)) } > cpu5_dlmu
    .inttab_tc5_075 (TEXT) BIND(__INTTAB_CPU5 + 0x0EA0) : {KEEP (*(.inttab5.intvec.117)) } > cpu5_dlmu
    .inttab_tc5_076 (TEXT) BIND(__INTTAB_CPU5 + 0x0EC0) : {KEEP (*(.inttab5.intvec.118)) } > cpu5_dlmu
    .inttab_tc5_077 (TEXT) BIND(__INTTAB_CPU5 + 0x0EE0) : {KEEP (*(.inttab5.intvec.119)) } > cpu5_dlmu
    .inttab_tc5_078 (TEXT) BIND(__INTTAB_CPU5 + 0x0F00) : {KEEP (*(.inttab5.intvec.120)) } > cpu5_dlmu
    .inttab_tc5_079 (TEXT) BIND(__INTTAB_CPU5 + 0x0F20) : {KEEP (*(.inttab5.intvec.121)) } > cpu5_dlmu
    .inttab_tc5_07A (TEXT) BIND(__INTTAB_CPU5 + 0x0F40) : {KEEP (*(.inttab5.intvec.122)) } > cpu5_dlmu
    .inttab_tc5_07B (TEXT) BIND(__INTTAB_CPU5 + 0x0F60) : {KEEP (*(.inttab5.intvec.123)) } > cpu5_dlmu
    .inttab_tc5_07C (TEXT) BIND(__INTTAB_CPU5 + 0x0F80) : {KEEP (*(.inttab5.intvec.124)) } > cpu5_dlmu
    .inttab_tc5_07D (TEXT) BIND(__INTTAB_CPU5 + 0x0FA0) : {KEEP (*(.inttab5.intvec.125)) } > cpu5_dlmu
    .inttab_tc5_07E (TEXT) BIND(__INTTAB_CPU5 + 0x0FC0) : {KEEP (*(.inttab5.intvec.126)) } > cpu5_dlmu
    .inttab_tc5_07F (TEXT) BIND(__INTTAB_CPU5 + 0x0FE0) : {KEEP (*(.inttab5.intvec.127)) } > cpu5_dlmu
    .inttab_tc5_080 (TEXT) BIND(__INTTAB_CPU5 + 0x1000) : {KEEP (*(.inttab5.intvec.128)) } > cpu5_dlmu
    .inttab_tc5_081 (TEXT) BIND(__INTTAB_CPU5 + 0x1020) : {KEEP (*(.inttab5.intvec.129)) } > cpu5_dlmu
    .inttab_tc5_082 (TEXT) BIND(__INTTAB_CPU5 + 0x1040) : {KEEP (*(.inttab5.intvec.130)) } > cpu5_dlmu
    .inttab_tc5_083 (TEXT) BIND(__INTTAB_CPU5 + 0x1060) : {KEEP (*(.inttab5.intvec.131)) } > cpu5_dlmu
    .inttab_tc5_084 (TEXT) BIND(__INTTAB_CPU5 + 0x1080) : {KEEP (*(.inttab5.intvec.132)) } > cpu5_dlmu
    .inttab_tc5_085 (TEXT) BIND(__INTTAB_CPU5 + 0x10A0) : {KEEP (*(.inttab5.intvec.133)) } > cpu5_dlmu
    .inttab_tc5_086 (TEXT) BIND(__INTTAB_CPU5 + 0x10C0) : {KEEP (*(.inttab5.intvec.134)) } > cpu5_dlmu
    .inttab_tc5_087 (TEXT) BIND(__INTTAB_CPU5 + 0x10E0) : {KEEP (*(.inttab5.intvec.135)) } > cpu5_dlmu
    .inttab_tc5_088 (TEXT) BIND(__INTTAB_CPU5 + 0x1100) : {KEEP (*(.inttab5.intvec.136)) } > cpu5_dlmu
    .inttab_tc5_089 (TEXT) BIND(__INTTAB_CPU5 + 0x1120) : {KEEP (*(.inttab5.intvec.137)) } > cpu5_dlmu
    .inttab_tc5_08A (TEXT) BIND(__INTTAB_CPU5 + 0x1140) : {KEEP (*(.inttab5.intvec.138)) } > cpu5_dlmu
    .inttab_tc5_08B (TEXT) BIND(__INTTAB_CPU5 + 0x1160) : {KEEP (*(.inttab5.intvec.139)) } > cpu5_dlmu
    .inttab_tc5_08C (TEXT) BIND(__INTTAB_CPU5 + 0x1180) : {KEEP (*(.inttab5.intvec.140)) } > cpu5_dlmu
    .inttab_tc5_08D (TEXT) BIND(__INTTAB_CPU5 + 0x11A0) : {KEEP (*(.inttab5.intvec.141)) } > cpu5_dlmu
    .inttab_tc5_08E (TEXT) BIND(__INTTAB_CPU5 + 0x11C0) : {KEEP (*(.inttab5.intvec.142)) } > cpu5_dlmu
    .inttab_tc5_08F (TEXT) BIND(__INTTAB_CPU5 + 0x11E0) : {KEEP (*(.inttab5.intvec.143)) } > cpu5_dlmu
    .inttab_tc5_090 (TEXT) BIND(__INTTAB_CPU5 + 0x1200) : {KEEP (*(.inttab5.intvec.144)) } > cpu5_dlmu
    .inttab_tc5_091 (TEXT) BIND(__INTTAB_CPU5 + 0x1220) : {KEEP (*(.inttab5.intvec.145)) } > cpu5_dlmu
    .inttab_tc5_092 (TEXT) BIND(__INTTAB_CPU5 + 0x1240) : {KEEP (*(.inttab5.intvec.146)) } > cpu5_dlmu
    .inttab_tc5_093 (TEXT) BIND(__INTTAB_CPU5 + 0x1260) : {KEEP (*(.inttab5.intvec.147)) } > cpu5_dlmu
    .inttab_tc5_094 (TEXT) BIND(__INTTAB_CPU5 + 0x1280) : {KEEP (*(.inttab5.intvec.148)) } > cpu5_dlmu
    .inttab_tc5_095 (TEXT) BIND(__INTTAB_CPU5 + 0x12A0) : {KEEP (*(.inttab5.intvec.149)) } > cpu5_dlmu
    .inttab_tc5_096 (TEXT) BIND(__INTTAB_CPU5 + 0x12C0) : {KEEP (*(.inttab5.intvec.150)) } > cpu5_dlmu
    .inttab_tc5_097 (TEXT) BIND(__INTTAB_CPU5 + 0x12E0) : {KEEP (*(.inttab5.intvec.151)) } > cpu5_dlmu
    .inttab_tc5_098 (TEXT) BIND(__INTTAB_CPU5 + 0x1300) : {KEEP (*(.inttab5.intvec.152)) } > cpu5_dlmu
    .inttab_tc5_099 (TEXT) BIND(__INTTAB_CPU5 + 0x1320) : {KEEP (*(.inttab5.intvec.153)) } > cpu5_dlmu
    .inttab_tc5_09A (TEXT) BIND(__INTTAB_CPU5 + 0x1340) : {KEEP (*(.inttab5.intvec.154)) } > cpu5_dlmu
    .inttab_tc5_09B (TEXT) BIND(__INTTAB_CPU5 + 0x1360) : {KEEP (*(.inttab5.intvec.155)) } > cpu5_dlmu
    .inttab_tc5_09C (TEXT) BIND(__INTTAB_CPU5 + 0x1380) : {KEEP (*(.inttab5.intvec.156)) } > cpu5_dlmu
    .inttab_tc5_09D (TEXT) BIND(__INTTAB_CPU5 + 0x13A0) : {KEEP (*(.inttab5.intvec.157)) } > cpu5_dlmu
    .inttab_tc5_09E (TEXT) BIND(__INTTAB_CPU5 + 0x13C0) : {KEEP (*(.inttab5.intvec.158)) } > cpu5_dlmu
    .inttab_tc5_09F (TEXT) BIND(__INTTAB_CPU5 + 0x13E0) : {KEEP (*(.inttab5.intvec.159)) } > cpu5_dlmu
    .inttab_tc5_0A0 (TEXT) BIND(__INTTAB_CPU5 + 0x1400) : {KEEP (*(.inttab5.intvec.160)) } > cpu5_dlmu
    .inttab_tc5_0A1 (TEXT) BIND(__INTTAB_CPU5 + 0x1420) : {KEEP (*(.inttab5.intvec.161)) } > cpu5_dlmu
    .inttab_tc5_0A2 (TEXT) BIND(__INTTAB_CPU5 + 0x1440) : {KEEP (*(.inttab5.intvec.162)) } > cpu5_dlmu
    .inttab_tc5_0A3 (TEXT) BIND(__INTTAB_CPU5 + 0x1460) : {KEEP (*(.inttab5.intvec.163)) } > cpu5_dlmu
    .inttab_tc5_0A4 (TEXT) BIND(__INTTAB_CPU5 + 0x1480) : {KEEP (*(.inttab5.intvec.164)) } > cpu5_dlmu
    .inttab_tc5_0A5 (TEXT) BIND(__INTTAB_CPU5 + 0x14A0) : {KEEP (*(.inttab5.intvec.165)) } > cpu5_dlmu
    .inttab_tc5_0A6 (TEXT) BIND(__INTTAB_CPU5 + 0x14C0) : {KEEP (*(.inttab5.intvec.166)) } > cpu5_dlmu
    .inttab_tc5_0A7 (TEXT) BIND(__INTTAB_CPU5 + 0x14E0) : {KEEP (*(.inttab5.intvec.167)) } > cpu5_dlmu
    .inttab_tc5_0A8 (TEXT) BIND(__INTTAB_CPU5 + 0x1500) : {KEEP (*(.inttab5.intvec.168)) } > cpu5_dlmu
    .inttab_tc5_0A9 (TEXT) BIND(__INTTAB_CPU5 + 0x1520) : {KEEP (*(.inttab5.intvec.169)) } > cpu5_dlmu
    .inttab_tc5_0AA (TEXT) BIND(__INTTAB_CPU5 + 0x1540) : {KEEP (*(.inttab5.intvec.170)) } > cpu5_dlmu
    .inttab_tc5_0AB (TEXT) BIND(__INTTAB_CPU5 + 0x1560) : {KEEP (*(.inttab5.intvec.171)) } > cpu5_dlmu
    .inttab_tc5_0AC (TEXT) BIND(__INTTAB_CPU5 + 0x1580) : {KEEP (*(.inttab5.intvec.172)) } > cpu5_dlmu
    .inttab_tc5_0AD (TEXT) BIND(__INTTAB_CPU5 + 0x15A0) : {KEEP (*(.inttab5.intvec.173)) } > cpu5_dlmu
    .inttab_tc5_0AE (TEXT) BIND(__INTTAB_CPU5 + 0x15C0) : {KEEP (*(.inttab5.intvec.174)) } > cpu5_dlmu
    .inttab_tc5_0AF (TEXT) BIND(__INTTAB_CPU5 + 0x15E0) : {KEEP (*(.inttab5.intvec.175)) } > cpu5_dlmu
    .inttab_tc5_0B0 (TEXT) BIND(__INTTAB_CPU5 + 0x1600) : {KEEP (*(.inttab5.intvec.176)) } > cpu5_dlmu
    .inttab_tc5_0B1 (TEXT) BIND(__INTTAB_CPU5 + 0x1620) : {KEEP (*(.inttab5.intvec.177)) } > cpu5_dlmu
    .inttab_tc5_0B2 (TEXT) BIND(__INTTAB_CPU5 + 0x1640) : {KEEP (*(.inttab5.intvec.178)) } > cpu5_dlmu
    .inttab_tc5_0B3 (TEXT) BIND(__INTTAB_CPU5 + 0x1660) : {KEEP (*(.inttab5.intvec.179)) } > cpu5_dlmu
    .inttab_tc5_0B4 (TEXT) BIND(__INTTAB_CPU5 + 0x1680) : {KEEP (*(.inttab5.intvec.180)) } > cpu5_dlmu
    .inttab_tc5_0B5 (TEXT) BIND(__INTTAB_CPU5 + 0x16A0) : {KEEP (*(.inttab5.intvec.181)) } > cpu5_dlmu
    .inttab_tc5_0B6 (TEXT) BIND(__INTTAB_CPU5 + 0x16C0) : {KEEP (*(.inttab5.intvec.182)) } > cpu5_dlmu
    .inttab_tc5_0B7 (TEXT) BIND(__INTTAB_CPU5 + 0x16E0) : {KEEP (*(.inttab5.intvec.183)) } > cpu5_dlmu
    .inttab_tc5_0B8 (TEXT) BIND(__INTTAB_CPU5 + 0x1700) : {KEEP (*(.inttab5.intvec.184)) } > cpu5_dlmu
    .inttab_tc5_0B9 (TEXT) BIND(__INTTAB_CPU5 + 0x1720) : {KEEP (*(.inttab5.intvec.185)) } > cpu5_dlmu
    .inttab_tc5_0BA (TEXT) BIND(__INTTAB_CPU5 + 0x1740) : {KEEP (*(.inttab5.intvec.186)) } > cpu5_dlmu
    .inttab_tc5_0BB (TEXT) BIND(__INTTAB_CPU5 + 0x1760) : {KEEP (*(.inttab5.intvec.187)) } > cpu5_dlmu
    .inttab_tc5_0BC (TEXT) BIND(__INTTAB_CPU5 + 0x1780) : {KEEP (*(.inttab5.intvec.188)) } > cpu5_dlmu
    .inttab_tc5_0BD (TEXT) BIND(__INTTAB_CPU5 + 0x17A0) : {KEEP (*(.inttab5.intvec.189)) } > cpu5_dlmu
    .inttab_tc5_0BE (TEXT) BIND(__INTTAB_CPU5 + 0x17C0) : {KEEP (*(.inttab5.intvec.190)) } > cpu5_dlmu
    .inttab_tc5_0BF (TEXT) BIND(__INTTAB_CPU5 + 0x17E0) : {KEEP (*(.inttab5.intvec.191)) } > cpu5_dlmu
    .inttab_tc5_0C0 (TEXT) BIND(__INTTAB_CPU5 + 0x1800) : {KEEP (*(.inttab5.intvec.192)) } > cpu5_dlmu
    .inttab_tc5_0C1 (TEXT) BIND(__INTTAB_CPU5 + 0x1820) : {KEEP (*(.inttab5.intvec.193)) } > cpu5_dlmu
    .inttab_tc5_0C2 (TEXT) BIND(__INTTAB_CPU5 + 0x1840) : {KEEP (*(.inttab5.intvec.194)) } > cpu5_dlmu
    .inttab_tc5_0C3 (TEXT) BIND(__INTTAB_CPU5 + 0x1860) : {KEEP (*(.inttab5.intvec.195)) } > cpu5_dlmu
    .inttab_tc5_0C4 (TEXT) BIND(__INTTAB_CPU5 + 0x1880) : {KEEP (*(.inttab5.intvec.196)) } > cpu5_dlmu
    .inttab_tc5_0C5 (TEXT) BIND(__INTTAB_CPU5 + 0x18A0) : {KEEP (*(.inttab5.intvec.197)) } > cpu5_dlmu
    .inttab_tc5_0C6 (TEXT) BIND(__INTTAB_CPU5 + 0x18C0) : {KEEP (*(.inttab5.intvec.198)) } > cpu5_dlmu
    .inttab_tc5_0C7 (TEXT) BIND(__INTTAB_CPU5 + 0x18E0) : {KEEP (*(.inttab5.intvec.199)) } > cpu5_dlmu
    .inttab_tc5_0C8 (TEXT) BIND(__INTTAB_CPU5 + 0x1900) : {KEEP (*(.inttab5.intvec.200)) } > cpu5_dlmu
    .inttab_tc5_0C9 (TEXT) BIND(__INTTAB_CPU5 + 0x1920) : {KEEP (*(.inttab5.intvec.201)) } > cpu5_dlmu
    .inttab_tc5_0CA (TEXT) BIND(__INTTAB_CPU5 + 0x1940) : {KEEP (*(.inttab5.intvec.202)) } > cpu5_dlmu
    .inttab_tc5_0CB (TEXT) BIND(__INTTAB_CPU5 + 0x1960) : {KEEP (*(.inttab5.intvec.203)) } > cpu5_dlmu
    .inttab_tc5_0CC (TEXT) BIND(__INTTAB_CPU5 + 0x1980) : {KEEP (*(.inttab5.intvec.204)) } > cpu5_dlmu
    .inttab_tc5_0CD (TEXT) BIND(__INTTAB_CPU5 + 0x19A0) : {KEEP (*(.inttab5.intvec.205)) } > cpu5_dlmu
    .inttab_tc5_0CE (TEXT) BIND(__INTTAB_CPU5 + 0x19C0) : {KEEP (*(.inttab5.intvec.206)) } > cpu5_dlmu
    .inttab_tc5_0CF (TEXT) BIND(__INTTAB_CPU5 + 0x19E0) : {KEEP (*(.inttab5.intvec.207)) } > cpu5_dlmu
    .inttab_tc5_0D0 (TEXT) BIND(__INTTAB_CPU5 + 0x1A00) : {KEEP (*(.inttab5.intvec.208)) } > cpu5_dlmu
    .inttab_tc5_0D1 (TEXT) BIND(__INTTAB_CPU5 + 0x1A20) : {KEEP (*(.inttab5.intvec.209)) } > cpu5_dlmu
    .inttab_tc5_0D2 (TEXT) BIND(__INTTAB_CPU5 + 0x1A40) : {KEEP (*(.inttab5.intvec.210)) } > cpu5_dlmu
    .inttab_tc5_0D3 (TEXT) BIND(__INTTAB_CPU5 + 0x1A60) : {KEEP (*(.inttab5.intvec.211)) } > cpu5_dlmu
    .inttab_tc5_0D4 (TEXT) BIND(__INTTAB_CPU5 + 0x1A80) : {KEEP (*(.inttab5.intvec.212)) } > cpu5_dlmu
    .inttab_tc5_0D5 (TEXT) BIND(__INTTAB_CPU5 + 0x1AA0) : {KEEP (*(.inttab5.intvec.213)) } > cpu5_dlmu
    .inttab_tc5_0D6 (TEXT) BIND(__INTTAB_CPU5 + 0x1AC0) : {KEEP (*(.inttab5.intvec.214)) } > cpu5_dlmu
    .inttab_tc5_0D7 (TEXT) BIND(__INTTAB_CPU5 + 0x1AE0) : {KEEP (*(.inttab5.intvec.215)) } > cpu5_dlmu
    .inttab_tc5_0D8 (TEXT) BIND(__INTTAB_CPU5 + 0x1B00) : {KEEP (*(.inttab5.intvec.216)) } > cpu5_dlmu
    .inttab_tc5_0D9 (TEXT) BIND(__INTTAB_CPU5 + 0x1B20) : {KEEP (*(.inttab5.intvec.217)) } > cpu5_dlmu
    .inttab_tc5_0DA (TEXT) BIND(__INTTAB_CPU5 + 0x1B40) : {KEEP (*(.inttab5.intvec.218)) } > cpu5_dlmu
    .inttab_tc5_0DB (TEXT) BIND(__INTTAB_CPU5 + 0x1B60) : {KEEP (*(.inttab5.intvec.219)) } > cpu5_dlmu
    .inttab_tc5_0DC (TEXT) BIND(__INTTAB_CPU5 + 0x1B80) : {KEEP (*(.inttab5.intvec.220)) } > cpu5_dlmu
    .inttab_tc5_0DD (TEXT) BIND(__INTTAB_CPU5 + 0x1BA0) : {KEEP (*(.inttab5.intvec.221)) } > cpu5_dlmu
    .inttab_tc5_0DE (TEXT) BIND(__INTTAB_CPU5 + 0x1BC0) : {KEEP (*(.inttab5.intvec.222)) } > cpu5_dlmu
    .inttab_tc5_0DF (TEXT) BIND(__INTTAB_CPU5 + 0x1BE0) : {KEEP (*(.inttab5.intvec.223)) } > cpu5_dlmu
    .inttab_tc5_0E0 (TEXT) BIND(__INTTAB_CPU5 + 0x1C00) : {KEEP (*(.inttab5.intvec.224)) } > cpu5_dlmu
    .inttab_tc5_0E1 (TEXT) BIND(__INTTAB_CPU5 + 0x1C20) : {KEEP (*(.inttab5.intvec.225)) } > cpu5_dlmu
    .inttab_tc5_0E2 (TEXT) BIND(__INTTAB_CPU5 + 0x1C40) : {KEEP (*(.inttab5.intvec.226)) } > cpu5_dlmu
    .inttab_tc5_0E3 (TEXT) BIND(__INTTAB_CPU5 + 0x1C60) : {KEEP (*(.inttab5.intvec.227)) } > cpu5_dlmu
    .inttab_tc5_0E4 (TEXT) BIND(__INTTAB_CPU5 + 0x1C80) : {KEEP (*(.inttab5.intvec.228)) } > cpu5_dlmu
    .inttab_tc5_0E5 (TEXT) BIND(__INTTAB_CPU5 + 0x1CA0) : {KEEP (*(.inttab5.intvec.229)) } > cpu5_dlmu
    .inttab_tc5_0E6 (TEXT) BIND(__INTTAB_CPU5 + 0x1CC0) : {KEEP (*(.inttab5.intvec.230)) } > cpu5_dlmu
    .inttab_tc5_0E7 (TEXT) BIND(__INTTAB_CPU5 + 0x1CE0) : {KEEP (*(.inttab5.intvec.231)) } > cpu5_dlmu
    .inttab_tc5_0E8 (TEXT) BIND(__INTTAB_CPU5 + 0x1D00) : {KEEP (*(.inttab5.intvec.232)) } > cpu5_dlmu
    .inttab_tc5_0E9 (TEXT) BIND(__INTTAB_CPU5 + 0x1D20) : {KEEP (*(.inttab5.intvec.233)) } > cpu5_dlmu
    .inttab_tc5_0EA (TEXT) BIND(__INTTAB_CPU5 + 0x1D40) : {KEEP (*(.inttab5.intvec.234)) } > cpu5_dlmu
    .inttab_tc5_0EB (TEXT) BIND(__INTTAB_CPU5 + 0x1D60) : {KEEP (*(.inttab5.intvec.235)) } > cpu5_dlmu
    .inttab_tc5_0EC (TEXT) BIND(__INTTAB_CPU5 + 0x1D80) : {KEEP (*(.inttab5.intvec.236)) } > cpu5_dlmu
    .inttab_tc5_0ED (TEXT) BIND(__INTTAB_CPU5 + 0x1DA0) : {KEEP (*(.inttab5.intvec.237)) } > cpu5_dlmu
    .inttab_tc5_0EE (TEXT) BIND(__INTTAB_CPU5 + 0x1DC0) : {KEEP (*(.inttab5.intvec.238)) } > cpu5_dlmu
    .inttab_tc5_0EF (TEXT) BIND(__INTTAB_CPU5 + 0x1DE0) : {KEEP (*(.inttab5.intvec.239)) } > cpu5_dlmu
    .inttab_tc5_0F0 (TEXT) BIND(__INTTAB_CPU5 + 0x1E00) : {KEEP (*(.inttab5.intvec.240)) } > cpu5_dlmu
    .inttab_tc5_0F1 (TEXT) BIND(__INTTAB_CPU5 + 0x1E20) : {KEEP (*(.inttab5.intvec.241)) } > cpu5_dlmu
    .inttab_tc5_0F2 (TEXT) BIND(__INTTAB_CPU5 + 0x1E40) : {KEEP (*(.inttab5.intvec.242)) } > cpu5_dlmu
    .inttab_tc5_0F3 (TEXT) BIND(__INTTAB_CPU5 + 0x1E60) : {KEEP (*(.inttab5.intvec.243)) } > cpu5_dlmu
    .inttab_tc5_0F4 (TEXT) BIND(__INTTAB_CPU5 + 0x1E80) : {KEEP (*(.inttab5.intvec.244)) } > cpu5_dlmu
    .inttab_tc5_0F5 (TEXT) BIND(__INTTAB_CPU5 + 0x1EA0) : {KEEP (*(.inttab5.intvec.245)) } > cpu5_dlmu
    .inttab_tc5_0F6 (TEXT) BIND(__INTTAB_CPU5 + 0x1EC0) : {KEEP (*(.inttab5.intvec.246)) } > cpu5_dlmu
    .inttab_tc5_0F7 (TEXT) BIND(__INTTAB_CPU5 + 0x1EE0) : {KEEP (*(.inttab5.intvec.247)) } > cpu5_dlmu
    .inttab_tc5_0F8 (TEXT) BIND(__INTTAB_CPU5 + 0x1F00) : {KEEP (*(.inttab5.intvec.248)) } > cpu5_dlmu
    .inttab_tc5_0F9 (TEXT) BIND(__INTTAB_CPU5 + 0x1F20) : {KEEP (*(.inttab5.intvec.249)) } > cpu5_dlmu
    .inttab_tc5_0FA (TEXT) BIND(__INTTAB_CPU5 + 0x1F40) : {KEEP (*(.inttab5.intvec.250)) } > cpu5_dlmu
    .inttab_tc5_0FB (TEXT) BIND(__INTTAB_CPU5 + 0x1F60) : {KEEP (*(.inttab5.intvec.251)) } > cpu5_dlmu
    .inttab_tc5_0FC (TEXT) BIND(__INTTAB_CPU5 + 0x1F80) : {KEEP (*(.inttab5.intvec.252)) } > cpu5_dlmu
    .inttab_tc5_0FD (TEXT) BIND(__INTTAB_CPU5 + 0x1FA0) : {KEEP (*(.inttab5.intvec.253)) } > cpu5_dlmu
    .inttab_tc5_0FE (TEXT) BIND(__INTTAB_CPU5 + 0x1FC0) : {KEEP (*(.inttab5.intvec.254)) } > cpu5_dlmu
    .inttab_tc5_0FF (TEXT) BIND(__INTTAB_CPU5 + 0x1FE0) : {KEEP (*(.inttab5.intvec.255)) } > cpu5_dlmu

}