
-Xgenerate-copytables

LCF_CSA2_SIZE    = 8k;
LCF_USTACK2_SIZE = 2k;
LCF_ISTACK2_SIZE = 1k;

LCF_HEAP_SIZE = 4k;

LCF_PPU_FLASH_SIZE  = 1M;
LCF_PPU_LMURAM_SIZE = 512k;
LCF_PPU_CSM_SIZE    = 512k;

LCF_DSPR2_START = 0x50000000;
LCF_DSPR2_SIZE  = 240K;




LCF_CSA2_OFFSET    = (LCF_DSPR2_SIZE - 1k - LCF_CSA2_SIZE);
LCF_ISTACK2_OFFSET = (LCF_CSA2_OFFSET - 256 - LCF_ISTACK2_SIZE);
LCF_USTACK2_OFFSET = (LCF_ISTACK2_OFFSET - 256 - LCF_USTACK2_SIZE);

LCF_HEAP2_OFFSET = (LCF_USTACK2_OFFSET - LCF_HEAP_SIZE);

LCF_INTVEC2_START = 0x809FE000;


__INTTAB_CPU2 = LCF_INTVEC2_START;
 



LCF_TRAPVEC2_START = 0x80800100;

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


RESET = LCF_STARTPTR_NC_CPU2;

 
 



MEMORY
{
    dsram2: org = 0x50000000, len = 240K
    psram2: org = 0x50100000, len = 64K
	

    pfls2: org = 0x80800000, len = 2M
    pfls2_nc: org = 0xa0800000, len = 2M
	
    pfls5: org = 0x81200000, len = 2M - 1M
    pfls5_nc: org = 0xa1200000, len = 2M - 1M
	


    ucb: org = 0xae400000, len = 80K

    cpu2_dlmu: org = 0x90100000, len = 512K
    cpu2_dlmu_nc: org = 0xb0100000, len = 512K
	
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
    /* CPU2 Stack and CSA defines */
    CPU2.ustack BIND(LCF_DSPR2_START + LCF_USTACK2_OFFSET) :
    { __USTACK2_END = . ;    . = . + LCF_USTACK2_SIZE;    __USTACK2 = . ; }
    
    CPU2.istack BIND(LCF_DSPR2_START + LCF_ISTACK2_OFFSET):
    { __ISTACK2_END = . ;    . = . + LCF_ISTACK2_SIZE;    __ISTACK2 = . ; }
    
    CPU2.csa BIND(LCF_DSPR2_START + LCF_CSA2_OFFSET):
    { __CSA2 = . ;    . = . + LCF_CSA2_SIZE;    __CSA2_END = . ; }
	
	


    __SP_END = __USTACK2_END;

    /*Fixed memory Allocations*/
    __IF_CONST = 0x80000020;


    /*Fixed memory Allocations for Trap Vector Table*/
    .traptab_tc2 (TEXT) BIND(LCF_TRAPVEC2_START) : { __TRAPTAB_CPU2 = .; KEEP (*(.traptab_cpu2)) } > pfls2
    /DISCARD/ :
    { 
        *(.traptab_cpu0)
        *(.traptab_cpu1)
        *(.traptab_cpu3)
        *(.traptab_cpu4)
	*(.traptab_cpu5)
        *(.interface_const)
    }

    /*Fixed memory Allocations for _START CPU2 */
    .start_tc2 (TEXT) LOAD(LCF_STARTPTR_CPU2) BIND(LCF_STARTPTR_NC_CPU2) : { __ENABLE_INDIVIDUAL_C_INIT_CPU2 = 1; KEEP (*(.start_cpu2)) } =0x800 > pfls2_nc
    __START0 = LCF_STARTPTR_NC_CPU0;
    __START1 = LCF_STARTPTR_NC_CPU1;
    __START2 = LCF_STARTPTR_NC_CPU2;
    __START3 = LCF_STARTPTR_NC_CPU3;
    __START4 = LCF_STARTPTR_NC_CPU4;
    __START5 = LCF_STARTPTR_NC_CPU5;

    /*Near Absolute Addressable Data Sections*/
    GROUP LOAD(> pfls2) COPYTABLE :
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
	
	
	

    /*Near Absolute Data, selectable by toolchain*/
    GROUP LOAD(> pfls2) COPYTABLE :
    {
        .zdata (DATA) :
        {
            *(.zdata.dsprInit.cpu2.32bit)
            *(.zdata.dsprInit.cpu2.16bit)
            *(.zdata.dsprInit.cpu2.8bit)
            *(.zdata)
        }
        
        .zdata_powerOn (DATA) :
        {
            *(.zdata.dsprPowerOnInit.cpu2.32bit)
            *(.zdata.dsprPowerOnInit.cpu2.16bit)
            *(.zdata.dsprPowerOnInit.cpu2.8bit)
        }
        
        .zbss (BSS) :
        {
            *(.zbss.dsprClearOnInit.cpu2.32bit)
            *(.zbss.dsprClearOnInit.cpu2.16bit)
            *(.zbss.dsprClearOnInit.cpu2.8bit)
            *(.zbss)
        }
        
        .zbss_powerOn (BSS) :
        {
            *(.zbss.dsprPowerOnClear.cpu2.32bit)
            *(.zbss.dsprPowerOnClear.cpu2.16bit)
            *(.zbss.dsprPowerOnClear.cpu2.8bit)
        }
        
        .zbss_noClear (BSS) :
        {
            *(.zbss.dsprNoInit.cpu2.32bit)
            *(.zbss.dsprNoInit.cpu2.16bit)
            *(.zbss.dsprNoInit.cpu2.8bit)
        }
		
		
    } > dsram2

    /*Relative A0/A1/A8/A9 Addressable Sections*/
    /*Relative A0 Addressable Data, selectable with patterns and user defined sections*/
    /*Note: A0 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A0 Addressable Data, selectable by toolchain*/
    GROUP LOAD(> pfls2) COPYTABLE :
	
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
    } > dsram2

    /*Relative A1 Addressable Const, selectable with patterns and user defined sections*/
    /*Note: A1 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A1 Addressable Const, selectable by toolchain*/
    GROUP :
    {
        .zrodata (CONST) :
        {
            *Ifx_Ssw_Tc2.* (.zrodata)
            *Cpu2_Main.* (.zrodata)
            *(.zrodata.const.cpu2.32bit)
            *(.zrodata.const.cpu2.16bit)
            *(.zrodata.const.cpu2.8bit)
            *(.zrodata.config.cpu2.32bit)
            *(.zrodata.config.cpu2.16bit)
            *(.zrodata.config.cpu2.8bit)
            *(.zrodata_cpu2)
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
    } > pfls2

    /*LMU memory sections*/
    GROUP LOAD(> pfls2) COPYTABLE :
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
    /*Relative A9 Addressable Data, selectable with patterns and user defined sections*/
    GROUP LOAD(> pfls2) COPYTABLE: 
	
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
    } > cpu2_dlmu

    GROUP LOAD(> pfls2) COPYTABLE :
    {
        .lmudata (DATA) :
        {
            *(.lmudata)
        }
        
        .lmubss (BSS) :
        {
            *(.lmubss)
        }
    } > cpu2_dlmu
	
    GROUP LOAD(> pfls2) :
    {
        .ppu_lmuram  :
        {
            . = ALIGN(4);
            __PPU_LMURAM_START = .;
            . += LCF_PPU_LMURAM_SIZE;
            __PPU_LMURAM_END = .;
        }
    } > ppu_lmuram_nc
	
    GROUP LOAD(> pfls2) :
    {
        .ppu_csm :
        {
        . = ALIGN(4);
        __PPU_CSM_START = .;
        . += LCF_PPU_CSM_SIZE;
        __PPU_CSM_END = .;
        }
    } > ppu_csm_nc
    
    GROUP LOAD(> pfls2) :
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
    } > pfls2

    __A8_MEM = SIZEOF(.rodata_a8) ? ADDR(.rodata_a8) : (ADDR(.rodata_a8) & 0xF0000000) + 32k ;
    
    /*Far Data / Far Const Sections, selectable with patterns and user defined sections*/
    /*Far Data Sections, selectable with patterns and user defined sections*/
    GROUP LOAD(> pfls2) COPYTABLE :
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
    /*Far Data Sections, selectable by toolchain*/
    GROUP LOAD(> pfls2) COPYTABLE :
	
    {
        .data (DATA) :
        {
            *(.data.farDsprInit.cpu2.32bit)
            *(.data.farDsprInit.cpu2.16bit)
            *(.data.farDsprInit.cpu2.8bit)
            *(.data)
        }
        
        .bss (BSS) :
        {
            *(.bss.farDsprClearOnInit.cpu2.32bit)
            *(.bss.farDsprClearOnInit.cpu2.16bit)
            *(.bss.farDsprClearOnInit.cpu2.8bit)
            *(.bss)
        }
        
        .bss_noClear (BSS) :
        {
            *(.bss.farDsprNoInit.cpu2.32bit)
            *(.bss.farDsprNoInit.cpu2.16bit)
            *(.bss.farDsprNoInit.cpu2.8bit)
        }
        
        .heap  :
        {
            . = ALIGN(4);
            __HEAP = .;
            __HEAP_START = .;
            __HEAP_END = . + LCF_HEAP_SIZE;
        }
    } > dsram2

    /* Far Const Sections, selectable with patterns and user defined sections */
    /* CPU2 Const Sections */
    CPU2.rodata (CONST) :
    {
        "*Ifx_Ssw_Tc2.*" (.rodata)
        "*Cpu2_Main.*" (.rodata)
        *(.rodata_cpu2)
    } > pfls2
	
    /*Far Const Sections, selectable by toolchain*/
    GROUP :
    {
        .rodata (CONST) :
        {
            *(.rodata)
            *(.rodata.farConst.cpu2.32bit)
            *(.rodata.farConst.cpu2.16bit)
            *(.rodata.farConst.cpu2.8bit)
        }
        
        .copytable (CONST) :
        {
            __DATA_ROM = .;
        }
    } > pfls2

    /*Code selections*/
    /*Code Sections, selectable with patterns and user defined sections*/
    /* CPU2 Code Sections */
    CPU2.text (TEXT) :
    {
        . = ALIGN(2);
        "*Ifx_Ssw_Tc2.*" (.text)
        "*Cpu2_Main.*" (.text)
        *(.text_cpu2)
    } > pfls2
    
    CPU2.psram_text (TEXT) LOAD(> pfls2) COPYTABLE :
    {
        . = ALIGN(2);
        *(.psram_text_cpu2)
        *(.cpu2_psram)
    } > psram2
	
	

    /*Code Sections, selectable by toolchain*/
    GROUP :
    {
        .text (TEXT) :
        {
            . = ALIGN(2);
            *(.text)
            *(.text.fast.pfls.cpu2)
            *(.text.slow.pfls.cpu2)
            *(.text.5ms.pfls.cpu2)
            *(.text.10ms.pfls.cpu2)
            *(.text.callout.pfls.cpu2)
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
    } > pfls2


    /* CPU2 Interrupt Vector Table */
    .inttab_tc2_000 (TEXT) BIND(__INTTAB_CPU2 + 0x0000) : {KEEP (*(.inttab2.intvec.0  )) } > pfls2
    .inttab_tc2_001 (TEXT) BIND(__INTTAB_CPU2 + 0x0020) : {KEEP (*(.inttab2.intvec.1  )) } > pfls2
    .inttab_tc2_002 (TEXT) BIND(__INTTAB_CPU2 + 0x0040) : {KEEP (*(.inttab2.intvec.2  )) } > pfls2
    .inttab_tc2_003 (TEXT) BIND(__INTTAB_CPU2 + 0x0060) : {KEEP (*(.inttab2.intvec.3  )) } > pfls2
    .inttab_tc2_004 (TEXT) BIND(__INTTAB_CPU2 + 0x0080) : {KEEP (*(.inttab2.intvec.4  )) } > pfls2
    .inttab_tc2_005 (TEXT) BIND(__INTTAB_CPU2 + 0x00A0) : {KEEP (*(.inttab2.intvec.5  )) } > pfls2
    .inttab_tc2_006 (TEXT) BIND(__INTTAB_CPU2 + 0x00C0) : {KEEP (*(.inttab2.intvec.6  )) } > pfls2
    .inttab_tc2_007 (TEXT) BIND(__INTTAB_CPU2 + 0x00E0) : {KEEP (*(.inttab2.intvec.7  )) } > pfls2
    .inttab_tc2_008 (TEXT) BIND(__INTTAB_CPU2 + 0x0100) : {KEEP (*(.inttab2.intvec.8  )) } > pfls2
    .inttab_tc2_009 (TEXT) BIND(__INTTAB_CPU2 + 0x0120) : {KEEP (*(.inttab2.intvec.9  )) } > pfls2
    .inttab_tc2_00A (TEXT) BIND(__INTTAB_CPU2 + 0x0140) : {KEEP (*(.inttab2.intvec.10 )) } > pfls2
    .inttab_tc2_00B (TEXT) BIND(__INTTAB_CPU2 + 0x0160) : {KEEP (*(.inttab2.intvec.11 )) } > pfls2
    .inttab_tc2_00C (TEXT) BIND(__INTTAB_CPU2 + 0x0180) : {KEEP (*(.inttab2.intvec.12 )) } > pfls2
    .inttab_tc2_00D (TEXT) BIND(__INTTAB_CPU2 + 0x01A0) : {KEEP (*(.inttab2.intvec.13 )) } > pfls2
    .inttab_tc2_00E (TEXT) BIND(__INTTAB_CPU2 + 0x01C0) : {KEEP (*(.inttab2.intvec.14 )) } > pfls2
    .inttab_tc2_00F (TEXT) BIND(__INTTAB_CPU2 + 0x01E0) : {KEEP (*(.inttab2.intvec.15 )) } > pfls2
    .inttab_tc2_010 (TEXT) BIND(__INTTAB_CPU2 + 0x0200) : {KEEP (*(.inttab2.intvec.16 )) } > pfls2
    .inttab_tc2_011 (TEXT) BIND(__INTTAB_CPU2 + 0x0220) : {KEEP (*(.inttab2.intvec.17 )) } > pfls2
    .inttab_tc2_012 (TEXT) BIND(__INTTAB_CPU2 + 0x0240) : {KEEP (*(.inttab2.intvec.18 )) } > pfls2
    .inttab_tc2_013 (TEXT) BIND(__INTTAB_CPU2 + 0x0260) : {KEEP (*(.inttab2.intvec.19 )) } > pfls2
    .inttab_tc2_014 (TEXT) BIND(__INTTAB_CPU2 + 0x0280) : {KEEP (*(.inttab2.intvec.20 )) } > pfls2
    .inttab_tc2_015 (TEXT) BIND(__INTTAB_CPU2 + 0x02A0) : {KEEP (*(.inttab2.intvec.21 )) } > pfls2
    .inttab_tc2_016 (TEXT) BIND(__INTTAB_CPU2 + 0x02C0) : {KEEP (*(.inttab2.intvec.22 )) } > pfls2
    .inttab_tc2_017 (TEXT) BIND(__INTTAB_CPU2 + 0x02E0) : {KEEP (*(.inttab2.intvec.23 )) } > pfls2
    .inttab_tc2_018 (TEXT) BIND(__INTTAB_CPU2 + 0x0300) : {KEEP (*(.inttab2.intvec.24 )) } > pfls2
    .inttab_tc2_019 (TEXT) BIND(__INTTAB_CPU2 + 0x0320) : {KEEP (*(.inttab2.intvec.25 )) } > pfls2
    .inttab_tc2_01A (TEXT) BIND(__INTTAB_CPU2 + 0x0340) : {KEEP (*(.inttab2.intvec.26 )) } > pfls2
    .inttab_tc2_01B (TEXT) BIND(__INTTAB_CPU2 + 0x0360) : {KEEP (*(.inttab2.intvec.27 )) } > pfls2
    .inttab_tc2_01C (TEXT) BIND(__INTTAB_CPU2 + 0x0380) : {KEEP (*(.inttab2.intvec.28 )) } > pfls2
    .inttab_tc2_01D (TEXT) BIND(__INTTAB_CPU2 + 0x03A0) : {KEEP (*(.inttab2.intvec.29 )) } > pfls2
    .inttab_tc2_01E (TEXT) BIND(__INTTAB_CPU2 + 0x03C0) : {KEEP (*(.inttab2.intvec.30 )) } > pfls2
    .inttab_tc2_01F (TEXT) BIND(__INTTAB_CPU2 + 0x03E0) : {KEEP (*(.inttab2.intvec.31 )) } > pfls2
    .inttab_tc2_020 (TEXT) BIND(__INTTAB_CPU2 + 0x0400) : {KEEP (*(.inttab2.intvec.32 )) } > pfls2
    .inttab_tc2_021 (TEXT) BIND(__INTTAB_CPU2 + 0x0420) : {KEEP (*(.inttab2.intvec.33 )) } > pfls2
    .inttab_tc2_022 (TEXT) BIND(__INTTAB_CPU2 + 0x0440) : {KEEP (*(.inttab2.intvec.34 )) } > pfls2
    .inttab_tc2_023 (TEXT) BIND(__INTTAB_CPU2 + 0x0460) : {KEEP (*(.inttab2.intvec.35 )) } > pfls2
    .inttab_tc2_024 (TEXT) BIND(__INTTAB_CPU2 + 0x0480) : {KEEP (*(.inttab2.intvec.36 )) } > pfls2
    .inttab_tc2_025 (TEXT) BIND(__INTTAB_CPU2 + 0x04A0) : {KEEP (*(.inttab2.intvec.37 )) } > pfls2
    .inttab_tc2_026 (TEXT) BIND(__INTTAB_CPU2 + 0x04C0) : {KEEP (*(.inttab2.intvec.38 )) } > pfls2
    .inttab_tc2_027 (TEXT) BIND(__INTTAB_CPU2 + 0x04E0) : {KEEP (*(.inttab2.intvec.39 )) } > pfls2
    .inttab_tc2_028 (TEXT) BIND(__INTTAB_CPU2 + 0x0500) : {KEEP (*(.inttab2.intvec.40 )) } > pfls2
    .inttab_tc2_029 (TEXT) BIND(__INTTAB_CPU2 + 0x0520) : {KEEP (*(.inttab2.intvec.41 )) } > pfls2
    .inttab_tc2_02A (TEXT) BIND(__INTTAB_CPU2 + 0x0540) : {KEEP (*(.inttab2.intvec.42 )) } > pfls2
    .inttab_tc2_02B (TEXT) BIND(__INTTAB_CPU2 + 0x0560) : {KEEP (*(.inttab2.intvec.43 )) } > pfls2
    .inttab_tc2_02C (TEXT) BIND(__INTTAB_CPU2 + 0x0580) : {KEEP (*(.inttab2.intvec.44 )) } > pfls2
    .inttab_tc2_02D (TEXT) BIND(__INTTAB_CPU2 + 0x05A0) : {KEEP (*(.inttab2.intvec.45 )) } > pfls2
    .inttab_tc2_02E (TEXT) BIND(__INTTAB_CPU2 + 0x05C0) : {KEEP (*(.inttab2.intvec.46 )) } > pfls2
    .inttab_tc2_02F (TEXT) BIND(__INTTAB_CPU2 + 0x05E0) : {KEEP (*(.inttab2.intvec.47 )) } > pfls2
    .inttab_tc2_030 (TEXT) BIND(__INTTAB_CPU2 + 0x0600) : {KEEP (*(.inttab2.intvec.48 )) } > pfls2
    .inttab_tc2_031 (TEXT) BIND(__INTTAB_CPU2 + 0x0620) : {KEEP (*(.inttab2.intvec.49 )) } > pfls2
    .inttab_tc2_032 (TEXT) BIND(__INTTAB_CPU2 + 0x0640) : {KEEP (*(.inttab2.intvec.50 )) } > pfls2
    .inttab_tc2_033 (TEXT) BIND(__INTTAB_CPU2 + 0x0660) : {KEEP (*(.inttab2.intvec.51 )) } > pfls2
    .inttab_tc2_034 (TEXT) BIND(__INTTAB_CPU2 + 0x0680) : {KEEP (*(.inttab2.intvec.52 )) } > pfls2
    .inttab_tc2_035 (TEXT) BIND(__INTTAB_CPU2 + 0x06A0) : {KEEP (*(.inttab2.intvec.53 )) } > pfls2
    .inttab_tc2_036 (TEXT) BIND(__INTTAB_CPU2 + 0x06C0) : {KEEP (*(.inttab2.intvec.54 )) } > pfls2
    .inttab_tc2_037 (TEXT) BIND(__INTTAB_CPU2 + 0x06E0) : {KEEP (*(.inttab2.intvec.55 )) } > pfls2
    .inttab_tc2_038 (TEXT) BIND(__INTTAB_CPU2 + 0x0700) : {KEEP (*(.inttab2.intvec.56 )) } > pfls2
    .inttab_tc2_039 (TEXT) BIND(__INTTAB_CPU2 + 0x0720) : {KEEP (*(.inttab2.intvec.57 )) } > pfls2
    .inttab_tc2_03A (TEXT) BIND(__INTTAB_CPU2 + 0x0740) : {KEEP (*(.inttab2.intvec.58 )) } > pfls2
    .inttab_tc2_03B (TEXT) BIND(__INTTAB_CPU2 + 0x0760) : {KEEP (*(.inttab2.intvec.59 )) } > pfls2
    .inttab_tc2_03C (TEXT) BIND(__INTTAB_CPU2 + 0x0780) : {KEEP (*(.inttab2.intvec.60 )) } > pfls2
    .inttab_tc2_03D (TEXT) BIND(__INTTAB_CPU2 + 0x07A0) : {KEEP (*(.inttab2.intvec.61 )) } > pfls2
    .inttab_tc2_03E (TEXT) BIND(__INTTAB_CPU2 + 0x07C0) : {KEEP (*(.inttab2.intvec.62 )) } > pfls2
    .inttab_tc2_03F (TEXT) BIND(__INTTAB_CPU2 + 0x07E0) : {KEEP (*(.inttab2.intvec.63 )) } > pfls2
    .inttab_tc2_040 (TEXT) BIND(__INTTAB_CPU2 + 0x0800) : {KEEP (*(.inttab2.intvec.64 )) } > pfls2
    .inttab_tc2_041 (TEXT) BIND(__INTTAB_CPU2 + 0x0820) : {KEEP (*(.inttab2.intvec.65 )) } > pfls2
    .inttab_tc2_042 (TEXT) BIND(__INTTAB_CPU2 + 0x0840) : {KEEP (*(.inttab2.intvec.66 )) } > pfls2
    .inttab_tc2_043 (TEXT) BIND(__INTTAB_CPU2 + 0x0860) : {KEEP (*(.inttab2.intvec.67 )) } > pfls2
    .inttab_tc2_044 (TEXT) BIND(__INTTAB_CPU2 + 0x0880) : {KEEP (*(.inttab2.intvec.68 )) } > pfls2
    .inttab_tc2_045 (TEXT) BIND(__INTTAB_CPU2 + 0x08A0) : {KEEP (*(.inttab2.intvec.69 )) } > pfls2
    .inttab_tc2_046 (TEXT) BIND(__INTTAB_CPU2 + 0x08C0) : {KEEP (*(.inttab2.intvec.70 )) } > pfls2
    .inttab_tc2_047 (TEXT) BIND(__INTTAB_CPU2 + 0x08E0) : {KEEP (*(.inttab2.intvec.71 )) } > pfls2
    .inttab_tc2_048 (TEXT) BIND(__INTTAB_CPU2 + 0x0900) : {KEEP (*(.inttab2.intvec.72 )) } > pfls2
    .inttab_tc2_049 (TEXT) BIND(__INTTAB_CPU2 + 0x0920) : {KEEP (*(.inttab2.intvec.73 )) } > pfls2
    .inttab_tc2_04A (TEXT) BIND(__INTTAB_CPU2 + 0x0940) : {KEEP (*(.inttab2.intvec.74 )) } > pfls2
    .inttab_tc2_04B (TEXT) BIND(__INTTAB_CPU2 + 0x0960) : {KEEP (*(.inttab2.intvec.75 )) } > pfls2
    .inttab_tc2_04C (TEXT) BIND(__INTTAB_CPU2 + 0x0980) : {KEEP (*(.inttab2.intvec.76 )) } > pfls2
    .inttab_tc2_04D (TEXT) BIND(__INTTAB_CPU2 + 0x09A0) : {KEEP (*(.inttab2.intvec.77 )) } > pfls2
    .inttab_tc2_04E (TEXT) BIND(__INTTAB_CPU2 + 0x09C0) : {KEEP (*(.inttab2.intvec.78 )) } > pfls2
    .inttab_tc2_04F (TEXT) BIND(__INTTAB_CPU2 + 0x09E0) : {KEEP (*(.inttab2.intvec.79 )) } > pfls2
    .inttab_tc2_050 (TEXT) BIND(__INTTAB_CPU2 + 0x0A00) : {KEEP (*(.inttab2.intvec.80 )) } > pfls2
    .inttab_tc2_051 (TEXT) BIND(__INTTAB_CPU2 + 0x0A20) : {KEEP (*(.inttab2.intvec.81 )) } > pfls2
    .inttab_tc2_052 (TEXT) BIND(__INTTAB_CPU2 + 0x0A40) : {KEEP (*(.inttab2.intvec.82 )) } > pfls2
    .inttab_tc2_053 (TEXT) BIND(__INTTAB_CPU2 + 0x0A60) : {KEEP (*(.inttab2.intvec.83 )) } > pfls2
    .inttab_tc2_054 (TEXT) BIND(__INTTAB_CPU2 + 0x0A80) : {KEEP (*(.inttab2.intvec.84 )) } > pfls2
    .inttab_tc2_055 (TEXT) BIND(__INTTAB_CPU2 + 0x0AA0) : {KEEP (*(.inttab2.intvec.85 )) } > pfls2
    .inttab_tc2_056 (TEXT) BIND(__INTTAB_CPU2 + 0x0AC0) : {KEEP (*(.inttab2.intvec.86 )) } > pfls2
    .inttab_tc2_057 (TEXT) BIND(__INTTAB_CPU2 + 0x0AE0) : {KEEP (*(.inttab2.intvec.87 )) } > pfls2
    .inttab_tc2_058 (TEXT) BIND(__INTTAB_CPU2 + 0x0B00) : {KEEP (*(.inttab2.intvec.88 )) } > pfls2
    .inttab_tc2_059 (TEXT) BIND(__INTTAB_CPU2 + 0x0B20) : {KEEP (*(.inttab2.intvec.89 )) } > pfls2
    .inttab_tc2_05A (TEXT) BIND(__INTTAB_CPU2 + 0x0B40) : {KEEP (*(.inttab2.intvec.90 )) } > pfls2
    .inttab_tc2_05B (TEXT) BIND(__INTTAB_CPU2 + 0x0B60) : {KEEP (*(.inttab2.intvec.91 )) } > pfls2
    .inttab_tc2_05C (TEXT) BIND(__INTTAB_CPU2 + 0x0B80) : {KEEP (*(.inttab2.intvec.92 )) } > pfls2
    .inttab_tc2_05D (TEXT) BIND(__INTTAB_CPU2 + 0x0BA0) : {KEEP (*(.inttab2.intvec.93 )) } > pfls2
    .inttab_tc2_05E (TEXT) BIND(__INTTAB_CPU2 + 0x0BC0) : {KEEP (*(.inttab2.intvec.94 )) } > pfls2
    .inttab_tc2_05F (TEXT) BIND(__INTTAB_CPU2 + 0x0BE0) : {KEEP (*(.inttab2.intvec.95 )) } > pfls2
    .inttab_tc2_060 (TEXT) BIND(__INTTAB_CPU2 + 0x0C00) : {KEEP (*(.inttab2.intvec.96 )) } > pfls2
    .inttab_tc2_061 (TEXT) BIND(__INTTAB_CPU2 + 0x0C20) : {KEEP (*(.inttab2.intvec.97 )) } > pfls2
    .inttab_tc2_062 (TEXT) BIND(__INTTAB_CPU2 + 0x0C40) : {KEEP (*(.inttab2.intvec.98 )) } > pfls2
    .inttab_tc2_063 (TEXT) BIND(__INTTAB_CPU2 + 0x0C60) : {KEEP (*(.inttab2.intvec.99 )) } > pfls2
    .inttab_tc2_064 (TEXT) BIND(__INTTAB_CPU2 + 0x0C80) : {KEEP (*(.inttab2.intvec.100)) } > pfls2
    .inttab_tc2_065 (TEXT) BIND(__INTTAB_CPU2 + 0x0CA0) : {KEEP (*(.inttab2.intvec.101)) } > pfls2
    .inttab_tc2_066 (TEXT) BIND(__INTTAB_CPU2 + 0x0CC0) : {KEEP (*(.inttab2.intvec.102)) } > pfls2
    .inttab_tc2_067 (TEXT) BIND(__INTTAB_CPU2 + 0x0CE0) : {KEEP (*(.inttab2.intvec.103)) } > pfls2
    .inttab_tc2_068 (TEXT) BIND(__INTTAB_CPU2 + 0x0D00) : {KEEP (*(.inttab2.intvec.104)) } > pfls2
    .inttab_tc2_069 (TEXT) BIND(__INTTAB_CPU2 + 0x0D20) : {KEEP (*(.inttab2.intvec.105)) } > pfls2
    .inttab_tc2_06A (TEXT) BIND(__INTTAB_CPU2 + 0x0D40) : {KEEP (*(.inttab2.intvec.106)) } > pfls2
    .inttab_tc2_06B (TEXT) BIND(__INTTAB_CPU2 + 0x0D60) : {KEEP (*(.inttab2.intvec.107)) } > pfls2
    .inttab_tc2_06C (TEXT) BIND(__INTTAB_CPU2 + 0x0D80) : {KEEP (*(.inttab2.intvec.108)) } > pfls2
    .inttab_tc2_06D (TEXT) BIND(__INTTAB_CPU2 + 0x0DA0) : {KEEP (*(.inttab2.intvec.109)) } > pfls2
    .inttab_tc2_06E (TEXT) BIND(__INTTAB_CPU2 + 0x0DC0) : {KEEP (*(.inttab2.intvec.110)) } > pfls2
    .inttab_tc2_06F (TEXT) BIND(__INTTAB_CPU2 + 0x0DE0) : {KEEP (*(.inttab2.intvec.111)) } > pfls2
    .inttab_tc2_070 (TEXT) BIND(__INTTAB_CPU2 + 0x0E00) : {KEEP (*(.inttab2.intvec.112)) } > pfls2
    .inttab_tc2_071 (TEXT) BIND(__INTTAB_CPU2 + 0x0E20) : {KEEP (*(.inttab2.intvec.113)) } > pfls2
    .inttab_tc2_072 (TEXT) BIND(__INTTAB_CPU2 + 0x0E40) : {KEEP (*(.inttab2.intvec.114)) } > pfls2
    .inttab_tc2_073 (TEXT) BIND(__INTTAB_CPU2 + 0x0E60) : {KEEP (*(.inttab2.intvec.115)) } > pfls2
    .inttab_tc2_074 (TEXT) BIND(__INTTAB_CPU2 + 0x0E80) : {KEEP (*(.inttab2.intvec.116)) } > pfls2
    .inttab_tc2_075 (TEXT) BIND(__INTTAB_CPU2 + 0x0EA0) : {KEEP (*(.inttab2.intvec.117)) } > pfls2
    .inttab_tc2_076 (TEXT) BIND(__INTTAB_CPU2 + 0x0EC0) : {KEEP (*(.inttab2.intvec.118)) } > pfls2
    .inttab_tc2_077 (TEXT) BIND(__INTTAB_CPU2 + 0x0EE0) : {KEEP (*(.inttab2.intvec.119)) } > pfls2
    .inttab_tc2_078 (TEXT) BIND(__INTTAB_CPU2 + 0x0F00) : {KEEP (*(.inttab2.intvec.120)) } > pfls2
    .inttab_tc2_079 (TEXT) BIND(__INTTAB_CPU2 + 0x0F20) : {KEEP (*(.inttab2.intvec.121)) } > pfls2
    .inttab_tc2_07A (TEXT) BIND(__INTTAB_CPU2 + 0x0F40) : {KEEP (*(.inttab2.intvec.122)) } > pfls2
    .inttab_tc2_07B (TEXT) BIND(__INTTAB_CPU2 + 0x0F60) : {KEEP (*(.inttab2.intvec.123)) } > pfls2
    .inttab_tc2_07C (TEXT) BIND(__INTTAB_CPU2 + 0x0F80) : {KEEP (*(.inttab2.intvec.124)) } > pfls2
    .inttab_tc2_07D (TEXT) BIND(__INTTAB_CPU2 + 0x0FA0) : {KEEP (*(.inttab2.intvec.125)) } > pfls2
    .inttab_tc2_07E (TEXT) BIND(__INTTAB_CPU2 + 0x0FC0) : {KEEP (*(.inttab2.intvec.126)) } > pfls2
    .inttab_tc2_07F (TEXT) BIND(__INTTAB_CPU2 + 0x0FE0) : {KEEP (*(.inttab2.intvec.127)) } > pfls2
    .inttab_tc2_080 (TEXT) BIND(__INTTAB_CPU2 + 0x1000) : {KEEP (*(.inttab2.intvec.128)) } > pfls2
    .inttab_tc2_081 (TEXT) BIND(__INTTAB_CPU2 + 0x1020) : {KEEP (*(.inttab2.intvec.129)) } > pfls2
    .inttab_tc2_082 (TEXT) BIND(__INTTAB_CPU2 + 0x1040) : {KEEP (*(.inttab2.intvec.130)) } > pfls2
    .inttab_tc2_083 (TEXT) BIND(__INTTAB_CPU2 + 0x1060) : {KEEP (*(.inttab2.intvec.131)) } > pfls2
    .inttab_tc2_084 (TEXT) BIND(__INTTAB_CPU2 + 0x1080) : {KEEP (*(.inttab2.intvec.132)) } > pfls2
    .inttab_tc2_085 (TEXT) BIND(__INTTAB_CPU2 + 0x10A0) : {KEEP (*(.inttab2.intvec.133)) } > pfls2
    .inttab_tc2_086 (TEXT) BIND(__INTTAB_CPU2 + 0x10C0) : {KEEP (*(.inttab2.intvec.134)) } > pfls2
    .inttab_tc2_087 (TEXT) BIND(__INTTAB_CPU2 + 0x10E0) : {KEEP (*(.inttab2.intvec.135)) } > pfls2
    .inttab_tc2_088 (TEXT) BIND(__INTTAB_CPU2 + 0x1100) : {KEEP (*(.inttab2.intvec.136)) } > pfls2
    .inttab_tc2_089 (TEXT) BIND(__INTTAB_CPU2 + 0x1120) : {KEEP (*(.inttab2.intvec.137)) } > pfls2
    .inttab_tc2_08A (TEXT) BIND(__INTTAB_CPU2 + 0x1140) : {KEEP (*(.inttab2.intvec.138)) } > pfls2
    .inttab_tc2_08B (TEXT) BIND(__INTTAB_CPU2 + 0x1160) : {KEEP (*(.inttab2.intvec.139)) } > pfls2
    .inttab_tc2_08C (TEXT) BIND(__INTTAB_CPU2 + 0x1180) : {KEEP (*(.inttab2.intvec.140)) } > pfls2
    .inttab_tc2_08D (TEXT) BIND(__INTTAB_CPU2 + 0x11A0) : {KEEP (*(.inttab2.intvec.141)) } > pfls2
    .inttab_tc2_08E (TEXT) BIND(__INTTAB_CPU2 + 0x11C0) : {KEEP (*(.inttab2.intvec.142)) } > pfls2
    .inttab_tc2_08F (TEXT) BIND(__INTTAB_CPU2 + 0x11E0) : {KEEP (*(.inttab2.intvec.143)) } > pfls2
    .inttab_tc2_090 (TEXT) BIND(__INTTAB_CPU2 + 0x1200) : {KEEP (*(.inttab2.intvec.144)) } > pfls2
    .inttab_tc2_091 (TEXT) BIND(__INTTAB_CPU2 + 0x1220) : {KEEP (*(.inttab2.intvec.145)) } > pfls2
    .inttab_tc2_092 (TEXT) BIND(__INTTAB_CPU2 + 0x1240) : {KEEP (*(.inttab2.intvec.146)) } > pfls2
    .inttab_tc2_093 (TEXT) BIND(__INTTAB_CPU2 + 0x1260) : {KEEP (*(.inttab2.intvec.147)) } > pfls2
    .inttab_tc2_094 (TEXT) BIND(__INTTAB_CPU2 + 0x1280) : {KEEP (*(.inttab2.intvec.148)) } > pfls2
    .inttab_tc2_095 (TEXT) BIND(__INTTAB_CPU2 + 0x12A0) : {KEEP (*(.inttab2.intvec.149)) } > pfls2
    .inttab_tc2_096 (TEXT) BIND(__INTTAB_CPU2 + 0x12C0) : {KEEP (*(.inttab2.intvec.150)) } > pfls2
    .inttab_tc2_097 (TEXT) BIND(__INTTAB_CPU2 + 0x12E0) : {KEEP (*(.inttab2.intvec.151)) } > pfls2
    .inttab_tc2_098 (TEXT) BIND(__INTTAB_CPU2 + 0x1300) : {KEEP (*(.inttab2.intvec.152)) } > pfls2
    .inttab_tc2_099 (TEXT) BIND(__INTTAB_CPU2 + 0x1320) : {KEEP (*(.inttab2.intvec.153)) } > pfls2
    .inttab_tc2_09A (TEXT) BIND(__INTTAB_CPU2 + 0x1340) : {KEEP (*(.inttab2.intvec.154)) } > pfls2
    .inttab_tc2_09B (TEXT) BIND(__INTTAB_CPU2 + 0x1360) : {KEEP (*(.inttab2.intvec.155)) } > pfls2
    .inttab_tc2_09C (TEXT) BIND(__INTTAB_CPU2 + 0x1380) : {KEEP (*(.inttab2.intvec.156)) } > pfls2
    .inttab_tc2_09D (TEXT) BIND(__INTTAB_CPU2 + 0x13A0) : {KEEP (*(.inttab2.intvec.157)) } > pfls2
    .inttab_tc2_09E (TEXT) BIND(__INTTAB_CPU2 + 0x13C0) : {KEEP (*(.inttab2.intvec.158)) } > pfls2
    .inttab_tc2_09F (TEXT) BIND(__INTTAB_CPU2 + 0x13E0) : {KEEP (*(.inttab2.intvec.159)) } > pfls2
    .inttab_tc2_0A0 (TEXT) BIND(__INTTAB_CPU2 + 0x1400) : {KEEP (*(.inttab2.intvec.160)) } > pfls2
    .inttab_tc2_0A1 (TEXT) BIND(__INTTAB_CPU2 + 0x1420) : {KEEP (*(.inttab2.intvec.161)) } > pfls2
    .inttab_tc2_0A2 (TEXT) BIND(__INTTAB_CPU2 + 0x1440) : {KEEP (*(.inttab2.intvec.162)) } > pfls2
    .inttab_tc2_0A3 (TEXT) BIND(__INTTAB_CPU2 + 0x1460) : {KEEP (*(.inttab2.intvec.163)) } > pfls2
    .inttab_tc2_0A4 (TEXT) BIND(__INTTAB_CPU2 + 0x1480) : {KEEP (*(.inttab2.intvec.164)) } > pfls2
    .inttab_tc2_0A5 (TEXT) BIND(__INTTAB_CPU2 + 0x14A0) : {KEEP (*(.inttab2.intvec.165)) } > pfls2
    .inttab_tc2_0A6 (TEXT) BIND(__INTTAB_CPU2 + 0x14C0) : {KEEP (*(.inttab2.intvec.166)) } > pfls2
    .inttab_tc2_0A7 (TEXT) BIND(__INTTAB_CPU2 + 0x14E0) : {KEEP (*(.inttab2.intvec.167)) } > pfls2
    .inttab_tc2_0A8 (TEXT) BIND(__INTTAB_CPU2 + 0x1500) : {KEEP (*(.inttab2.intvec.168)) } > pfls2
    .inttab_tc2_0A9 (TEXT) BIND(__INTTAB_CPU2 + 0x1520) : {KEEP (*(.inttab2.intvec.169)) } > pfls2
    .inttab_tc2_0AA (TEXT) BIND(__INTTAB_CPU2 + 0x1540) : {KEEP (*(.inttab2.intvec.170)) } > pfls2
    .inttab_tc2_0AB (TEXT) BIND(__INTTAB_CPU2 + 0x1560) : {KEEP (*(.inttab2.intvec.171)) } > pfls2
    .inttab_tc2_0AC (TEXT) BIND(__INTTAB_CPU2 + 0x1580) : {KEEP (*(.inttab2.intvec.172)) } > pfls2
    .inttab_tc2_0AD (TEXT) BIND(__INTTAB_CPU2 + 0x15A0) : {KEEP (*(.inttab2.intvec.173)) } > pfls2
    .inttab_tc2_0AE (TEXT) BIND(__INTTAB_CPU2 + 0x15C0) : {KEEP (*(.inttab2.intvec.174)) } > pfls2
    .inttab_tc2_0AF (TEXT) BIND(__INTTAB_CPU2 + 0x15E0) : {KEEP (*(.inttab2.intvec.175)) } > pfls2
    .inttab_tc2_0B0 (TEXT) BIND(__INTTAB_CPU2 + 0x1600) : {KEEP (*(.inttab2.intvec.176)) } > pfls2
    .inttab_tc2_0B1 (TEXT) BIND(__INTTAB_CPU2 + 0x1620) : {KEEP (*(.inttab2.intvec.177)) } > pfls2
    .inttab_tc2_0B2 (TEXT) BIND(__INTTAB_CPU2 + 0x1640) : {KEEP (*(.inttab2.intvec.178)) } > pfls2
    .inttab_tc2_0B3 (TEXT) BIND(__INTTAB_CPU2 + 0x1660) : {KEEP (*(.inttab2.intvec.179)) } > pfls2
    .inttab_tc2_0B4 (TEXT) BIND(__INTTAB_CPU2 + 0x1680) : {KEEP (*(.inttab2.intvec.180)) } > pfls2
    .inttab_tc2_0B5 (TEXT) BIND(__INTTAB_CPU2 + 0x16A0) : {KEEP (*(.inttab2.intvec.181)) } > pfls2
    .inttab_tc2_0B6 (TEXT) BIND(__INTTAB_CPU2 + 0x16C0) : {KEEP (*(.inttab2.intvec.182)) } > pfls2
    .inttab_tc2_0B7 (TEXT) BIND(__INTTAB_CPU2 + 0x16E0) : {KEEP (*(.inttab2.intvec.183)) } > pfls2
    .inttab_tc2_0B8 (TEXT) BIND(__INTTAB_CPU2 + 0x1700) : {KEEP (*(.inttab2.intvec.184)) } > pfls2
    .inttab_tc2_0B9 (TEXT) BIND(__INTTAB_CPU2 + 0x1720) : {KEEP (*(.inttab2.intvec.185)) } > pfls2
    .inttab_tc2_0BA (TEXT) BIND(__INTTAB_CPU2 + 0x1740) : {KEEP (*(.inttab2.intvec.186)) } > pfls2
    .inttab_tc2_0BB (TEXT) BIND(__INTTAB_CPU2 + 0x1760) : {KEEP (*(.inttab2.intvec.187)) } > pfls2
    .inttab_tc2_0BC (TEXT) BIND(__INTTAB_CPU2 + 0x1780) : {KEEP (*(.inttab2.intvec.188)) } > pfls2
    .inttab_tc2_0BD (TEXT) BIND(__INTTAB_CPU2 + 0x17A0) : {KEEP (*(.inttab2.intvec.189)) } > pfls2
    .inttab_tc2_0BE (TEXT) BIND(__INTTAB_CPU2 + 0x17C0) : {KEEP (*(.inttab2.intvec.190)) } > pfls2
    .inttab_tc2_0BF (TEXT) BIND(__INTTAB_CPU2 + 0x17E0) : {KEEP (*(.inttab2.intvec.191)) } > pfls2
    .inttab_tc2_0C0 (TEXT) BIND(__INTTAB_CPU2 + 0x1800) : {KEEP (*(.inttab2.intvec.192)) } > pfls2
    .inttab_tc2_0C1 (TEXT) BIND(__INTTAB_CPU2 + 0x1820) : {KEEP (*(.inttab2.intvec.193)) } > pfls2
    .inttab_tc2_0C2 (TEXT) BIND(__INTTAB_CPU2 + 0x1840) : {KEEP (*(.inttab2.intvec.194)) } > pfls2
    .inttab_tc2_0C3 (TEXT) BIND(__INTTAB_CPU2 + 0x1860) : {KEEP (*(.inttab2.intvec.195)) } > pfls2
    .inttab_tc2_0C4 (TEXT) BIND(__INTTAB_CPU2 + 0x1880) : {KEEP (*(.inttab2.intvec.196)) } > pfls2
    .inttab_tc2_0C5 (TEXT) BIND(__INTTAB_CPU2 + 0x18A0) : {KEEP (*(.inttab2.intvec.197)) } > pfls2
    .inttab_tc2_0C6 (TEXT) BIND(__INTTAB_CPU2 + 0x18C0) : {KEEP (*(.inttab2.intvec.198)) } > pfls2
    .inttab_tc2_0C7 (TEXT) BIND(__INTTAB_CPU2 + 0x18E0) : {KEEP (*(.inttab2.intvec.199)) } > pfls2
    .inttab_tc2_0C8 (TEXT) BIND(__INTTAB_CPU2 + 0x1900) : {KEEP (*(.inttab2.intvec.200)) } > pfls2
    .inttab_tc2_0C9 (TEXT) BIND(__INTTAB_CPU2 + 0x1920) : {KEEP (*(.inttab2.intvec.201)) } > pfls2
    .inttab_tc2_0CA (TEXT) BIND(__INTTAB_CPU2 + 0x1940) : {KEEP (*(.inttab2.intvec.202)) } > pfls2
    .inttab_tc2_0CB (TEXT) BIND(__INTTAB_CPU2 + 0x1960) : {KEEP (*(.inttab2.intvec.203)) } > pfls2
    .inttab_tc2_0CC (TEXT) BIND(__INTTAB_CPU2 + 0x1980) : {KEEP (*(.inttab2.intvec.204)) } > pfls2
    .inttab_tc2_0CD (TEXT) BIND(__INTTAB_CPU2 + 0x19A0) : {KEEP (*(.inttab2.intvec.205)) } > pfls2
    .inttab_tc2_0CE (TEXT) BIND(__INTTAB_CPU2 + 0x19C0) : {KEEP (*(.inttab2.intvec.206)) } > pfls2
    .inttab_tc2_0CF (TEXT) BIND(__INTTAB_CPU2 + 0x19E0) : {KEEP (*(.inttab2.intvec.207)) } > pfls2
    .inttab_tc2_0D0 (TEXT) BIND(__INTTAB_CPU2 + 0x1A00) : {KEEP (*(.inttab2.intvec.208)) } > pfls2
    .inttab_tc2_0D1 (TEXT) BIND(__INTTAB_CPU2 + 0x1A20) : {KEEP (*(.inttab2.intvec.209)) } > pfls2
    .inttab_tc2_0D2 (TEXT) BIND(__INTTAB_CPU2 + 0x1A40) : {KEEP (*(.inttab2.intvec.210)) } > pfls2
    .inttab_tc2_0D3 (TEXT) BIND(__INTTAB_CPU2 + 0x1A60) : {KEEP (*(.inttab2.intvec.211)) } > pfls2
    .inttab_tc2_0D4 (TEXT) BIND(__INTTAB_CPU2 + 0x1A80) : {KEEP (*(.inttab2.intvec.212)) } > pfls2
    .inttab_tc2_0D5 (TEXT) BIND(__INTTAB_CPU2 + 0x1AA0) : {KEEP (*(.inttab2.intvec.213)) } > pfls2
    .inttab_tc2_0D6 (TEXT) BIND(__INTTAB_CPU2 + 0x1AC0) : {KEEP (*(.inttab2.intvec.214)) } > pfls2
    .inttab_tc2_0D7 (TEXT) BIND(__INTTAB_CPU2 + 0x1AE0) : {KEEP (*(.inttab2.intvec.215)) } > pfls2
    .inttab_tc2_0D8 (TEXT) BIND(__INTTAB_CPU2 + 0x1B00) : {KEEP (*(.inttab2.intvec.216)) } > pfls2
    .inttab_tc2_0D9 (TEXT) BIND(__INTTAB_CPU2 + 0x1B20) : {KEEP (*(.inttab2.intvec.217)) } > pfls2
    .inttab_tc2_0DA (TEXT) BIND(__INTTAB_CPU2 + 0x1B40) : {KEEP (*(.inttab2.intvec.218)) } > pfls2
    .inttab_tc2_0DB (TEXT) BIND(__INTTAB_CPU2 + 0x1B60) : {KEEP (*(.inttab2.intvec.219)) } > pfls2
    .inttab_tc2_0DC (TEXT) BIND(__INTTAB_CPU2 + 0x1B80) : {KEEP (*(.inttab2.intvec.220)) } > pfls2
    .inttab_tc2_0DD (TEXT) BIND(__INTTAB_CPU2 + 0x1BA0) : {KEEP (*(.inttab2.intvec.221)) } > pfls2
    .inttab_tc2_0DE (TEXT) BIND(__INTTAB_CPU2 + 0x1BC0) : {KEEP (*(.inttab2.intvec.222)) } > pfls2
    .inttab_tc2_0DF (TEXT) BIND(__INTTAB_CPU2 + 0x1BE0) : {KEEP (*(.inttab2.intvec.223)) } > pfls2
    .inttab_tc2_0E0 (TEXT) BIND(__INTTAB_CPU2 + 0x1C00) : {KEEP (*(.inttab2.intvec.224)) } > pfls2
    .inttab_tc2_0E1 (TEXT) BIND(__INTTAB_CPU2 + 0x1C20) : {KEEP (*(.inttab2.intvec.225)) } > pfls2
    .inttab_tc2_0E2 (TEXT) BIND(__INTTAB_CPU2 + 0x1C40) : {KEEP (*(.inttab2.intvec.226)) } > pfls2
    .inttab_tc2_0E3 (TEXT) BIND(__INTTAB_CPU2 + 0x1C60) : {KEEP (*(.inttab2.intvec.227)) } > pfls2
    .inttab_tc2_0E4 (TEXT) BIND(__INTTAB_CPU2 + 0x1C80) : {KEEP (*(.inttab2.intvec.228)) } > pfls2
    .inttab_tc2_0E5 (TEXT) BIND(__INTTAB_CPU2 + 0x1CA0) : {KEEP (*(.inttab2.intvec.229)) } > pfls2
    .inttab_tc2_0E6 (TEXT) BIND(__INTTAB_CPU2 + 0x1CC0) : {KEEP (*(.inttab2.intvec.230)) } > pfls2
    .inttab_tc2_0E7 (TEXT) BIND(__INTTAB_CPU2 + 0x1CE0) : {KEEP (*(.inttab2.intvec.231)) } > pfls2
    .inttab_tc2_0E8 (TEXT) BIND(__INTTAB_CPU2 + 0x1D00) : {KEEP (*(.inttab2.intvec.232)) } > pfls2
    .inttab_tc2_0E9 (TEXT) BIND(__INTTAB_CPU2 + 0x1D20) : {KEEP (*(.inttab2.intvec.233)) } > pfls2
    .inttab_tc2_0EA (TEXT) BIND(__INTTAB_CPU2 + 0x1D40) : {KEEP (*(.inttab2.intvec.234)) } > pfls2
    .inttab_tc2_0EB (TEXT) BIND(__INTTAB_CPU2 + 0x1D60) : {KEEP (*(.inttab2.intvec.235)) } > pfls2
    .inttab_tc2_0EC (TEXT) BIND(__INTTAB_CPU2 + 0x1D80) : {KEEP (*(.inttab2.intvec.236)) } > pfls2
    .inttab_tc2_0ED (TEXT) BIND(__INTTAB_CPU2 + 0x1DA0) : {KEEP (*(.inttab2.intvec.237)) } > pfls2
    .inttab_tc2_0EE (TEXT) BIND(__INTTAB_CPU2 + 0x1DC0) : {KEEP (*(.inttab2.intvec.238)) } > pfls2
    .inttab_tc2_0EF (TEXT) BIND(__INTTAB_CPU2 + 0x1DE0) : {KEEP (*(.inttab2.intvec.239)) } > pfls2
    .inttab_tc2_0F0 (TEXT) BIND(__INTTAB_CPU2 + 0x1E00) : {KEEP (*(.inttab2.intvec.240)) } > pfls2
    .inttab_tc2_0F1 (TEXT) BIND(__INTTAB_CPU2 + 0x1E20) : {KEEP (*(.inttab2.intvec.241)) } > pfls2
    .inttab_tc2_0F2 (TEXT) BIND(__INTTAB_CPU2 + 0x1E40) : {KEEP (*(.inttab2.intvec.242)) } > pfls2
    .inttab_tc2_0F3 (TEXT) BIND(__INTTAB_CPU2 + 0x1E60) : {KEEP (*(.inttab2.intvec.243)) } > pfls2
    .inttab_tc2_0F4 (TEXT) BIND(__INTTAB_CPU2 + 0x1E80) : {KEEP (*(.inttab2.intvec.244)) } > pfls2
    .inttab_tc2_0F5 (TEXT) BIND(__INTTAB_CPU2 + 0x1EA0) : {KEEP (*(.inttab2.intvec.245)) } > pfls2
    .inttab_tc2_0F6 (TEXT) BIND(__INTTAB_CPU2 + 0x1EC0) : {KEEP (*(.inttab2.intvec.246)) } > pfls2
    .inttab_tc2_0F7 (TEXT) BIND(__INTTAB_CPU2 + 0x1EE0) : {KEEP (*(.inttab2.intvec.247)) } > pfls2
    .inttab_tc2_0F8 (TEXT) BIND(__INTTAB_CPU2 + 0x1F00) : {KEEP (*(.inttab2.intvec.248)) } > pfls2
    .inttab_tc2_0F9 (TEXT) BIND(__INTTAB_CPU2 + 0x1F20) : {KEEP (*(.inttab2.intvec.249)) } > pfls2
    .inttab_tc2_0FA (TEXT) BIND(__INTTAB_CPU2 + 0x1F40) : {KEEP (*(.inttab2.intvec.250)) } > pfls2
    .inttab_tc2_0FB (TEXT) BIND(__INTTAB_CPU2 + 0x1F60) : {KEEP (*(.inttab2.intvec.251)) } > pfls2
    .inttab_tc2_0FC (TEXT) BIND(__INTTAB_CPU2 + 0x1F80) : {KEEP (*(.inttab2.intvec.252)) } > pfls2
    .inttab_tc2_0FD (TEXT) BIND(__INTTAB_CPU2 + 0x1FA0) : {KEEP (*(.inttab2.intvec.253)) } > pfls2
    .inttab_tc2_0FE (TEXT) BIND(__INTTAB_CPU2 + 0x1FC0) : {KEEP (*(.inttab2.intvec.254)) } > pfls2
    .inttab_tc2_0FF (TEXT) BIND(__INTTAB_CPU2 + 0x1FE0) : {KEEP (*(.inttab2.intvec.255)) } > pfls2

}