
-Xgenerate-copytables


LCF_CSA1_SIZE    = 8k;
LCF_USTACK1_SIZE = 2k;
LCF_ISTACK1_SIZE = 1k;


LCF_HEAP_SIZE = 4k;

LCF_PPU_FLASH_SIZE  = 1M;
LCF_PPU_LMURAM_SIZE = 512k;
LCF_PPU_CSM_SIZE    = 512k;



LCF_DSPR1_START = 0x60000000;
LCF_DSPR1_SIZE  = 240K;


LCF_CSA1_OFFSET    = (LCF_DSPR1_SIZE - 1k - LCF_CSA1_SIZE);
LCF_ISTACK1_OFFSET = (LCF_CSA1_OFFSET - 256 - LCF_ISTACK1_SIZE);
LCF_USTACK1_OFFSET = (LCF_ISTACK1_OFFSET - 256 - LCF_USTACK1_SIZE);

LCF_HEAP1_OFFSET = (LCF_USTACK1_OFFSET - LCF_HEAP_SIZE);

LCF_INTVEC1_START = 0x807FE000;


__INTTAB_CPU1 = LCF_INTVEC1_START;
 



LCF_TRAPVEC1_START = 0x80400100;

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


RESET = LCF_STARTPTR_NC_CPU1;

MEMORY
{
    dsram1: org = 0x60000000, len = 240K
    psram1: org = 0x60100000, len = 64K

	

    pfls1: org = 0x80400000, len = 4M
    pfls1_nc: org = 0xa0400000, len = 4M	

    pfls5: org = 0x81200000, len = 2M - 1M
    pfls5_nc: org = 0xa1200000, len = 2M - 1M

    ucb: org = 0xae400000, len = 80K

    cpu1_dlmu: org = 0x90080000, len = 512K
    cpu1_dlmu_nc: org = 0xb0080000, len = 512K
	


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
    /* CPU1 Stack and CSA defines */
    CPU1.ustack BIND(LCF_DSPR1_START + LCF_USTACK1_OFFSET) :
    { __USTACK1_END = . ;    . = . + LCF_USTACK1_SIZE;    __USTACK1 = . ; }
    
    CPU1.istack BIND(LCF_DSPR1_START + LCF_ISTACK1_OFFSET):
    { __ISTACK1_END = . ;    . = . + LCF_ISTACK1_SIZE;    __ISTACK1 = . ; }
    
    CPU1.csa BIND(LCF_DSPR1_START + LCF_CSA1_OFFSET):
    { __CSA1 = . ;    . = . + LCF_CSA1_SIZE;    __CSA1_END = . ; }
	
	


    __SP_END = __USTACK1_END;

    /*Fixed memory Allocations*/
    __IF_CONST = 0x80000020;


    /*Fixed memory Allocations for Trap Vector Table*/
    .traptab_tc1 (TEXT) BIND(LCF_TRAPVEC1_START) : { __TRAPTAB_CPU1 = .; KEEP (*(.traptab_cpu1)) } > pfls1

    /DISCARD/ :
    { 
        *(.traptab_cpu0)
        *(.traptab_cpu2)
        *(.traptab_cpu3)
        *(.traptab_cpu4)
	*(.traptab_cpu5)
        *(.interface_const)
    }

    /*Fixed memory Allocations for _START CPU1 */
    .start_tc1 (TEXT) LOAD(LCF_STARTPTR_CPU1) BIND(LCF_STARTPTR_NC_CPU1) : { __ENABLE_INDIVIDUAL_C_INIT_CPU1 = 1; KEEP (*(.start_cpu1)) } =0x800 > pfls1_nc
    __START0 = LCF_STARTPTR_NC_CPU0;
    __START1 = LCF_STARTPTR_NC_CPU1;
    __START2 = LCF_STARTPTR_NC_CPU2;
    __START3 = LCF_STARTPTR_NC_CPU3;
    __START4 = LCF_STARTPTR_NC_CPU4;
    __START5 = LCF_STARTPTR_NC_CPU5;

    /*Near Absolute Addressable Data Sections*/
    GROUP LOAD(> pfls1) COPYTABLE :
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
	
	
	

    /*Near Absolute Data, selectable by toolchain*/
    GROUP LOAD(> pfls1) COPYTABLE :
    {
        .zdata (DATA) :
        {
            *(.zdata.dsprInit.cpu1.32bit)
            *(.zdata.dsprInit.cpu1.16bit)
            *(.zdata.dsprInit.cpu1.8bit)
            *(.zdata)
        }
        
        .zdata_powerOn (DATA) :
        {
            *(.zdata.dsprPowerOnInit.cpu1.32bit)
            *(.zdata.dsprPowerOnInit.cpu1.16bit)
            *(.zdata.dsprPowerOnInit.cpu1.8bit)
        }
        
        .zbss (BSS) :
        {
            *(.zbss.dsprClearOnInit.cpu1.32bit)
            *(.zbss.dsprClearOnInit.cpu1.16bit)
            *(.zbss.dsprClearOnInit.cpu1.8bit)
            *(.zbss)
        }
        
        .zbss_powerOn (BSS) :
        {
            *(.zbss.dsprPowerOnClear.cpu1.32bit)
            *(.zbss.dsprPowerOnClear.cpu1.16bit)
            *(.zbss.dsprPowerOnClear.cpu1.8bit)
        }
        
        .zbss_noClear (BSS) :
        {
            *(.zbss.dsprNoInit.cpu1.32bit)
            *(.zbss.dsprNoInit.cpu1.16bit)
            *(.zbss.dsprNoInit.cpu1.8bit)
        }
		
		
    } > dsram1

    /*Relative A0/A1/A8/A9 Addressable Sections*/
    /*Relative A0 Addressable Data, selectable with patterns and user defined sections*/
    /*Note: A0 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A0 Addressable Data, selectable by toolchain*/
    GROUP LOAD(> pfls1) COPYTABLE :
	
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
    } > dsram1

    /*Relative A1 Addressable Const, selectable with patterns and user defined sections*/
    /*Note: A1 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A1 Addressable Const, selectable by toolchain*/
    GROUP :
    {
        .zrodata (CONST) :
        {
            *Ifx_Ssw_Tc1.* (.zrodata)
            *Cpu1_Main.* (.zrodata)
            *(.zrodata.const.cpu1.32bit)
            *(.zrodata.const.cpu1.16bit)
            *(.zrodata.const.cpu1.8bit)
            *(.zrodata.config.cpu1.32bit)
            *(.zrodata.config.cpu1.16bit)
            *(.zrodata.config.cpu1.8bit)
            *(.zrodata_cpu1)
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
    } > pfls1

    /*LMU memory sections*/

    GROUP LOAD(> pfls1) COPYTABLE :
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
    /*Relative A9 Addressable Data, selectable with patterns and user defined sections*/
    GROUP LOAD(> pfls1) COPYTABLE: 
	
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
    } > cpu1_dlmu



    GROUP LOAD(> pfls1) COPYTABLE :
    {
        .lmudata (DATA) :
        {
            *(.lmudata)
        }
        
        .lmubss (BSS) :
        {
            *(.lmubss)
        }
    } > cpu1_dlmu

 GROUP LOAD(> pfls1) :
    {
        .ppu_lmuram  :
        {
            . = ALIGN(4);
            __PPU_LMURAM_START = .;
            . += LCF_PPU_LMURAM_SIZE;
            __PPU_LMURAM_END = .;
        }
    } > ppu_lmuram_nc
	
    GROUP LOAD(> pfls1) :
    {
        .ppu_csm :
        {
        . = ALIGN(4);
        __PPU_CSM_START = .;
        . += LCF_PPU_CSM_SIZE;
        __PPU_CSM_END = .;
        }
    } > ppu_csm_nc
    
    GROUP LOAD(> pfls1) :
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
    } > pfls1

    __A8_MEM = SIZEOF(.rodata_a8) ? ADDR(.rodata_a8) : (ADDR(.rodata_a8) & 0xF0000000) + 32k ;
    
    /*Far Data / Far Const Sections, selectable with patterns and user defined sections*/
    /*Far Data Sections, selectable with patterns and user defined sections*/
    GROUP LOAD(> pfls1) COPYTABLE :
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
    /*Far Data Sections, selectable by toolchain*/
    GROUP LOAD(> pfls1) COPYTABLE :
	
    {
        .data (DATA) :
        {
            *(.data.farDsprInit.cpu1.32bit)
            *(.data.farDsprInit.cpu1.16bit)
            *(.data.farDsprInit.cpu1.8bit)
            *(.data)
        }
        
        .bss (BSS) :
        {
            *(.bss.farDsprClearOnInit.cpu1.32bit)
            *(.bss.farDsprClearOnInit.cpu1.16bit)
            *(.bss.farDsprClearOnInit.cpu1.8bit)
            *(.bss)
        }
        
        .bss_noClear (BSS) :
        {
            *(.bss.farDsprNoInit.cpu1.32bit)
            *(.bss.farDsprNoInit.cpu1.16bit)
            *(.bss.farDsprNoInit.cpu1.8bit)
        }
        
        .heap  :
        {
            . = ALIGN(4);
            __HEAP = .;
            __HEAP_START = .;
            __HEAP_END = . + LCF_HEAP_SIZE;
        }
    } > dsram1

    /* Far Const Sections, selectable with patterns and user defined sections */
    /* CPU1 Const Sections */
    CPU1.rodata (CONST) :
    {
        "*Ifx_Ssw_Tc1.*" (.rodata)
        "*Cpu1_Main.*" (.rodata)
        *(.rodata_cpu1)
    } > pfls1
	
    /*Far Const Sections, selectable by toolchain*/
    GROUP :
    {
        .rodata (CONST) :
        {
            *(.rodata)
            *(.rodata.farConst.cpu1.32bit)
            *(.rodata.farConst.cpu1.16bit)
            *(.rodata.farConst.cpu1.8bit)
        }
        
        .copytable (CONST) :
        {
            __DATA_ROM = .;
        }
    } > pfls1

    /*Code selections*/
    /*Code Sections, selectable with patterns and user defined sections*/
    /* CPU1 Code Sections */
    CPU1.text (TEXT) :
    {
        . = ALIGN(2);
        "*Ifx_Ssw_Tc1.*" (.text)
        "*Cpu1_Main.*" (.text)
        *(.text_cpu1)
    } > pfls1
    
    CPU1.psram_text (TEXT) LOAD(> pfls1) COPYTABLE :
    {
        . = ALIGN(2);
        *(.psram_text_cpu1)
        *(.cpu1_psram)
    } > psram1
	
	

    /*Code Sections, selectable by toolchain*/
    GROUP :
    {
        .text (TEXT) :
        {
            . = ALIGN(2);
            *(.text)
            *(.text.fast.pfls.cpu1)
            *(.text.slow.pfls.cpu1)
            *(.text.5ms.pfls.cpu1)
            *(.text.10ms.pfls.cpu1)
            *(.text.callout.pfls.cpu1)
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
    } > pfls1


    /* CPU1 Interrupt Vector Table */
    .inttab_tc1_000 (TEXT) BIND(__INTTAB_CPU1 + 0x0000) : {KEEP (*(.inttab1.intvec.0  )) } > pfls1
    .inttab_tc1_001 (TEXT) BIND(__INTTAB_CPU1 + 0x0020) : {KEEP (*(.inttab1.intvec.1  )) } > pfls1
    .inttab_tc1_002 (TEXT) BIND(__INTTAB_CPU1 + 0x0040) : {KEEP (*(.inttab1.intvec.2  )) } > pfls1
    .inttab_tc1_003 (TEXT) BIND(__INTTAB_CPU1 + 0x0060) : {KEEP (*(.inttab1.intvec.3  )) } > pfls1
    .inttab_tc1_004 (TEXT) BIND(__INTTAB_CPU1 + 0x0080) : {KEEP (*(.inttab1.intvec.4  )) } > pfls1
    .inttab_tc1_005 (TEXT) BIND(__INTTAB_CPU1 + 0x00A0) : {KEEP (*(.inttab1.intvec.5  )) } > pfls1
    .inttab_tc1_006 (TEXT) BIND(__INTTAB_CPU1 + 0x00C0) : {KEEP (*(.inttab1.intvec.6  )) } > pfls1
    .inttab_tc1_007 (TEXT) BIND(__INTTAB_CPU1 + 0x00E0) : {KEEP (*(.inttab1.intvec.7  )) } > pfls1
    .inttab_tc1_008 (TEXT) BIND(__INTTAB_CPU1 + 0x0100) : {KEEP (*(.inttab1.intvec.8  )) } > pfls1
    .inttab_tc1_009 (TEXT) BIND(__INTTAB_CPU1 + 0x0120) : {KEEP (*(.inttab1.intvec.9  )) } > pfls1
    .inttab_tc1_00A (TEXT) BIND(__INTTAB_CPU1 + 0x0140) : {KEEP (*(.inttab1.intvec.10 )) } > pfls1
    .inttab_tc1_00B (TEXT) BIND(__INTTAB_CPU1 + 0x0160) : {KEEP (*(.inttab1.intvec.11 )) } > pfls1
    .inttab_tc1_00C (TEXT) BIND(__INTTAB_CPU1 + 0x0180) : {KEEP (*(.inttab1.intvec.12 )) } > pfls1
    .inttab_tc1_00D (TEXT) BIND(__INTTAB_CPU1 + 0x01A0) : {KEEP (*(.inttab1.intvec.13 )) } > pfls1
    .inttab_tc1_00E (TEXT) BIND(__INTTAB_CPU1 + 0x01C0) : {KEEP (*(.inttab1.intvec.14 )) } > pfls1
    .inttab_tc1_00F (TEXT) BIND(__INTTAB_CPU1 + 0x01E0) : {KEEP (*(.inttab1.intvec.15 )) } > pfls1
    .inttab_tc1_010 (TEXT) BIND(__INTTAB_CPU1 + 0x0200) : {KEEP (*(.inttab1.intvec.16 )) } > pfls1
    .inttab_tc1_011 (TEXT) BIND(__INTTAB_CPU1 + 0x0220) : {KEEP (*(.inttab1.intvec.17 )) } > pfls1
    .inttab_tc1_012 (TEXT) BIND(__INTTAB_CPU1 + 0x0240) : {KEEP (*(.inttab1.intvec.18 )) } > pfls1
    .inttab_tc1_013 (TEXT) BIND(__INTTAB_CPU1 + 0x0260) : {KEEP (*(.inttab1.intvec.19 )) } > pfls1
    .inttab_tc1_014 (TEXT) BIND(__INTTAB_CPU1 + 0x0280) : {KEEP (*(.inttab1.intvec.20 )) } > pfls1
    .inttab_tc1_015 (TEXT) BIND(__INTTAB_CPU1 + 0x02A0) : {KEEP (*(.inttab1.intvec.21 )) } > pfls1
    .inttab_tc1_016 (TEXT) BIND(__INTTAB_CPU1 + 0x02C0) : {KEEP (*(.inttab1.intvec.22 )) } > pfls1
    .inttab_tc1_017 (TEXT) BIND(__INTTAB_CPU1 + 0x02E0) : {KEEP (*(.inttab1.intvec.23 )) } > pfls1
    .inttab_tc1_018 (TEXT) BIND(__INTTAB_CPU1 + 0x0300) : {KEEP (*(.inttab1.intvec.24 )) } > pfls1
    .inttab_tc1_019 (TEXT) BIND(__INTTAB_CPU1 + 0x0320) : {KEEP (*(.inttab1.intvec.25 )) } > pfls1
    .inttab_tc1_01A (TEXT) BIND(__INTTAB_CPU1 + 0x0340) : {KEEP (*(.inttab1.intvec.26 )) } > pfls1
    .inttab_tc1_01B (TEXT) BIND(__INTTAB_CPU1 + 0x0360) : {KEEP (*(.inttab1.intvec.27 )) } > pfls1
    .inttab_tc1_01C (TEXT) BIND(__INTTAB_CPU1 + 0x0380) : {KEEP (*(.inttab1.intvec.28 )) } > pfls1
    .inttab_tc1_01D (TEXT) BIND(__INTTAB_CPU1 + 0x03A0) : {KEEP (*(.inttab1.intvec.29 )) } > pfls1
    .inttab_tc1_01E (TEXT) BIND(__INTTAB_CPU1 + 0x03C0) : {KEEP (*(.inttab1.intvec.30 )) } > pfls1
    .inttab_tc1_01F (TEXT) BIND(__INTTAB_CPU1 + 0x03E0) : {KEEP (*(.inttab1.intvec.31 )) } > pfls1
    .inttab_tc1_020 (TEXT) BIND(__INTTAB_CPU1 + 0x0400) : {KEEP (*(.inttab1.intvec.32 )) } > pfls1
    .inttab_tc1_021 (TEXT) BIND(__INTTAB_CPU1 + 0x0420) : {KEEP (*(.inttab1.intvec.33 )) } > pfls1
    .inttab_tc1_022 (TEXT) BIND(__INTTAB_CPU1 + 0x0440) : {KEEP (*(.inttab1.intvec.34 )) } > pfls1
    .inttab_tc1_023 (TEXT) BIND(__INTTAB_CPU1 + 0x0460) : {KEEP (*(.inttab1.intvec.35 )) } > pfls1
    .inttab_tc1_024 (TEXT) BIND(__INTTAB_CPU1 + 0x0480) : {KEEP (*(.inttab1.intvec.36 )) } > pfls1
    .inttab_tc1_025 (TEXT) BIND(__INTTAB_CPU1 + 0x04A0) : {KEEP (*(.inttab1.intvec.37 )) } > pfls1
    .inttab_tc1_026 (TEXT) BIND(__INTTAB_CPU1 + 0x04C0) : {KEEP (*(.inttab1.intvec.38 )) } > pfls1
    .inttab_tc1_027 (TEXT) BIND(__INTTAB_CPU1 + 0x04E0) : {KEEP (*(.inttab1.intvec.39 )) } > pfls1
    .inttab_tc1_028 (TEXT) BIND(__INTTAB_CPU1 + 0x0500) : {KEEP (*(.inttab1.intvec.40 )) } > pfls1
    .inttab_tc1_029 (TEXT) BIND(__INTTAB_CPU1 + 0x0520) : {KEEP (*(.inttab1.intvec.41 )) } > pfls1
    .inttab_tc1_02A (TEXT) BIND(__INTTAB_CPU1 + 0x0540) : {KEEP (*(.inttab1.intvec.42 )) } > pfls1
    .inttab_tc1_02B (TEXT) BIND(__INTTAB_CPU1 + 0x0560) : {KEEP (*(.inttab1.intvec.43 )) } > pfls1
    .inttab_tc1_02C (TEXT) BIND(__INTTAB_CPU1 + 0x0580) : {KEEP (*(.inttab1.intvec.44 )) } > pfls1
    .inttab_tc1_02D (TEXT) BIND(__INTTAB_CPU1 + 0x05A0) : {KEEP (*(.inttab1.intvec.45 )) } > pfls1
    .inttab_tc1_02E (TEXT) BIND(__INTTAB_CPU1 + 0x05C0) : {KEEP (*(.inttab1.intvec.46 )) } > pfls1
    .inttab_tc1_02F (TEXT) BIND(__INTTAB_CPU1 + 0x05E0) : {KEEP (*(.inttab1.intvec.47 )) } > pfls1
    .inttab_tc1_030 (TEXT) BIND(__INTTAB_CPU1 + 0x0600) : {KEEP (*(.inttab1.intvec.48 )) } > pfls1
    .inttab_tc1_031 (TEXT) BIND(__INTTAB_CPU1 + 0x0620) : {KEEP (*(.inttab1.intvec.49 )) } > pfls1
    .inttab_tc1_032 (TEXT) BIND(__INTTAB_CPU1 + 0x0640) : {KEEP (*(.inttab1.intvec.50 )) } > pfls1
    .inttab_tc1_033 (TEXT) BIND(__INTTAB_CPU1 + 0x0660) : {KEEP (*(.inttab1.intvec.51 )) } > pfls1
    .inttab_tc1_034 (TEXT) BIND(__INTTAB_CPU1 + 0x0680) : {KEEP (*(.inttab1.intvec.52 )) } > pfls1
    .inttab_tc1_035 (TEXT) BIND(__INTTAB_CPU1 + 0x06A0) : {KEEP (*(.inttab1.intvec.53 )) } > pfls1
    .inttab_tc1_036 (TEXT) BIND(__INTTAB_CPU1 + 0x06C0) : {KEEP (*(.inttab1.intvec.54 )) } > pfls1
    .inttab_tc1_037 (TEXT) BIND(__INTTAB_CPU1 + 0x06E0) : {KEEP (*(.inttab1.intvec.55 )) } > pfls1
    .inttab_tc1_038 (TEXT) BIND(__INTTAB_CPU1 + 0x0700) : {KEEP (*(.inttab1.intvec.56 )) } > pfls1
    .inttab_tc1_039 (TEXT) BIND(__INTTAB_CPU1 + 0x0720) : {KEEP (*(.inttab1.intvec.57 )) } > pfls1
    .inttab_tc1_03A (TEXT) BIND(__INTTAB_CPU1 + 0x0740) : {KEEP (*(.inttab1.intvec.58 )) } > pfls1
    .inttab_tc1_03B (TEXT) BIND(__INTTAB_CPU1 + 0x0760) : {KEEP (*(.inttab1.intvec.59 )) } > pfls1
    .inttab_tc1_03C (TEXT) BIND(__INTTAB_CPU1 + 0x0780) : {KEEP (*(.inttab1.intvec.60 )) } > pfls1
    .inttab_tc1_03D (TEXT) BIND(__INTTAB_CPU1 + 0x07A0) : {KEEP (*(.inttab1.intvec.61 )) } > pfls1
    .inttab_tc1_03E (TEXT) BIND(__INTTAB_CPU1 + 0x07C0) : {KEEP (*(.inttab1.intvec.62 )) } > pfls1
    .inttab_tc1_03F (TEXT) BIND(__INTTAB_CPU1 + 0x07E0) : {KEEP (*(.inttab1.intvec.63 )) } > pfls1
    .inttab_tc1_040 (TEXT) BIND(__INTTAB_CPU1 + 0x0800) : {KEEP (*(.inttab1.intvec.64 )) } > pfls1
    .inttab_tc1_041 (TEXT) BIND(__INTTAB_CPU1 + 0x0820) : {KEEP (*(.inttab1.intvec.65 )) } > pfls1
    .inttab_tc1_042 (TEXT) BIND(__INTTAB_CPU1 + 0x0840) : {KEEP (*(.inttab1.intvec.66 )) } > pfls1
    .inttab_tc1_043 (TEXT) BIND(__INTTAB_CPU1 + 0x0860) : {KEEP (*(.inttab1.intvec.67 )) } > pfls1
    .inttab_tc1_044 (TEXT) BIND(__INTTAB_CPU1 + 0x0880) : {KEEP (*(.inttab1.intvec.68 )) } > pfls1
    .inttab_tc1_045 (TEXT) BIND(__INTTAB_CPU1 + 0x08A0) : {KEEP (*(.inttab1.intvec.69 )) } > pfls1
    .inttab_tc1_046 (TEXT) BIND(__INTTAB_CPU1 + 0x08C0) : {KEEP (*(.inttab1.intvec.70 )) } > pfls1
    .inttab_tc1_047 (TEXT) BIND(__INTTAB_CPU1 + 0x08E0) : {KEEP (*(.inttab1.intvec.71 )) } > pfls1
    .inttab_tc1_048 (TEXT) BIND(__INTTAB_CPU1 + 0x0900) : {KEEP (*(.inttab1.intvec.72 )) } > pfls1
    .inttab_tc1_049 (TEXT) BIND(__INTTAB_CPU1 + 0x0920) : {KEEP (*(.inttab1.intvec.73 )) } > pfls1
    .inttab_tc1_04A (TEXT) BIND(__INTTAB_CPU1 + 0x0940) : {KEEP (*(.inttab1.intvec.74 )) } > pfls1
    .inttab_tc1_04B (TEXT) BIND(__INTTAB_CPU1 + 0x0960) : {KEEP (*(.inttab1.intvec.75 )) } > pfls1
    .inttab_tc1_04C (TEXT) BIND(__INTTAB_CPU1 + 0x0980) : {KEEP (*(.inttab1.intvec.76 )) } > pfls1
    .inttab_tc1_04D (TEXT) BIND(__INTTAB_CPU1 + 0x09A0) : {KEEP (*(.inttab1.intvec.77 )) } > pfls1
    .inttab_tc1_04E (TEXT) BIND(__INTTAB_CPU1 + 0x09C0) : {KEEP (*(.inttab1.intvec.78 )) } > pfls1
    .inttab_tc1_04F (TEXT) BIND(__INTTAB_CPU1 + 0x09E0) : {KEEP (*(.inttab1.intvec.79 )) } > pfls1
    .inttab_tc1_050 (TEXT) BIND(__INTTAB_CPU1 + 0x0A00) : {KEEP (*(.inttab1.intvec.80 )) } > pfls1
    .inttab_tc1_051 (TEXT) BIND(__INTTAB_CPU1 + 0x0A20) : {KEEP (*(.inttab1.intvec.81 )) } > pfls1
    .inttab_tc1_052 (TEXT) BIND(__INTTAB_CPU1 + 0x0A40) : {KEEP (*(.inttab1.intvec.82 )) } > pfls1
    .inttab_tc1_053 (TEXT) BIND(__INTTAB_CPU1 + 0x0A60) : {KEEP (*(.inttab1.intvec.83 )) } > pfls1
    .inttab_tc1_054 (TEXT) BIND(__INTTAB_CPU1 + 0x0A80) : {KEEP (*(.inttab1.intvec.84 )) } > pfls1
    .inttab_tc1_055 (TEXT) BIND(__INTTAB_CPU1 + 0x0AA0) : {KEEP (*(.inttab1.intvec.85 )) } > pfls1
    .inttab_tc1_056 (TEXT) BIND(__INTTAB_CPU1 + 0x0AC0) : {KEEP (*(.inttab1.intvec.86 )) } > pfls1
    .inttab_tc1_057 (TEXT) BIND(__INTTAB_CPU1 + 0x0AE0) : {KEEP (*(.inttab1.intvec.87 )) } > pfls1
    .inttab_tc1_058 (TEXT) BIND(__INTTAB_CPU1 + 0x0B00) : {KEEP (*(.inttab1.intvec.88 )) } > pfls1
    .inttab_tc1_059 (TEXT) BIND(__INTTAB_CPU1 + 0x0B20) : {KEEP (*(.inttab1.intvec.89 )) } > pfls1
    .inttab_tc1_05A (TEXT) BIND(__INTTAB_CPU1 + 0x0B40) : {KEEP (*(.inttab1.intvec.90 )) } > pfls1
    .inttab_tc1_05B (TEXT) BIND(__INTTAB_CPU1 + 0x0B60) : {KEEP (*(.inttab1.intvec.91 )) } > pfls1
    .inttab_tc1_05C (TEXT) BIND(__INTTAB_CPU1 + 0x0B80) : {KEEP (*(.inttab1.intvec.92 )) } > pfls1
    .inttab_tc1_05D (TEXT) BIND(__INTTAB_CPU1 + 0x0BA0) : {KEEP (*(.inttab1.intvec.93 )) } > pfls1
    .inttab_tc1_05E (TEXT) BIND(__INTTAB_CPU1 + 0x0BC0) : {KEEP (*(.inttab1.intvec.94 )) } > pfls1
    .inttab_tc1_05F (TEXT) BIND(__INTTAB_CPU1 + 0x0BE0) : {KEEP (*(.inttab1.intvec.95 )) } > pfls1
    .inttab_tc1_060 (TEXT) BIND(__INTTAB_CPU1 + 0x0C00) : {KEEP (*(.inttab1.intvec.96 )) } > pfls1
    .inttab_tc1_061 (TEXT) BIND(__INTTAB_CPU1 + 0x0C20) : {KEEP (*(.inttab1.intvec.97 )) } > pfls1
    .inttab_tc1_062 (TEXT) BIND(__INTTAB_CPU1 + 0x0C40) : {KEEP (*(.inttab1.intvec.98 )) } > pfls1
    .inttab_tc1_063 (TEXT) BIND(__INTTAB_CPU1 + 0x0C60) : {KEEP (*(.inttab1.intvec.99 )) } > pfls1
    .inttab_tc1_064 (TEXT) BIND(__INTTAB_CPU1 + 0x0C80) : {KEEP (*(.inttab1.intvec.100)) } > pfls1
    .inttab_tc1_065 (TEXT) BIND(__INTTAB_CPU1 + 0x0CA0) : {KEEP (*(.inttab1.intvec.101)) } > pfls1
    .inttab_tc1_066 (TEXT) BIND(__INTTAB_CPU1 + 0x0CC0) : {KEEP (*(.inttab1.intvec.102)) } > pfls1
    .inttab_tc1_067 (TEXT) BIND(__INTTAB_CPU1 + 0x0CE0) : {KEEP (*(.inttab1.intvec.103)) } > pfls1
    .inttab_tc1_068 (TEXT) BIND(__INTTAB_CPU1 + 0x0D00) : {KEEP (*(.inttab1.intvec.104)) } > pfls1
    .inttab_tc1_069 (TEXT) BIND(__INTTAB_CPU1 + 0x0D20) : {KEEP (*(.inttab1.intvec.105)) } > pfls1
    .inttab_tc1_06A (TEXT) BIND(__INTTAB_CPU1 + 0x0D40) : {KEEP (*(.inttab1.intvec.106)) } > pfls1
    .inttab_tc1_06B (TEXT) BIND(__INTTAB_CPU1 + 0x0D60) : {KEEP (*(.inttab1.intvec.107)) } > pfls1
    .inttab_tc1_06C (TEXT) BIND(__INTTAB_CPU1 + 0x0D80) : {KEEP (*(.inttab1.intvec.108)) } > pfls1
    .inttab_tc1_06D (TEXT) BIND(__INTTAB_CPU1 + 0x0DA0) : {KEEP (*(.inttab1.intvec.109)) } > pfls1
    .inttab_tc1_06E (TEXT) BIND(__INTTAB_CPU1 + 0x0DC0) : {KEEP (*(.inttab1.intvec.110)) } > pfls1
    .inttab_tc1_06F (TEXT) BIND(__INTTAB_CPU1 + 0x0DE0) : {KEEP (*(.inttab1.intvec.111)) } > pfls1
    .inttab_tc1_070 (TEXT) BIND(__INTTAB_CPU1 + 0x0E00) : {KEEP (*(.inttab1.intvec.112)) } > pfls1
    .inttab_tc1_071 (TEXT) BIND(__INTTAB_CPU1 + 0x0E20) : {KEEP (*(.inttab1.intvec.113)) } > pfls1
    .inttab_tc1_072 (TEXT) BIND(__INTTAB_CPU1 + 0x0E40) : {KEEP (*(.inttab1.intvec.114)) } > pfls1
    .inttab_tc1_073 (TEXT) BIND(__INTTAB_CPU1 + 0x0E60) : {KEEP (*(.inttab1.intvec.115)) } > pfls1
    .inttab_tc1_074 (TEXT) BIND(__INTTAB_CPU1 + 0x0E80) : {KEEP (*(.inttab1.intvec.116)) } > pfls1
    .inttab_tc1_075 (TEXT) BIND(__INTTAB_CPU1 + 0x0EA0) : {KEEP (*(.inttab1.intvec.117)) } > pfls1
    .inttab_tc1_076 (TEXT) BIND(__INTTAB_CPU1 + 0x0EC0) : {KEEP (*(.inttab1.intvec.118)) } > pfls1
    .inttab_tc1_077 (TEXT) BIND(__INTTAB_CPU1 + 0x0EE0) : {KEEP (*(.inttab1.intvec.119)) } > pfls1
    .inttab_tc1_078 (TEXT) BIND(__INTTAB_CPU1 + 0x0F00) : {KEEP (*(.inttab1.intvec.120)) } > pfls1
    .inttab_tc1_079 (TEXT) BIND(__INTTAB_CPU1 + 0x0F20) : {KEEP (*(.inttab1.intvec.121)) } > pfls1
    .inttab_tc1_07A (TEXT) BIND(__INTTAB_CPU1 + 0x0F40) : {KEEP (*(.inttab1.intvec.122)) } > pfls1
    .inttab_tc1_07B (TEXT) BIND(__INTTAB_CPU1 + 0x0F60) : {KEEP (*(.inttab1.intvec.123)) } > pfls1
    .inttab_tc1_07C (TEXT) BIND(__INTTAB_CPU1 + 0x0F80) : {KEEP (*(.inttab1.intvec.124)) } > pfls1
    .inttab_tc1_07D (TEXT) BIND(__INTTAB_CPU1 + 0x0FA0) : {KEEP (*(.inttab1.intvec.125)) } > pfls1
    .inttab_tc1_07E (TEXT) BIND(__INTTAB_CPU1 + 0x0FC0) : {KEEP (*(.inttab1.intvec.126)) } > pfls1
    .inttab_tc1_07F (TEXT) BIND(__INTTAB_CPU1 + 0x0FE0) : {KEEP (*(.inttab1.intvec.127)) } > pfls1
    .inttab_tc1_080 (TEXT) BIND(__INTTAB_CPU1 + 0x1000) : {KEEP (*(.inttab1.intvec.128)) } > pfls1
    .inttab_tc1_081 (TEXT) BIND(__INTTAB_CPU1 + 0x1020) : {KEEP (*(.inttab1.intvec.129)) } > pfls1
    .inttab_tc1_082 (TEXT) BIND(__INTTAB_CPU1 + 0x1040) : {KEEP (*(.inttab1.intvec.130)) } > pfls1
    .inttab_tc1_083 (TEXT) BIND(__INTTAB_CPU1 + 0x1060) : {KEEP (*(.inttab1.intvec.131)) } > pfls1
    .inttab_tc1_084 (TEXT) BIND(__INTTAB_CPU1 + 0x1080) : {KEEP (*(.inttab1.intvec.132)) } > pfls1
    .inttab_tc1_085 (TEXT) BIND(__INTTAB_CPU1 + 0x10A0) : {KEEP (*(.inttab1.intvec.133)) } > pfls1
    .inttab_tc1_086 (TEXT) BIND(__INTTAB_CPU1 + 0x10C0) : {KEEP (*(.inttab1.intvec.134)) } > pfls1
    .inttab_tc1_087 (TEXT) BIND(__INTTAB_CPU1 + 0x10E0) : {KEEP (*(.inttab1.intvec.135)) } > pfls1
    .inttab_tc1_088 (TEXT) BIND(__INTTAB_CPU1 + 0x1100) : {KEEP (*(.inttab1.intvec.136)) } > pfls1
    .inttab_tc1_089 (TEXT) BIND(__INTTAB_CPU1 + 0x1120) : {KEEP (*(.inttab1.intvec.137)) } > pfls1
    .inttab_tc1_08A (TEXT) BIND(__INTTAB_CPU1 + 0x1140) : {KEEP (*(.inttab1.intvec.138)) } > pfls1
    .inttab_tc1_08B (TEXT) BIND(__INTTAB_CPU1 + 0x1160) : {KEEP (*(.inttab1.intvec.139)) } > pfls1
    .inttab_tc1_08C (TEXT) BIND(__INTTAB_CPU1 + 0x1180) : {KEEP (*(.inttab1.intvec.140)) } > pfls1
    .inttab_tc1_08D (TEXT) BIND(__INTTAB_CPU1 + 0x11A0) : {KEEP (*(.inttab1.intvec.141)) } > pfls1
    .inttab_tc1_08E (TEXT) BIND(__INTTAB_CPU1 + 0x11C0) : {KEEP (*(.inttab1.intvec.142)) } > pfls1
    .inttab_tc1_08F (TEXT) BIND(__INTTAB_CPU1 + 0x11E0) : {KEEP (*(.inttab1.intvec.143)) } > pfls1
    .inttab_tc1_090 (TEXT) BIND(__INTTAB_CPU1 + 0x1200) : {KEEP (*(.inttab1.intvec.144)) } > pfls1
    .inttab_tc1_091 (TEXT) BIND(__INTTAB_CPU1 + 0x1220) : {KEEP (*(.inttab1.intvec.145)) } > pfls1
    .inttab_tc1_092 (TEXT) BIND(__INTTAB_CPU1 + 0x1240) : {KEEP (*(.inttab1.intvec.146)) } > pfls1
    .inttab_tc1_093 (TEXT) BIND(__INTTAB_CPU1 + 0x1260) : {KEEP (*(.inttab1.intvec.147)) } > pfls1
    .inttab_tc1_094 (TEXT) BIND(__INTTAB_CPU1 + 0x1280) : {KEEP (*(.inttab1.intvec.148)) } > pfls1
    .inttab_tc1_095 (TEXT) BIND(__INTTAB_CPU1 + 0x12A0) : {KEEP (*(.inttab1.intvec.149)) } > pfls1
    .inttab_tc1_096 (TEXT) BIND(__INTTAB_CPU1 + 0x12C0) : {KEEP (*(.inttab1.intvec.150)) } > pfls1
    .inttab_tc1_097 (TEXT) BIND(__INTTAB_CPU1 + 0x12E0) : {KEEP (*(.inttab1.intvec.151)) } > pfls1
    .inttab_tc1_098 (TEXT) BIND(__INTTAB_CPU1 + 0x1300) : {KEEP (*(.inttab1.intvec.152)) } > pfls1
    .inttab_tc1_099 (TEXT) BIND(__INTTAB_CPU1 + 0x1320) : {KEEP (*(.inttab1.intvec.153)) } > pfls1
    .inttab_tc1_09A (TEXT) BIND(__INTTAB_CPU1 + 0x1340) : {KEEP (*(.inttab1.intvec.154)) } > pfls1
    .inttab_tc1_09B (TEXT) BIND(__INTTAB_CPU1 + 0x1360) : {KEEP (*(.inttab1.intvec.155)) } > pfls1
    .inttab_tc1_09C (TEXT) BIND(__INTTAB_CPU1 + 0x1380) : {KEEP (*(.inttab1.intvec.156)) } > pfls1
    .inttab_tc1_09D (TEXT) BIND(__INTTAB_CPU1 + 0x13A0) : {KEEP (*(.inttab1.intvec.157)) } > pfls1
    .inttab_tc1_09E (TEXT) BIND(__INTTAB_CPU1 + 0x13C0) : {KEEP (*(.inttab1.intvec.158)) } > pfls1
    .inttab_tc1_09F (TEXT) BIND(__INTTAB_CPU1 + 0x13E0) : {KEEP (*(.inttab1.intvec.159)) } > pfls1
    .inttab_tc1_0A0 (TEXT) BIND(__INTTAB_CPU1 + 0x1400) : {KEEP (*(.inttab1.intvec.160)) } > pfls1
    .inttab_tc1_0A1 (TEXT) BIND(__INTTAB_CPU1 + 0x1420) : {KEEP (*(.inttab1.intvec.161)) } > pfls1
    .inttab_tc1_0A2 (TEXT) BIND(__INTTAB_CPU1 + 0x1440) : {KEEP (*(.inttab1.intvec.162)) } > pfls1
    .inttab_tc1_0A3 (TEXT) BIND(__INTTAB_CPU1 + 0x1460) : {KEEP (*(.inttab1.intvec.163)) } > pfls1
    .inttab_tc1_0A4 (TEXT) BIND(__INTTAB_CPU1 + 0x1480) : {KEEP (*(.inttab1.intvec.164)) } > pfls1
    .inttab_tc1_0A5 (TEXT) BIND(__INTTAB_CPU1 + 0x14A0) : {KEEP (*(.inttab1.intvec.165)) } > pfls1
    .inttab_tc1_0A6 (TEXT) BIND(__INTTAB_CPU1 + 0x14C0) : {KEEP (*(.inttab1.intvec.166)) } > pfls1
    .inttab_tc1_0A7 (TEXT) BIND(__INTTAB_CPU1 + 0x14E0) : {KEEP (*(.inttab1.intvec.167)) } > pfls1
    .inttab_tc1_0A8 (TEXT) BIND(__INTTAB_CPU1 + 0x1500) : {KEEP (*(.inttab1.intvec.168)) } > pfls1
    .inttab_tc1_0A9 (TEXT) BIND(__INTTAB_CPU1 + 0x1520) : {KEEP (*(.inttab1.intvec.169)) } > pfls1
    .inttab_tc1_0AA (TEXT) BIND(__INTTAB_CPU1 + 0x1540) : {KEEP (*(.inttab1.intvec.170)) } > pfls1
    .inttab_tc1_0AB (TEXT) BIND(__INTTAB_CPU1 + 0x1560) : {KEEP (*(.inttab1.intvec.171)) } > pfls1
    .inttab_tc1_0AC (TEXT) BIND(__INTTAB_CPU1 + 0x1580) : {KEEP (*(.inttab1.intvec.172)) } > pfls1
    .inttab_tc1_0AD (TEXT) BIND(__INTTAB_CPU1 + 0x15A0) : {KEEP (*(.inttab1.intvec.173)) } > pfls1
    .inttab_tc1_0AE (TEXT) BIND(__INTTAB_CPU1 + 0x15C0) : {KEEP (*(.inttab1.intvec.174)) } > pfls1
    .inttab_tc1_0AF (TEXT) BIND(__INTTAB_CPU1 + 0x15E0) : {KEEP (*(.inttab1.intvec.175)) } > pfls1
    .inttab_tc1_0B0 (TEXT) BIND(__INTTAB_CPU1 + 0x1600) : {KEEP (*(.inttab1.intvec.176)) } > pfls1
    .inttab_tc1_0B1 (TEXT) BIND(__INTTAB_CPU1 + 0x1620) : {KEEP (*(.inttab1.intvec.177)) } > pfls1
    .inttab_tc1_0B2 (TEXT) BIND(__INTTAB_CPU1 + 0x1640) : {KEEP (*(.inttab1.intvec.178)) } > pfls1
    .inttab_tc1_0B3 (TEXT) BIND(__INTTAB_CPU1 + 0x1660) : {KEEP (*(.inttab1.intvec.179)) } > pfls1
    .inttab_tc1_0B4 (TEXT) BIND(__INTTAB_CPU1 + 0x1680) : {KEEP (*(.inttab1.intvec.180)) } > pfls1
    .inttab_tc1_0B5 (TEXT) BIND(__INTTAB_CPU1 + 0x16A0) : {KEEP (*(.inttab1.intvec.181)) } > pfls1
    .inttab_tc1_0B6 (TEXT) BIND(__INTTAB_CPU1 + 0x16C0) : {KEEP (*(.inttab1.intvec.182)) } > pfls1
    .inttab_tc1_0B7 (TEXT) BIND(__INTTAB_CPU1 + 0x16E0) : {KEEP (*(.inttab1.intvec.183)) } > pfls1
    .inttab_tc1_0B8 (TEXT) BIND(__INTTAB_CPU1 + 0x1700) : {KEEP (*(.inttab1.intvec.184)) } > pfls1
    .inttab_tc1_0B9 (TEXT) BIND(__INTTAB_CPU1 + 0x1720) : {KEEP (*(.inttab1.intvec.185)) } > pfls1
    .inttab_tc1_0BA (TEXT) BIND(__INTTAB_CPU1 + 0x1740) : {KEEP (*(.inttab1.intvec.186)) } > pfls1
    .inttab_tc1_0BB (TEXT) BIND(__INTTAB_CPU1 + 0x1760) : {KEEP (*(.inttab1.intvec.187)) } > pfls1
    .inttab_tc1_0BC (TEXT) BIND(__INTTAB_CPU1 + 0x1780) : {KEEP (*(.inttab1.intvec.188)) } > pfls1
    .inttab_tc1_0BD (TEXT) BIND(__INTTAB_CPU1 + 0x17A0) : {KEEP (*(.inttab1.intvec.189)) } > pfls1
    .inttab_tc1_0BE (TEXT) BIND(__INTTAB_CPU1 + 0x17C0) : {KEEP (*(.inttab1.intvec.190)) } > pfls1
    .inttab_tc1_0BF (TEXT) BIND(__INTTAB_CPU1 + 0x17E0) : {KEEP (*(.inttab1.intvec.191)) } > pfls1
    .inttab_tc1_0C0 (TEXT) BIND(__INTTAB_CPU1 + 0x1800) : {KEEP (*(.inttab1.intvec.192)) } > pfls1
    .inttab_tc1_0C1 (TEXT) BIND(__INTTAB_CPU1 + 0x1820) : {KEEP (*(.inttab1.intvec.193)) } > pfls1
    .inttab_tc1_0C2 (TEXT) BIND(__INTTAB_CPU1 + 0x1840) : {KEEP (*(.inttab1.intvec.194)) } > pfls1
    .inttab_tc1_0C3 (TEXT) BIND(__INTTAB_CPU1 + 0x1860) : {KEEP (*(.inttab1.intvec.195)) } > pfls1
    .inttab_tc1_0C4 (TEXT) BIND(__INTTAB_CPU1 + 0x1880) : {KEEP (*(.inttab1.intvec.196)) } > pfls1
    .inttab_tc1_0C5 (TEXT) BIND(__INTTAB_CPU1 + 0x18A0) : {KEEP (*(.inttab1.intvec.197)) } > pfls1
    .inttab_tc1_0C6 (TEXT) BIND(__INTTAB_CPU1 + 0x18C0) : {KEEP (*(.inttab1.intvec.198)) } > pfls1
    .inttab_tc1_0C7 (TEXT) BIND(__INTTAB_CPU1 + 0x18E0) : {KEEP (*(.inttab1.intvec.199)) } > pfls1
    .inttab_tc1_0C8 (TEXT) BIND(__INTTAB_CPU1 + 0x1900) : {KEEP (*(.inttab1.intvec.200)) } > pfls1
    .inttab_tc1_0C9 (TEXT) BIND(__INTTAB_CPU1 + 0x1920) : {KEEP (*(.inttab1.intvec.201)) } > pfls1
    .inttab_tc1_0CA (TEXT) BIND(__INTTAB_CPU1 + 0x1940) : {KEEP (*(.inttab1.intvec.202)) } > pfls1
    .inttab_tc1_0CB (TEXT) BIND(__INTTAB_CPU1 + 0x1960) : {KEEP (*(.inttab1.intvec.203)) } > pfls1
    .inttab_tc1_0CC (TEXT) BIND(__INTTAB_CPU1 + 0x1980) : {KEEP (*(.inttab1.intvec.204)) } > pfls1
    .inttab_tc1_0CD (TEXT) BIND(__INTTAB_CPU1 + 0x19A0) : {KEEP (*(.inttab1.intvec.205)) } > pfls1
    .inttab_tc1_0CE (TEXT) BIND(__INTTAB_CPU1 + 0x19C0) : {KEEP (*(.inttab1.intvec.206)) } > pfls1
    .inttab_tc1_0CF (TEXT) BIND(__INTTAB_CPU1 + 0x19E0) : {KEEP (*(.inttab1.intvec.207)) } > pfls1
    .inttab_tc1_0D0 (TEXT) BIND(__INTTAB_CPU1 + 0x1A00) : {KEEP (*(.inttab1.intvec.208)) } > pfls1
    .inttab_tc1_0D1 (TEXT) BIND(__INTTAB_CPU1 + 0x1A20) : {KEEP (*(.inttab1.intvec.209)) } > pfls1
    .inttab_tc1_0D2 (TEXT) BIND(__INTTAB_CPU1 + 0x1A40) : {KEEP (*(.inttab1.intvec.210)) } > pfls1
    .inttab_tc1_0D3 (TEXT) BIND(__INTTAB_CPU1 + 0x1A60) : {KEEP (*(.inttab1.intvec.211)) } > pfls1
    .inttab_tc1_0D4 (TEXT) BIND(__INTTAB_CPU1 + 0x1A80) : {KEEP (*(.inttab1.intvec.212)) } > pfls1
    .inttab_tc1_0D5 (TEXT) BIND(__INTTAB_CPU1 + 0x1AA0) : {KEEP (*(.inttab1.intvec.213)) } > pfls1
    .inttab_tc1_0D6 (TEXT) BIND(__INTTAB_CPU1 + 0x1AC0) : {KEEP (*(.inttab1.intvec.214)) } > pfls1
    .inttab_tc1_0D7 (TEXT) BIND(__INTTAB_CPU1 + 0x1AE0) : {KEEP (*(.inttab1.intvec.215)) } > pfls1
    .inttab_tc1_0D8 (TEXT) BIND(__INTTAB_CPU1 + 0x1B00) : {KEEP (*(.inttab1.intvec.216)) } > pfls1
    .inttab_tc1_0D9 (TEXT) BIND(__INTTAB_CPU1 + 0x1B20) : {KEEP (*(.inttab1.intvec.217)) } > pfls1
    .inttab_tc1_0DA (TEXT) BIND(__INTTAB_CPU1 + 0x1B40) : {KEEP (*(.inttab1.intvec.218)) } > pfls1
    .inttab_tc1_0DB (TEXT) BIND(__INTTAB_CPU1 + 0x1B60) : {KEEP (*(.inttab1.intvec.219)) } > pfls1
    .inttab_tc1_0DC (TEXT) BIND(__INTTAB_CPU1 + 0x1B80) : {KEEP (*(.inttab1.intvec.220)) } > pfls1
    .inttab_tc1_0DD (TEXT) BIND(__INTTAB_CPU1 + 0x1BA0) : {KEEP (*(.inttab1.intvec.221)) } > pfls1
    .inttab_tc1_0DE (TEXT) BIND(__INTTAB_CPU1 + 0x1BC0) : {KEEP (*(.inttab1.intvec.222)) } > pfls1
    .inttab_tc1_0DF (TEXT) BIND(__INTTAB_CPU1 + 0x1BE0) : {KEEP (*(.inttab1.intvec.223)) } > pfls1
    .inttab_tc1_0E0 (TEXT) BIND(__INTTAB_CPU1 + 0x1C00) : {KEEP (*(.inttab1.intvec.224)) } > pfls1
    .inttab_tc1_0E1 (TEXT) BIND(__INTTAB_CPU1 + 0x1C20) : {KEEP (*(.inttab1.intvec.225)) } > pfls1
    .inttab_tc1_0E2 (TEXT) BIND(__INTTAB_CPU1 + 0x1C40) : {KEEP (*(.inttab1.intvec.226)) } > pfls1
    .inttab_tc1_0E3 (TEXT) BIND(__INTTAB_CPU1 + 0x1C60) : {KEEP (*(.inttab1.intvec.227)) } > pfls1
    .inttab_tc1_0E4 (TEXT) BIND(__INTTAB_CPU1 + 0x1C80) : {KEEP (*(.inttab1.intvec.228)) } > pfls1
    .inttab_tc1_0E5 (TEXT) BIND(__INTTAB_CPU1 + 0x1CA0) : {KEEP (*(.inttab1.intvec.229)) } > pfls1
    .inttab_tc1_0E6 (TEXT) BIND(__INTTAB_CPU1 + 0x1CC0) : {KEEP (*(.inttab1.intvec.230)) } > pfls1
    .inttab_tc1_0E7 (TEXT) BIND(__INTTAB_CPU1 + 0x1CE0) : {KEEP (*(.inttab1.intvec.231)) } > pfls1
    .inttab_tc1_0E8 (TEXT) BIND(__INTTAB_CPU1 + 0x1D00) : {KEEP (*(.inttab1.intvec.232)) } > pfls1
    .inttab_tc1_0E9 (TEXT) BIND(__INTTAB_CPU1 + 0x1D20) : {KEEP (*(.inttab1.intvec.233)) } > pfls1
    .inttab_tc1_0EA (TEXT) BIND(__INTTAB_CPU1 + 0x1D40) : {KEEP (*(.inttab1.intvec.234)) } > pfls1
    .inttab_tc1_0EB (TEXT) BIND(__INTTAB_CPU1 + 0x1D60) : {KEEP (*(.inttab1.intvec.235)) } > pfls1
    .inttab_tc1_0EC (TEXT) BIND(__INTTAB_CPU1 + 0x1D80) : {KEEP (*(.inttab1.intvec.236)) } > pfls1
    .inttab_tc1_0ED (TEXT) BIND(__INTTAB_CPU1 + 0x1DA0) : {KEEP (*(.inttab1.intvec.237)) } > pfls1
    .inttab_tc1_0EE (TEXT) BIND(__INTTAB_CPU1 + 0x1DC0) : {KEEP (*(.inttab1.intvec.238)) } > pfls1
    .inttab_tc1_0EF (TEXT) BIND(__INTTAB_CPU1 + 0x1DE0) : {KEEP (*(.inttab1.intvec.239)) } > pfls1
    .inttab_tc1_0F0 (TEXT) BIND(__INTTAB_CPU1 + 0x1E00) : {KEEP (*(.inttab1.intvec.240)) } > pfls1
    .inttab_tc1_0F1 (TEXT) BIND(__INTTAB_CPU1 + 0x1E20) : {KEEP (*(.inttab1.intvec.241)) } > pfls1
    .inttab_tc1_0F2 (TEXT) BIND(__INTTAB_CPU1 + 0x1E40) : {KEEP (*(.inttab1.intvec.242)) } > pfls1
    .inttab_tc1_0F3 (TEXT) BIND(__INTTAB_CPU1 + 0x1E60) : {KEEP (*(.inttab1.intvec.243)) } > pfls1
    .inttab_tc1_0F4 (TEXT) BIND(__INTTAB_CPU1 + 0x1E80) : {KEEP (*(.inttab1.intvec.244)) } > pfls1
    .inttab_tc1_0F5 (TEXT) BIND(__INTTAB_CPU1 + 0x1EA0) : {KEEP (*(.inttab1.intvec.245)) } > pfls1
    .inttab_tc1_0F6 (TEXT) BIND(__INTTAB_CPU1 + 0x1EC0) : {KEEP (*(.inttab1.intvec.246)) } > pfls1
    .inttab_tc1_0F7 (TEXT) BIND(__INTTAB_CPU1 + 0x1EE0) : {KEEP (*(.inttab1.intvec.247)) } > pfls1
    .inttab_tc1_0F8 (TEXT) BIND(__INTTAB_CPU1 + 0x1F00) : {KEEP (*(.inttab1.intvec.248)) } > pfls1
    .inttab_tc1_0F9 (TEXT) BIND(__INTTAB_CPU1 + 0x1F20) : {KEEP (*(.inttab1.intvec.249)) } > pfls1
    .inttab_tc1_0FA (TEXT) BIND(__INTTAB_CPU1 + 0x1F40) : {KEEP (*(.inttab1.intvec.250)) } > pfls1
    .inttab_tc1_0FB (TEXT) BIND(__INTTAB_CPU1 + 0x1F60) : {KEEP (*(.inttab1.intvec.251)) } > pfls1
    .inttab_tc1_0FC (TEXT) BIND(__INTTAB_CPU1 + 0x1F80) : {KEEP (*(.inttab1.intvec.252)) } > pfls1
    .inttab_tc1_0FD (TEXT) BIND(__INTTAB_CPU1 + 0x1FA0) : {KEEP (*(.inttab1.intvec.253)) } > pfls1
    .inttab_tc1_0FE (TEXT) BIND(__INTTAB_CPU1 + 0x1FC0) : {KEEP (*(.inttab1.intvec.254)) } > pfls1
    .inttab_tc1_0FF (TEXT) BIND(__INTTAB_CPU1 + 0x1FE0) : {KEEP (*(.inttab1.intvec.255)) } > pfls1

}