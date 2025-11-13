
-Xgenerate-copytables

LCF_CSA3_SIZE    = 8k;
LCF_USTACK3_SIZE = 2k;
LCF_ISTACK3_SIZE = 1k;

LCF_HEAP_SIZE = 4k;

LCF_PPU_FLASH_SIZE  = 1M;
LCF_PPU_LMURAM_SIZE = 512k;
LCF_PPU_CSM_SIZE    = 512k;

LCF_DSPR3_START = 0x40000000;
LCF_DSPR3_SIZE  = 240K;




LCF_CSA3_OFFSET    = (LCF_DSPR3_SIZE - 1k - LCF_CSA3_SIZE);
LCF_ISTACK3_OFFSET = (LCF_CSA3_OFFSET - 256 - LCF_ISTACK3_SIZE);
LCF_USTACK3_OFFSET = (LCF_ISTACK3_OFFSET - 256 - LCF_USTACK3_SIZE);

LCF_HEAP3_OFFSET = (LCF_USTACK3_OFFSET - LCF_HEAP_SIZE);

LCF_INTVEC3_START = 0x80DFE000;


__INTTAB_CPU3 = LCF_INTVEC3_START;
 



LCF_TRAPVEC3_START = 0x80A00100;

LCF_STARTPTR_CPU0 = 0x80000000; 
LCF_STARTPTR_CPU1 = 0x80400000;
LCF_STARTPTR_CPU2 = 0x80800000;
LCF_STARTPTR_CPU3 = 0x80A00000;
LCF_STARTPTR_CPU4 = 0x80E00000;
LCF_STARTPTR_CPU5 = 0x81200000;

LCF_STARTPTR_NC_CPU0 = 0xA0000000;
LCF_STARTPTR_NC_CPU1 = 0xA0400000;
LCF_STARTPTR_NC_CPU2 = 0xA0800000;
LCF_STARTPTR_NC_CPU3 = 0xA0A00000;
LCF_STARTPTR_NC_CPU4 = 0xA0E00000;
LCF_STARTPTR_NC_CPU5 = 0xA1200000;


RESET = LCF_STARTPTR_NC_CPU3;

 
 



MEMORY
{
    dsram3: org = 0x40000000, len = 240K
    psram3: org = 0x40100000, len = 64K
	

    pfls3: org = 0x80a00000, len = 4M
    pfls3_nc: org = 0xa0a00000, len = 4M
	
    pfls5: org = 0x81200000, len = 2M - 1M
    pfls5_nc: org = 0xa1200000, len = 2M - 1M

    ucb: org = 0xae400000, len = 80K

    cpu3_dlmu: org = 0x90180000, len = 512K
    cpu3_dlmu_nc: org = 0xb0180000, len = 512K
	
    lmuram: org = 0x90400000, len = 5M - 512k
    lmuram_nc: org = 0xb0400000, len = 5M - 512k
	
    ppu_lmuram : org = 0x90880000, len = 512k
    ppu_lmuram_nc : org = 0xb0880000, len = 512k  

    ppu_csm : org = 0x92080000, len = 512k
    ppu_csm_nc : org = 0xb2080000, len = 512k
    
    ppu_code : org = 0x81300000, len = 1M
    ppu_code_nc : org = 0xa1300000, len = 1M 
}

SECTIONS
{
/* Sections located at absolute fixed address */
/* Fixed memory Allocations for stack memory and CSA */
    /* CPU3 Stack and CSA defines */
    CPU3.ustack BIND(LCF_DSPR3_START + LCF_USTACK3_OFFSET) :
    { __USTACK3_END = . ;    . = . + LCF_USTACK3_SIZE;    __USTACK3 = . ; }
    
    CPU3.istack BIND(LCF_DSPR3_START + LCF_ISTACK3_OFFSET):
    { __ISTACK3_END = . ;    . = . + LCF_ISTACK3_SIZE;    __ISTACK3 = . ; }
    
    CPU3.csa BIND(LCF_DSPR3_START + LCF_CSA3_OFFSET):
    { __CSA3 = . ;    . = . + LCF_CSA3_SIZE;    __CSA3_END = . ; }
	
	


    __SP_END = __USTACK3_END;

    /*Fixed memory Allocations*/
    __IF_CONST = 0x80000020;


    /*Fixed memory Allocations for Trap Vector Table*/
    .traptab_tc3 (TEXT) BIND(LCF_TRAPVEC3_START) : { __TRAPTAB_CPU3 = .; KEEP (*(.traptab_cpu3)) } > pfls3

    /DISCARD/ :
    { 
        *(.traptab_cpu0)
        *(.traptab_cpu1)
        *(.traptab_cpu2)
        *(.traptab_cpu4)
	*(.traptab_cpu5)
        *(.interface_const)
    }

    /*Fixed memory Allocations for _START CPU3 */
    .start_tc3 (TEXT) LOAD(LCF_STARTPTR_CPU3) BIND(LCF_STARTPTR_NC_CPU3) : { __ENABLE_INDIVIDUAL_C_INIT_CPU3 = 1; KEEP (*(.start_cpu3)) } =0x800 > pfls3_nc
    __START0 = LCF_STARTPTR_NC_CPU0;
    __START1 = LCF_STARTPTR_NC_CPU1;
    __START2 = LCF_STARTPTR_NC_CPU2;
    __START3 = LCF_STARTPTR_NC_CPU3;
    __START4 = LCF_STARTPTR_NC_CPU4;
    __START5 = LCF_STARTPTR_NC_CPU5;

    /*Near Absolute Addressable Data Sections*/
    GROUP LOAD(> pfls3) COPYTABLE :
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
	
	
	

    /*Near Absolute Data, selectable by toolchain*/
    GROUP LOAD(> pfls3) COPYTABLE :
    {
        .zdata (DATA) :
        {
            *(.zdata.dsprInit.cpu3.32bit)
            *(.zdata.dsprInit.cpu3.16bit)
            *(.zdata.dsprInit.cpu3.8bit)
            *(.zdata)
        }
        
        .zdata_powerOn (DATA) :
        {
            *(.zdata.dsprPowerOnInit.cpu3.32bit)
            *(.zdata.dsprPowerOnInit.cpu3.16bit)
            *(.zdata.dsprPowerOnInit.cpu3.8bit)
        }
        
        .zbss (BSS) :
        {
            *(.zbss.dsprClearOnInit.cpu3.32bit)
            *(.zbss.dsprClearOnInit.cpu3.16bit)
            *(.zbss.dsprClearOnInit.cpu3.8bit)
            *(.zbss)
        }
        
        .zbss_powerOn (BSS) :
        {
            *(.zbss.dsprPowerOnClear.cpu3.32bit)
            *(.zbss.dsprPowerOnClear.cpu3.16bit)
            *(.zbss.dsprPowerOnClear.cpu3.8bit)
        }
        
        .zbss_noClear (BSS) :
        {
            *(.zbss.dsprNoInit.cpu3.32bit)
            *(.zbss.dsprNoInit.cpu3.16bit)
            *(.zbss.dsprNoInit.cpu3.8bit)
        }
		
		
    } > dsram3

    /*Relative A0/A1/A8/A9 Addressable Sections*/
    /*Relative A0 Addressable Data, selectable with patterns and user defined sections*/
    /*Note: A0 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A0 Addressable Data, selectable by toolchain*/
    GROUP LOAD(> pfls3) COPYTABLE :
	
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
    } > dsram3

    /*Relative A1 Addressable Const, selectable with patterns and user defined sections*/
    /*Note: A1 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A1 Addressable Const, selectable by toolchain*/
    GROUP :
    {
        .zrodata (CONST) :
        {
            *Ifx_Ssw_Tc3.* (.zrodata)
            *Cpu3_Main.* (.zrodata)
            *(.zrodata.const.cpu3.32bit)
            *(.zrodata.const.cpu3.16bit)
            *(.zrodata.const.cpu3.8bit)
            *(.zrodata.config.cpu3.32bit)
            *(.zrodata.config.cpu3.16bit)
            *(.zrodata.config.cpu3.8bit)
            *(.zrodata_cpu3)
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
    } > pfls3

    /*LMU memory sections*/
    GROUP LOAD(> pfls3) COPYTABLE :
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
    /*Relative A9 Addressable Data, selectable with patterns and user defined sections*/
    GROUP LOAD(> pfls3) COPYTABLE: 
	
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
    } > cpu3_dlmu

    GROUP LOAD(> pfls3) COPYTABLE :
    {
        .lmudata (DATA) :
        {
            *(.lmudata)
        }
        
        .lmubss (BSS) :
        {
            *(.lmubss)
        }
    } > cpu3_dlmu
	
 GROUP LOAD(> pfls3) :
    {
        .ppu_lmuram  :
        {
            . = ALIGN(4);
            __PPU_LMURAM_START = .;
            . += LCF_PPU_LMURAM_SIZE;
            __PPU_LMURAM_END = .;
        }
    } > ppu_lmuram_nc
	
    GROUP LOAD(> pfls3) :
    {
        .ppu_csm :
        {
        . = ALIGN(4);
        __PPU_CSM_START = .;
        . += LCF_PPU_CSM_SIZE;
        __PPU_CSM_END = .;
        }
    } > ppu_csm_nc
    
    GROUP LOAD(> pfls3) :
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
    } > pfls3

    __A8_MEM = SIZEOF(.rodata_a8) ? ADDR(.rodata_a8) : (ADDR(.rodata_a8) & 0xF0000000) + 32k ;
    
    /*Far Data / Far Const Sections, selectable with patterns and user defined sections*/
    /*Far Data Sections, selectable with patterns and user defined sections*/
    GROUP LOAD(> pfls3) COPYTABLE :
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
    /*Far Data Sections, selectable by toolchain*/
    GROUP LOAD(> pfls3) COPYTABLE :
	
    {
        .data (DATA) :
        {
            *(.data.farDsprInit.cpu3.32bit)
            *(.data.farDsprInit.cpu3.16bit)
            *(.data.farDsprInit.cpu3.8bit)
            *(.data)
        }
        
        .bss (BSS) :
        {
            *(.bss.farDsprClearOnInit.cpu3.32bit)
            *(.bss.farDsprClearOnInit.cpu3.16bit)
            *(.bss.farDsprClearOnInit.cpu3.8bit)
            *(.bss)
        }
        
        .bss_noClear (BSS) :
        {
            *(.bss.farDsprNoInit.cpu3.32bit)
            *(.bss.farDsprNoInit.cpu3.16bit)
            *(.bss.farDsprNoInit.cpu3.8bit)
        }
        
        .heap  :
        {
            . = ALIGN(4);
            __HEAP = .;
            __HEAP_START = .;
            __HEAP_END = . + LCF_HEAP_SIZE;
        }
    } > dsram3

    /* Far Const Sections, selectable with patterns and user defined sections */
    /* CPU3 Const Sections */
    CPU3.rodata (CONST) :
    {
        "*Ifx_Ssw_Tc3.*" (.rodata)
        "*Cpu3_Main.*" (.rodata)
        *(.rodata_cpu3)
    } > pfls3
	
    /*Far Const Sections, selectable by toolchain*/
    GROUP :
    {
        .rodata (CONST) :
        {
            *(.rodata)
            *(.rodata.farConst.cpu3.32bit)
            *(.rodata.farConst.cpu3.16bit)
            *(.rodata.farConst.cpu3.8bit)
        }
        
        .copytable (CONST) :
        {
            __DATA_ROM = .;
        }
    } > pfls3

    /*Code selections*/
    /*Code Sections, selectable with patterns and user defined sections*/
    /* CPU3 Code Sections */
    CPU3.text (TEXT) :
    {
        . = ALIGN(2);
        "*Ifx_Ssw_Tc3.*" (.text)
        "*Cpu3_Main.*" (.text)
        *(.text_cpu3)
    } > pfls3
    
    CPU3.psram_text (TEXT) LOAD(> pfls3) COPYTABLE :
    {
        . = ALIGN(2);
        *(.psram_text_cpu3)
        *(.cpu3_psram)
    } > psram3
	
	

    /*Code Sections, selectable by toolchain*/
    GROUP :
    {
        .text (TEXT) :
        {
            . = ALIGN(2);
            *(.text)
            *(.text.fast.pfls.cpu3)
            *(.text.slow.pfls.cpu3)
            *(.text.5ms.pfls.cpu3)
            *(.text.10ms.pfls.cpu3)
            *(.text.callout.pfls.cpu3)
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
    } > pfls3


    /* CPU3 Interrupt Vector Table */
    .inttab_tc3_000 (TEXT) BIND(__INTTAB_CPU3 + 0x0000) : {KEEP (*(.inttab3.intvec.0  )) } > pfls3
    .inttab_tc3_001 (TEXT) BIND(__INTTAB_CPU3 + 0x0020) : {KEEP (*(.inttab3.intvec.1  )) } > pfls3
    .inttab_tc3_002 (TEXT) BIND(__INTTAB_CPU3 + 0x0040) : {KEEP (*(.inttab3.intvec.2  )) } > pfls3
    .inttab_tc3_003 (TEXT) BIND(__INTTAB_CPU3 + 0x0060) : {KEEP (*(.inttab3.intvec.3  )) } > pfls3
    .inttab_tc3_004 (TEXT) BIND(__INTTAB_CPU3 + 0x0080) : {KEEP (*(.inttab3.intvec.4  )) } > pfls3
    .inttab_tc3_005 (TEXT) BIND(__INTTAB_CPU3 + 0x00A0) : {KEEP (*(.inttab3.intvec.5  )) } > pfls3
    .inttab_tc3_006 (TEXT) BIND(__INTTAB_CPU3 + 0x00C0) : {KEEP (*(.inttab3.intvec.6  )) } > pfls3
    .inttab_tc3_007 (TEXT) BIND(__INTTAB_CPU3 + 0x00E0) : {KEEP (*(.inttab3.intvec.7  )) } > pfls3
    .inttab_tc3_008 (TEXT) BIND(__INTTAB_CPU3 + 0x0100) : {KEEP (*(.inttab3.intvec.8  )) } > pfls3
    .inttab_tc3_009 (TEXT) BIND(__INTTAB_CPU3 + 0x0120) : {KEEP (*(.inttab3.intvec.9  )) } > pfls3
    .inttab_tc3_00A (TEXT) BIND(__INTTAB_CPU3 + 0x0140) : {KEEP (*(.inttab3.intvec.10 )) } > pfls3
    .inttab_tc3_00B (TEXT) BIND(__INTTAB_CPU3 + 0x0160) : {KEEP (*(.inttab3.intvec.11 )) } > pfls3
    .inttab_tc3_00C (TEXT) BIND(__INTTAB_CPU3 + 0x0180) : {KEEP (*(.inttab3.intvec.12 )) } > pfls3
    .inttab_tc3_00D (TEXT) BIND(__INTTAB_CPU3 + 0x01A0) : {KEEP (*(.inttab3.intvec.13 )) } > pfls3
    .inttab_tc3_00E (TEXT) BIND(__INTTAB_CPU3 + 0x01C0) : {KEEP (*(.inttab3.intvec.14 )) } > pfls3
    .inttab_tc3_00F (TEXT) BIND(__INTTAB_CPU3 + 0x01E0) : {KEEP (*(.inttab3.intvec.15 )) } > pfls3
    .inttab_tc3_010 (TEXT) BIND(__INTTAB_CPU3 + 0x0200) : {KEEP (*(.inttab3.intvec.16 )) } > pfls3
    .inttab_tc3_011 (TEXT) BIND(__INTTAB_CPU3 + 0x0220) : {KEEP (*(.inttab3.intvec.17 )) } > pfls3
    .inttab_tc3_012 (TEXT) BIND(__INTTAB_CPU3 + 0x0240) : {KEEP (*(.inttab3.intvec.18 )) } > pfls3
    .inttab_tc3_013 (TEXT) BIND(__INTTAB_CPU3 + 0x0260) : {KEEP (*(.inttab3.intvec.19 )) } > pfls3
    .inttab_tc3_014 (TEXT) BIND(__INTTAB_CPU3 + 0x0280) : {KEEP (*(.inttab3.intvec.20 )) } > pfls3
    .inttab_tc3_015 (TEXT) BIND(__INTTAB_CPU3 + 0x02A0) : {KEEP (*(.inttab3.intvec.21 )) } > pfls3
    .inttab_tc3_016 (TEXT) BIND(__INTTAB_CPU3 + 0x02C0) : {KEEP (*(.inttab3.intvec.22 )) } > pfls3
    .inttab_tc3_017 (TEXT) BIND(__INTTAB_CPU3 + 0x02E0) : {KEEP (*(.inttab3.intvec.23 )) } > pfls3
    .inttab_tc3_018 (TEXT) BIND(__INTTAB_CPU3 + 0x0300) : {KEEP (*(.inttab3.intvec.24 )) } > pfls3
    .inttab_tc3_019 (TEXT) BIND(__INTTAB_CPU3 + 0x0320) : {KEEP (*(.inttab3.intvec.25 )) } > pfls3
    .inttab_tc3_01A (TEXT) BIND(__INTTAB_CPU3 + 0x0340) : {KEEP (*(.inttab3.intvec.26 )) } > pfls3
    .inttab_tc3_01B (TEXT) BIND(__INTTAB_CPU3 + 0x0360) : {KEEP (*(.inttab3.intvec.27 )) } > pfls3
    .inttab_tc3_01C (TEXT) BIND(__INTTAB_CPU3 + 0x0380) : {KEEP (*(.inttab3.intvec.28 )) } > pfls3
    .inttab_tc3_01D (TEXT) BIND(__INTTAB_CPU3 + 0x03A0) : {KEEP (*(.inttab3.intvec.29 )) } > pfls3
    .inttab_tc3_01E (TEXT) BIND(__INTTAB_CPU3 + 0x03C0) : {KEEP (*(.inttab3.intvec.30 )) } > pfls3
    .inttab_tc3_01F (TEXT) BIND(__INTTAB_CPU3 + 0x03E0) : {KEEP (*(.inttab3.intvec.31 )) } > pfls3
    .inttab_tc3_020 (TEXT) BIND(__INTTAB_CPU3 + 0x0400) : {KEEP (*(.inttab3.intvec.32 )) } > pfls3
    .inttab_tc3_021 (TEXT) BIND(__INTTAB_CPU3 + 0x0420) : {KEEP (*(.inttab3.intvec.33 )) } > pfls3
    .inttab_tc3_022 (TEXT) BIND(__INTTAB_CPU3 + 0x0440) : {KEEP (*(.inttab3.intvec.34 )) } > pfls3
    .inttab_tc3_023 (TEXT) BIND(__INTTAB_CPU3 + 0x0460) : {KEEP (*(.inttab3.intvec.35 )) } > pfls3
    .inttab_tc3_024 (TEXT) BIND(__INTTAB_CPU3 + 0x0480) : {KEEP (*(.inttab3.intvec.36 )) } > pfls3
    .inttab_tc3_025 (TEXT) BIND(__INTTAB_CPU3 + 0x04A0) : {KEEP (*(.inttab3.intvec.37 )) } > pfls3
    .inttab_tc3_026 (TEXT) BIND(__INTTAB_CPU3 + 0x04C0) : {KEEP (*(.inttab3.intvec.38 )) } > pfls3
    .inttab_tc3_027 (TEXT) BIND(__INTTAB_CPU3 + 0x04E0) : {KEEP (*(.inttab3.intvec.39 )) } > pfls3
    .inttab_tc3_028 (TEXT) BIND(__INTTAB_CPU3 + 0x0500) : {KEEP (*(.inttab3.intvec.40 )) } > pfls3
    .inttab_tc3_029 (TEXT) BIND(__INTTAB_CPU3 + 0x0520) : {KEEP (*(.inttab3.intvec.41 )) } > pfls3
    .inttab_tc3_02A (TEXT) BIND(__INTTAB_CPU3 + 0x0540) : {KEEP (*(.inttab3.intvec.42 )) } > pfls3
    .inttab_tc3_02B (TEXT) BIND(__INTTAB_CPU3 + 0x0560) : {KEEP (*(.inttab3.intvec.43 )) } > pfls3
    .inttab_tc3_02C (TEXT) BIND(__INTTAB_CPU3 + 0x0580) : {KEEP (*(.inttab3.intvec.44 )) } > pfls3
    .inttab_tc3_02D (TEXT) BIND(__INTTAB_CPU3 + 0x05A0) : {KEEP (*(.inttab3.intvec.45 )) } > pfls3
    .inttab_tc3_02E (TEXT) BIND(__INTTAB_CPU3 + 0x05C0) : {KEEP (*(.inttab3.intvec.46 )) } > pfls3
    .inttab_tc3_02F (TEXT) BIND(__INTTAB_CPU3 + 0x05E0) : {KEEP (*(.inttab3.intvec.47 )) } > pfls3
    .inttab_tc3_030 (TEXT) BIND(__INTTAB_CPU3 + 0x0600) : {KEEP (*(.inttab3.intvec.48 )) } > pfls3
    .inttab_tc3_031 (TEXT) BIND(__INTTAB_CPU3 + 0x0620) : {KEEP (*(.inttab3.intvec.49 )) } > pfls3
    .inttab_tc3_032 (TEXT) BIND(__INTTAB_CPU3 + 0x0640) : {KEEP (*(.inttab3.intvec.50 )) } > pfls3
    .inttab_tc3_033 (TEXT) BIND(__INTTAB_CPU3 + 0x0660) : {KEEP (*(.inttab3.intvec.51 )) } > pfls3
    .inttab_tc3_034 (TEXT) BIND(__INTTAB_CPU3 + 0x0680) : {KEEP (*(.inttab3.intvec.52 )) } > pfls3
    .inttab_tc3_035 (TEXT) BIND(__INTTAB_CPU3 + 0x06A0) : {KEEP (*(.inttab3.intvec.53 )) } > pfls3
    .inttab_tc3_036 (TEXT) BIND(__INTTAB_CPU3 + 0x06C0) : {KEEP (*(.inttab3.intvec.54 )) } > pfls3
    .inttab_tc3_037 (TEXT) BIND(__INTTAB_CPU3 + 0x06E0) : {KEEP (*(.inttab3.intvec.55 )) } > pfls3
    .inttab_tc3_038 (TEXT) BIND(__INTTAB_CPU3 + 0x0700) : {KEEP (*(.inttab3.intvec.56 )) } > pfls3
    .inttab_tc3_039 (TEXT) BIND(__INTTAB_CPU3 + 0x0720) : {KEEP (*(.inttab3.intvec.57 )) } > pfls3
    .inttab_tc3_03A (TEXT) BIND(__INTTAB_CPU3 + 0x0740) : {KEEP (*(.inttab3.intvec.58 )) } > pfls3
    .inttab_tc3_03B (TEXT) BIND(__INTTAB_CPU3 + 0x0760) : {KEEP (*(.inttab3.intvec.59 )) } > pfls3
    .inttab_tc3_03C (TEXT) BIND(__INTTAB_CPU3 + 0x0780) : {KEEP (*(.inttab3.intvec.60 )) } > pfls3
    .inttab_tc3_03D (TEXT) BIND(__INTTAB_CPU3 + 0x07A0) : {KEEP (*(.inttab3.intvec.61 )) } > pfls3
    .inttab_tc3_03E (TEXT) BIND(__INTTAB_CPU3 + 0x07C0) : {KEEP (*(.inttab3.intvec.62 )) } > pfls3
    .inttab_tc3_03F (TEXT) BIND(__INTTAB_CPU3 + 0x07E0) : {KEEP (*(.inttab3.intvec.63 )) } > pfls3
    .inttab_tc3_040 (TEXT) BIND(__INTTAB_CPU3 + 0x0800) : {KEEP (*(.inttab3.intvec.64 )) } > pfls3
    .inttab_tc3_041 (TEXT) BIND(__INTTAB_CPU3 + 0x0820) : {KEEP (*(.inttab3.intvec.65 )) } > pfls3
    .inttab_tc3_042 (TEXT) BIND(__INTTAB_CPU3 + 0x0840) : {KEEP (*(.inttab3.intvec.66 )) } > pfls3
    .inttab_tc3_043 (TEXT) BIND(__INTTAB_CPU3 + 0x0860) : {KEEP (*(.inttab3.intvec.67 )) } > pfls3
    .inttab_tc3_044 (TEXT) BIND(__INTTAB_CPU3 + 0x0880) : {KEEP (*(.inttab3.intvec.68 )) } > pfls3
    .inttab_tc3_045 (TEXT) BIND(__INTTAB_CPU3 + 0x08A0) : {KEEP (*(.inttab3.intvec.69 )) } > pfls3
    .inttab_tc3_046 (TEXT) BIND(__INTTAB_CPU3 + 0x08C0) : {KEEP (*(.inttab3.intvec.70 )) } > pfls3
    .inttab_tc3_047 (TEXT) BIND(__INTTAB_CPU3 + 0x08E0) : {KEEP (*(.inttab3.intvec.71 )) } > pfls3
    .inttab_tc3_048 (TEXT) BIND(__INTTAB_CPU3 + 0x0900) : {KEEP (*(.inttab3.intvec.72 )) } > pfls3
    .inttab_tc3_049 (TEXT) BIND(__INTTAB_CPU3 + 0x0920) : {KEEP (*(.inttab3.intvec.73 )) } > pfls3
    .inttab_tc3_04A (TEXT) BIND(__INTTAB_CPU3 + 0x0940) : {KEEP (*(.inttab3.intvec.74 )) } > pfls3
    .inttab_tc3_04B (TEXT) BIND(__INTTAB_CPU3 + 0x0960) : {KEEP (*(.inttab3.intvec.75 )) } > pfls3
    .inttab_tc3_04C (TEXT) BIND(__INTTAB_CPU3 + 0x0980) : {KEEP (*(.inttab3.intvec.76 )) } > pfls3
    .inttab_tc3_04D (TEXT) BIND(__INTTAB_CPU3 + 0x09A0) : {KEEP (*(.inttab3.intvec.77 )) } > pfls3
    .inttab_tc3_04E (TEXT) BIND(__INTTAB_CPU3 + 0x09C0) : {KEEP (*(.inttab3.intvec.78 )) } > pfls3
    .inttab_tc3_04F (TEXT) BIND(__INTTAB_CPU3 + 0x09E0) : {KEEP (*(.inttab3.intvec.79 )) } > pfls3
    .inttab_tc3_050 (TEXT) BIND(__INTTAB_CPU3 + 0x0A00) : {KEEP (*(.inttab3.intvec.80 )) } > pfls3
    .inttab_tc3_051 (TEXT) BIND(__INTTAB_CPU3 + 0x0A20) : {KEEP (*(.inttab3.intvec.81 )) } > pfls3
    .inttab_tc3_052 (TEXT) BIND(__INTTAB_CPU3 + 0x0A40) : {KEEP (*(.inttab3.intvec.82 )) } > pfls3
    .inttab_tc3_053 (TEXT) BIND(__INTTAB_CPU3 + 0x0A60) : {KEEP (*(.inttab3.intvec.83 )) } > pfls3
    .inttab_tc3_054 (TEXT) BIND(__INTTAB_CPU3 + 0x0A80) : {KEEP (*(.inttab3.intvec.84 )) } > pfls3
    .inttab_tc3_055 (TEXT) BIND(__INTTAB_CPU3 + 0x0AA0) : {KEEP (*(.inttab3.intvec.85 )) } > pfls3
    .inttab_tc3_056 (TEXT) BIND(__INTTAB_CPU3 + 0x0AC0) : {KEEP (*(.inttab3.intvec.86 )) } > pfls3
    .inttab_tc3_057 (TEXT) BIND(__INTTAB_CPU3 + 0x0AE0) : {KEEP (*(.inttab3.intvec.87 )) } > pfls3
    .inttab_tc3_058 (TEXT) BIND(__INTTAB_CPU3 + 0x0B00) : {KEEP (*(.inttab3.intvec.88 )) } > pfls3
    .inttab_tc3_059 (TEXT) BIND(__INTTAB_CPU3 + 0x0B20) : {KEEP (*(.inttab3.intvec.89 )) } > pfls3
    .inttab_tc3_05A (TEXT) BIND(__INTTAB_CPU3 + 0x0B40) : {KEEP (*(.inttab3.intvec.90 )) } > pfls3
    .inttab_tc3_05B (TEXT) BIND(__INTTAB_CPU3 + 0x0B60) : {KEEP (*(.inttab3.intvec.91 )) } > pfls3
    .inttab_tc3_05C (TEXT) BIND(__INTTAB_CPU3 + 0x0B80) : {KEEP (*(.inttab3.intvec.92 )) } > pfls3
    .inttab_tc3_05D (TEXT) BIND(__INTTAB_CPU3 + 0x0BA0) : {KEEP (*(.inttab3.intvec.93 )) } > pfls3
    .inttab_tc3_05E (TEXT) BIND(__INTTAB_CPU3 + 0x0BC0) : {KEEP (*(.inttab3.intvec.94 )) } > pfls3
    .inttab_tc3_05F (TEXT) BIND(__INTTAB_CPU3 + 0x0BE0) : {KEEP (*(.inttab3.intvec.95 )) } > pfls3
    .inttab_tc3_060 (TEXT) BIND(__INTTAB_CPU3 + 0x0C00) : {KEEP (*(.inttab3.intvec.96 )) } > pfls3
    .inttab_tc3_061 (TEXT) BIND(__INTTAB_CPU3 + 0x0C20) : {KEEP (*(.inttab3.intvec.97 )) } > pfls3
    .inttab_tc3_062 (TEXT) BIND(__INTTAB_CPU3 + 0x0C40) : {KEEP (*(.inttab3.intvec.98 )) } > pfls3
    .inttab_tc3_063 (TEXT) BIND(__INTTAB_CPU3 + 0x0C60) : {KEEP (*(.inttab3.intvec.99 )) } > pfls3
    .inttab_tc3_064 (TEXT) BIND(__INTTAB_CPU3 + 0x0C80) : {KEEP (*(.inttab3.intvec.100)) } > pfls3
    .inttab_tc3_065 (TEXT) BIND(__INTTAB_CPU3 + 0x0CA0) : {KEEP (*(.inttab3.intvec.101)) } > pfls3
    .inttab_tc3_066 (TEXT) BIND(__INTTAB_CPU3 + 0x0CC0) : {KEEP (*(.inttab3.intvec.102)) } > pfls3
    .inttab_tc3_067 (TEXT) BIND(__INTTAB_CPU3 + 0x0CE0) : {KEEP (*(.inttab3.intvec.103)) } > pfls3
    .inttab_tc3_068 (TEXT) BIND(__INTTAB_CPU3 + 0x0D00) : {KEEP (*(.inttab3.intvec.104)) } > pfls3
    .inttab_tc3_069 (TEXT) BIND(__INTTAB_CPU3 + 0x0D20) : {KEEP (*(.inttab3.intvec.105)) } > pfls3
    .inttab_tc3_06A (TEXT) BIND(__INTTAB_CPU3 + 0x0D40) : {KEEP (*(.inttab3.intvec.106)) } > pfls3
    .inttab_tc3_06B (TEXT) BIND(__INTTAB_CPU3 + 0x0D60) : {KEEP (*(.inttab3.intvec.107)) } > pfls3
    .inttab_tc3_06C (TEXT) BIND(__INTTAB_CPU3 + 0x0D80) : {KEEP (*(.inttab3.intvec.108)) } > pfls3
    .inttab_tc3_06D (TEXT) BIND(__INTTAB_CPU3 + 0x0DA0) : {KEEP (*(.inttab3.intvec.109)) } > pfls3
    .inttab_tc3_06E (TEXT) BIND(__INTTAB_CPU3 + 0x0DC0) : {KEEP (*(.inttab3.intvec.110)) } > pfls3
    .inttab_tc3_06F (TEXT) BIND(__INTTAB_CPU3 + 0x0DE0) : {KEEP (*(.inttab3.intvec.111)) } > pfls3
    .inttab_tc3_070 (TEXT) BIND(__INTTAB_CPU3 + 0x0E00) : {KEEP (*(.inttab3.intvec.112)) } > pfls3
    .inttab_tc3_071 (TEXT) BIND(__INTTAB_CPU3 + 0x0E20) : {KEEP (*(.inttab3.intvec.113)) } > pfls3
    .inttab_tc3_072 (TEXT) BIND(__INTTAB_CPU3 + 0x0E40) : {KEEP (*(.inttab3.intvec.114)) } > pfls3
    .inttab_tc3_073 (TEXT) BIND(__INTTAB_CPU3 + 0x0E60) : {KEEP (*(.inttab3.intvec.115)) } > pfls3
    .inttab_tc3_074 (TEXT) BIND(__INTTAB_CPU3 + 0x0E80) : {KEEP (*(.inttab3.intvec.116)) } > pfls3
    .inttab_tc3_075 (TEXT) BIND(__INTTAB_CPU3 + 0x0EA0) : {KEEP (*(.inttab3.intvec.117)) } > pfls3
    .inttab_tc3_076 (TEXT) BIND(__INTTAB_CPU3 + 0x0EC0) : {KEEP (*(.inttab3.intvec.118)) } > pfls3
    .inttab_tc3_077 (TEXT) BIND(__INTTAB_CPU3 + 0x0EE0) : {KEEP (*(.inttab3.intvec.119)) } > pfls3
    .inttab_tc3_078 (TEXT) BIND(__INTTAB_CPU3 + 0x0F00) : {KEEP (*(.inttab3.intvec.120)) } > pfls3
    .inttab_tc3_079 (TEXT) BIND(__INTTAB_CPU3 + 0x0F20) : {KEEP (*(.inttab3.intvec.121)) } > pfls3
    .inttab_tc3_07A (TEXT) BIND(__INTTAB_CPU3 + 0x0F40) : {KEEP (*(.inttab3.intvec.122)) } > pfls3
    .inttab_tc3_07B (TEXT) BIND(__INTTAB_CPU3 + 0x0F60) : {KEEP (*(.inttab3.intvec.123)) } > pfls3
    .inttab_tc3_07C (TEXT) BIND(__INTTAB_CPU3 + 0x0F80) : {KEEP (*(.inttab3.intvec.124)) } > pfls3
    .inttab_tc3_07D (TEXT) BIND(__INTTAB_CPU3 + 0x0FA0) : {KEEP (*(.inttab3.intvec.125)) } > pfls3
    .inttab_tc3_07E (TEXT) BIND(__INTTAB_CPU3 + 0x0FC0) : {KEEP (*(.inttab3.intvec.126)) } > pfls3
    .inttab_tc3_07F (TEXT) BIND(__INTTAB_CPU3 + 0x0FE0) : {KEEP (*(.inttab3.intvec.127)) } > pfls3
    .inttab_tc3_080 (TEXT) BIND(__INTTAB_CPU3 + 0x1000) : {KEEP (*(.inttab3.intvec.128)) } > pfls3
    .inttab_tc3_081 (TEXT) BIND(__INTTAB_CPU3 + 0x1020) : {KEEP (*(.inttab3.intvec.129)) } > pfls3
    .inttab_tc3_082 (TEXT) BIND(__INTTAB_CPU3 + 0x1040) : {KEEP (*(.inttab3.intvec.130)) } > pfls3
    .inttab_tc3_083 (TEXT) BIND(__INTTAB_CPU3 + 0x1060) : {KEEP (*(.inttab3.intvec.131)) } > pfls3
    .inttab_tc3_084 (TEXT) BIND(__INTTAB_CPU3 + 0x1080) : {KEEP (*(.inttab3.intvec.132)) } > pfls3
    .inttab_tc3_085 (TEXT) BIND(__INTTAB_CPU3 + 0x10A0) : {KEEP (*(.inttab3.intvec.133)) } > pfls3
    .inttab_tc3_086 (TEXT) BIND(__INTTAB_CPU3 + 0x10C0) : {KEEP (*(.inttab3.intvec.134)) } > pfls3
    .inttab_tc3_087 (TEXT) BIND(__INTTAB_CPU3 + 0x10E0) : {KEEP (*(.inttab3.intvec.135)) } > pfls3
    .inttab_tc3_088 (TEXT) BIND(__INTTAB_CPU3 + 0x1100) : {KEEP (*(.inttab3.intvec.136)) } > pfls3
    .inttab_tc3_089 (TEXT) BIND(__INTTAB_CPU3 + 0x1120) : {KEEP (*(.inttab3.intvec.137)) } > pfls3
    .inttab_tc3_08A (TEXT) BIND(__INTTAB_CPU3 + 0x1140) : {KEEP (*(.inttab3.intvec.138)) } > pfls3
    .inttab_tc3_08B (TEXT) BIND(__INTTAB_CPU3 + 0x1160) : {KEEP (*(.inttab3.intvec.139)) } > pfls3
    .inttab_tc3_08C (TEXT) BIND(__INTTAB_CPU3 + 0x1180) : {KEEP (*(.inttab3.intvec.140)) } > pfls3
    .inttab_tc3_08D (TEXT) BIND(__INTTAB_CPU3 + 0x11A0) : {KEEP (*(.inttab3.intvec.141)) } > pfls3
    .inttab_tc3_08E (TEXT) BIND(__INTTAB_CPU3 + 0x11C0) : {KEEP (*(.inttab3.intvec.142)) } > pfls3
    .inttab_tc3_08F (TEXT) BIND(__INTTAB_CPU3 + 0x11E0) : {KEEP (*(.inttab3.intvec.143)) } > pfls3
    .inttab_tc3_090 (TEXT) BIND(__INTTAB_CPU3 + 0x1200) : {KEEP (*(.inttab3.intvec.144)) } > pfls3
    .inttab_tc3_091 (TEXT) BIND(__INTTAB_CPU3 + 0x1220) : {KEEP (*(.inttab3.intvec.145)) } > pfls3
    .inttab_tc3_092 (TEXT) BIND(__INTTAB_CPU3 + 0x1240) : {KEEP (*(.inttab3.intvec.146)) } > pfls3
    .inttab_tc3_093 (TEXT) BIND(__INTTAB_CPU3 + 0x1260) : {KEEP (*(.inttab3.intvec.147)) } > pfls3
    .inttab_tc3_094 (TEXT) BIND(__INTTAB_CPU3 + 0x1280) : {KEEP (*(.inttab3.intvec.148)) } > pfls3
    .inttab_tc3_095 (TEXT) BIND(__INTTAB_CPU3 + 0x12A0) : {KEEP (*(.inttab3.intvec.149)) } > pfls3
    .inttab_tc3_096 (TEXT) BIND(__INTTAB_CPU3 + 0x12C0) : {KEEP (*(.inttab3.intvec.150)) } > pfls3
    .inttab_tc3_097 (TEXT) BIND(__INTTAB_CPU3 + 0x12E0) : {KEEP (*(.inttab3.intvec.151)) } > pfls3
    .inttab_tc3_098 (TEXT) BIND(__INTTAB_CPU3 + 0x1300) : {KEEP (*(.inttab3.intvec.152)) } > pfls3
    .inttab_tc3_099 (TEXT) BIND(__INTTAB_CPU3 + 0x1320) : {KEEP (*(.inttab3.intvec.153)) } > pfls3
    .inttab_tc3_09A (TEXT) BIND(__INTTAB_CPU3 + 0x1340) : {KEEP (*(.inttab3.intvec.154)) } > pfls3
    .inttab_tc3_09B (TEXT) BIND(__INTTAB_CPU3 + 0x1360) : {KEEP (*(.inttab3.intvec.155)) } > pfls3
    .inttab_tc3_09C (TEXT) BIND(__INTTAB_CPU3 + 0x1380) : {KEEP (*(.inttab3.intvec.156)) } > pfls3
    .inttab_tc3_09D (TEXT) BIND(__INTTAB_CPU3 + 0x13A0) : {KEEP (*(.inttab3.intvec.157)) } > pfls3
    .inttab_tc3_09E (TEXT) BIND(__INTTAB_CPU3 + 0x13C0) : {KEEP (*(.inttab3.intvec.158)) } > pfls3
    .inttab_tc3_09F (TEXT) BIND(__INTTAB_CPU3 + 0x13E0) : {KEEP (*(.inttab3.intvec.159)) } > pfls3
    .inttab_tc3_0A0 (TEXT) BIND(__INTTAB_CPU3 + 0x1400) : {KEEP (*(.inttab3.intvec.160)) } > pfls3
    .inttab_tc3_0A1 (TEXT) BIND(__INTTAB_CPU3 + 0x1420) : {KEEP (*(.inttab3.intvec.161)) } > pfls3
    .inttab_tc3_0A2 (TEXT) BIND(__INTTAB_CPU3 + 0x1440) : {KEEP (*(.inttab3.intvec.162)) } > pfls3
    .inttab_tc3_0A3 (TEXT) BIND(__INTTAB_CPU3 + 0x1460) : {KEEP (*(.inttab3.intvec.163)) } > pfls3
    .inttab_tc3_0A4 (TEXT) BIND(__INTTAB_CPU3 + 0x1480) : {KEEP (*(.inttab3.intvec.164)) } > pfls3
    .inttab_tc3_0A5 (TEXT) BIND(__INTTAB_CPU3 + 0x14A0) : {KEEP (*(.inttab3.intvec.165)) } > pfls3
    .inttab_tc3_0A6 (TEXT) BIND(__INTTAB_CPU3 + 0x14C0) : {KEEP (*(.inttab3.intvec.166)) } > pfls3
    .inttab_tc3_0A7 (TEXT) BIND(__INTTAB_CPU3 + 0x14E0) : {KEEP (*(.inttab3.intvec.167)) } > pfls3
    .inttab_tc3_0A8 (TEXT) BIND(__INTTAB_CPU3 + 0x1500) : {KEEP (*(.inttab3.intvec.168)) } > pfls3
    .inttab_tc3_0A9 (TEXT) BIND(__INTTAB_CPU3 + 0x1520) : {KEEP (*(.inttab3.intvec.169)) } > pfls3
    .inttab_tc3_0AA (TEXT) BIND(__INTTAB_CPU3 + 0x1540) : {KEEP (*(.inttab3.intvec.170)) } > pfls3
    .inttab_tc3_0AB (TEXT) BIND(__INTTAB_CPU3 + 0x1560) : {KEEP (*(.inttab3.intvec.171)) } > pfls3
    .inttab_tc3_0AC (TEXT) BIND(__INTTAB_CPU3 + 0x1580) : {KEEP (*(.inttab3.intvec.172)) } > pfls3
    .inttab_tc3_0AD (TEXT) BIND(__INTTAB_CPU3 + 0x15A0) : {KEEP (*(.inttab3.intvec.173)) } > pfls3
    .inttab_tc3_0AE (TEXT) BIND(__INTTAB_CPU3 + 0x15C0) : {KEEP (*(.inttab3.intvec.174)) } > pfls3
    .inttab_tc3_0AF (TEXT) BIND(__INTTAB_CPU3 + 0x15E0) : {KEEP (*(.inttab3.intvec.175)) } > pfls3
    .inttab_tc3_0B0 (TEXT) BIND(__INTTAB_CPU3 + 0x1600) : {KEEP (*(.inttab3.intvec.176)) } > pfls3
    .inttab_tc3_0B1 (TEXT) BIND(__INTTAB_CPU3 + 0x1620) : {KEEP (*(.inttab3.intvec.177)) } > pfls3
    .inttab_tc3_0B2 (TEXT) BIND(__INTTAB_CPU3 + 0x1640) : {KEEP (*(.inttab3.intvec.178)) } > pfls3
    .inttab_tc3_0B3 (TEXT) BIND(__INTTAB_CPU3 + 0x1660) : {KEEP (*(.inttab3.intvec.179)) } > pfls3
    .inttab_tc3_0B4 (TEXT) BIND(__INTTAB_CPU3 + 0x1680) : {KEEP (*(.inttab3.intvec.180)) } > pfls3
    .inttab_tc3_0B5 (TEXT) BIND(__INTTAB_CPU3 + 0x16A0) : {KEEP (*(.inttab3.intvec.181)) } > pfls3
    .inttab_tc3_0B6 (TEXT) BIND(__INTTAB_CPU3 + 0x16C0) : {KEEP (*(.inttab3.intvec.182)) } > pfls3
    .inttab_tc3_0B7 (TEXT) BIND(__INTTAB_CPU3 + 0x16E0) : {KEEP (*(.inttab3.intvec.183)) } > pfls3
    .inttab_tc3_0B8 (TEXT) BIND(__INTTAB_CPU3 + 0x1700) : {KEEP (*(.inttab3.intvec.184)) } > pfls3
    .inttab_tc3_0B9 (TEXT) BIND(__INTTAB_CPU3 + 0x1720) : {KEEP (*(.inttab3.intvec.185)) } > pfls3
    .inttab_tc3_0BA (TEXT) BIND(__INTTAB_CPU3 + 0x1740) : {KEEP (*(.inttab3.intvec.186)) } > pfls3
    .inttab_tc3_0BB (TEXT) BIND(__INTTAB_CPU3 + 0x1760) : {KEEP (*(.inttab3.intvec.187)) } > pfls3
    .inttab_tc3_0BC (TEXT) BIND(__INTTAB_CPU3 + 0x1780) : {KEEP (*(.inttab3.intvec.188)) } > pfls3
    .inttab_tc3_0BD (TEXT) BIND(__INTTAB_CPU3 + 0x17A0) : {KEEP (*(.inttab3.intvec.189)) } > pfls3
    .inttab_tc3_0BE (TEXT) BIND(__INTTAB_CPU3 + 0x17C0) : {KEEP (*(.inttab3.intvec.190)) } > pfls3
    .inttab_tc3_0BF (TEXT) BIND(__INTTAB_CPU3 + 0x17E0) : {KEEP (*(.inttab3.intvec.191)) } > pfls3
    .inttab_tc3_0C0 (TEXT) BIND(__INTTAB_CPU3 + 0x1800) : {KEEP (*(.inttab3.intvec.192)) } > pfls3
    .inttab_tc3_0C1 (TEXT) BIND(__INTTAB_CPU3 + 0x1820) : {KEEP (*(.inttab3.intvec.193)) } > pfls3
    .inttab_tc3_0C2 (TEXT) BIND(__INTTAB_CPU3 + 0x1840) : {KEEP (*(.inttab3.intvec.194)) } > pfls3
    .inttab_tc3_0C3 (TEXT) BIND(__INTTAB_CPU3 + 0x1860) : {KEEP (*(.inttab3.intvec.195)) } > pfls3
    .inttab_tc3_0C4 (TEXT) BIND(__INTTAB_CPU3 + 0x1880) : {KEEP (*(.inttab3.intvec.196)) } > pfls3
    .inttab_tc3_0C5 (TEXT) BIND(__INTTAB_CPU3 + 0x18A0) : {KEEP (*(.inttab3.intvec.197)) } > pfls3
    .inttab_tc3_0C6 (TEXT) BIND(__INTTAB_CPU3 + 0x18C0) : {KEEP (*(.inttab3.intvec.198)) } > pfls3
    .inttab_tc3_0C7 (TEXT) BIND(__INTTAB_CPU3 + 0x18E0) : {KEEP (*(.inttab3.intvec.199)) } > pfls3
    .inttab_tc3_0C8 (TEXT) BIND(__INTTAB_CPU3 + 0x1900) : {KEEP (*(.inttab3.intvec.200)) } > pfls3
    .inttab_tc3_0C9 (TEXT) BIND(__INTTAB_CPU3 + 0x1920) : {KEEP (*(.inttab3.intvec.201)) } > pfls3
    .inttab_tc3_0CA (TEXT) BIND(__INTTAB_CPU3 + 0x1940) : {KEEP (*(.inttab3.intvec.202)) } > pfls3
    .inttab_tc3_0CB (TEXT) BIND(__INTTAB_CPU3 + 0x1960) : {KEEP (*(.inttab3.intvec.203)) } > pfls3
    .inttab_tc3_0CC (TEXT) BIND(__INTTAB_CPU3 + 0x1980) : {KEEP (*(.inttab3.intvec.204)) } > pfls3
    .inttab_tc3_0CD (TEXT) BIND(__INTTAB_CPU3 + 0x19A0) : {KEEP (*(.inttab3.intvec.205)) } > pfls3
    .inttab_tc3_0CE (TEXT) BIND(__INTTAB_CPU3 + 0x19C0) : {KEEP (*(.inttab3.intvec.206)) } > pfls3
    .inttab_tc3_0CF (TEXT) BIND(__INTTAB_CPU3 + 0x19E0) : {KEEP (*(.inttab3.intvec.207)) } > pfls3
    .inttab_tc3_0D0 (TEXT) BIND(__INTTAB_CPU3 + 0x1A00) : {KEEP (*(.inttab3.intvec.208)) } > pfls3
    .inttab_tc3_0D1 (TEXT) BIND(__INTTAB_CPU3 + 0x1A20) : {KEEP (*(.inttab3.intvec.209)) } > pfls3
    .inttab_tc3_0D2 (TEXT) BIND(__INTTAB_CPU3 + 0x1A40) : {KEEP (*(.inttab3.intvec.210)) } > pfls3
    .inttab_tc3_0D3 (TEXT) BIND(__INTTAB_CPU3 + 0x1A60) : {KEEP (*(.inttab3.intvec.211)) } > pfls3
    .inttab_tc3_0D4 (TEXT) BIND(__INTTAB_CPU3 + 0x1A80) : {KEEP (*(.inttab3.intvec.212)) } > pfls3
    .inttab_tc3_0D5 (TEXT) BIND(__INTTAB_CPU3 + 0x1AA0) : {KEEP (*(.inttab3.intvec.213)) } > pfls3
    .inttab_tc3_0D6 (TEXT) BIND(__INTTAB_CPU3 + 0x1AC0) : {KEEP (*(.inttab3.intvec.214)) } > pfls3
    .inttab_tc3_0D7 (TEXT) BIND(__INTTAB_CPU3 + 0x1AE0) : {KEEP (*(.inttab3.intvec.215)) } > pfls3
    .inttab_tc3_0D8 (TEXT) BIND(__INTTAB_CPU3 + 0x1B00) : {KEEP (*(.inttab3.intvec.216)) } > pfls3
    .inttab_tc3_0D9 (TEXT) BIND(__INTTAB_CPU3 + 0x1B20) : {KEEP (*(.inttab3.intvec.217)) } > pfls3
    .inttab_tc3_0DA (TEXT) BIND(__INTTAB_CPU3 + 0x1B40) : {KEEP (*(.inttab3.intvec.218)) } > pfls3
    .inttab_tc3_0DB (TEXT) BIND(__INTTAB_CPU3 + 0x1B60) : {KEEP (*(.inttab3.intvec.219)) } > pfls3
    .inttab_tc3_0DC (TEXT) BIND(__INTTAB_CPU3 + 0x1B80) : {KEEP (*(.inttab3.intvec.220)) } > pfls3
    .inttab_tc3_0DD (TEXT) BIND(__INTTAB_CPU3 + 0x1BA0) : {KEEP (*(.inttab3.intvec.221)) } > pfls3
    .inttab_tc3_0DE (TEXT) BIND(__INTTAB_CPU3 + 0x1BC0) : {KEEP (*(.inttab3.intvec.222)) } > pfls3
    .inttab_tc3_0DF (TEXT) BIND(__INTTAB_CPU3 + 0x1BE0) : {KEEP (*(.inttab3.intvec.223)) } > pfls3
    .inttab_tc3_0E0 (TEXT) BIND(__INTTAB_CPU3 + 0x1C00) : {KEEP (*(.inttab3.intvec.224)) } > pfls3
    .inttab_tc3_0E1 (TEXT) BIND(__INTTAB_CPU3 + 0x1C20) : {KEEP (*(.inttab3.intvec.225)) } > pfls3
    .inttab_tc3_0E2 (TEXT) BIND(__INTTAB_CPU3 + 0x1C40) : {KEEP (*(.inttab3.intvec.226)) } > pfls3
    .inttab_tc3_0E3 (TEXT) BIND(__INTTAB_CPU3 + 0x1C60) : {KEEP (*(.inttab3.intvec.227)) } > pfls3
    .inttab_tc3_0E4 (TEXT) BIND(__INTTAB_CPU3 + 0x1C80) : {KEEP (*(.inttab3.intvec.228)) } > pfls3
    .inttab_tc3_0E5 (TEXT) BIND(__INTTAB_CPU3 + 0x1CA0) : {KEEP (*(.inttab3.intvec.229)) } > pfls3
    .inttab_tc3_0E6 (TEXT) BIND(__INTTAB_CPU3 + 0x1CC0) : {KEEP (*(.inttab3.intvec.230)) } > pfls3
    .inttab_tc3_0E7 (TEXT) BIND(__INTTAB_CPU3 + 0x1CE0) : {KEEP (*(.inttab3.intvec.231)) } > pfls3
    .inttab_tc3_0E8 (TEXT) BIND(__INTTAB_CPU3 + 0x1D00) : {KEEP (*(.inttab3.intvec.232)) } > pfls3
    .inttab_tc3_0E9 (TEXT) BIND(__INTTAB_CPU3 + 0x1D20) : {KEEP (*(.inttab3.intvec.233)) } > pfls3
    .inttab_tc3_0EA (TEXT) BIND(__INTTAB_CPU3 + 0x1D40) : {KEEP (*(.inttab3.intvec.234)) } > pfls3
    .inttab_tc3_0EB (TEXT) BIND(__INTTAB_CPU3 + 0x1D60) : {KEEP (*(.inttab3.intvec.235)) } > pfls3
    .inttab_tc3_0EC (TEXT) BIND(__INTTAB_CPU3 + 0x1D80) : {KEEP (*(.inttab3.intvec.236)) } > pfls3
    .inttab_tc3_0ED (TEXT) BIND(__INTTAB_CPU3 + 0x1DA0) : {KEEP (*(.inttab3.intvec.237)) } > pfls3
    .inttab_tc3_0EE (TEXT) BIND(__INTTAB_CPU3 + 0x1DC0) : {KEEP (*(.inttab3.intvec.238)) } > pfls3
    .inttab_tc3_0EF (TEXT) BIND(__INTTAB_CPU3 + 0x1DE0) : {KEEP (*(.inttab3.intvec.239)) } > pfls3
    .inttab_tc3_0F0 (TEXT) BIND(__INTTAB_CPU3 + 0x1E00) : {KEEP (*(.inttab3.intvec.240)) } > pfls3
    .inttab_tc3_0F1 (TEXT) BIND(__INTTAB_CPU3 + 0x1E20) : {KEEP (*(.inttab3.intvec.241)) } > pfls3
    .inttab_tc3_0F2 (TEXT) BIND(__INTTAB_CPU3 + 0x1E40) : {KEEP (*(.inttab3.intvec.242)) } > pfls3
    .inttab_tc3_0F3 (TEXT) BIND(__INTTAB_CPU3 + 0x1E60) : {KEEP (*(.inttab3.intvec.243)) } > pfls3
    .inttab_tc3_0F4 (TEXT) BIND(__INTTAB_CPU3 + 0x1E80) : {KEEP (*(.inttab3.intvec.244)) } > pfls3
    .inttab_tc3_0F5 (TEXT) BIND(__INTTAB_CPU3 + 0x1EA0) : {KEEP (*(.inttab3.intvec.245)) } > pfls3
    .inttab_tc3_0F6 (TEXT) BIND(__INTTAB_CPU3 + 0x1EC0) : {KEEP (*(.inttab3.intvec.246)) } > pfls3
    .inttab_tc3_0F7 (TEXT) BIND(__INTTAB_CPU3 + 0x1EE0) : {KEEP (*(.inttab3.intvec.247)) } > pfls3
    .inttab_tc3_0F8 (TEXT) BIND(__INTTAB_CPU3 + 0x1F00) : {KEEP (*(.inttab3.intvec.248)) } > pfls3
    .inttab_tc3_0F9 (TEXT) BIND(__INTTAB_CPU3 + 0x1F20) : {KEEP (*(.inttab3.intvec.249)) } > pfls3
    .inttab_tc3_0FA (TEXT) BIND(__INTTAB_CPU3 + 0x1F40) : {KEEP (*(.inttab3.intvec.250)) } > pfls3
    .inttab_tc3_0FB (TEXT) BIND(__INTTAB_CPU3 + 0x1F60) : {KEEP (*(.inttab3.intvec.251)) } > pfls3
    .inttab_tc3_0FC (TEXT) BIND(__INTTAB_CPU3 + 0x1F80) : {KEEP (*(.inttab3.intvec.252)) } > pfls3
    .inttab_tc3_0FD (TEXT) BIND(__INTTAB_CPU3 + 0x1FA0) : {KEEP (*(.inttab3.intvec.253)) } > pfls3
    .inttab_tc3_0FE (TEXT) BIND(__INTTAB_CPU3 + 0x1FC0) : {KEEP (*(.inttab3.intvec.254)) } > pfls3
    .inttab_tc3_0FF (TEXT) BIND(__INTTAB_CPU3 + 0x1FE0) : {KEEP (*(.inttab3.intvec.255)) } > pfls3

}