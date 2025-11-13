
-Xgenerate-copytables

LCF_CSA4_SIZE    = 8k;
LCF_USTACK4_SIZE = 2k;
LCF_ISTACK4_SIZE = 1k;

LCF_HEAP_SIZE = 4k;

LCF_PPU_FLASH_SIZE  = 1M;
LCF_PPU_LMURAM_SIZE = 512k;
LCF_PPU_CSM_SIZE    = 512k;

LCF_DSPR4_START = 0x30000000;
LCF_DSPR4_SIZE  = 240K;




LCF_CSA4_OFFSET    = (LCF_DSPR4_SIZE - 1k - LCF_CSA4_SIZE);
LCF_ISTACK4_OFFSET = (LCF_CSA4_OFFSET - 256 - LCF_ISTACK4_SIZE);
LCF_USTACK4_OFFSET = (LCF_ISTACK4_OFFSET - 256 - LCF_USTACK4_SIZE);

LCF_HEAP4_OFFSET = (LCF_USTACK4_OFFSET - LCF_HEAP_SIZE);

LCF_INTVEC4_START = 0x811FE000;


__INTTAB_CPU4 = LCF_INTVEC4_START;
 



LCF_TRAPVEC4_START = 0x80E00100;

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


RESET = LCF_STARTPTR_NC_CPU4;

 
 



MEMORY
{
    dsram4: org = 0x30000000, len = 240K
    psram4: org = 0x30100000, len = 64K
	

    pfls4: org = 0x80e00000, len = 4M
    pfls4_nc: org = 0xa0e00000, len = 4M

    pfls5: org = 0x81200000, len = 2M - 1M
    pfls5_nc: org = 0xa1200000, len = 2M - 1M
	
    ucb: org = 0xae400000, len = 80K

    cpu4_dlmu: org = 0x90200000, len = 512K
    cpu4_dlmu_nc: org = 0xb0200000, len = 512K
	

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
    /* CPU4 Stack and CSA defines */
    CPU4.ustack BIND(LCF_DSPR4_START + LCF_USTACK4_OFFSET) :
    { __USTACK4_END = . ;    . = . + LCF_USTACK4_SIZE;    __USTACK4 = . ; }
    
    CPU4.istack BIND(LCF_DSPR4_START + LCF_ISTACK4_OFFSET):
    { __ISTACK4_END = . ;    . = . + LCF_ISTACK4_SIZE;    __ISTACK4 = . ; }
    
    CPU4.csa BIND(LCF_DSPR4_START + LCF_CSA4_OFFSET):
    { __CSA4 = . ;    . = . + LCF_CSA4_SIZE;    __CSA4_END = . ; }
	
	


    __SP_END = __USTACK4_END;

    /*Fixed memory Allocations*/
    __IF_CONST = 0x80000020;


    /*Fixed memory Allocations for Trap Vector Table*/
    .traptab_tc4 (TEXT) BIND(LCF_TRAPVEC4_START) : { __TRAPTAB_CPU4 = .; KEEP (*(.traptab_cpu4)) } > pfls4

    /DISCARD/ :
    { 
        *(.traptab_cpu0)
        *(.traptab_cpu1)
        *(.traptab_cpu2)
        *(.traptab_cpu3)
	*(.traptab_cpu5)
        *(.interface_const)
    }

    /*Fixed memory Allocations for _START CPU4 */
    .start_tc4 (TEXT) LOAD(LCF_STARTPTR_CPU4) BIND(LCF_STARTPTR_NC_CPU4) : { __ENABLE_INDIVIDUAL_C_INIT_CPU4 = 1; KEEP (*(.start_cpu4)) } =0x800 > pfls4_nc
    __START0 = LCF_STARTPTR_NC_CPU0;
    __START1 = LCF_STARTPTR_NC_CPU1;
    __START2 = LCF_STARTPTR_NC_CPU2;
    __START3 = LCF_STARTPTR_NC_CPU3;
    __START4 = LCF_STARTPTR_NC_CPU4;
    __START5 = LCF_STARTPTR_NC_CPU5;

    /*Near Absolute Addressable Data Sections*/
    GROUP LOAD(> pfls4) COPYTABLE :
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
	
	
	

    /*Near Absolute Data, selectable by toolchain*/
    GROUP LOAD(> pfls4) COPYTABLE :
    {
        .zdata (DATA) :
        {
            *(.zdata.dsprInit.cpu4.32bit)
            *(.zdata.dsprInit.cpu4.16bit)
            *(.zdata.dsprInit.cpu4.8bit)
            *(.zdata)
        }
        
        .zdata_powerOn (DATA) :
        {
            *(.zdata.dsprPowerOnInit.cpu4.32bit)
            *(.zdata.dsprPowerOnInit.cpu4.16bit)
            *(.zdata.dsprPowerOnInit.cpu4.8bit)
        }
        
        .zbss (BSS) :
        {
            *(.zbss.dsprClearOnInit.cpu4.32bit)
            *(.zbss.dsprClearOnInit.cpu4.16bit)
            *(.zbss.dsprClearOnInit.cpu4.8bit)
            *(.zbss)
        }
        
        .zbss_powerOn (BSS) :
        {
            *(.zbss.dsprPowerOnClear.cpu4.32bit)
            *(.zbss.dsprPowerOnClear.cpu4.16bit)
            *(.zbss.dsprPowerOnClear.cpu4.8bit)
        }
        
        .zbss_noClear (BSS) :
        {
            *(.zbss.dsprNoInit.cpu4.32bit)
            *(.zbss.dsprNoInit.cpu4.16bit)
            *(.zbss.dsprNoInit.cpu4.8bit)
        }
		
		
    } > dsram4

    /*Relative A0/A1/A8/A9 Addressable Sections*/
    /*Relative A0 Addressable Data, selectable with patterns and user defined sections*/
    /*Note: A0 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A0 Addressable Data, selectable by toolchain*/
    GROUP LOAD(> pfls4) COPYTABLE :
	
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
    } > dsram4

    /*Relative A1 Addressable Const, selectable with patterns and user defined sections*/
    /*Note: A1 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A1 Addressable Const, selectable by toolchain*/
    GROUP :
    {
        .zrodata (CONST) :
        {
            *Ifx_Ssw_Tc4.* (.zrodata)
            *Cpu4_Main.* (.zrodata)
            *(.zrodata.const.cpu4.32bit)
            *(.zrodata.const.cpu4.16bit)
            *(.zrodata.const.cpu4.8bit)
            *(.zrodata.config.cpu4.32bit)
            *(.zrodata.config.cpu4.16bit)
            *(.zrodata.config.cpu4.8bit)
            *(.zrodata_cpu4)
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
    } > pfls4

    /*LMU memory sections*/
    GROUP LOAD(> pfls4) COPYTABLE :
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
    /*Relative A9 Addressable Data, selectable with patterns and user defined sections*/
    GROUP LOAD(> pfls4) COPYTABLE: 
	
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
    } > cpu4_dlmu

    GROUP LOAD(> pfls4) COPYTABLE :
    {
        .lmudata (DATA) :
        {
            *(.lmudata)
        }
        
        .lmubss (BSS) :
        {
            *(.lmubss)
        }
    } > cpu4_dlmu

    GROUP LOAD(> pfls4) :
    {
        .ppu_lmuram  :
        {
            . = ALIGN(4);
            __PPU_LMURAM_START = .;
            . += LCF_PPU_LMURAM_SIZE;
            __PPU_LMURAM_END = .;
        }
    } > ppu_lmuram_nc
	
    GROUP LOAD(> pfls4) :
    {
        .ppu_csm :
        {
        . = ALIGN(4);
        __PPU_CSM_START = .;
        . += LCF_PPU_CSM_SIZE;
        __PPU_CSM_END = .;
        }
    } > ppu_csm_nc
    
    GROUP LOAD(> pfls4) :
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
    } > pfls4

    __A8_MEM = SIZEOF(.rodata_a8) ? ADDR(.rodata_a8) : (ADDR(.rodata_a8) & 0xF0000000) + 32k ;
    
    /*Far Data / Far Const Sections, selectable with patterns and user defined sections*/
    /*Far Data Sections, selectable with patterns and user defined sections*/
    GROUP LOAD(> pfls4) COPYTABLE :
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
    /*Far Data Sections, selectable by toolchain*/
    GROUP LOAD(> pfls4) COPYTABLE :
	
    {
        .data (DATA) :
        {
            *(.data.farDsprInit.cpu4.32bit)
            *(.data.farDsprInit.cpu4.16bit)
            *(.data.farDsprInit.cpu4.8bit)
            *(.data)
        }
        
        .bss (BSS) :
        {
            *(.bss.farDsprClearOnInit.cpu4.32bit)
            *(.bss.farDsprClearOnInit.cpu4.16bit)
            *(.bss.farDsprClearOnInit.cpu4.8bit)
            *(.bss)
        }
        
        .bss_noClear (BSS) :
        {
            *(.bss.farDsprNoInit.cpu4.32bit)
            *(.bss.farDsprNoInit.cpu4.16bit)
            *(.bss.farDsprNoInit.cpu4.8bit)
        }
        
        .heap  :
        {
            . = ALIGN(4);
            __HEAP = .;
            __HEAP_START = .;
            __HEAP_END = . + LCF_HEAP_SIZE;
        }
    } > dsram4

    /* Far Const Sections, selectable with patterns and user defined sections */
    /* CPU4 Const Sections */
    CPU4.rodata (CONST) :
    {
        "*Ifx_Ssw_Tc4.*" (.rodata)
        "*Cpu4_Main.*" (.rodata)
        *(.rodata_cpu4)
    } > pfls4
	
    /*Far Const Sections, selectable by toolchain*/
    GROUP :
    {
        .rodata (CONST) :
        {
            *(.rodata)
            *(.rodata.farConst.cpu4.32bit)
            *(.rodata.farConst.cpu4.16bit)
            *(.rodata.farConst.cpu4.8bit)
        }
        
        .copytable (CONST) :
        {
            __DATA_ROM = .;
        }
    } > pfls4

    /*Code selections*/
    /*Code Sections, selectable with patterns and user defined sections*/
    /* CPU4 Code Sections */
    CPU4.text (TEXT) :
    {
        . = ALIGN(2);
        "*Ifx_Ssw_Tc4.*" (.text)
        "*Cpu4_Main.*" (.text)
        *(.text_cpu4)
    } > pfls4
    
    CPU4.psram_text (TEXT) LOAD(> pfls4) COPYTABLE :
    {
        . = ALIGN(2);
        *(.psram_text_cpu4)
        *(.cpu4_psram)
    } > psram4
	
	

    /*Code Sections, selectable by toolchain*/
    GROUP :
    {
        .text (TEXT) :
        {
            . = ALIGN(2);
            *(.text)
            *(.text.fast.pfls.cpu4)
            *(.text.slow.pfls.cpu4)
            *(.text.5ms.pfls.cpu4)
            *(.text.10ms.pfls.cpu4)
            *(.text.callout.pfls.cpu4)
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
    } > pfls4


    /* CPU4 Interrupt Vector Table */
    .inttab_tc4_000 (TEXT) BIND(__INTTAB_CPU4 + 0x0000) : {KEEP (*(.inttab4.intvec.0  )) } > pfls4
    .inttab_tc4_001 (TEXT) BIND(__INTTAB_CPU4 + 0x0020) : {KEEP (*(.inttab4.intvec.1  )) } > pfls4
    .inttab_tc4_002 (TEXT) BIND(__INTTAB_CPU4 + 0x0040) : {KEEP (*(.inttab4.intvec.2  )) } > pfls4
    .inttab_tc4_003 (TEXT) BIND(__INTTAB_CPU4 + 0x0060) : {KEEP (*(.inttab4.intvec.3  )) } > pfls4
    .inttab_tc4_004 (TEXT) BIND(__INTTAB_CPU4 + 0x0080) : {KEEP (*(.inttab4.intvec.4  )) } > pfls4
    .inttab_tc4_005 (TEXT) BIND(__INTTAB_CPU4 + 0x00A0) : {KEEP (*(.inttab4.intvec.5  )) } > pfls4
    .inttab_tc4_006 (TEXT) BIND(__INTTAB_CPU4 + 0x00C0) : {KEEP (*(.inttab4.intvec.6  )) } > pfls4
    .inttab_tc4_007 (TEXT) BIND(__INTTAB_CPU4 + 0x00E0) : {KEEP (*(.inttab4.intvec.7  )) } > pfls4
    .inttab_tc4_008 (TEXT) BIND(__INTTAB_CPU4 + 0x0100) : {KEEP (*(.inttab4.intvec.8  )) } > pfls4
    .inttab_tc4_009 (TEXT) BIND(__INTTAB_CPU4 + 0x0120) : {KEEP (*(.inttab4.intvec.9  )) } > pfls4
    .inttab_tc4_00A (TEXT) BIND(__INTTAB_CPU4 + 0x0140) : {KEEP (*(.inttab4.intvec.10 )) } > pfls4
    .inttab_tc4_00B (TEXT) BIND(__INTTAB_CPU4 + 0x0160) : {KEEP (*(.inttab4.intvec.11 )) } > pfls4
    .inttab_tc4_00C (TEXT) BIND(__INTTAB_CPU4 + 0x0180) : {KEEP (*(.inttab4.intvec.12 )) } > pfls4
    .inttab_tc4_00D (TEXT) BIND(__INTTAB_CPU4 + 0x01A0) : {KEEP (*(.inttab4.intvec.13 )) } > pfls4
    .inttab_tc4_00E (TEXT) BIND(__INTTAB_CPU4 + 0x01C0) : {KEEP (*(.inttab4.intvec.14 )) } > pfls4
    .inttab_tc4_00F (TEXT) BIND(__INTTAB_CPU4 + 0x01E0) : {KEEP (*(.inttab4.intvec.15 )) } > pfls4
    .inttab_tc4_010 (TEXT) BIND(__INTTAB_CPU4 + 0x0200) : {KEEP (*(.inttab4.intvec.16 )) } > pfls4
    .inttab_tc4_011 (TEXT) BIND(__INTTAB_CPU4 + 0x0220) : {KEEP (*(.inttab4.intvec.17 )) } > pfls4
    .inttab_tc4_012 (TEXT) BIND(__INTTAB_CPU4 + 0x0240) : {KEEP (*(.inttab4.intvec.18 )) } > pfls4
    .inttab_tc4_013 (TEXT) BIND(__INTTAB_CPU4 + 0x0260) : {KEEP (*(.inttab4.intvec.19 )) } > pfls4
    .inttab_tc4_014 (TEXT) BIND(__INTTAB_CPU4 + 0x0280) : {KEEP (*(.inttab4.intvec.20 )) } > pfls4
    .inttab_tc4_015 (TEXT) BIND(__INTTAB_CPU4 + 0x02A0) : {KEEP (*(.inttab4.intvec.21 )) } > pfls4
    .inttab_tc4_016 (TEXT) BIND(__INTTAB_CPU4 + 0x02C0) : {KEEP (*(.inttab4.intvec.22 )) } > pfls4
    .inttab_tc4_017 (TEXT) BIND(__INTTAB_CPU4 + 0x02E0) : {KEEP (*(.inttab4.intvec.23 )) } > pfls4
    .inttab_tc4_018 (TEXT) BIND(__INTTAB_CPU4 + 0x0300) : {KEEP (*(.inttab4.intvec.24 )) } > pfls4
    .inttab_tc4_019 (TEXT) BIND(__INTTAB_CPU4 + 0x0320) : {KEEP (*(.inttab4.intvec.25 )) } > pfls4
    .inttab_tc4_01A (TEXT) BIND(__INTTAB_CPU4 + 0x0340) : {KEEP (*(.inttab4.intvec.26 )) } > pfls4
    .inttab_tc4_01B (TEXT) BIND(__INTTAB_CPU4 + 0x0360) : {KEEP (*(.inttab4.intvec.27 )) } > pfls4
    .inttab_tc4_01C (TEXT) BIND(__INTTAB_CPU4 + 0x0380) : {KEEP (*(.inttab4.intvec.28 )) } > pfls4
    .inttab_tc4_01D (TEXT) BIND(__INTTAB_CPU4 + 0x03A0) : {KEEP (*(.inttab4.intvec.29 )) } > pfls4
    .inttab_tc4_01E (TEXT) BIND(__INTTAB_CPU4 + 0x03C0) : {KEEP (*(.inttab4.intvec.30 )) } > pfls4
    .inttab_tc4_01F (TEXT) BIND(__INTTAB_CPU4 + 0x03E0) : {KEEP (*(.inttab4.intvec.31 )) } > pfls4
    .inttab_tc4_020 (TEXT) BIND(__INTTAB_CPU4 + 0x0400) : {KEEP (*(.inttab4.intvec.32 )) } > pfls4
    .inttab_tc4_021 (TEXT) BIND(__INTTAB_CPU4 + 0x0420) : {KEEP (*(.inttab4.intvec.33 )) } > pfls4
    .inttab_tc4_022 (TEXT) BIND(__INTTAB_CPU4 + 0x0440) : {KEEP (*(.inttab4.intvec.34 )) } > pfls4
    .inttab_tc4_023 (TEXT) BIND(__INTTAB_CPU4 + 0x0460) : {KEEP (*(.inttab4.intvec.35 )) } > pfls4
    .inttab_tc4_024 (TEXT) BIND(__INTTAB_CPU4 + 0x0480) : {KEEP (*(.inttab4.intvec.36 )) } > pfls4
    .inttab_tc4_025 (TEXT) BIND(__INTTAB_CPU4 + 0x04A0) : {KEEP (*(.inttab4.intvec.37 )) } > pfls4
    .inttab_tc4_026 (TEXT) BIND(__INTTAB_CPU4 + 0x04C0) : {KEEP (*(.inttab4.intvec.38 )) } > pfls4
    .inttab_tc4_027 (TEXT) BIND(__INTTAB_CPU4 + 0x04E0) : {KEEP (*(.inttab4.intvec.39 )) } > pfls4
    .inttab_tc4_028 (TEXT) BIND(__INTTAB_CPU4 + 0x0500) : {KEEP (*(.inttab4.intvec.40 )) } > pfls4
    .inttab_tc4_029 (TEXT) BIND(__INTTAB_CPU4 + 0x0520) : {KEEP (*(.inttab4.intvec.41 )) } > pfls4
    .inttab_tc4_02A (TEXT) BIND(__INTTAB_CPU4 + 0x0540) : {KEEP (*(.inttab4.intvec.42 )) } > pfls4
    .inttab_tc4_02B (TEXT) BIND(__INTTAB_CPU4 + 0x0560) : {KEEP (*(.inttab4.intvec.43 )) } > pfls4
    .inttab_tc4_02C (TEXT) BIND(__INTTAB_CPU4 + 0x0580) : {KEEP (*(.inttab4.intvec.44 )) } > pfls4
    .inttab_tc4_02D (TEXT) BIND(__INTTAB_CPU4 + 0x05A0) : {KEEP (*(.inttab4.intvec.45 )) } > pfls4
    .inttab_tc4_02E (TEXT) BIND(__INTTAB_CPU4 + 0x05C0) : {KEEP (*(.inttab4.intvec.46 )) } > pfls4
    .inttab_tc4_02F (TEXT) BIND(__INTTAB_CPU4 + 0x05E0) : {KEEP (*(.inttab4.intvec.47 )) } > pfls4
    .inttab_tc4_030 (TEXT) BIND(__INTTAB_CPU4 + 0x0600) : {KEEP (*(.inttab4.intvec.48 )) } > pfls4
    .inttab_tc4_031 (TEXT) BIND(__INTTAB_CPU4 + 0x0620) : {KEEP (*(.inttab4.intvec.49 )) } > pfls4
    .inttab_tc4_032 (TEXT) BIND(__INTTAB_CPU4 + 0x0640) : {KEEP (*(.inttab4.intvec.50 )) } > pfls4
    .inttab_tc4_033 (TEXT) BIND(__INTTAB_CPU4 + 0x0660) : {KEEP (*(.inttab4.intvec.51 )) } > pfls4
    .inttab_tc4_034 (TEXT) BIND(__INTTAB_CPU4 + 0x0680) : {KEEP (*(.inttab4.intvec.52 )) } > pfls4
    .inttab_tc4_035 (TEXT) BIND(__INTTAB_CPU4 + 0x06A0) : {KEEP (*(.inttab4.intvec.53 )) } > pfls4
    .inttab_tc4_036 (TEXT) BIND(__INTTAB_CPU4 + 0x06C0) : {KEEP (*(.inttab4.intvec.54 )) } > pfls4
    .inttab_tc4_037 (TEXT) BIND(__INTTAB_CPU4 + 0x06E0) : {KEEP (*(.inttab4.intvec.55 )) } > pfls4
    .inttab_tc4_038 (TEXT) BIND(__INTTAB_CPU4 + 0x0700) : {KEEP (*(.inttab4.intvec.56 )) } > pfls4
    .inttab_tc4_039 (TEXT) BIND(__INTTAB_CPU4 + 0x0720) : {KEEP (*(.inttab4.intvec.57 )) } > pfls4
    .inttab_tc4_03A (TEXT) BIND(__INTTAB_CPU4 + 0x0740) : {KEEP (*(.inttab4.intvec.58 )) } > pfls4
    .inttab_tc4_03B (TEXT) BIND(__INTTAB_CPU4 + 0x0760) : {KEEP (*(.inttab4.intvec.59 )) } > pfls4
    .inttab_tc4_03C (TEXT) BIND(__INTTAB_CPU4 + 0x0780) : {KEEP (*(.inttab4.intvec.60 )) } > pfls4
    .inttab_tc4_03D (TEXT) BIND(__INTTAB_CPU4 + 0x07A0) : {KEEP (*(.inttab4.intvec.61 )) } > pfls4
    .inttab_tc4_03E (TEXT) BIND(__INTTAB_CPU4 + 0x07C0) : {KEEP (*(.inttab4.intvec.62 )) } > pfls4
    .inttab_tc4_03F (TEXT) BIND(__INTTAB_CPU4 + 0x07E0) : {KEEP (*(.inttab4.intvec.63 )) } > pfls4
    .inttab_tc4_040 (TEXT) BIND(__INTTAB_CPU4 + 0x0800) : {KEEP (*(.inttab4.intvec.64 )) } > pfls4
    .inttab_tc4_041 (TEXT) BIND(__INTTAB_CPU4 + 0x0820) : {KEEP (*(.inttab4.intvec.65 )) } > pfls4
    .inttab_tc4_042 (TEXT) BIND(__INTTAB_CPU4 + 0x0840) : {KEEP (*(.inttab4.intvec.66 )) } > pfls4
    .inttab_tc4_043 (TEXT) BIND(__INTTAB_CPU4 + 0x0860) : {KEEP (*(.inttab4.intvec.67 )) } > pfls4
    .inttab_tc4_044 (TEXT) BIND(__INTTAB_CPU4 + 0x0880) : {KEEP (*(.inttab4.intvec.68 )) } > pfls4
    .inttab_tc4_045 (TEXT) BIND(__INTTAB_CPU4 + 0x08A0) : {KEEP (*(.inttab4.intvec.69 )) } > pfls4
    .inttab_tc4_046 (TEXT) BIND(__INTTAB_CPU4 + 0x08C0) : {KEEP (*(.inttab4.intvec.70 )) } > pfls4
    .inttab_tc4_047 (TEXT) BIND(__INTTAB_CPU4 + 0x08E0) : {KEEP (*(.inttab4.intvec.71 )) } > pfls4
    .inttab_tc4_048 (TEXT) BIND(__INTTAB_CPU4 + 0x0900) : {KEEP (*(.inttab4.intvec.72 )) } > pfls4
    .inttab_tc4_049 (TEXT) BIND(__INTTAB_CPU4 + 0x0920) : {KEEP (*(.inttab4.intvec.73 )) } > pfls4
    .inttab_tc4_04A (TEXT) BIND(__INTTAB_CPU4 + 0x0940) : {KEEP (*(.inttab4.intvec.74 )) } > pfls4
    .inttab_tc4_04B (TEXT) BIND(__INTTAB_CPU4 + 0x0960) : {KEEP (*(.inttab4.intvec.75 )) } > pfls4
    .inttab_tc4_04C (TEXT) BIND(__INTTAB_CPU4 + 0x0980) : {KEEP (*(.inttab4.intvec.76 )) } > pfls4
    .inttab_tc4_04D (TEXT) BIND(__INTTAB_CPU4 + 0x09A0) : {KEEP (*(.inttab4.intvec.77 )) } > pfls4
    .inttab_tc4_04E (TEXT) BIND(__INTTAB_CPU4 + 0x09C0) : {KEEP (*(.inttab4.intvec.78 )) } > pfls4
    .inttab_tc4_04F (TEXT) BIND(__INTTAB_CPU4 + 0x09E0) : {KEEP (*(.inttab4.intvec.79 )) } > pfls4
    .inttab_tc4_050 (TEXT) BIND(__INTTAB_CPU4 + 0x0A00) : {KEEP (*(.inttab4.intvec.80 )) } > pfls4
    .inttab_tc4_051 (TEXT) BIND(__INTTAB_CPU4 + 0x0A20) : {KEEP (*(.inttab4.intvec.81 )) } > pfls4
    .inttab_tc4_052 (TEXT) BIND(__INTTAB_CPU4 + 0x0A40) : {KEEP (*(.inttab4.intvec.82 )) } > pfls4
    .inttab_tc4_053 (TEXT) BIND(__INTTAB_CPU4 + 0x0A60) : {KEEP (*(.inttab4.intvec.83 )) } > pfls4
    .inttab_tc4_054 (TEXT) BIND(__INTTAB_CPU4 + 0x0A80) : {KEEP (*(.inttab4.intvec.84 )) } > pfls4
    .inttab_tc4_055 (TEXT) BIND(__INTTAB_CPU4 + 0x0AA0) : {KEEP (*(.inttab4.intvec.85 )) } > pfls4
    .inttab_tc4_056 (TEXT) BIND(__INTTAB_CPU4 + 0x0AC0) : {KEEP (*(.inttab4.intvec.86 )) } > pfls4
    .inttab_tc4_057 (TEXT) BIND(__INTTAB_CPU4 + 0x0AE0) : {KEEP (*(.inttab4.intvec.87 )) } > pfls4
    .inttab_tc4_058 (TEXT) BIND(__INTTAB_CPU4 + 0x0B00) : {KEEP (*(.inttab4.intvec.88 )) } > pfls4
    .inttab_tc4_059 (TEXT) BIND(__INTTAB_CPU4 + 0x0B20) : {KEEP (*(.inttab4.intvec.89 )) } > pfls4
    .inttab_tc4_05A (TEXT) BIND(__INTTAB_CPU4 + 0x0B40) : {KEEP (*(.inttab4.intvec.90 )) } > pfls4
    .inttab_tc4_05B (TEXT) BIND(__INTTAB_CPU4 + 0x0B60) : {KEEP (*(.inttab4.intvec.91 )) } > pfls4
    .inttab_tc4_05C (TEXT) BIND(__INTTAB_CPU4 + 0x0B80) : {KEEP (*(.inttab4.intvec.92 )) } > pfls4
    .inttab_tc4_05D (TEXT) BIND(__INTTAB_CPU4 + 0x0BA0) : {KEEP (*(.inttab4.intvec.93 )) } > pfls4
    .inttab_tc4_05E (TEXT) BIND(__INTTAB_CPU4 + 0x0BC0) : {KEEP (*(.inttab4.intvec.94 )) } > pfls4
    .inttab_tc4_05F (TEXT) BIND(__INTTAB_CPU4 + 0x0BE0) : {KEEP (*(.inttab4.intvec.95 )) } > pfls4
    .inttab_tc4_060 (TEXT) BIND(__INTTAB_CPU4 + 0x0C00) : {KEEP (*(.inttab4.intvec.96 )) } > pfls4
    .inttab_tc4_061 (TEXT) BIND(__INTTAB_CPU4 + 0x0C20) : {KEEP (*(.inttab4.intvec.97 )) } > pfls4
    .inttab_tc4_062 (TEXT) BIND(__INTTAB_CPU4 + 0x0C40) : {KEEP (*(.inttab4.intvec.98 )) } > pfls4
    .inttab_tc4_063 (TEXT) BIND(__INTTAB_CPU4 + 0x0C60) : {KEEP (*(.inttab4.intvec.99 )) } > pfls4
    .inttab_tc4_064 (TEXT) BIND(__INTTAB_CPU4 + 0x0C80) : {KEEP (*(.inttab4.intvec.100)) } > pfls4
    .inttab_tc4_065 (TEXT) BIND(__INTTAB_CPU4 + 0x0CA0) : {KEEP (*(.inttab4.intvec.101)) } > pfls4
    .inttab_tc4_066 (TEXT) BIND(__INTTAB_CPU4 + 0x0CC0) : {KEEP (*(.inttab4.intvec.102)) } > pfls4
    .inttab_tc4_067 (TEXT) BIND(__INTTAB_CPU4 + 0x0CE0) : {KEEP (*(.inttab4.intvec.103)) } > pfls4
    .inttab_tc4_068 (TEXT) BIND(__INTTAB_CPU4 + 0x0D00) : {KEEP (*(.inttab4.intvec.104)) } > pfls4
    .inttab_tc4_069 (TEXT) BIND(__INTTAB_CPU4 + 0x0D20) : {KEEP (*(.inttab4.intvec.105)) } > pfls4
    .inttab_tc4_06A (TEXT) BIND(__INTTAB_CPU4 + 0x0D40) : {KEEP (*(.inttab4.intvec.106)) } > pfls4
    .inttab_tc4_06B (TEXT) BIND(__INTTAB_CPU4 + 0x0D60) : {KEEP (*(.inttab4.intvec.107)) } > pfls4
    .inttab_tc4_06C (TEXT) BIND(__INTTAB_CPU4 + 0x0D80) : {KEEP (*(.inttab4.intvec.108)) } > pfls4
    .inttab_tc4_06D (TEXT) BIND(__INTTAB_CPU4 + 0x0DA0) : {KEEP (*(.inttab4.intvec.109)) } > pfls4
    .inttab_tc4_06E (TEXT) BIND(__INTTAB_CPU4 + 0x0DC0) : {KEEP (*(.inttab4.intvec.110)) } > pfls4
    .inttab_tc4_06F (TEXT) BIND(__INTTAB_CPU4 + 0x0DE0) : {KEEP (*(.inttab4.intvec.111)) } > pfls4
    .inttab_tc4_070 (TEXT) BIND(__INTTAB_CPU4 + 0x0E00) : {KEEP (*(.inttab4.intvec.112)) } > pfls4
    .inttab_tc4_071 (TEXT) BIND(__INTTAB_CPU4 + 0x0E20) : {KEEP (*(.inttab4.intvec.113)) } > pfls4
    .inttab_tc4_072 (TEXT) BIND(__INTTAB_CPU4 + 0x0E40) : {KEEP (*(.inttab4.intvec.114)) } > pfls4
    .inttab_tc4_073 (TEXT) BIND(__INTTAB_CPU4 + 0x0E60) : {KEEP (*(.inttab4.intvec.115)) } > pfls4
    .inttab_tc4_074 (TEXT) BIND(__INTTAB_CPU4 + 0x0E80) : {KEEP (*(.inttab4.intvec.116)) } > pfls4
    .inttab_tc4_075 (TEXT) BIND(__INTTAB_CPU4 + 0x0EA0) : {KEEP (*(.inttab4.intvec.117)) } > pfls4
    .inttab_tc4_076 (TEXT) BIND(__INTTAB_CPU4 + 0x0EC0) : {KEEP (*(.inttab4.intvec.118)) } > pfls4
    .inttab_tc4_077 (TEXT) BIND(__INTTAB_CPU4 + 0x0EE0) : {KEEP (*(.inttab4.intvec.119)) } > pfls4
    .inttab_tc4_078 (TEXT) BIND(__INTTAB_CPU4 + 0x0F00) : {KEEP (*(.inttab4.intvec.120)) } > pfls4
    .inttab_tc4_079 (TEXT) BIND(__INTTAB_CPU4 + 0x0F20) : {KEEP (*(.inttab4.intvec.121)) } > pfls4
    .inttab_tc4_07A (TEXT) BIND(__INTTAB_CPU4 + 0x0F40) : {KEEP (*(.inttab4.intvec.122)) } > pfls4
    .inttab_tc4_07B (TEXT) BIND(__INTTAB_CPU4 + 0x0F60) : {KEEP (*(.inttab4.intvec.123)) } > pfls4
    .inttab_tc4_07C (TEXT) BIND(__INTTAB_CPU4 + 0x0F80) : {KEEP (*(.inttab4.intvec.124)) } > pfls4
    .inttab_tc4_07D (TEXT) BIND(__INTTAB_CPU4 + 0x0FA0) : {KEEP (*(.inttab4.intvec.125)) } > pfls4
    .inttab_tc4_07E (TEXT) BIND(__INTTAB_CPU4 + 0x0FC0) : {KEEP (*(.inttab4.intvec.126)) } > pfls4
    .inttab_tc4_07F (TEXT) BIND(__INTTAB_CPU4 + 0x0FE0) : {KEEP (*(.inttab4.intvec.127)) } > pfls4
    .inttab_tc4_080 (TEXT) BIND(__INTTAB_CPU4 + 0x1000) : {KEEP (*(.inttab4.intvec.128)) } > pfls4
    .inttab_tc4_081 (TEXT) BIND(__INTTAB_CPU4 + 0x1020) : {KEEP (*(.inttab4.intvec.129)) } > pfls4
    .inttab_tc4_082 (TEXT) BIND(__INTTAB_CPU4 + 0x1040) : {KEEP (*(.inttab4.intvec.130)) } > pfls4
    .inttab_tc4_083 (TEXT) BIND(__INTTAB_CPU4 + 0x1060) : {KEEP (*(.inttab4.intvec.131)) } > pfls4
    .inttab_tc4_084 (TEXT) BIND(__INTTAB_CPU4 + 0x1080) : {KEEP (*(.inttab4.intvec.132)) } > pfls4
    .inttab_tc4_085 (TEXT) BIND(__INTTAB_CPU4 + 0x10A0) : {KEEP (*(.inttab4.intvec.133)) } > pfls4
    .inttab_tc4_086 (TEXT) BIND(__INTTAB_CPU4 + 0x10C0) : {KEEP (*(.inttab4.intvec.134)) } > pfls4
    .inttab_tc4_087 (TEXT) BIND(__INTTAB_CPU4 + 0x10E0) : {KEEP (*(.inttab4.intvec.135)) } > pfls4
    .inttab_tc4_088 (TEXT) BIND(__INTTAB_CPU4 + 0x1100) : {KEEP (*(.inttab4.intvec.136)) } > pfls4
    .inttab_tc4_089 (TEXT) BIND(__INTTAB_CPU4 + 0x1120) : {KEEP (*(.inttab4.intvec.137)) } > pfls4
    .inttab_tc4_08A (TEXT) BIND(__INTTAB_CPU4 + 0x1140) : {KEEP (*(.inttab4.intvec.138)) } > pfls4
    .inttab_tc4_08B (TEXT) BIND(__INTTAB_CPU4 + 0x1160) : {KEEP (*(.inttab4.intvec.139)) } > pfls4
    .inttab_tc4_08C (TEXT) BIND(__INTTAB_CPU4 + 0x1180) : {KEEP (*(.inttab4.intvec.140)) } > pfls4
    .inttab_tc4_08D (TEXT) BIND(__INTTAB_CPU4 + 0x11A0) : {KEEP (*(.inttab4.intvec.141)) } > pfls4
    .inttab_tc4_08E (TEXT) BIND(__INTTAB_CPU4 + 0x11C0) : {KEEP (*(.inttab4.intvec.142)) } > pfls4
    .inttab_tc4_08F (TEXT) BIND(__INTTAB_CPU4 + 0x11E0) : {KEEP (*(.inttab4.intvec.143)) } > pfls4
    .inttab_tc4_090 (TEXT) BIND(__INTTAB_CPU4 + 0x1200) : {KEEP (*(.inttab4.intvec.144)) } > pfls4
    .inttab_tc4_091 (TEXT) BIND(__INTTAB_CPU4 + 0x1220) : {KEEP (*(.inttab4.intvec.145)) } > pfls4
    .inttab_tc4_092 (TEXT) BIND(__INTTAB_CPU4 + 0x1240) : {KEEP (*(.inttab4.intvec.146)) } > pfls4
    .inttab_tc4_093 (TEXT) BIND(__INTTAB_CPU4 + 0x1260) : {KEEP (*(.inttab4.intvec.147)) } > pfls4
    .inttab_tc4_094 (TEXT) BIND(__INTTAB_CPU4 + 0x1280) : {KEEP (*(.inttab4.intvec.148)) } > pfls4
    .inttab_tc4_095 (TEXT) BIND(__INTTAB_CPU4 + 0x12A0) : {KEEP (*(.inttab4.intvec.149)) } > pfls4
    .inttab_tc4_096 (TEXT) BIND(__INTTAB_CPU4 + 0x12C0) : {KEEP (*(.inttab4.intvec.150)) } > pfls4
    .inttab_tc4_097 (TEXT) BIND(__INTTAB_CPU4 + 0x12E0) : {KEEP (*(.inttab4.intvec.151)) } > pfls4
    .inttab_tc4_098 (TEXT) BIND(__INTTAB_CPU4 + 0x1300) : {KEEP (*(.inttab4.intvec.152)) } > pfls4
    .inttab_tc4_099 (TEXT) BIND(__INTTAB_CPU4 + 0x1320) : {KEEP (*(.inttab4.intvec.153)) } > pfls4
    .inttab_tc4_09A (TEXT) BIND(__INTTAB_CPU4 + 0x1340) : {KEEP (*(.inttab4.intvec.154)) } > pfls4
    .inttab_tc4_09B (TEXT) BIND(__INTTAB_CPU4 + 0x1360) : {KEEP (*(.inttab4.intvec.155)) } > pfls4
    .inttab_tc4_09C (TEXT) BIND(__INTTAB_CPU4 + 0x1380) : {KEEP (*(.inttab4.intvec.156)) } > pfls4
    .inttab_tc4_09D (TEXT) BIND(__INTTAB_CPU4 + 0x13A0) : {KEEP (*(.inttab4.intvec.157)) } > pfls4
    .inttab_tc4_09E (TEXT) BIND(__INTTAB_CPU4 + 0x13C0) : {KEEP (*(.inttab4.intvec.158)) } > pfls4
    .inttab_tc4_09F (TEXT) BIND(__INTTAB_CPU4 + 0x13E0) : {KEEP (*(.inttab4.intvec.159)) } > pfls4
    .inttab_tc4_0A0 (TEXT) BIND(__INTTAB_CPU4 + 0x1400) : {KEEP (*(.inttab4.intvec.160)) } > pfls4
    .inttab_tc4_0A1 (TEXT) BIND(__INTTAB_CPU4 + 0x1420) : {KEEP (*(.inttab4.intvec.161)) } > pfls4
    .inttab_tc4_0A2 (TEXT) BIND(__INTTAB_CPU4 + 0x1440) : {KEEP (*(.inttab4.intvec.162)) } > pfls4
    .inttab_tc4_0A3 (TEXT) BIND(__INTTAB_CPU4 + 0x1460) : {KEEP (*(.inttab4.intvec.163)) } > pfls4
    .inttab_tc4_0A4 (TEXT) BIND(__INTTAB_CPU4 + 0x1480) : {KEEP (*(.inttab4.intvec.164)) } > pfls4
    .inttab_tc4_0A5 (TEXT) BIND(__INTTAB_CPU4 + 0x14A0) : {KEEP (*(.inttab4.intvec.165)) } > pfls4
    .inttab_tc4_0A6 (TEXT) BIND(__INTTAB_CPU4 + 0x14C0) : {KEEP (*(.inttab4.intvec.166)) } > pfls4
    .inttab_tc4_0A7 (TEXT) BIND(__INTTAB_CPU4 + 0x14E0) : {KEEP (*(.inttab4.intvec.167)) } > pfls4
    .inttab_tc4_0A8 (TEXT) BIND(__INTTAB_CPU4 + 0x1500) : {KEEP (*(.inttab4.intvec.168)) } > pfls4
    .inttab_tc4_0A9 (TEXT) BIND(__INTTAB_CPU4 + 0x1520) : {KEEP (*(.inttab4.intvec.169)) } > pfls4
    .inttab_tc4_0AA (TEXT) BIND(__INTTAB_CPU4 + 0x1540) : {KEEP (*(.inttab4.intvec.170)) } > pfls4
    .inttab_tc4_0AB (TEXT) BIND(__INTTAB_CPU4 + 0x1560) : {KEEP (*(.inttab4.intvec.171)) } > pfls4
    .inttab_tc4_0AC (TEXT) BIND(__INTTAB_CPU4 + 0x1580) : {KEEP (*(.inttab4.intvec.172)) } > pfls4
    .inttab_tc4_0AD (TEXT) BIND(__INTTAB_CPU4 + 0x15A0) : {KEEP (*(.inttab4.intvec.173)) } > pfls4
    .inttab_tc4_0AE (TEXT) BIND(__INTTAB_CPU4 + 0x15C0) : {KEEP (*(.inttab4.intvec.174)) } > pfls4
    .inttab_tc4_0AF (TEXT) BIND(__INTTAB_CPU4 + 0x15E0) : {KEEP (*(.inttab4.intvec.175)) } > pfls4
    .inttab_tc4_0B0 (TEXT) BIND(__INTTAB_CPU4 + 0x1600) : {KEEP (*(.inttab4.intvec.176)) } > pfls4
    .inttab_tc4_0B1 (TEXT) BIND(__INTTAB_CPU4 + 0x1620) : {KEEP (*(.inttab4.intvec.177)) } > pfls4
    .inttab_tc4_0B2 (TEXT) BIND(__INTTAB_CPU4 + 0x1640) : {KEEP (*(.inttab4.intvec.178)) } > pfls4
    .inttab_tc4_0B3 (TEXT) BIND(__INTTAB_CPU4 + 0x1660) : {KEEP (*(.inttab4.intvec.179)) } > pfls4
    .inttab_tc4_0B4 (TEXT) BIND(__INTTAB_CPU4 + 0x1680) : {KEEP (*(.inttab4.intvec.180)) } > pfls4
    .inttab_tc4_0B5 (TEXT) BIND(__INTTAB_CPU4 + 0x16A0) : {KEEP (*(.inttab4.intvec.181)) } > pfls4
    .inttab_tc4_0B6 (TEXT) BIND(__INTTAB_CPU4 + 0x16C0) : {KEEP (*(.inttab4.intvec.182)) } > pfls4
    .inttab_tc4_0B7 (TEXT) BIND(__INTTAB_CPU4 + 0x16E0) : {KEEP (*(.inttab4.intvec.183)) } > pfls4
    .inttab_tc4_0B8 (TEXT) BIND(__INTTAB_CPU4 + 0x1700) : {KEEP (*(.inttab4.intvec.184)) } > pfls4
    .inttab_tc4_0B9 (TEXT) BIND(__INTTAB_CPU4 + 0x1720) : {KEEP (*(.inttab4.intvec.185)) } > pfls4
    .inttab_tc4_0BA (TEXT) BIND(__INTTAB_CPU4 + 0x1740) : {KEEP (*(.inttab4.intvec.186)) } > pfls4
    .inttab_tc4_0BB (TEXT) BIND(__INTTAB_CPU4 + 0x1760) : {KEEP (*(.inttab4.intvec.187)) } > pfls4
    .inttab_tc4_0BC (TEXT) BIND(__INTTAB_CPU4 + 0x1780) : {KEEP (*(.inttab4.intvec.188)) } > pfls4
    .inttab_tc4_0BD (TEXT) BIND(__INTTAB_CPU4 + 0x17A0) : {KEEP (*(.inttab4.intvec.189)) } > pfls4
    .inttab_tc4_0BE (TEXT) BIND(__INTTAB_CPU4 + 0x17C0) : {KEEP (*(.inttab4.intvec.190)) } > pfls4
    .inttab_tc4_0BF (TEXT) BIND(__INTTAB_CPU4 + 0x17E0) : {KEEP (*(.inttab4.intvec.191)) } > pfls4
    .inttab_tc4_0C0 (TEXT) BIND(__INTTAB_CPU4 + 0x1800) : {KEEP (*(.inttab4.intvec.192)) } > pfls4
    .inttab_tc4_0C1 (TEXT) BIND(__INTTAB_CPU4 + 0x1820) : {KEEP (*(.inttab4.intvec.193)) } > pfls4
    .inttab_tc4_0C2 (TEXT) BIND(__INTTAB_CPU4 + 0x1840) : {KEEP (*(.inttab4.intvec.194)) } > pfls4
    .inttab_tc4_0C3 (TEXT) BIND(__INTTAB_CPU4 + 0x1860) : {KEEP (*(.inttab4.intvec.195)) } > pfls4
    .inttab_tc4_0C4 (TEXT) BIND(__INTTAB_CPU4 + 0x1880) : {KEEP (*(.inttab4.intvec.196)) } > pfls4
    .inttab_tc4_0C5 (TEXT) BIND(__INTTAB_CPU4 + 0x18A0) : {KEEP (*(.inttab4.intvec.197)) } > pfls4
    .inttab_tc4_0C6 (TEXT) BIND(__INTTAB_CPU4 + 0x18C0) : {KEEP (*(.inttab4.intvec.198)) } > pfls4
    .inttab_tc4_0C7 (TEXT) BIND(__INTTAB_CPU4 + 0x18E0) : {KEEP (*(.inttab4.intvec.199)) } > pfls4
    .inttab_tc4_0C8 (TEXT) BIND(__INTTAB_CPU4 + 0x1900) : {KEEP (*(.inttab4.intvec.200)) } > pfls4
    .inttab_tc4_0C9 (TEXT) BIND(__INTTAB_CPU4 + 0x1920) : {KEEP (*(.inttab4.intvec.201)) } > pfls4
    .inttab_tc4_0CA (TEXT) BIND(__INTTAB_CPU4 + 0x1940) : {KEEP (*(.inttab4.intvec.202)) } > pfls4
    .inttab_tc4_0CB (TEXT) BIND(__INTTAB_CPU4 + 0x1960) : {KEEP (*(.inttab4.intvec.203)) } > pfls4
    .inttab_tc4_0CC (TEXT) BIND(__INTTAB_CPU4 + 0x1980) : {KEEP (*(.inttab4.intvec.204)) } > pfls4
    .inttab_tc4_0CD (TEXT) BIND(__INTTAB_CPU4 + 0x19A0) : {KEEP (*(.inttab4.intvec.205)) } > pfls4
    .inttab_tc4_0CE (TEXT) BIND(__INTTAB_CPU4 + 0x19C0) : {KEEP (*(.inttab4.intvec.206)) } > pfls4
    .inttab_tc4_0CF (TEXT) BIND(__INTTAB_CPU4 + 0x19E0) : {KEEP (*(.inttab4.intvec.207)) } > pfls4
    .inttab_tc4_0D0 (TEXT) BIND(__INTTAB_CPU4 + 0x1A00) : {KEEP (*(.inttab4.intvec.208)) } > pfls4
    .inttab_tc4_0D1 (TEXT) BIND(__INTTAB_CPU4 + 0x1A20) : {KEEP (*(.inttab4.intvec.209)) } > pfls4
    .inttab_tc4_0D2 (TEXT) BIND(__INTTAB_CPU4 + 0x1A40) : {KEEP (*(.inttab4.intvec.210)) } > pfls4
    .inttab_tc4_0D3 (TEXT) BIND(__INTTAB_CPU4 + 0x1A60) : {KEEP (*(.inttab4.intvec.211)) } > pfls4
    .inttab_tc4_0D4 (TEXT) BIND(__INTTAB_CPU4 + 0x1A80) : {KEEP (*(.inttab4.intvec.212)) } > pfls4
    .inttab_tc4_0D5 (TEXT) BIND(__INTTAB_CPU4 + 0x1AA0) : {KEEP (*(.inttab4.intvec.213)) } > pfls4
    .inttab_tc4_0D6 (TEXT) BIND(__INTTAB_CPU4 + 0x1AC0) : {KEEP (*(.inttab4.intvec.214)) } > pfls4
    .inttab_tc4_0D7 (TEXT) BIND(__INTTAB_CPU4 + 0x1AE0) : {KEEP (*(.inttab4.intvec.215)) } > pfls4
    .inttab_tc4_0D8 (TEXT) BIND(__INTTAB_CPU4 + 0x1B00) : {KEEP (*(.inttab4.intvec.216)) } > pfls4
    .inttab_tc4_0D9 (TEXT) BIND(__INTTAB_CPU4 + 0x1B20) : {KEEP (*(.inttab4.intvec.217)) } > pfls4
    .inttab_tc4_0DA (TEXT) BIND(__INTTAB_CPU4 + 0x1B40) : {KEEP (*(.inttab4.intvec.218)) } > pfls4
    .inttab_tc4_0DB (TEXT) BIND(__INTTAB_CPU4 + 0x1B60) : {KEEP (*(.inttab4.intvec.219)) } > pfls4
    .inttab_tc4_0DC (TEXT) BIND(__INTTAB_CPU4 + 0x1B80) : {KEEP (*(.inttab4.intvec.220)) } > pfls4
    .inttab_tc4_0DD (TEXT) BIND(__INTTAB_CPU4 + 0x1BA0) : {KEEP (*(.inttab4.intvec.221)) } > pfls4
    .inttab_tc4_0DE (TEXT) BIND(__INTTAB_CPU4 + 0x1BC0) : {KEEP (*(.inttab4.intvec.222)) } > pfls4
    .inttab_tc4_0DF (TEXT) BIND(__INTTAB_CPU4 + 0x1BE0) : {KEEP (*(.inttab4.intvec.223)) } > pfls4
    .inttab_tc4_0E0 (TEXT) BIND(__INTTAB_CPU4 + 0x1C00) : {KEEP (*(.inttab4.intvec.224)) } > pfls4
    .inttab_tc4_0E1 (TEXT) BIND(__INTTAB_CPU4 + 0x1C20) : {KEEP (*(.inttab4.intvec.225)) } > pfls4
    .inttab_tc4_0E2 (TEXT) BIND(__INTTAB_CPU4 + 0x1C40) : {KEEP (*(.inttab4.intvec.226)) } > pfls4
    .inttab_tc4_0E3 (TEXT) BIND(__INTTAB_CPU4 + 0x1C60) : {KEEP (*(.inttab4.intvec.227)) } > pfls4
    .inttab_tc4_0E4 (TEXT) BIND(__INTTAB_CPU4 + 0x1C80) : {KEEP (*(.inttab4.intvec.228)) } > pfls4
    .inttab_tc4_0E5 (TEXT) BIND(__INTTAB_CPU4 + 0x1CA0) : {KEEP (*(.inttab4.intvec.229)) } > pfls4
    .inttab_tc4_0E6 (TEXT) BIND(__INTTAB_CPU4 + 0x1CC0) : {KEEP (*(.inttab4.intvec.230)) } > pfls4
    .inttab_tc4_0E7 (TEXT) BIND(__INTTAB_CPU4 + 0x1CE0) : {KEEP (*(.inttab4.intvec.231)) } > pfls4
    .inttab_tc4_0E8 (TEXT) BIND(__INTTAB_CPU4 + 0x1D00) : {KEEP (*(.inttab4.intvec.232)) } > pfls4
    .inttab_tc4_0E9 (TEXT) BIND(__INTTAB_CPU4 + 0x1D20) : {KEEP (*(.inttab4.intvec.233)) } > pfls4
    .inttab_tc4_0EA (TEXT) BIND(__INTTAB_CPU4 + 0x1D40) : {KEEP (*(.inttab4.intvec.234)) } > pfls4
    .inttab_tc4_0EB (TEXT) BIND(__INTTAB_CPU4 + 0x1D60) : {KEEP (*(.inttab4.intvec.235)) } > pfls4
    .inttab_tc4_0EC (TEXT) BIND(__INTTAB_CPU4 + 0x1D80) : {KEEP (*(.inttab4.intvec.236)) } > pfls4
    .inttab_tc4_0ED (TEXT) BIND(__INTTAB_CPU4 + 0x1DA0) : {KEEP (*(.inttab4.intvec.237)) } > pfls4
    .inttab_tc4_0EE (TEXT) BIND(__INTTAB_CPU4 + 0x1DC0) : {KEEP (*(.inttab4.intvec.238)) } > pfls4
    .inttab_tc4_0EF (TEXT) BIND(__INTTAB_CPU4 + 0x1DE0) : {KEEP (*(.inttab4.intvec.239)) } > pfls4
    .inttab_tc4_0F0 (TEXT) BIND(__INTTAB_CPU4 + 0x1E00) : {KEEP (*(.inttab4.intvec.240)) } > pfls4
    .inttab_tc4_0F1 (TEXT) BIND(__INTTAB_CPU4 + 0x1E20) : {KEEP (*(.inttab4.intvec.241)) } > pfls4
    .inttab_tc4_0F2 (TEXT) BIND(__INTTAB_CPU4 + 0x1E40) : {KEEP (*(.inttab4.intvec.242)) } > pfls4
    .inttab_tc4_0F3 (TEXT) BIND(__INTTAB_CPU4 + 0x1E60) : {KEEP (*(.inttab4.intvec.243)) } > pfls4
    .inttab_tc4_0F4 (TEXT) BIND(__INTTAB_CPU4 + 0x1E80) : {KEEP (*(.inttab4.intvec.244)) } > pfls4
    .inttab_tc4_0F5 (TEXT) BIND(__INTTAB_CPU4 + 0x1EA0) : {KEEP (*(.inttab4.intvec.245)) } > pfls4
    .inttab_tc4_0F6 (TEXT) BIND(__INTTAB_CPU4 + 0x1EC0) : {KEEP (*(.inttab4.intvec.246)) } > pfls4
    .inttab_tc4_0F7 (TEXT) BIND(__INTTAB_CPU4 + 0x1EE0) : {KEEP (*(.inttab4.intvec.247)) } > pfls4
    .inttab_tc4_0F8 (TEXT) BIND(__INTTAB_CPU4 + 0x1F00) : {KEEP (*(.inttab4.intvec.248)) } > pfls4
    .inttab_tc4_0F9 (TEXT) BIND(__INTTAB_CPU4 + 0x1F20) : {KEEP (*(.inttab4.intvec.249)) } > pfls4
    .inttab_tc4_0FA (TEXT) BIND(__INTTAB_CPU4 + 0x1F40) : {KEEP (*(.inttab4.intvec.250)) } > pfls4
    .inttab_tc4_0FB (TEXT) BIND(__INTTAB_CPU4 + 0x1F60) : {KEEP (*(.inttab4.intvec.251)) } > pfls4
    .inttab_tc4_0FC (TEXT) BIND(__INTTAB_CPU4 + 0x1F80) : {KEEP (*(.inttab4.intvec.252)) } > pfls4
    .inttab_tc4_0FD (TEXT) BIND(__INTTAB_CPU4 + 0x1FA0) : {KEEP (*(.inttab4.intvec.253)) } > pfls4
    .inttab_tc4_0FE (TEXT) BIND(__INTTAB_CPU4 + 0x1FC0) : {KEEP (*(.inttab4.intvec.254)) } > pfls4
    .inttab_tc4_0FF (TEXT) BIND(__INTTAB_CPU4 + 0x1FE0) : {KEEP (*(.inttab4.intvec.255)) } > pfls4

}