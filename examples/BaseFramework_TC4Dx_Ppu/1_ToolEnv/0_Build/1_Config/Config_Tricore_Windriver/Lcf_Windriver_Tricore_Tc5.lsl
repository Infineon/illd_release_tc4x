
-Xgenerate-copytables

LCF_CSA5_SIZE    = 8k;
LCF_USTACK5_SIZE = 2k;
LCF_ISTACK5_SIZE = 1k;

LCF_HEAP_SIZE = 4k;

LCF_PPU_FLASH_SIZE  = 1M;
LCF_PPU_LMURAM_SIZE = 512k;
LCF_PPU_CSM_SIZE    = 512k;

LCF_DSPR5_START = 0x20000000;
LCF_DSPR5_SIZE  = 240K;

LCF_CSA5_OFFSET    = (LCF_DSPR5_SIZE - 1k - LCF_CSA5_SIZE);
LCF_ISTACK5_OFFSET = (LCF_CSA5_OFFSET - 256 - LCF_ISTACK5_SIZE);
LCF_USTACK5_OFFSET = (LCF_ISTACK5_OFFSET - 256 - LCF_USTACK5_SIZE);

LCF_HEAP5_OFFSET = (LCF_USTACK5_OFFSET - LCF_HEAP_SIZE);

LCF_INTVEC5_START = 0x813FE000;
 

__INTTAB_CPU5 = LCF_INTVEC5_START;
 


LCF_TRAPVEC5_START = 0x81200100;

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


RESET = LCF_STARTPTR_NC_CPU5;


MEMORY
{
    dsram5: org = 0x20000000, len = 240K
    psram5: org = 0x20100000, len = 64K

    pfls5: org = 0x81200000, len = 2M - 1M
    pfls5_nc: org = 0xa1200000, len = 2M - 1M
	


    ucb: org = 0xae400000, len = 80K
	

    cpu5_dlmu: org = 0x90280000, len = 512K
    cpu5_dlmu_nc: org = 0xb0280000, len = 512K

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
    /* CPU5 Stack and CSA defines */
    CPU5.ustack BIND(LCF_DSPR5_START + LCF_USTACK5_OFFSET) :
    { __USTACK5_END = . ;    . = . + LCF_USTACK5_SIZE;    __USTACK5 = . ; }
    
    CPU5.istack BIND(LCF_DSPR5_START + LCF_ISTACK5_OFFSET):
    { __ISTACK5_END = . ;    . = . + LCF_ISTACK5_SIZE;    __ISTACK5 = . ; }
    
    CPU5.csa BIND(LCF_DSPR5_START + LCF_CSA5_OFFSET):
    { __CSA5 = . ;    . = . + LCF_CSA5_SIZE;    __CSA5_END = . ; }
	
	
	
	


    __SP_END = __USTACK5_END;


    /*Fixed memory Allocations*/
    __IF_CONST = 0x80000020;



    /*Fixed memory Allocations for Trap Vector Table*/
    .traptab_tc5 (TEXT) BIND(LCF_TRAPVEC5_START) : { __TRAPTAB_CPU5 = .; KEEP (*(.traptab_cpu5)) .= ALIGN(0x100); } > pfls5

    /DISCARD/ :
    { 
        *(.traptab_cpu0)
        *(.traptab_cpu1)
        *(.traptab_cpu2)
        *(.traptab_cpu3)
	*(.traptab_cpu4)
        *(.interface_const)
    }

    /*Fixed memory Allocations for _START CPU5 */
    .start_tc5 (TEXT) LOAD(LCF_STARTPTR_CPU5) BIND(LCF_STARTPTR_NC_CPU5) : { __ENABLE_INDIVIDUAL_C_INIT_CPU5 = 1; KEEP (*(.start_cpu5)) } =0x800 > pfls5_nc
    __START0 = LCF_STARTPTR_NC_CPU0;
    __START1 = LCF_STARTPTR_NC_CPU1;
    __START2 = LCF_STARTPTR_NC_CPU2;
    __START3 = LCF_STARTPTR_NC_CPU3;
    __START4 = LCF_STARTPTR_NC_CPU4;
    __START5 = LCF_STARTPTR_NC_CPU5;

    /*Near Absolute Addressable Data Sections*/
    GROUP LOAD(> pfls5) COPYTABLE :
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
    /*Near Absolute Data, selectable by toolchain*/
    GROUP LOAD(> pfls5) COPYTABLE :
    {
        .zdata (DATA) :
        {
            *(.zdata.dsprInit.cpu5.32bit)
            *(.zdata.dsprInit.cpu5.16bit)
            *(.zdata.dsprInit.cpu5.8bit)
            *(.zdata)
        }
        
        .zdata_powerOn (DATA) :
        {
            *(.zdata.dsprPowerOnInit.cpu5.32bit)
            *(.zdata.dsprPowerOnInit.cpu5.16bit)
            *(.zdata.dsprPowerOnInit.cpu5.8bit)
        }
        
        .zbss (BSS) :
        {
            *(.zbss.dsprClearOnInit.cpu5.32bit)
            *(.zbss.dsprClearOnInit.cpu5.16bit)
            *(.zbss.dsprClearOnInit.cpu5.8bit)
            *(.zbss)
        }
        
        .zbss_powerOn (BSS) :
        {
            *(.zbss.dsprPowerOnClear.cpu5.32bit)
            *(.zbss.dsprPowerOnClear.cpu5.16bit)
            *(.zbss.dsprPowerOnClear.cpu5.8bit)
        }
        
        .zbss_noClear (BSS) :
        {
            *(.zbss.dsprNoInit.cpu5.32bit)
            *(.zbss.dsprNoInit.cpu5.16bit)
            *(.zbss.dsprNoInit.cpu5.8bit)
        }
		
		
    } > dsram5

    /*Relative A0/A1/A8/A9 Addressable Sections*/
    /*Relative A0 Addressable Data, selectable with patterns and user defined sections*/
    /*Note: A0 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A0 Addressable Data, selectable by toolchain*/
    GROUP LOAD(> pfls5) COPYTABLE :
	
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
    } > dsram5

    /*Relative A1 Addressable Const, selectable with patterns and user defined sections*/
    /*Note: A1 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A1 Addressable Const, selectable by toolchain*/
    GROUP :
    {
        .zrodata (CONST) :
        {
            *Ifx_Ssw_Tc5.* (.zrodata)
            *Cpu5_Main.* (.zrodata)
            *(.zrodata.const.cpu5.32bit)
            *(.zrodata.const.cpu5.16bit)
            *(.zrodata.const.cpu5.8bit)
            *(.zrodata.config.cpu5.32bit)
            *(.zrodata.config.cpu5.16bit)
            *(.zrodata.config.cpu5.8bit)
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
    } > pfls5

    /*LMU memory sections*/	
    GROUP LOAD(> pfls5) COPYTABLE :
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
    GROUP LOAD(> pfls5) COPYTABLE: 
	
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
    } > cpu5_dlmu

    GROUP LOAD(> pfls5) COPYTABLE :
    {
        .lmudata (DATA) :
        {
            *(.lmudata)
        }
        
        .lmubss (BSS) :
        {
            *(.lmubss)
        }
    } > cpu5_dlmu
	
    GROUP LOAD(> pfls5) :
    {
        .ppu_lmuram  :
        {
            . = ALIGN(4);
            __PPU_LMURAM_START = .;
            . += LCF_PPU_LMURAM_SIZE;
            __PPU_LMURAM_END = .;
        }
    } > ppu_lmuram_nc
	
    GROUP LOAD(> pfls5) :
    {
        .ppu_csm :
        {
        . = ALIGN(4);
        __PPU_CSM_START = .;
        . += LCF_PPU_CSM_SIZE;
        __PPU_CSM_END = .;
        }
    } > ppu_csm_nc
    
    GROUP LOAD(> pfls5) :
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
    } > pfls5

    __A8_MEM = SIZEOF(.rodata_a8) ? ADDR(.rodata_a8) : (ADDR(.rodata_a8) & 0xF0000000) + 32k ;
    
    /*Far Data / Far Const Sections, selectable with patterns and user defined sections*/
    /*Far Data Sections, selectable with patterns and user defined sections*/
    GROUP LOAD(> pfls5) COPYTABLE :
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
    /*Far Data Sections, selectable by toolchain*/
    GROUP LOAD(> pfls5) COPYTABLE :
	
    {
        .data (DATA) :
        {
            *(.data.farDsprInit.cpu5.32bit)
            *(.data.farDsprInit.cpu5.16bit)
            *(.data.farDsprInit.cpu5.8bit)
            *(.data)
        }
        
        .bss (BSS) :
        {
            *(.bss.farDsprClearOnInit.cpu5.32bit)
            *(.bss.farDsprClearOnInit.cpu5.16bit)
            *(.bss.farDsprClearOnInit.cpu5.8bit)
            *(.bss)
        }
        
        .bss_noClear (BSS) :
        {
            *(.bss.farDsprNoInit.cpu5.32bit)
            *(.bss.farDsprNoInit.cpu5.16bit)
            *(.bss.farDsprNoInit.cpu5.8bit)
        }
        
        .heap  :
        {
            . = ALIGN(4);
            __HEAP = .;
            __HEAP_START = .;
            __HEAP_END = . + LCF_HEAP_SIZE;
        }
    } > dsram5

    /* Far Const Sections, selectable with patterns and user defined sections */
    /* CPU5 Const Sections */
    CPU5.rodata (CONST) :
    {
        "*Ifx_Ssw_Tc5.*" (.rodata)
        "*Cpu5_Main.*" (.rodata)
        *(.rodata_cpu5)
    } > pfls5
	
    /*Far Const Sections, selectable by toolchain*/
    GROUP :
    {
        .rodata (CONST) :
        {
            *(.rodata)
            *(.rodata.farConst.cpu5.32bit)
            *(.rodata.farConst.cpu5.16bit)
            *(.rodata.farConst.cpu5.8bit)
        }
        
        .copytable (CONST) :
        {
            __DATA_ROM = .;
        }
    } > pfls5

    /*Code selections*/
    /*Code Sections, selectable with patterns and user defined sections*/
    /* CPU5 Code Sections */
    CPU5.text (TEXT) :
    {
        . = ALIGN(2);
        "*Ifx_Ssw_Tc5.*" (.text)
        "*Cpu5_Main.*" (.text)
        *(.text_cpu5)
    } > pfls5
    
    CPU5.psram_text (TEXT) LOAD(> pfls5) COPYTABLE :
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
            *(.text.fast.pfls.cpu5)
            *(.text.slow.pfls.cpu5)
            *(.text.5ms.pfls.cpu5)
            *(.text.10ms.pfls.cpu5)
            *(.text.callout.pfls.cpu5)
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
    } > pfls5


    /* CPU5 Interrupt Vector Table */
    .inttab_tc5_000 (TEXT) BIND(__INTTAB_CPU5 + 0x0000) : {KEEP (*(.inttab5.intvec.0  )) } > pfls5
    .inttab_tc5_001 (TEXT) BIND(__INTTAB_CPU5 + 0x0020) : {KEEP (*(.inttab5.intvec.1  )) } > pfls5
    .inttab_tc5_002 (TEXT) BIND(__INTTAB_CPU5 + 0x0040) : {KEEP (*(.inttab5.intvec.2  )) } > pfls5
    .inttab_tc5_003 (TEXT) BIND(__INTTAB_CPU5 + 0x0060) : {KEEP (*(.inttab5.intvec.3  )) } > pfls5
    .inttab_tc5_004 (TEXT) BIND(__INTTAB_CPU5 + 0x0080) : {KEEP (*(.inttab5.intvec.4  )) } > pfls5
    .inttab_tc5_005 (TEXT) BIND(__INTTAB_CPU5 + 0x00A0) : {KEEP (*(.inttab5.intvec.5  )) } > pfls5
    .inttab_tc5_006 (TEXT) BIND(__INTTAB_CPU5 + 0x00C0) : {KEEP (*(.inttab5.intvec.6  )) } > pfls5
    .inttab_tc5_007 (TEXT) BIND(__INTTAB_CPU5 + 0x00E0) : {KEEP (*(.inttab5.intvec.7  )) } > pfls5
    .inttab_tc5_008 (TEXT) BIND(__INTTAB_CPU5 + 0x0100) : {KEEP (*(.inttab5.intvec.8  )) } > pfls5
    .inttab_tc5_009 (TEXT) BIND(__INTTAB_CPU5 + 0x0120) : {KEEP (*(.inttab5.intvec.9  )) } > pfls5
    .inttab_tc5_00A (TEXT) BIND(__INTTAB_CPU5 + 0x0140) : {KEEP (*(.inttab5.intvec.10 )) } > pfls5
    .inttab_tc5_00B (TEXT) BIND(__INTTAB_CPU5 + 0x0160) : {KEEP (*(.inttab5.intvec.11 )) } > pfls5
    .inttab_tc5_00C (TEXT) BIND(__INTTAB_CPU5 + 0x0180) : {KEEP (*(.inttab5.intvec.12 )) } > pfls5
    .inttab_tc5_00D (TEXT) BIND(__INTTAB_CPU5 + 0x01A0) : {KEEP (*(.inttab5.intvec.13 )) } > pfls5
    .inttab_tc5_00E (TEXT) BIND(__INTTAB_CPU5 + 0x01C0) : {KEEP (*(.inttab5.intvec.14 )) } > pfls5
    .inttab_tc5_00F (TEXT) BIND(__INTTAB_CPU5 + 0x01E0) : {KEEP (*(.inttab5.intvec.15 )) } > pfls5
    .inttab_tc5_010 (TEXT) BIND(__INTTAB_CPU5 + 0x0200) : {KEEP (*(.inttab5.intvec.16 )) } > pfls5
    .inttab_tc5_011 (TEXT) BIND(__INTTAB_CPU5 + 0x0220) : {KEEP (*(.inttab5.intvec.17 )) } > pfls5
    .inttab_tc5_012 (TEXT) BIND(__INTTAB_CPU5 + 0x0240) : {KEEP (*(.inttab5.intvec.18 )) } > pfls5
    .inttab_tc5_013 (TEXT) BIND(__INTTAB_CPU5 + 0x0260) : {KEEP (*(.inttab5.intvec.19 )) } > pfls5
    .inttab_tc5_014 (TEXT) BIND(__INTTAB_CPU5 + 0x0280) : {KEEP (*(.inttab5.intvec.20 )) } > pfls5
    .inttab_tc5_015 (TEXT) BIND(__INTTAB_CPU5 + 0x02A0) : {KEEP (*(.inttab5.intvec.21 )) } > pfls5
    .inttab_tc5_016 (TEXT) BIND(__INTTAB_CPU5 + 0x02C0) : {KEEP (*(.inttab5.intvec.22 )) } > pfls5
    .inttab_tc5_017 (TEXT) BIND(__INTTAB_CPU5 + 0x02E0) : {KEEP (*(.inttab5.intvec.23 )) } > pfls5
    .inttab_tc5_018 (TEXT) BIND(__INTTAB_CPU5 + 0x0300) : {KEEP (*(.inttab5.intvec.24 )) } > pfls5
    .inttab_tc5_019 (TEXT) BIND(__INTTAB_CPU5 + 0x0320) : {KEEP (*(.inttab5.intvec.25 )) } > pfls5
    .inttab_tc5_01A (TEXT) BIND(__INTTAB_CPU5 + 0x0340) : {KEEP (*(.inttab5.intvec.26 )) } > pfls5
    .inttab_tc5_01B (TEXT) BIND(__INTTAB_CPU5 + 0x0360) : {KEEP (*(.inttab5.intvec.27 )) } > pfls5
    .inttab_tc5_01C (TEXT) BIND(__INTTAB_CPU5 + 0x0380) : {KEEP (*(.inttab5.intvec.28 )) } > pfls5
    .inttab_tc5_01D (TEXT) BIND(__INTTAB_CPU5 + 0x03A0) : {KEEP (*(.inttab5.intvec.29 )) } > pfls5
    .inttab_tc5_01E (TEXT) BIND(__INTTAB_CPU5 + 0x03C0) : {KEEP (*(.inttab5.intvec.30 )) } > pfls5
    .inttab_tc5_01F (TEXT) BIND(__INTTAB_CPU5 + 0x03E0) : {KEEP (*(.inttab5.intvec.31 )) } > pfls5
    .inttab_tc5_020 (TEXT) BIND(__INTTAB_CPU5 + 0x0400) : {KEEP (*(.inttab5.intvec.32 )) } > pfls5
    .inttab_tc5_021 (TEXT) BIND(__INTTAB_CPU5 + 0x0420) : {KEEP (*(.inttab5.intvec.33 )) } > pfls5
    .inttab_tc5_022 (TEXT) BIND(__INTTAB_CPU5 + 0x0440) : {KEEP (*(.inttab5.intvec.34 )) } > pfls5
    .inttab_tc5_023 (TEXT) BIND(__INTTAB_CPU5 + 0x0460) : {KEEP (*(.inttab5.intvec.35 )) } > pfls5
    .inttab_tc5_024 (TEXT) BIND(__INTTAB_CPU5 + 0x0480) : {KEEP (*(.inttab5.intvec.36 )) } > pfls5
    .inttab_tc5_025 (TEXT) BIND(__INTTAB_CPU5 + 0x04A0) : {KEEP (*(.inttab5.intvec.37 )) } > pfls5
    .inttab_tc5_026 (TEXT) BIND(__INTTAB_CPU5 + 0x04C0) : {KEEP (*(.inttab5.intvec.38 )) } > pfls5
    .inttab_tc5_027 (TEXT) BIND(__INTTAB_CPU5 + 0x04E0) : {KEEP (*(.inttab5.intvec.39 )) } > pfls5
    .inttab_tc5_028 (TEXT) BIND(__INTTAB_CPU5 + 0x0500) : {KEEP (*(.inttab5.intvec.40 )) } > pfls5
    .inttab_tc5_029 (TEXT) BIND(__INTTAB_CPU5 + 0x0520) : {KEEP (*(.inttab5.intvec.41 )) } > pfls5
    .inttab_tc5_02A (TEXT) BIND(__INTTAB_CPU5 + 0x0540) : {KEEP (*(.inttab5.intvec.42 )) } > pfls5
    .inttab_tc5_02B (TEXT) BIND(__INTTAB_CPU5 + 0x0560) : {KEEP (*(.inttab5.intvec.43 )) } > pfls5
    .inttab_tc5_02C (TEXT) BIND(__INTTAB_CPU5 + 0x0580) : {KEEP (*(.inttab5.intvec.44 )) } > pfls5
    .inttab_tc5_02D (TEXT) BIND(__INTTAB_CPU5 + 0x05A0) : {KEEP (*(.inttab5.intvec.45 )) } > pfls5
    .inttab_tc5_02E (TEXT) BIND(__INTTAB_CPU5 + 0x05C0) : {KEEP (*(.inttab5.intvec.46 )) } > pfls5
    .inttab_tc5_02F (TEXT) BIND(__INTTAB_CPU5 + 0x05E0) : {KEEP (*(.inttab5.intvec.47 )) } > pfls5
    .inttab_tc5_030 (TEXT) BIND(__INTTAB_CPU5 + 0x0600) : {KEEP (*(.inttab5.intvec.48 )) } > pfls5
    .inttab_tc5_031 (TEXT) BIND(__INTTAB_CPU5 + 0x0620) : {KEEP (*(.inttab5.intvec.49 )) } > pfls5
    .inttab_tc5_032 (TEXT) BIND(__INTTAB_CPU5 + 0x0640) : {KEEP (*(.inttab5.intvec.50 )) } > pfls5
    .inttab_tc5_033 (TEXT) BIND(__INTTAB_CPU5 + 0x0660) : {KEEP (*(.inttab5.intvec.51 )) } > pfls5
    .inttab_tc5_034 (TEXT) BIND(__INTTAB_CPU5 + 0x0680) : {KEEP (*(.inttab5.intvec.52 )) } > pfls5
    .inttab_tc5_035 (TEXT) BIND(__INTTAB_CPU5 + 0x06A0) : {KEEP (*(.inttab5.intvec.53 )) } > pfls5
    .inttab_tc5_036 (TEXT) BIND(__INTTAB_CPU5 + 0x06C0) : {KEEP (*(.inttab5.intvec.54 )) } > pfls5
    .inttab_tc5_037 (TEXT) BIND(__INTTAB_CPU5 + 0x06E0) : {KEEP (*(.inttab5.intvec.55 )) } > pfls5
    .inttab_tc5_038 (TEXT) BIND(__INTTAB_CPU5 + 0x0700) : {KEEP (*(.inttab5.intvec.56 )) } > pfls5
    .inttab_tc5_039 (TEXT) BIND(__INTTAB_CPU5 + 0x0720) : {KEEP (*(.inttab5.intvec.57 )) } > pfls5
    .inttab_tc5_03A (TEXT) BIND(__INTTAB_CPU5 + 0x0740) : {KEEP (*(.inttab5.intvec.58 )) } > pfls5
    .inttab_tc5_03B (TEXT) BIND(__INTTAB_CPU5 + 0x0760) : {KEEP (*(.inttab5.intvec.59 )) } > pfls5
    .inttab_tc5_03C (TEXT) BIND(__INTTAB_CPU5 + 0x0780) : {KEEP (*(.inttab5.intvec.60 )) } > pfls5
    .inttab_tc5_03D (TEXT) BIND(__INTTAB_CPU5 + 0x07A0) : {KEEP (*(.inttab5.intvec.61 )) } > pfls5
    .inttab_tc5_03E (TEXT) BIND(__INTTAB_CPU5 + 0x07C0) : {KEEP (*(.inttab5.intvec.62 )) } > pfls5
    .inttab_tc5_03F (TEXT) BIND(__INTTAB_CPU5 + 0x07E0) : {KEEP (*(.inttab5.intvec.63 )) } > pfls5
    .inttab_tc5_040 (TEXT) BIND(__INTTAB_CPU5 + 0x0800) : {KEEP (*(.inttab5.intvec.64 )) } > pfls5
    .inttab_tc5_041 (TEXT) BIND(__INTTAB_CPU5 + 0x0820) : {KEEP (*(.inttab5.intvec.65 )) } > pfls5
    .inttab_tc5_042 (TEXT) BIND(__INTTAB_CPU5 + 0x0840) : {KEEP (*(.inttab5.intvec.66 )) } > pfls5
    .inttab_tc5_043 (TEXT) BIND(__INTTAB_CPU5 + 0x0860) : {KEEP (*(.inttab5.intvec.67 )) } > pfls5
    .inttab_tc5_044 (TEXT) BIND(__INTTAB_CPU5 + 0x0880) : {KEEP (*(.inttab5.intvec.68 )) } > pfls5
    .inttab_tc5_045 (TEXT) BIND(__INTTAB_CPU5 + 0x08A0) : {KEEP (*(.inttab5.intvec.69 )) } > pfls5
    .inttab_tc5_046 (TEXT) BIND(__INTTAB_CPU5 + 0x08C0) : {KEEP (*(.inttab5.intvec.70 )) } > pfls5
    .inttab_tc5_047 (TEXT) BIND(__INTTAB_CPU5 + 0x08E0) : {KEEP (*(.inttab5.intvec.71 )) } > pfls5
    .inttab_tc5_048 (TEXT) BIND(__INTTAB_CPU5 + 0x0900) : {KEEP (*(.inttab5.intvec.72 )) } > pfls5
    .inttab_tc5_049 (TEXT) BIND(__INTTAB_CPU5 + 0x0920) : {KEEP (*(.inttab5.intvec.73 )) } > pfls5
    .inttab_tc5_04A (TEXT) BIND(__INTTAB_CPU5 + 0x0940) : {KEEP (*(.inttab5.intvec.74 )) } > pfls5
    .inttab_tc5_04B (TEXT) BIND(__INTTAB_CPU5 + 0x0960) : {KEEP (*(.inttab5.intvec.75 )) } > pfls5
    .inttab_tc5_04C (TEXT) BIND(__INTTAB_CPU5 + 0x0980) : {KEEP (*(.inttab5.intvec.76 )) } > pfls5
    .inttab_tc5_04D (TEXT) BIND(__INTTAB_CPU5 + 0x09A0) : {KEEP (*(.inttab5.intvec.77 )) } > pfls5
    .inttab_tc5_04E (TEXT) BIND(__INTTAB_CPU5 + 0x09C0) : {KEEP (*(.inttab5.intvec.78 )) } > pfls5
    .inttab_tc5_04F (TEXT) BIND(__INTTAB_CPU5 + 0x09E0) : {KEEP (*(.inttab5.intvec.79 )) } > pfls5
    .inttab_tc5_050 (TEXT) BIND(__INTTAB_CPU5 + 0x0A00) : {KEEP (*(.inttab5.intvec.80 )) } > pfls5
    .inttab_tc5_051 (TEXT) BIND(__INTTAB_CPU5 + 0x0A20) : {KEEP (*(.inttab5.intvec.81 )) } > pfls5
    .inttab_tc5_052 (TEXT) BIND(__INTTAB_CPU5 + 0x0A40) : {KEEP (*(.inttab5.intvec.82 )) } > pfls5
    .inttab_tc5_053 (TEXT) BIND(__INTTAB_CPU5 + 0x0A60) : {KEEP (*(.inttab5.intvec.83 )) } > pfls5
    .inttab_tc5_054 (TEXT) BIND(__INTTAB_CPU5 + 0x0A80) : {KEEP (*(.inttab5.intvec.84 )) } > pfls5
    .inttab_tc5_055 (TEXT) BIND(__INTTAB_CPU5 + 0x0AA0) : {KEEP (*(.inttab5.intvec.85 )) } > pfls5
    .inttab_tc5_056 (TEXT) BIND(__INTTAB_CPU5 + 0x0AC0) : {KEEP (*(.inttab5.intvec.86 )) } > pfls5
    .inttab_tc5_057 (TEXT) BIND(__INTTAB_CPU5 + 0x0AE0) : {KEEP (*(.inttab5.intvec.87 )) } > pfls5
    .inttab_tc5_058 (TEXT) BIND(__INTTAB_CPU5 + 0x0B00) : {KEEP (*(.inttab5.intvec.88 )) } > pfls5
    .inttab_tc5_059 (TEXT) BIND(__INTTAB_CPU5 + 0x0B20) : {KEEP (*(.inttab5.intvec.89 )) } > pfls5
    .inttab_tc5_05A (TEXT) BIND(__INTTAB_CPU5 + 0x0B40) : {KEEP (*(.inttab5.intvec.90 )) } > pfls5
    .inttab_tc5_05B (TEXT) BIND(__INTTAB_CPU5 + 0x0B60) : {KEEP (*(.inttab5.intvec.91 )) } > pfls5
    .inttab_tc5_05C (TEXT) BIND(__INTTAB_CPU5 + 0x0B80) : {KEEP (*(.inttab5.intvec.92 )) } > pfls5
    .inttab_tc5_05D (TEXT) BIND(__INTTAB_CPU5 + 0x0BA0) : {KEEP (*(.inttab5.intvec.93 )) } > pfls5
    .inttab_tc5_05E (TEXT) BIND(__INTTAB_CPU5 + 0x0BC0) : {KEEP (*(.inttab5.intvec.94 )) } > pfls5
    .inttab_tc5_05F (TEXT) BIND(__INTTAB_CPU5 + 0x0BE0) : {KEEP (*(.inttab5.intvec.95 )) } > pfls5
    .inttab_tc5_060 (TEXT) BIND(__INTTAB_CPU5 + 0x0C00) : {KEEP (*(.inttab5.intvec.96 )) } > pfls5
    .inttab_tc5_061 (TEXT) BIND(__INTTAB_CPU5 + 0x0C20) : {KEEP (*(.inttab5.intvec.97 )) } > pfls5
    .inttab_tc5_062 (TEXT) BIND(__INTTAB_CPU5 + 0x0C40) : {KEEP (*(.inttab5.intvec.98 )) } > pfls5
    .inttab_tc5_063 (TEXT) BIND(__INTTAB_CPU5 + 0x0C60) : {KEEP (*(.inttab5.intvec.99 )) } > pfls5
    .inttab_tc5_064 (TEXT) BIND(__INTTAB_CPU5 + 0x0C80) : {KEEP (*(.inttab5.intvec.100)) } > pfls5
    .inttab_tc5_065 (TEXT) BIND(__INTTAB_CPU5 + 0x0CA0) : {KEEP (*(.inttab5.intvec.101)) } > pfls5
    .inttab_tc5_066 (TEXT) BIND(__INTTAB_CPU5 + 0x0CC0) : {KEEP (*(.inttab5.intvec.102)) } > pfls5
    .inttab_tc5_067 (TEXT) BIND(__INTTAB_CPU5 + 0x0CE0) : {KEEP (*(.inttab5.intvec.103)) } > pfls5
    .inttab_tc5_068 (TEXT) BIND(__INTTAB_CPU5 + 0x0D00) : {KEEP (*(.inttab5.intvec.104)) } > pfls5
    .inttab_tc5_069 (TEXT) BIND(__INTTAB_CPU5 + 0x0D20) : {KEEP (*(.inttab5.intvec.105)) } > pfls5
    .inttab_tc5_06A (TEXT) BIND(__INTTAB_CPU5 + 0x0D40) : {KEEP (*(.inttab5.intvec.106)) } > pfls5
    .inttab_tc5_06B (TEXT) BIND(__INTTAB_CPU5 + 0x0D60) : {KEEP (*(.inttab5.intvec.107)) } > pfls5
    .inttab_tc5_06C (TEXT) BIND(__INTTAB_CPU5 + 0x0D80) : {KEEP (*(.inttab5.intvec.108)) } > pfls5
    .inttab_tc5_06D (TEXT) BIND(__INTTAB_CPU5 + 0x0DA0) : {KEEP (*(.inttab5.intvec.109)) } > pfls5
    .inttab_tc5_06E (TEXT) BIND(__INTTAB_CPU5 + 0x0DC0) : {KEEP (*(.inttab5.intvec.110)) } > pfls5
    .inttab_tc5_06F (TEXT) BIND(__INTTAB_CPU5 + 0x0DE0) : {KEEP (*(.inttab5.intvec.111)) } > pfls5
    .inttab_tc5_070 (TEXT) BIND(__INTTAB_CPU5 + 0x0E00) : {KEEP (*(.inttab5.intvec.112)) } > pfls5
    .inttab_tc5_071 (TEXT) BIND(__INTTAB_CPU5 + 0x0E20) : {KEEP (*(.inttab5.intvec.113)) } > pfls5
    .inttab_tc5_072 (TEXT) BIND(__INTTAB_CPU5 + 0x0E40) : {KEEP (*(.inttab5.intvec.114)) } > pfls5
    .inttab_tc5_073 (TEXT) BIND(__INTTAB_CPU5 + 0x0E60) : {KEEP (*(.inttab5.intvec.115)) } > pfls5
    .inttab_tc5_074 (TEXT) BIND(__INTTAB_CPU5 + 0x0E80) : {KEEP (*(.inttab5.intvec.116)) } > pfls5
    .inttab_tc5_075 (TEXT) BIND(__INTTAB_CPU5 + 0x0EA0) : {KEEP (*(.inttab5.intvec.117)) } > pfls5
    .inttab_tc5_076 (TEXT) BIND(__INTTAB_CPU5 + 0x0EC0) : {KEEP (*(.inttab5.intvec.118)) } > pfls5
    .inttab_tc5_077 (TEXT) BIND(__INTTAB_CPU5 + 0x0EE0) : {KEEP (*(.inttab5.intvec.119)) } > pfls5
    .inttab_tc5_078 (TEXT) BIND(__INTTAB_CPU5 + 0x0F00) : {KEEP (*(.inttab5.intvec.120)) } > pfls5
    .inttab_tc5_079 (TEXT) BIND(__INTTAB_CPU5 + 0x0F20) : {KEEP (*(.inttab5.intvec.121)) } > pfls5
    .inttab_tc5_07A (TEXT) BIND(__INTTAB_CPU5 + 0x0F40) : {KEEP (*(.inttab5.intvec.122)) } > pfls5
    .inttab_tc5_07B (TEXT) BIND(__INTTAB_CPU5 + 0x0F60) : {KEEP (*(.inttab5.intvec.123)) } > pfls5
    .inttab_tc5_07C (TEXT) BIND(__INTTAB_CPU5 + 0x0F80) : {KEEP (*(.inttab5.intvec.124)) } > pfls5
    .inttab_tc5_07D (TEXT) BIND(__INTTAB_CPU5 + 0x0FA0) : {KEEP (*(.inttab5.intvec.125)) } > pfls5
    .inttab_tc5_07E (TEXT) BIND(__INTTAB_CPU5 + 0x0FC0) : {KEEP (*(.inttab5.intvec.126)) } > pfls5
    .inttab_tc5_07F (TEXT) BIND(__INTTAB_CPU5 + 0x0FE0) : {KEEP (*(.inttab5.intvec.127)) } > pfls5
    .inttab_tc5_080 (TEXT) BIND(__INTTAB_CPU5 + 0x1000) : {KEEP (*(.inttab5.intvec.128)) } > pfls5
    .inttab_tc5_081 (TEXT) BIND(__INTTAB_CPU5 + 0x1020) : {KEEP (*(.inttab5.intvec.129)) } > pfls5
    .inttab_tc5_082 (TEXT) BIND(__INTTAB_CPU5 + 0x1040) : {KEEP (*(.inttab5.intvec.130)) } > pfls5
    .inttab_tc5_083 (TEXT) BIND(__INTTAB_CPU5 + 0x1060) : {KEEP (*(.inttab5.intvec.131)) } > pfls5
    .inttab_tc5_084 (TEXT) BIND(__INTTAB_CPU5 + 0x1080) : {KEEP (*(.inttab5.intvec.132)) } > pfls5
    .inttab_tc5_085 (TEXT) BIND(__INTTAB_CPU5 + 0x10A0) : {KEEP (*(.inttab5.intvec.133)) } > pfls5
    .inttab_tc5_086 (TEXT) BIND(__INTTAB_CPU5 + 0x10C0) : {KEEP (*(.inttab5.intvec.134)) } > pfls5
    .inttab_tc5_087 (TEXT) BIND(__INTTAB_CPU5 + 0x10E0) : {KEEP (*(.inttab5.intvec.135)) } > pfls5
    .inttab_tc5_088 (TEXT) BIND(__INTTAB_CPU5 + 0x1100) : {KEEP (*(.inttab5.intvec.136)) } > pfls5
    .inttab_tc5_089 (TEXT) BIND(__INTTAB_CPU5 + 0x1120) : {KEEP (*(.inttab5.intvec.137)) } > pfls5
    .inttab_tc5_08A (TEXT) BIND(__INTTAB_CPU5 + 0x1140) : {KEEP (*(.inttab5.intvec.138)) } > pfls5
    .inttab_tc5_08B (TEXT) BIND(__INTTAB_CPU5 + 0x1160) : {KEEP (*(.inttab5.intvec.139)) } > pfls5
    .inttab_tc5_08C (TEXT) BIND(__INTTAB_CPU5 + 0x1180) : {KEEP (*(.inttab5.intvec.140)) } > pfls5
    .inttab_tc5_08D (TEXT) BIND(__INTTAB_CPU5 + 0x11A0) : {KEEP (*(.inttab5.intvec.141)) } > pfls5
    .inttab_tc5_08E (TEXT) BIND(__INTTAB_CPU5 + 0x11C0) : {KEEP (*(.inttab5.intvec.142)) } > pfls5
    .inttab_tc5_08F (TEXT) BIND(__INTTAB_CPU5 + 0x11E0) : {KEEP (*(.inttab5.intvec.143)) } > pfls5
    .inttab_tc5_090 (TEXT) BIND(__INTTAB_CPU5 + 0x1200) : {KEEP (*(.inttab5.intvec.144)) } > pfls5
    .inttab_tc5_091 (TEXT) BIND(__INTTAB_CPU5 + 0x1220) : {KEEP (*(.inttab5.intvec.145)) } > pfls5
    .inttab_tc5_092 (TEXT) BIND(__INTTAB_CPU5 + 0x1240) : {KEEP (*(.inttab5.intvec.146)) } > pfls5
    .inttab_tc5_093 (TEXT) BIND(__INTTAB_CPU5 + 0x1260) : {KEEP (*(.inttab5.intvec.147)) } > pfls5
    .inttab_tc5_094 (TEXT) BIND(__INTTAB_CPU5 + 0x1280) : {KEEP (*(.inttab5.intvec.148)) } > pfls5
    .inttab_tc5_095 (TEXT) BIND(__INTTAB_CPU5 + 0x12A0) : {KEEP (*(.inttab5.intvec.149)) } > pfls5
    .inttab_tc5_096 (TEXT) BIND(__INTTAB_CPU5 + 0x12C0) : {KEEP (*(.inttab5.intvec.150)) } > pfls5
    .inttab_tc5_097 (TEXT) BIND(__INTTAB_CPU5 + 0x12E0) : {KEEP (*(.inttab5.intvec.151)) } > pfls5
    .inttab_tc5_098 (TEXT) BIND(__INTTAB_CPU5 + 0x1300) : {KEEP (*(.inttab5.intvec.152)) } > pfls5
    .inttab_tc5_099 (TEXT) BIND(__INTTAB_CPU5 + 0x1320) : {KEEP (*(.inttab5.intvec.153)) } > pfls5
    .inttab_tc5_09A (TEXT) BIND(__INTTAB_CPU5 + 0x1340) : {KEEP (*(.inttab5.intvec.154)) } > pfls5
    .inttab_tc5_09B (TEXT) BIND(__INTTAB_CPU5 + 0x1360) : {KEEP (*(.inttab5.intvec.155)) } > pfls5
    .inttab_tc5_09C (TEXT) BIND(__INTTAB_CPU5 + 0x1380) : {KEEP (*(.inttab5.intvec.156)) } > pfls5
    .inttab_tc5_09D (TEXT) BIND(__INTTAB_CPU5 + 0x13A0) : {KEEP (*(.inttab5.intvec.157)) } > pfls5
    .inttab_tc5_09E (TEXT) BIND(__INTTAB_CPU5 + 0x13C0) : {KEEP (*(.inttab5.intvec.158)) } > pfls5
    .inttab_tc5_09F (TEXT) BIND(__INTTAB_CPU5 + 0x13E0) : {KEEP (*(.inttab5.intvec.159)) } > pfls5
    .inttab_tc5_0A0 (TEXT) BIND(__INTTAB_CPU5 + 0x1400) : {KEEP (*(.inttab5.intvec.160)) } > pfls5
    .inttab_tc5_0A1 (TEXT) BIND(__INTTAB_CPU5 + 0x1420) : {KEEP (*(.inttab5.intvec.161)) } > pfls5
    .inttab_tc5_0A2 (TEXT) BIND(__INTTAB_CPU5 + 0x1440) : {KEEP (*(.inttab5.intvec.162)) } > pfls5
    .inttab_tc5_0A3 (TEXT) BIND(__INTTAB_CPU5 + 0x1460) : {KEEP (*(.inttab5.intvec.163)) } > pfls5
    .inttab_tc5_0A4 (TEXT) BIND(__INTTAB_CPU5 + 0x1480) : {KEEP (*(.inttab5.intvec.164)) } > pfls5
    .inttab_tc5_0A5 (TEXT) BIND(__INTTAB_CPU5 + 0x14A0) : {KEEP (*(.inttab5.intvec.165)) } > pfls5
    .inttab_tc5_0A6 (TEXT) BIND(__INTTAB_CPU5 + 0x14C0) : {KEEP (*(.inttab5.intvec.166)) } > pfls5
    .inttab_tc5_0A7 (TEXT) BIND(__INTTAB_CPU5 + 0x14E0) : {KEEP (*(.inttab5.intvec.167)) } > pfls5
    .inttab_tc5_0A8 (TEXT) BIND(__INTTAB_CPU5 + 0x1500) : {KEEP (*(.inttab5.intvec.168)) } > pfls5
    .inttab_tc5_0A9 (TEXT) BIND(__INTTAB_CPU5 + 0x1520) : {KEEP (*(.inttab5.intvec.169)) } > pfls5
    .inttab_tc5_0AA (TEXT) BIND(__INTTAB_CPU5 + 0x1540) : {KEEP (*(.inttab5.intvec.170)) } > pfls5
    .inttab_tc5_0AB (TEXT) BIND(__INTTAB_CPU5 + 0x1560) : {KEEP (*(.inttab5.intvec.171)) } > pfls5
    .inttab_tc5_0AC (TEXT) BIND(__INTTAB_CPU5 + 0x1580) : {KEEP (*(.inttab5.intvec.172)) } > pfls5
    .inttab_tc5_0AD (TEXT) BIND(__INTTAB_CPU5 + 0x15A0) : {KEEP (*(.inttab5.intvec.173)) } > pfls5
    .inttab_tc5_0AE (TEXT) BIND(__INTTAB_CPU5 + 0x15C0) : {KEEP (*(.inttab5.intvec.174)) } > pfls5
    .inttab_tc5_0AF (TEXT) BIND(__INTTAB_CPU5 + 0x15E0) : {KEEP (*(.inttab5.intvec.175)) } > pfls5
    .inttab_tc5_0B0 (TEXT) BIND(__INTTAB_CPU5 + 0x1600) : {KEEP (*(.inttab5.intvec.176)) } > pfls5
    .inttab_tc5_0B1 (TEXT) BIND(__INTTAB_CPU5 + 0x1620) : {KEEP (*(.inttab5.intvec.177)) } > pfls5
    .inttab_tc5_0B2 (TEXT) BIND(__INTTAB_CPU5 + 0x1640) : {KEEP (*(.inttab5.intvec.178)) } > pfls5
    .inttab_tc5_0B3 (TEXT) BIND(__INTTAB_CPU5 + 0x1660) : {KEEP (*(.inttab5.intvec.179)) } > pfls5
    .inttab_tc5_0B4 (TEXT) BIND(__INTTAB_CPU5 + 0x1680) : {KEEP (*(.inttab5.intvec.180)) } > pfls5
    .inttab_tc5_0B5 (TEXT) BIND(__INTTAB_CPU5 + 0x16A0) : {KEEP (*(.inttab5.intvec.181)) } > pfls5
    .inttab_tc5_0B6 (TEXT) BIND(__INTTAB_CPU5 + 0x16C0) : {KEEP (*(.inttab5.intvec.182)) } > pfls5
    .inttab_tc5_0B7 (TEXT) BIND(__INTTAB_CPU5 + 0x16E0) : {KEEP (*(.inttab5.intvec.183)) } > pfls5
    .inttab_tc5_0B8 (TEXT) BIND(__INTTAB_CPU5 + 0x1700) : {KEEP (*(.inttab5.intvec.184)) } > pfls5
    .inttab_tc5_0B9 (TEXT) BIND(__INTTAB_CPU5 + 0x1720) : {KEEP (*(.inttab5.intvec.185)) } > pfls5
    .inttab_tc5_0BA (TEXT) BIND(__INTTAB_CPU5 + 0x1740) : {KEEP (*(.inttab5.intvec.186)) } > pfls5
    .inttab_tc5_0BB (TEXT) BIND(__INTTAB_CPU5 + 0x1760) : {KEEP (*(.inttab5.intvec.187)) } > pfls5
    .inttab_tc5_0BC (TEXT) BIND(__INTTAB_CPU5 + 0x1780) : {KEEP (*(.inttab5.intvec.188)) } > pfls5
    .inttab_tc5_0BD (TEXT) BIND(__INTTAB_CPU5 + 0x17A0) : {KEEP (*(.inttab5.intvec.189)) } > pfls5
    .inttab_tc5_0BE (TEXT) BIND(__INTTAB_CPU5 + 0x17C0) : {KEEP (*(.inttab5.intvec.190)) } > pfls5
    .inttab_tc5_0BF (TEXT) BIND(__INTTAB_CPU5 + 0x17E0) : {KEEP (*(.inttab5.intvec.191)) } > pfls5
    .inttab_tc5_0C0 (TEXT) BIND(__INTTAB_CPU5 + 0x1800) : {KEEP (*(.inttab5.intvec.192)) } > pfls5
    .inttab_tc5_0C1 (TEXT) BIND(__INTTAB_CPU5 + 0x1820) : {KEEP (*(.inttab5.intvec.193)) } > pfls5
    .inttab_tc5_0C2 (TEXT) BIND(__INTTAB_CPU5 + 0x1840) : {KEEP (*(.inttab5.intvec.194)) } > pfls5
    .inttab_tc5_0C3 (TEXT) BIND(__INTTAB_CPU5 + 0x1860) : {KEEP (*(.inttab5.intvec.195)) } > pfls5
    .inttab_tc5_0C4 (TEXT) BIND(__INTTAB_CPU5 + 0x1880) : {KEEP (*(.inttab5.intvec.196)) } > pfls5
    .inttab_tc5_0C5 (TEXT) BIND(__INTTAB_CPU5 + 0x18A0) : {KEEP (*(.inttab5.intvec.197)) } > pfls5
    .inttab_tc5_0C6 (TEXT) BIND(__INTTAB_CPU5 + 0x18C0) : {KEEP (*(.inttab5.intvec.198)) } > pfls5
    .inttab_tc5_0C7 (TEXT) BIND(__INTTAB_CPU5 + 0x18E0) : {KEEP (*(.inttab5.intvec.199)) } > pfls5
    .inttab_tc5_0C8 (TEXT) BIND(__INTTAB_CPU5 + 0x1900) : {KEEP (*(.inttab5.intvec.200)) } > pfls5
    .inttab_tc5_0C9 (TEXT) BIND(__INTTAB_CPU5 + 0x1920) : {KEEP (*(.inttab5.intvec.201)) } > pfls5
    .inttab_tc5_0CA (TEXT) BIND(__INTTAB_CPU5 + 0x1940) : {KEEP (*(.inttab5.intvec.202)) } > pfls5
    .inttab_tc5_0CB (TEXT) BIND(__INTTAB_CPU5 + 0x1960) : {KEEP (*(.inttab5.intvec.203)) } > pfls5
    .inttab_tc5_0CC (TEXT) BIND(__INTTAB_CPU5 + 0x1980) : {KEEP (*(.inttab5.intvec.204)) } > pfls5
    .inttab_tc5_0CD (TEXT) BIND(__INTTAB_CPU5 + 0x19A0) : {KEEP (*(.inttab5.intvec.205)) } > pfls5
    .inttab_tc5_0CE (TEXT) BIND(__INTTAB_CPU5 + 0x19C0) : {KEEP (*(.inttab5.intvec.206)) } > pfls5
    .inttab_tc5_0CF (TEXT) BIND(__INTTAB_CPU5 + 0x19E0) : {KEEP (*(.inttab5.intvec.207)) } > pfls5
    .inttab_tc5_0D0 (TEXT) BIND(__INTTAB_CPU5 + 0x1A00) : {KEEP (*(.inttab5.intvec.208)) } > pfls5
    .inttab_tc5_0D1 (TEXT) BIND(__INTTAB_CPU5 + 0x1A20) : {KEEP (*(.inttab5.intvec.209)) } > pfls5
    .inttab_tc5_0D2 (TEXT) BIND(__INTTAB_CPU5 + 0x1A40) : {KEEP (*(.inttab5.intvec.210)) } > pfls5
    .inttab_tc5_0D3 (TEXT) BIND(__INTTAB_CPU5 + 0x1A60) : {KEEP (*(.inttab5.intvec.211)) } > pfls5
    .inttab_tc5_0D4 (TEXT) BIND(__INTTAB_CPU5 + 0x1A80) : {KEEP (*(.inttab5.intvec.212)) } > pfls5
    .inttab_tc5_0D5 (TEXT) BIND(__INTTAB_CPU5 + 0x1AA0) : {KEEP (*(.inttab5.intvec.213)) } > pfls5
    .inttab_tc5_0D6 (TEXT) BIND(__INTTAB_CPU5 + 0x1AC0) : {KEEP (*(.inttab5.intvec.214)) } > pfls5
    .inttab_tc5_0D7 (TEXT) BIND(__INTTAB_CPU5 + 0x1AE0) : {KEEP (*(.inttab5.intvec.215)) } > pfls5
    .inttab_tc5_0D8 (TEXT) BIND(__INTTAB_CPU5 + 0x1B00) : {KEEP (*(.inttab5.intvec.216)) } > pfls5
    .inttab_tc5_0D9 (TEXT) BIND(__INTTAB_CPU5 + 0x1B20) : {KEEP (*(.inttab5.intvec.217)) } > pfls5
    .inttab_tc5_0DA (TEXT) BIND(__INTTAB_CPU5 + 0x1B40) : {KEEP (*(.inttab5.intvec.218)) } > pfls5
    .inttab_tc5_0DB (TEXT) BIND(__INTTAB_CPU5 + 0x1B60) : {KEEP (*(.inttab5.intvec.219)) } > pfls5
    .inttab_tc5_0DC (TEXT) BIND(__INTTAB_CPU5 + 0x1B80) : {KEEP (*(.inttab5.intvec.220)) } > pfls5
    .inttab_tc5_0DD (TEXT) BIND(__INTTAB_CPU5 + 0x1BA0) : {KEEP (*(.inttab5.intvec.221)) } > pfls5
    .inttab_tc5_0DE (TEXT) BIND(__INTTAB_CPU5 + 0x1BC0) : {KEEP (*(.inttab5.intvec.222)) } > pfls5
    .inttab_tc5_0DF (TEXT) BIND(__INTTAB_CPU5 + 0x1BE0) : {KEEP (*(.inttab5.intvec.223)) } > pfls5
    .inttab_tc5_0E0 (TEXT) BIND(__INTTAB_CPU5 + 0x1C00) : {KEEP (*(.inttab5.intvec.224)) } > pfls5
    .inttab_tc5_0E1 (TEXT) BIND(__INTTAB_CPU5 + 0x1C20) : {KEEP (*(.inttab5.intvec.225)) } > pfls5
    .inttab_tc5_0E2 (TEXT) BIND(__INTTAB_CPU5 + 0x1C40) : {KEEP (*(.inttab5.intvec.226)) } > pfls5
    .inttab_tc5_0E3 (TEXT) BIND(__INTTAB_CPU5 + 0x1C60) : {KEEP (*(.inttab5.intvec.227)) } > pfls5
    .inttab_tc5_0E4 (TEXT) BIND(__INTTAB_CPU5 + 0x1C80) : {KEEP (*(.inttab5.intvec.228)) } > pfls5
    .inttab_tc5_0E5 (TEXT) BIND(__INTTAB_CPU5 + 0x1CA0) : {KEEP (*(.inttab5.intvec.229)) } > pfls5
    .inttab_tc5_0E6 (TEXT) BIND(__INTTAB_CPU5 + 0x1CC0) : {KEEP (*(.inttab5.intvec.230)) } > pfls5
    .inttab_tc5_0E7 (TEXT) BIND(__INTTAB_CPU5 + 0x1CE0) : {KEEP (*(.inttab5.intvec.231)) } > pfls5
    .inttab_tc5_0E8 (TEXT) BIND(__INTTAB_CPU5 + 0x1D00) : {KEEP (*(.inttab5.intvec.232)) } > pfls5
    .inttab_tc5_0E9 (TEXT) BIND(__INTTAB_CPU5 + 0x1D20) : {KEEP (*(.inttab5.intvec.233)) } > pfls5
    .inttab_tc5_0EA (TEXT) BIND(__INTTAB_CPU5 + 0x1D40) : {KEEP (*(.inttab5.intvec.234)) } > pfls5
    .inttab_tc5_0EB (TEXT) BIND(__INTTAB_CPU5 + 0x1D60) : {KEEP (*(.inttab5.intvec.235)) } > pfls5
    .inttab_tc5_0EC (TEXT) BIND(__INTTAB_CPU5 + 0x1D80) : {KEEP (*(.inttab5.intvec.236)) } > pfls5
    .inttab_tc5_0ED (TEXT) BIND(__INTTAB_CPU5 + 0x1DA0) : {KEEP (*(.inttab5.intvec.237)) } > pfls5
    .inttab_tc5_0EE (TEXT) BIND(__INTTAB_CPU5 + 0x1DC0) : {KEEP (*(.inttab5.intvec.238)) } > pfls5
    .inttab_tc5_0EF (TEXT) BIND(__INTTAB_CPU5 + 0x1DE0) : {KEEP (*(.inttab5.intvec.239)) } > pfls5
    .inttab_tc5_0F0 (TEXT) BIND(__INTTAB_CPU5 + 0x1E00) : {KEEP (*(.inttab5.intvec.240)) } > pfls5
    .inttab_tc5_0F1 (TEXT) BIND(__INTTAB_CPU5 + 0x1E20) : {KEEP (*(.inttab5.intvec.241)) } > pfls5
    .inttab_tc5_0F2 (TEXT) BIND(__INTTAB_CPU5 + 0x1E40) : {KEEP (*(.inttab5.intvec.242)) } > pfls5
    .inttab_tc5_0F3 (TEXT) BIND(__INTTAB_CPU5 + 0x1E60) : {KEEP (*(.inttab5.intvec.243)) } > pfls5
    .inttab_tc5_0F4 (TEXT) BIND(__INTTAB_CPU5 + 0x1E80) : {KEEP (*(.inttab5.intvec.244)) } > pfls5
    .inttab_tc5_0F5 (TEXT) BIND(__INTTAB_CPU5 + 0x1EA0) : {KEEP (*(.inttab5.intvec.245)) } > pfls5
    .inttab_tc5_0F6 (TEXT) BIND(__INTTAB_CPU5 + 0x1EC0) : {KEEP (*(.inttab5.intvec.246)) } > pfls5
    .inttab_tc5_0F7 (TEXT) BIND(__INTTAB_CPU5 + 0x1EE0) : {KEEP (*(.inttab5.intvec.247)) } > pfls5
    .inttab_tc5_0F8 (TEXT) BIND(__INTTAB_CPU5 + 0x1F00) : {KEEP (*(.inttab5.intvec.248)) } > pfls5
    .inttab_tc5_0F9 (TEXT) BIND(__INTTAB_CPU5 + 0x1F20) : {KEEP (*(.inttab5.intvec.249)) } > pfls5
    .inttab_tc5_0FA (TEXT) BIND(__INTTAB_CPU5 + 0x1F40) : {KEEP (*(.inttab5.intvec.250)) } > pfls5
    .inttab_tc5_0FB (TEXT) BIND(__INTTAB_CPU5 + 0x1F60) : {KEEP (*(.inttab5.intvec.251)) } > pfls5
    .inttab_tc5_0FC (TEXT) BIND(__INTTAB_CPU5 + 0x1F80) : {KEEP (*(.inttab5.intvec.252)) } > pfls5
    .inttab_tc5_0FD (TEXT) BIND(__INTTAB_CPU5 + 0x1FA0) : {KEEP (*(.inttab5.intvec.253)) } > pfls5
    .inttab_tc5_0FE (TEXT) BIND(__INTTAB_CPU5 + 0x1FC0) : {KEEP (*(.inttab5.intvec.254)) } > pfls5
    .inttab_tc5_0FF (TEXT) BIND(__INTTAB_CPU5 + 0x1FE0) : {KEEP (*(.inttab5.intvec.255)) } > pfls5

}