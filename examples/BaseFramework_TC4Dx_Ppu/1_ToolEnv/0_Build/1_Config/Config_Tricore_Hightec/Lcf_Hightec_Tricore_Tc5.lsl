/* Default linker script, for normal executables */
OUTPUT_FORMAT("elf32-tricore")
OUTPUT_ARCH(tricore)
ENTRY(_START5)

__TRICORE_DERIVATE_MEMORY_MAP__ = 0x4D0;

LCF_CSA5_SIZE = 8k;
LCF_USTACK5_SIZE = 2k;
LCF_ISTACK5_SIZE = 1k;

LCF_HEAP_SIZE = 4k;

LCF_PPU_FLASH_SIZE  = 1M;
LCF_PPU_LMURAM_SIZE = 512k;
LCF_PPU_CSM_SIZE    = 512k;

LCF_DSPR5_START = 0x20000000;
LCF_DSPR5_SIZE  = 240K;

LCF_CSA5_OFFSET =    (LCF_DSPR5_SIZE - 1k - LCF_CSA5_SIZE);
LCF_ISTACK5_OFFSET = (LCF_CSA5_OFFSET - 256 - LCF_ISTACK5_SIZE);
LCF_USTACK5_OFFSET = (LCF_ISTACK5_OFFSET - 256 - LCF_USTACK5_SIZE);

LCF_HEAP5_OFFSET =   (LCF_USTACK5_OFFSET - LCF_HEAP_SIZE);

LCF_INTVEC5_START  = 0x813FE000 - LCF_PPU_FLASH_SIZE;
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
__INTTAB_CPU5 = LCF_INTVEC5_START;

RESET = LCF_STARTPTR_NC_CPU5;

MEMORY
{
    dsram5 (w!x): org = 0x20000000, len = 240K
    psram5 (w!x): org = 0x20100000, len = 64K

    
    psram_local (w!x): org = 0xc0000000, len = 64K
    
    
    pfls5 (rx): org = 0x81200000, len = 2M
    pfls5_nc (rx): org = 0xA1200000, len = 2M
    
    cpu5_dlmu (w!x): org = 0x90280000, len = 512K
    cpu5_dlmu_nc (w!x): org = 0xb0280000, len = 512K

    lmuram (w!x): org = 0x90400000, len = 5M
    lmuram_nc (w!x): org = 0xb0400000, len = 5M

    ppu_csm (w!x): org = 0x92080000, len = 512k
    ppu_csm_nc (w!x): org = 0xb2080000, len = 512k
}

/* map cached and non cached addresses */
REGION_MIRROR("pfls5", "pfls5_nc")
REGION_MIRROR("cpu5_dlmu", "cpu5_dlmu_nc")
REGION_MIRROR("lmuram", "lmuram_nc")
REGION_MIRROR("ppu_csm", "ppu_csm_nc")

/*Un comment one of the below statement groups to enable CpuX DMI RAM to hold global variables*/

REGION_ALIAS( default_ram , dsram5)
REGION_ALIAS( default_rom , pfls5)

/*Fixed memory Allocations for _START*/
SECTIONS
{
   
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU5 = 1);
}

    SECTIONS
    {
		.start_tc5 (LCF_STARTPTR_NC_CPU5) :  { KEEP (*(.start_cpu5)); } > pfls5_nc
        .traptab_tc5 (LCF_TRAPVEC5_START) : { PROVIDE(__TRAPTAB_CPU5 = .); KEEP (*(.traptab_cpu5)); } > pfls5
		 PROVIDE(__START5 = LCF_STARTPTR_NC_CPU5);
	}
    /*Near Absolute Addressable Data Sections*/
    SECTIONS
    {
        .CPU5.zdata (LCF_DSPR5_START):
        {
            *Ifx_Ssw_Tc5.* (.zdata) *Ifx_Ssw_Tc5.* (.zdata.*)
            *Cpu5_Main.* (.zdata) *Cpu5_Main.* (.zdata.*)
            *(.zdata_cpu5) *(.zdata_cpu5.*)
            . = ALIGN(2);
        } > dsram5 AT> default_rom
        
        .CPU5.zbss (NOLOAD): ALIGN(4)
        {
            *Ifx_Ssw_Tc5.* (.zbss) *Ifx_Ssw_Tc5.* (.zbss.*)
            *Cpu5_Main.* (.zbss) *Cpu5_Main.* (.zbss.*)
            *(.zbss_cpu5)*(.zbss_cpu5.*)

        } > dsram5
    }


/*Near Absolute Data, selectable by toolchain*/
SECTIONS
{    
        .zdata_powerOn : ALIGN(4) 
        {
            *(.zdata.dsprPowerOnInit.cpu5.32bit)
            *(.zdata.dsprPowerOnInit.cpu5.16bit)
            *(.zdata.dsprPowerOnInit.cpu5.8bit)
            . = ALIGN(2);
        } > default_ram AT> default_rom
        
        .zdata : ALIGN(4) 
        {
            *(.zdata.dsprInit.cpu5.32bit)
            *(.zdata.dsprInit.cpu5.16bit)
            *(.zdata.dsprInit.cpu5.8bit)
            *(.zdata) *(.zdata.*)
            *(.gnu.linkonce.z.*)
            . = ALIGN(2);
        } > default_ram AT> default_rom
        
        .zbss_powerOn (NOLOAD) : ALIGN(4)
        {
            *(.zbss.dsprPowerOnClear.cpu5.32bit)
            *(.zbss.dsprPowerOnClear.cpu5.16bit)
            *(.zbss.dsprPowerOnClear.cpu5.8bit)
        } > default_ram
        
        .zbss_noClear (NOLOAD) : ALIGN(4)
        {
            *(.zbss.dsprNoInit.cpu5.32bit)
            *(.zbss.dsprNoInit.cpu5.16bit)
            *(.zbss.dsprNoInit.cpu5.8bit)
        } > default_ram
        
        .zbss (NOLOAD) : ALIGN(4)
        {
            *(.zbss.dsprClearOnInit.cpu5.32bit)
            *(.zbss.dsprClearOnInit.cpu5.16bit)
            *(.zbss.dsprClearOnInit.cpu5.8bit)
            *(.zbss) *(.zbss.*)
            *(.bbss) *(.bbss.*)
            *(.gnu.linkonce.zb.*)
        } > default_ram
    }

/*Near Absolute Const, selectable with patterns and user defined sections*/
    /*Near Absolute Const, selectable with patterns and user defined sections*/
    SECTIONS
    {
        .zrodata : ALIGN(4)
        {
        *Ifx_Ssw_Tc?.* (.zrodata) *Ifx_Ssw_Tc?.* (.zrodata.*)
        *Cpu?_Main.* (.zrodata) *Cpu?_Main.* (.zrodata.*)
        *(.zrodata_cpu?) *(.zrodata_cpu?.*)		
    
            *(.zrodata.const.cpu5.32bit)
            *(.zrodata.const.cpu5.16bit)
            *(.zrodata.const.cpu5.8bit)
            *(.zrodata.config.cpu5.32bit)
            *(.zrodata.config.cpu5.16bit)
            *(.zrodata.config.cpu5.8bit)
            *(.zrodata) *(.zrodata.*)
        } > pfls5
    }

/*Relative A0/A1/A8/A9 Addressable Sections*/
SECTIONS
{
    /*Relative A0 Addressable Data, selectable with patterns and user defined sections*/
        /*Note: A0 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A0 Addressable Data, selectable by toolchain*/
    .sdata : ALIGN(4)
    {
		*(.data_a0) *(.data_a0.*)
        *(.sdata) *(.sdata.*)
        . = ALIGN(2);
    } > default_ram AT> default_rom
    .sbss (NOLOAD): ALIGN(4)
    {
        *(.bss_a0) *(.bss_a0.*)
        *(.sbss) *(.sbss.*)
    } > default_ram
    __SMALL_DATA__ = SIZEOF(.sdata) ? ADDR(.sdata) : (ADDR(.sdata) & 0xF0000000) + 32k ;
    __A0_MEM = __SMALL_DATA__;
}

SECTIONS
{
    /*Relative A1 Addressable Const, selectable with patterns and user defined sections*/
        /*Note: A1 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A1 Addressable Const, selectable by toolchain*/
    .sdata2 : ALIGN(4)
    {
        *(.rodata_a1) *(.rodata_a1.*)
        *(.srodata) *(.srodata.*)
    } > default_rom
    __SMALL_DATA2__ = SIZEOF(.sdata2) ? ADDR(.sdata2) : (ADDR(.sdata2) & 0xF0000000) + 32k ;
    __A1_MEM = __SMALL_DATA2__;
}

SECTIONS
{
    /*Relative A9 Addressable Data, selectable with patterns and user defined sections*/
    .sdata4 : ALIGN(4)
    {
        *(.data_a9) *(.data_a9.*)
        *(.a9sdata) *(.a9sdata.*)
        . = ALIGN(2);
    } > cpu5_dlmu AT> default_rom
    
    .sbss4 : ALIGN(4)
    {
        *(.bss_a9) *(.bss_a9.*)
        *(.a9sbss) *(.a9sbss.*)
    } > cpu5_dlmu
    
    __SMALL_DATA4__ = SIZEOF(.sdata4) ? ADDR(.sdata4) : (ADDR(.sdata4) & 0xF0000000) + 32k ;
    __A9_MEM = __SMALL_DATA4__;

    /*Relative A8 Addressable Const, selectable with patterns and user defined sections*/
    .sdata3 : 
    {
		*(.rodata_a8) *(.rodata_a8.*)
    } > default_rom
    
    __SMALL_DATA3__ = SIZEOF(.sdata3) ? ADDR(.sdata3) : (ADDR(.sdata3) & 0xF0000000) + 32k ;
    __A8_MEM = __SMALL_DATA3__;
}

/*Far Data / Far Const Sections, selectable with patterns and user defined sections*/
/*Far Data Sections, selectable with patterns and user defined sections*/
SECTIONS
{
    /*DSRAM5 Sections*/
    .CPU5.data : ALIGN(4)
    {
        *Ifx_Ssw_Tc5.* (.data) *Ifx_Ssw_Tc5.* (.data.*)
        *Cpu5_Main.* (.data) *Cpu5_Main.* (.data.*)
        *(.data_cpu5) *(.data_cpu5.*)
        . = ALIGN(2);
    } > dsram5 AT> default_rom
    
    .CPU5.bss (NOLOAD): ALIGN(4)
    {
        *Ifx_Ssw_Tc5.* (.bss) *Ifx_Ssw_Tc5.* (.bss.*)
        *Cpu5_Main.* (.bss) *Cpu5_Main.* (.bss.*)
        *(.bss_cpu5) *(.bss_cpu5.*)

    } > dsram5
    
    /*DLMU5 Sections*/
    .CPU5.lmudata : ALIGN(4) 
    {
         *(.lmudata_cpu5) *(.lmudata_cpu5.*)
        . = ALIGN(2);
    } > cpu5_dlmu AT> default_rom
    
    .CPU5.lmubss (NOLOAD) : ALIGN(4) 
    {
        *(.lmubss_cpu5) *(.lmubss_cpu5.*)   
    } > cpu5_dlmu
}

/*Far Data Sections, selectable by toolchain*/
SECTIONS
{
    .data : ALIGN(4)
    {
        *(.data.farDsprInit.cpu5.32bit)
        *(.data.farDsprInit.cpu5.16bit)
        *(.data.farDsprInit.cpu5.8bit)
        *(.data) *(.data.*)
        *(.gnu.linkonce.d.*)
        . = ALIGN(2);
    } > default_ram AT> default_rom
	
	.bss_noClear (NOLOAD) : ALIGN(4)
    {
        *(.bss.farDsprNoInit.cpu5.32bit)
        *(.bss.farDsprNoInit.cpu5.16bit)
        *(.bss.farDsprNoInit.cpu5.8bit)
    } > default_ram
	
    
    .bss (NOLOAD) : ALIGN(4)
    {
        *(.bss.farDsprClearOnInit.cpu5.32bit)
        *(.bss.farDsprClearOnInit.cpu5.16bit)
        *(.bss.farDsprClearOnInit.cpu5.8bit)
        *(.bss) *(.bss.*)
        *(.gnu.linkonce.b.*)
    } > default_ram
    
    .heap (NOLOAD) : ALIGN(4)
    {
    __HEAP = .;
    __heap_start = .;
    . += LCF_HEAP_SIZE;
    __HEAP_END = .;
    __heap_end = .;
    } > default_ram
}

SECTIONS
    {
    .lmudata : ALIGN(4)
    {
        *(.lmudata) *(.lmudata.*)
        *(.uncached.lmudata) *(.uncached.lmudata.*)
        . = ALIGN(2);
    } > cpu5_dlmu AT> default_rom
    
    .lmubss : ALIGN(4) 
    {
        *(.lmubss) *(.lmubss.*)
        *(.uncached.lmubss) *(.uncached.lmubss.*)
    } > cpu5_dlmu

    .ppu_lmuram (ORIGIN(lmuram_nc) + LENGTH(lmuram_nc) - LCF_PPU_LMURAM_SIZE) (NOLOAD) :
    {
        PROVIDE(__PPU_LMURAM_START = .);
        . += LCF_PPU_LMURAM_SIZE;
        PROVIDE(__PPU_LMURAM_END = .);
    } > lmuram_nc
}

SECTIONS
{
    .ppu_csm (NOLOAD) :
    {
        PROVIDE(__PPU_CSM_START = .);
        . += LCF_PPU_CSM_SIZE;
        PROVIDE(__PPU_CSM_END = .);
    } > ppu_csm_nc
}

/*Sections located at absolute fixed address*/
/*Fixed memory Allocations for stack memory and CSA*/
SECTIONS
{
    .CPU5.ustack (LCF_DSPR5_START + LCF_USTACK5_OFFSET)(NOLOAD):
    { PROVIDE(__USTACK5_END = .);    . = . + LCF_USTACK5_SIZE;    PROVIDE(__USTACK5 = .); } > dsram5
    
    .CPU5.istack (LCF_DSPR5_START + LCF_ISTACK5_OFFSET)(NOLOAD):
    { PROVIDE(__ISTACK5_END = .);    . = . + LCF_ISTACK5_SIZE;    PROVIDE(__ISTACK5 = .); } > dsram5
    
    .CPU5.csa (LCF_DSPR5_START + LCF_CSA5_OFFSET)(NOLOAD):
    { PROVIDE(__CSA5 = .);    . = . + LCF_CSA5_SIZE;    PROVIDE(__CSA5_END = .); } > dsram5
}

/*Far Const Sections, selectable with patterns and user defined sections*/
SECTIONS
{
    .CPU5.rodata : ALIGN(4) 
    {
        *Ifx_Ssw_Tc5.* (.rodata) *Ifx_Ssw_Tc5.* (.rodata.*)
        *Cpu5_Main.* (.rodata) *Cpu5_Main.* (.rodata.*)
		*(.rodata_cpu5) *(.rodata_cpu5.*)
    } > pfls5
}

/*Far Const Sections, selectable by toolchain*/
SECTIONS
{
    .rodata : 
    {
        *(.rodata.farConst.cpu5.32bit)
        *(.rodata.farConst.cpu5.16bit)
        *(.rodata.farConst.cpu5.8bit)
		*(.rodata) *(.rodata.*)
    *(.gnu.linkonce.r.*)
    /*
     * Create the clear and copy tables that tell the startup code
     * which memory areas to clear and to copy, respectively.
     */
    . = ALIGN(4) ;
    PROVIDE(__clear_table = .);
    LONG(0 + ADDR(.CPU5.zbss));       LONG(SIZEOF(.CPU5.zbss));
    LONG(0 + ADDR(.CPU5.bss));        LONG(SIZEOF(.CPU5.bss));
    LONG(0 + ADDR(.CPU5.lmubss));     LONG(SIZEOF(.CPU5.lmubss));
    LONG(0 + ADDR(.zbss));            LONG(SIZEOF(.zbss));
    LONG(0 + ADDR(.sbss));            LONG(SIZEOF(.sbss));
    LONG(0 + ADDR(.bss));             LONG(SIZEOF(.bss));
    LONG(0 + ADDR(.lmubss));          LONG(SIZEOF(.lmubss));
    LONG(0 + ADDR(.sbss4));           LONG(SIZEOF(.sbss4));
    LONG(-1);                         LONG(-1);
    PROVIDE(__clear_table_powerOn = .);
    LONG(0 + ADDR(.zbss_powerOn));    LONG(SIZEOF(.zbss_powerOn));
    LONG(-1);                         LONG(-1);
    PROVIDE(__copy_table = .);
    LONG(LOADADDR(.CPU5.zdata));      LONG(0 + ADDR(.CPU5.zdata));      LONG(SIZEOF(.CPU5.zdata));
    LONG(LOADADDR(.CPU5.data));       LONG(0 + ADDR(.CPU5.data));       LONG(SIZEOF(.CPU5.data));
    LONG(LOADADDR(.CPU5.lmudata));    LONG(0 + ADDR(.CPU5.lmudata));    LONG(SIZEOF(.CPU5.lmudata));
    LONG(LOADADDR(.zdata));           LONG(0 + ADDR(.zdata));           LONG(SIZEOF(.zdata));
    LONG(LOADADDR(.sdata));           LONG(0 + ADDR(.sdata));           LONG(SIZEOF(.sdata));
    LONG(LOADADDR(.data));            LONG(0 + ADDR(.data));            LONG(SIZEOF(.data));
    LONG(LOADADDR(.lmudata));         LONG(0 + ADDR(.lmudata));         LONG(SIZEOF(.lmudata));
    LONG(LOADADDR(.sdata4));          LONG(0 + ADDR(.sdata4));          LONG(SIZEOF(.sdata4));
    LONG(LOADADDR(.CPU5.psram_text)); LONG(0 + ADDR(.CPU5.psram_text)); LONG(SIZEOF(.CPU5.psram_text));
    LONG(-1);                         LONG(-1);                         LONG(-1);
    PROVIDE(__copy_table_powerOn = .) ;
    LONG(LOADADDR(.zdata_powerOn));   LONG(0 + ADDR(.zdata_powerOn));   LONG(SIZEOF(.zdata_powerOn));
    LONG(-1);                         LONG(-1);                         LONG(-1);
    . = ALIGN(8);
    } > default_rom
}

/*Code selections*/
/*Code Sections, selectable with patterns and user defined sections*/
SECTIONS
{
    .CPU5.text : ALIGN(4) 
    {
        *Ifx_Ssw_Tc5.*(.text) *Ifx_Ssw_Tc5.*(.text.*)
        *Cpu5_Main.*(.text) *Cpu5_Main.*(.text.*)
        *(.text_cpu5) *(.text_cpu5.*)
        . = ALIGN(4);
    } > pfls5
	
    /*
     * Code executed before calling main extra section for C++ constructor init
     *  -------------------------Start-----------------------------------------
     */
    .init :
    {
        PROVIDE(__init_start = .);
        KEEP(*(.init))
        KEEP(*(.init*))
        PROVIDE(__init_end = .);
        . = ALIGN(8);
    
    } > pfls5
    
    .fini :
    {
        PROVIDE(__fini_start = .);
        KEEP(*(.fini))
        KEEP(*(.fini*))
        PROVIDE(__fini_end = .);
        . = ALIGN(8);
    } > pfls5
    
    /*
     * Code executed before calling main extra section for C++ constructor init
     *  -------------------------End-----------------------------------------
     */
    .CPU5.psram_text  : ALIGN(4) 
    {
        *(.psram_text_cpu5) *(.psram_text_cpu5.*)
        *(.cpu5_psram) *(.cpu5_psram.*)
        . = ALIGN(4);
    } > psram5 AT> pfls5
}

/*Code Sections, selectable by toolchain*/
SECTIONS
{
    .text :
    {
        *(.text.fast.pfls.cpu5)
        *(.text.slow.pfls.cpu5)
        *(.text.5ms.pfls.cpu5)
        *(.text.10ms.pfls.cpu5)
        *(.text.callout.pfls.cpu5)
		*(.text) *(.text.*)
        *(.gnu.linkonce.t.*)
        *(.gnu.warning)        /* .gnu.warning sections are handled specially by elf32.em. */
        . = ALIGN(4);
    } > default_rom
	
  .preinit_array : ALIGN(8) {
    PROVIDE_HIDDEN ( __preinit_array_start = . );
    KEEP (*(.preinit_array))
    PROVIDE_HIDDEN ( __preinit_array_end = . );
  } > default_rom


  .init_array : ALIGN(8) {
    PROVIDE_HIDDEN ( __init_array_start = . );
    KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.*) SORT_BY_INIT_PRIORITY(.ctors.*)))
    KEEP (*(.init_array .ctors))
    PROVIDE_HIDDEN ( __init_array_end = . );
  } > default_rom


  .fini_array : ALIGN(8) {
    . = ALIGN(8);
    PROVIDE_HIDDEN ( __fini_array_start = . );
    KEEP (*(SORT_BY_INIT_PRIORITY(.fini_array.*) SORT_BY_INIT_PRIORITY(.dtors.*)))
    KEEP (*(.fini_array .dtors))
    PROVIDE_HIDDEN ( __fini_array_end = . );
  } >default_rom
	

    /*
     * C++ exception handling tables.  NOTE: gcc emits .eh_frame
     * sections when compiling C sources with debugging enabled (-g).
     * If you can be sure that your final application consists
     * exclusively of C objects (i.e., no C++ objects), you may use
     * the -R option of the "strip" and "objcopy" utilities to remove
     * the .eh_frame section from the executable.
     */
      .eh_frame : ALIGN(8)
	  {
			__eh_frame_start = .;
			KEEP(*(.eh_frame))
			__eh_frame_end = .;
			. = ALIGN(8);
      } > default_rom
    
    .eh_frame_hdr : ALIGN(8)
    {
        KEEP(*(.eh_frame_hdr))
        . = ALIGN(8);
    } > default_rom
    
    __eh_frame_hdr_start = SIZEOF(.eh_frame_hdr) > 0 ? ADDR(.eh_frame_hdr) : 0;
    __eh_frame_hdr_end = SIZEOF(.eh_frame_hdr) > 0 ? . : 0;
    
    .ppu_code (ORIGIN(pfls5) + LENGTH(pfls5) - LCF_PPU_FLASH_SIZE) (NOLOAD) :
    {
        PROVIDE(__PPU_IF_CONSTANTS = .);
        PROVIDE(__PPU_CODE_START = .);
        . += LCF_PPU_FLASH_SIZE;
        PROVIDE(__PPU_CODE_END = .);
    } > pfls5
    
    /*
     * DWARF debug sections.
     * Symbols in the DWARF debugging sections are relative to the
     * beginning of the section, so we begin them at 0.
     */
    /*
     * DWARF 1
     */
    .comment         0 : { *(.comment) }
    .debug           0 : { *(.debug) }
    .line            0 : { *(.line) }
    /*
     * GNU DWARF 1 extensions
     */
    .debug_srcinfo   0 : { *(.debug_srcinfo) }
    .debug_sfnames   0 : { *(.debug_sfnames) }
    /*
     * DWARF 1.1 and DWARF 2
     */
    .debug_aranges   0 : { *(.debug_aranges) }
    .debug_pubnames  0 : { *(.debug_pubnames) }
    /*
     * DWARF 2
     */
    .debug_info      0 : { *(.debug_info) }
    .debug_abbrev    0 : { *(.debug_abbrev) }
    .debug_line      0 : { *(.debug_line) }
    .debug_frame     0 : { *(.debug_frame) }
    .debug_str       0 : { *(.debug_str) }
    .debug_loc       0 : { *(.debug_loc) }
    .debug_macinfo   0 : { *(.debug_macinfo) }
    .debug_ranges    0 : { *(.debug_ranges) }
    /*
     * SGI/MIPS DWARF 2 extensions
     */
    .debug_weaknames 0 : { *(.debug_weaknames) }
    .debug_funcnames 0 : { *(.debug_funcnames) }
    .debug_typenames 0 : { *(.debug_typenames) }
    .debug_varnames  0 : { *(.debug_varnames) }
    /*
     * Optional sections that may only appear when relocating.
     */
    /*
     * Optional sections that may appear regardless of relocating.
     */
    .version_info    0 : { *(.version_info) }
    .boffs           0 : { KEEP (*(.boffs)) }
}

SECTIONS
{
    /* capture all VM int vector table entries here, just to demonstrate the macros. */
    .inttabvm_demo : { KEEP (*(.intvecvm_*  )); } > default_rom
}

/*Fixed memory Allocations for Interrupt Vector Table*/
SECTIONS
{
    /*CPU5 Interrupt Vector Table*/
    .inttab_tc5_000 (__INTTAB_CPU5 + 0x0000) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_0  )); } > pfls5
    .inttab_tc5_001 (__INTTAB_CPU5 + 0x0020) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_1  )); } > pfls5
    .inttab_tc5_002 (__INTTAB_CPU5 + 0x0040) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_2  )); } > pfls5
    .inttab_tc5_003 (__INTTAB_CPU5 + 0x0060) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_3  )); } > pfls5
    .inttab_tc5_004 (__INTTAB_CPU5 + 0x0080) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_4  )); } > pfls5
    .inttab_tc5_005 (__INTTAB_CPU5 + 0x00A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_5  )); } > pfls5
    .inttab_tc5_006 (__INTTAB_CPU5 + 0x00C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_6  )); } > pfls5
    .inttab_tc5_007 (__INTTAB_CPU5 + 0x00E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_7  )); } > pfls5
    .inttab_tc5_008 (__INTTAB_CPU5 + 0x0100) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_8  )); } > pfls5
    .inttab_tc5_009 (__INTTAB_CPU5 + 0x0120) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_9  )); } > pfls5
    .inttab_tc5_00A (__INTTAB_CPU5 + 0x0140) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_10 )); } > pfls5
    .inttab_tc5_00B (__INTTAB_CPU5 + 0x0160) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_11 )); } > pfls5
    .inttab_tc5_00C (__INTTAB_CPU5 + 0x0180) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_12 )); } > pfls5
    .inttab_tc5_00D (__INTTAB_CPU5 + 0x01A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_13 )); } > pfls5
    .inttab_tc5_00E (__INTTAB_CPU5 + 0x01C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_14 )); } > pfls5
    .inttab_tc5_00F (__INTTAB_CPU5 + 0x01E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_15 )); } > pfls5
    .inttab_tc5_010 (__INTTAB_CPU5 + 0x0200) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_16 )); } > pfls5
    .inttab_tc5_011 (__INTTAB_CPU5 + 0x0220) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_17 )); } > pfls5
    .inttab_tc5_012 (__INTTAB_CPU5 + 0x0240) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_18 )); } > pfls5
    .inttab_tc5_013 (__INTTAB_CPU5 + 0x0260) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_19 )); } > pfls5
    .inttab_tc5_014 (__INTTAB_CPU5 + 0x0280) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_20 )); } > pfls5
    .inttab_tc5_015 (__INTTAB_CPU5 + 0x02A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_21 )); } > pfls5
    .inttab_tc5_016 (__INTTAB_CPU5 + 0x02C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_22 )); } > pfls5
    .inttab_tc5_017 (__INTTAB_CPU5 + 0x02E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_23 )); } > pfls5
    .inttab_tc5_018 (__INTTAB_CPU5 + 0x0300) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_24 )); } > pfls5
    .inttab_tc5_019 (__INTTAB_CPU5 + 0x0320) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_25 )); } > pfls5
    .inttab_tc5_01A (__INTTAB_CPU5 + 0x0340) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_26 )); } > pfls5
    .inttab_tc5_01B (__INTTAB_CPU5 + 0x0360) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_27 )); } > pfls5
    .inttab_tc5_01C (__INTTAB_CPU5 + 0x0380) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_28 )); } > pfls5
    .inttab_tc5_01D (__INTTAB_CPU5 + 0x03A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_29 )); } > pfls5
    .inttab_tc5_01E (__INTTAB_CPU5 + 0x03C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_30 )); } > pfls5
    .inttab_tc5_01F (__INTTAB_CPU5 + 0x03E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_31 )); } > pfls5
    .inttab_tc5_020 (__INTTAB_CPU5 + 0x0400) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_32 )); } > pfls5
    .inttab_tc5_021 (__INTTAB_CPU5 + 0x0420) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_33 )); } > pfls5
    .inttab_tc5_022 (__INTTAB_CPU5 + 0x0440) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_34 )); } > pfls5
    .inttab_tc5_023 (__INTTAB_CPU5 + 0x0460) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_35 )); } > pfls5
    .inttab_tc5_024 (__INTTAB_CPU5 + 0x0480) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_36 )); } > pfls5
    .inttab_tc5_025 (__INTTAB_CPU5 + 0x04A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_37 )); } > pfls5
    .inttab_tc5_026 (__INTTAB_CPU5 + 0x04C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_38 )); } > pfls5
    .inttab_tc5_027 (__INTTAB_CPU5 + 0x04E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_39 )); } > pfls5
    .inttab_tc5_028 (__INTTAB_CPU5 + 0x0500) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_40 )); } > pfls5
    .inttab_tc5_029 (__INTTAB_CPU5 + 0x0520) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_41 )); } > pfls5
    .inttab_tc5_02A (__INTTAB_CPU5 + 0x0540) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_42 )); } > pfls5
    .inttab_tc5_02B (__INTTAB_CPU5 + 0x0560) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_43 )); } > pfls5
    .inttab_tc5_02C (__INTTAB_CPU5 + 0x0580) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_44 )); } > pfls5
    .inttab_tc5_02D (__INTTAB_CPU5 + 0x05A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_45 )); } > pfls5
    .inttab_tc5_02E (__INTTAB_CPU5 + 0x05C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_46 )); } > pfls5
    .inttab_tc5_02F (__INTTAB_CPU5 + 0x05E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_47 )); } > pfls5
    .inttab_tc5_030 (__INTTAB_CPU5 + 0x0600) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_48 )); } > pfls5
    .inttab_tc5_031 (__INTTAB_CPU5 + 0x0620) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_49 )); } > pfls5
    .inttab_tc5_032 (__INTTAB_CPU5 + 0x0640) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_50 )); } > pfls5
    .inttab_tc5_033 (__INTTAB_CPU5 + 0x0660) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_51 )); } > pfls5
    .inttab_tc5_034 (__INTTAB_CPU5 + 0x0680) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_52 )); } > pfls5
    .inttab_tc5_035 (__INTTAB_CPU5 + 0x06A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_53 )); } > pfls5
    .inttab_tc5_036 (__INTTAB_CPU5 + 0x06C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_54 )); } > pfls5
    .inttab_tc5_037 (__INTTAB_CPU5 + 0x06E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_55 )); } > pfls5
    .inttab_tc5_038 (__INTTAB_CPU5 + 0x0700) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_56 )); } > pfls5
    .inttab_tc5_039 (__INTTAB_CPU5 + 0x0720) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_57 )); } > pfls5
    .inttab_tc5_03A (__INTTAB_CPU5 + 0x0740) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_58 )); } > pfls5
    .inttab_tc5_03B (__INTTAB_CPU5 + 0x0760) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_59 )); } > pfls5
    .inttab_tc5_03C (__INTTAB_CPU5 + 0x0780) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_60 )); } > pfls5
    .inttab_tc5_03D (__INTTAB_CPU5 + 0x07A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_61 )); } > pfls5
    .inttab_tc5_03E (__INTTAB_CPU5 + 0x07C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_62 )); } > pfls5
    .inttab_tc5_03F (__INTTAB_CPU5 + 0x07E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_63 )); } > pfls5
    .inttab_tc5_040 (__INTTAB_CPU5 + 0x0800) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_64 )); } > pfls5
    .inttab_tc5_041 (__INTTAB_CPU5 + 0x0820) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_65 )); } > pfls5
    .inttab_tc5_042 (__INTTAB_CPU5 + 0x0840) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_66 )); } > pfls5
    .inttab_tc5_043 (__INTTAB_CPU5 + 0x0860) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_67 )); } > pfls5
    .inttab_tc5_044 (__INTTAB_CPU5 + 0x0880) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_68 )); } > pfls5
    .inttab_tc5_045 (__INTTAB_CPU5 + 0x08A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_69 )); } > pfls5
    .inttab_tc5_046 (__INTTAB_CPU5 + 0x08C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_70 )); } > pfls5
    .inttab_tc5_047 (__INTTAB_CPU5 + 0x08E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_71 )); } > pfls5
    .inttab_tc5_048 (__INTTAB_CPU5 + 0x0900) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_72 )); } > pfls5
    .inttab_tc5_049 (__INTTAB_CPU5 + 0x0920) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_73 )); } > pfls5
    .inttab_tc5_04A (__INTTAB_CPU5 + 0x0940) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_74 )); } > pfls5
    .inttab_tc5_04B (__INTTAB_CPU5 + 0x0960) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_75 )); } > pfls5
    .inttab_tc5_04C (__INTTAB_CPU5 + 0x0980) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_76 )); } > pfls5
    .inttab_tc5_04D (__INTTAB_CPU5 + 0x09A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_77 )); } > pfls5
    .inttab_tc5_04E (__INTTAB_CPU5 + 0x09C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_78 )); } > pfls5
    .inttab_tc5_04F (__INTTAB_CPU5 + 0x09E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_79 )); } > pfls5
    .inttab_tc5_050 (__INTTAB_CPU5 + 0x0A00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_80 )); } > pfls5
    .inttab_tc5_051 (__INTTAB_CPU5 + 0x0A20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_81 )); } > pfls5
    .inttab_tc5_052 (__INTTAB_CPU5 + 0x0A40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_82 )); } > pfls5
    .inttab_tc5_053 (__INTTAB_CPU5 + 0x0A60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_83 )); } > pfls5
    .inttab_tc5_054 (__INTTAB_CPU5 + 0x0A80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_84 )); } > pfls5
    .inttab_tc5_055 (__INTTAB_CPU5 + 0x0AA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_85 )); } > pfls5
    .inttab_tc5_056 (__INTTAB_CPU5 + 0x0AC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_86 )); } > pfls5
    .inttab_tc5_057 (__INTTAB_CPU5 + 0x0AE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_87 )); } > pfls5
    .inttab_tc5_058 (__INTTAB_CPU5 + 0x0B00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_88 )); } > pfls5
    .inttab_tc5_059 (__INTTAB_CPU5 + 0x0B20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_89 )); } > pfls5
    .inttab_tc5_05A (__INTTAB_CPU5 + 0x0B40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_90 )); } > pfls5
    .inttab_tc5_05B (__INTTAB_CPU5 + 0x0B60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_91 )); } > pfls5
    .inttab_tc5_05C (__INTTAB_CPU5 + 0x0B80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_92 )); } > pfls5
    .inttab_tc5_05D (__INTTAB_CPU5 + 0x0BA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_93 )); } > pfls5
    .inttab_tc5_05E (__INTTAB_CPU5 + 0x0BC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_94 )); } > pfls5
    .inttab_tc5_05F (__INTTAB_CPU5 + 0x0BE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_95 )); } > pfls5
    .inttab_tc5_060 (__INTTAB_CPU5 + 0x0C00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_96 )); } > pfls5
    .inttab_tc5_061 (__INTTAB_CPU5 + 0x0C20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_97 )); } > pfls5
    .inttab_tc5_062 (__INTTAB_CPU5 + 0x0C40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_98 )); } > pfls5
    .inttab_tc5_063 (__INTTAB_CPU5 + 0x0C60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_99 )); } > pfls5
    .inttab_tc5_064 (__INTTAB_CPU5 + 0x0C80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_100)); } > pfls5
    .inttab_tc5_065 (__INTTAB_CPU5 + 0x0CA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_101)); } > pfls5
    .inttab_tc5_066 (__INTTAB_CPU5 + 0x0CC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_102)); } > pfls5
    .inttab_tc5_067 (__INTTAB_CPU5 + 0x0CE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_103)); } > pfls5
    .inttab_tc5_068 (__INTTAB_CPU5 + 0x0D00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_104)); } > pfls5
    .inttab_tc5_069 (__INTTAB_CPU5 + 0x0D20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_105)); } > pfls5
    .inttab_tc5_06A (__INTTAB_CPU5 + 0x0D40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_106)); } > pfls5
    .inttab_tc5_06B (__INTTAB_CPU5 + 0x0D60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_107)); } > pfls5
    .inttab_tc5_06C (__INTTAB_CPU5 + 0x0D80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_108)); } > pfls5
    .inttab_tc5_06D (__INTTAB_CPU5 + 0x0DA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_109)); } > pfls5
    .inttab_tc5_06E (__INTTAB_CPU5 + 0x0DC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_110)); } > pfls5
    .inttab_tc5_06F (__INTTAB_CPU5 + 0x0DE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_111)); } > pfls5
    .inttab_tc5_070 (__INTTAB_CPU5 + 0x0E00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_112)); } > pfls5
    .inttab_tc5_071 (__INTTAB_CPU5 + 0x0E20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_113)); } > pfls5
    .inttab_tc5_072 (__INTTAB_CPU5 + 0x0E40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_114)); } > pfls5
    .inttab_tc5_073 (__INTTAB_CPU5 + 0x0E60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_115)); } > pfls5
    .inttab_tc5_074 (__INTTAB_CPU5 + 0x0E80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_116)); } > pfls5
    .inttab_tc5_075 (__INTTAB_CPU5 + 0x0EA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_117)); } > pfls5
    .inttab_tc5_076 (__INTTAB_CPU5 + 0x0EC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_118)); } > pfls5
    .inttab_tc5_077 (__INTTAB_CPU5 + 0x0EE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_119)); } > pfls5
    .inttab_tc5_078 (__INTTAB_CPU5 + 0x0F00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_120)); } > pfls5
    .inttab_tc5_079 (__INTTAB_CPU5 + 0x0F20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_121)); } > pfls5
    .inttab_tc5_07A (__INTTAB_CPU5 + 0x0F40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_122)); } > pfls5
    .inttab_tc5_07B (__INTTAB_CPU5 + 0x0F60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_123)); } > pfls5
    .inttab_tc5_07C (__INTTAB_CPU5 + 0x0F80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_124)); } > pfls5
    .inttab_tc5_07D (__INTTAB_CPU5 + 0x0FA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_125)); } > pfls5
    .inttab_tc5_07E (__INTTAB_CPU5 + 0x0FC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_126)); } > pfls5
    .inttab_tc5_07F (__INTTAB_CPU5 + 0x0FE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_127)); } > pfls5
    .inttab_tc5_080 (__INTTAB_CPU5 + 0x1000) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_128)); } > pfls5
    .inttab_tc5_081 (__INTTAB_CPU5 + 0x1020) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_129)); } > pfls5
    .inttab_tc5_082 (__INTTAB_CPU5 + 0x1040) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_130)); } > pfls5
    .inttab_tc5_083 (__INTTAB_CPU5 + 0x1060) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_131)); } > pfls5
    .inttab_tc5_084 (__INTTAB_CPU5 + 0x1080) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_132)); } > pfls5
    .inttab_tc5_085 (__INTTAB_CPU5 + 0x10A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_133)); } > pfls5
    .inttab_tc5_086 (__INTTAB_CPU5 + 0x10C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_134)); } > pfls5
    .inttab_tc5_087 (__INTTAB_CPU5 + 0x10E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_135)); } > pfls5
    .inttab_tc5_088 (__INTTAB_CPU5 + 0x1100) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_136)); } > pfls5
    .inttab_tc5_089 (__INTTAB_CPU5 + 0x1120) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_137)); } > pfls5
    .inttab_tc5_08A (__INTTAB_CPU5 + 0x1140) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_138)); } > pfls5
    .inttab_tc5_08B (__INTTAB_CPU5 + 0x1160) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_139)); } > pfls5
    .inttab_tc5_08C (__INTTAB_CPU5 + 0x1180) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_140)); } > pfls5
    .inttab_tc5_08D (__INTTAB_CPU5 + 0x11A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_141)); } > pfls5
    .inttab_tc5_08E (__INTTAB_CPU5 + 0x11C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_142)); } > pfls5
    .inttab_tc5_08F (__INTTAB_CPU5 + 0x11E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_143)); } > pfls5
    .inttab_tc5_090 (__INTTAB_CPU5 + 0x1200) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_144)); } > pfls5
    .inttab_tc5_091 (__INTTAB_CPU5 + 0x1220) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_145)); } > pfls5
    .inttab_tc5_092 (__INTTAB_CPU5 + 0x1240) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_146)); } > pfls5
    .inttab_tc5_093 (__INTTAB_CPU5 + 0x1260) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_147)); } > pfls5
    .inttab_tc5_094 (__INTTAB_CPU5 + 0x1280) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_148)); } > pfls5
    .inttab_tc5_095 (__INTTAB_CPU5 + 0x12A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_149)); } > pfls5
    .inttab_tc5_096 (__INTTAB_CPU5 + 0x12C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_150)); } > pfls5
    .inttab_tc5_097 (__INTTAB_CPU5 + 0x12E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_151)); } > pfls5
    .inttab_tc5_098 (__INTTAB_CPU5 + 0x1300) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_152)); } > pfls5
    .inttab_tc5_099 (__INTTAB_CPU5 + 0x1320) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_153)); } > pfls5
    .inttab_tc5_09A (__INTTAB_CPU5 + 0x1340) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_154)); } > pfls5
    .inttab_tc5_09B (__INTTAB_CPU5 + 0x1360) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_155)); } > pfls5
    .inttab_tc5_09C (__INTTAB_CPU5 + 0x1380) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_156)); } > pfls5
    .inttab_tc5_09D (__INTTAB_CPU5 + 0x13A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_157)); } > pfls5
    .inttab_tc5_09E (__INTTAB_CPU5 + 0x13C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_158)); } > pfls5
    .inttab_tc5_09F (__INTTAB_CPU5 + 0x13E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_159)); } > pfls5
    .inttab_tc5_0A0 (__INTTAB_CPU5 + 0x1400) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_160)); } > pfls5
    .inttab_tc5_0A1 (__INTTAB_CPU5 + 0x1420) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_161)); } > pfls5
    .inttab_tc5_0A2 (__INTTAB_CPU5 + 0x1440) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_162)); } > pfls5
    .inttab_tc5_0A3 (__INTTAB_CPU5 + 0x1460) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_163)); } > pfls5
    .inttab_tc5_0A4 (__INTTAB_CPU5 + 0x1480) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_164)); } > pfls5
    .inttab_tc5_0A5 (__INTTAB_CPU5 + 0x14A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_165)); } > pfls5
    .inttab_tc5_0A6 (__INTTAB_CPU5 + 0x14C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_166)); } > pfls5
    .inttab_tc5_0A7 (__INTTAB_CPU5 + 0x14E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_167)); } > pfls5
    .inttab_tc5_0A8 (__INTTAB_CPU5 + 0x1500) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_168)); } > pfls5
    .inttab_tc5_0A9 (__INTTAB_CPU5 + 0x1520) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_169)); } > pfls5
    .inttab_tc5_0AA (__INTTAB_CPU5 + 0x1540) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_170)); } > pfls5
    .inttab_tc5_0AB (__INTTAB_CPU5 + 0x1560) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_171)); } > pfls5
    .inttab_tc5_0AC (__INTTAB_CPU5 + 0x1580) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_172)); } > pfls5
    .inttab_tc5_0AD (__INTTAB_CPU5 + 0x15A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_173)); } > pfls5
    .inttab_tc5_0AE (__INTTAB_CPU5 + 0x15C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_174)); } > pfls5
    .inttab_tc5_0AF (__INTTAB_CPU5 + 0x15E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_175)); } > pfls5
    .inttab_tc5_0B0 (__INTTAB_CPU5 + 0x1600) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_176)); } > pfls5
    .inttab_tc5_0B1 (__INTTAB_CPU5 + 0x1620) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_177)); } > pfls5
    .inttab_tc5_0B2 (__INTTAB_CPU5 + 0x1640) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_178)); } > pfls5
    .inttab_tc5_0B3 (__INTTAB_CPU5 + 0x1660) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_179)); } > pfls5
    .inttab_tc5_0B4 (__INTTAB_CPU5 + 0x1680) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_180)); } > pfls5
    .inttab_tc5_0B5 (__INTTAB_CPU5 + 0x16A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_181)); } > pfls5
    .inttab_tc5_0B6 (__INTTAB_CPU5 + 0x16C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_182)); } > pfls5
    .inttab_tc5_0B7 (__INTTAB_CPU5 + 0x16E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_183)); } > pfls5
    .inttab_tc5_0B8 (__INTTAB_CPU5 + 0x1700) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_184)); } > pfls5
    .inttab_tc5_0B9 (__INTTAB_CPU5 + 0x1720) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_185)); } > pfls5
    .inttab_tc5_0BA (__INTTAB_CPU5 + 0x1740) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_186)); } > pfls5
    .inttab_tc5_0BB (__INTTAB_CPU5 + 0x1760) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_187)); } > pfls5
    .inttab_tc5_0BC (__INTTAB_CPU5 + 0x1780) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_188)); } > pfls5
    .inttab_tc5_0BD (__INTTAB_CPU5 + 0x17A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_189)); } > pfls5
    .inttab_tc5_0BE (__INTTAB_CPU5 + 0x17C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_190)); } > pfls5
    .inttab_tc5_0BF (__INTTAB_CPU5 + 0x17E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_191)); } > pfls5
    .inttab_tc5_0C0 (__INTTAB_CPU5 + 0x1800) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_192)); } > pfls5
    .inttab_tc5_0C1 (__INTTAB_CPU5 + 0x1820) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_193)); } > pfls5
    .inttab_tc5_0C2 (__INTTAB_CPU5 + 0x1840) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_194)); } > pfls5
    .inttab_tc5_0C3 (__INTTAB_CPU5 + 0x1860) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_195)); } > pfls5
    .inttab_tc5_0C4 (__INTTAB_CPU5 + 0x1880) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_196)); } > pfls5
    .inttab_tc5_0C5 (__INTTAB_CPU5 + 0x18A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_197)); } > pfls5
    .inttab_tc5_0C6 (__INTTAB_CPU5 + 0x18C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_198)); } > pfls5
    .inttab_tc5_0C7 (__INTTAB_CPU5 + 0x18E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_199)); } > pfls5
    .inttab_tc5_0C8 (__INTTAB_CPU5 + 0x1900) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_200)); } > pfls5
    .inttab_tc5_0C9 (__INTTAB_CPU5 + 0x1920) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_201)); } > pfls5
    .inttab_tc5_0CA (__INTTAB_CPU5 + 0x1940) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_202)); } > pfls5
    .inttab_tc5_0CB (__INTTAB_CPU5 + 0x1960) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_203)); } > pfls5
    .inttab_tc5_0CC (__INTTAB_CPU5 + 0x1980) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_204)); } > pfls5
    .inttab_tc5_0CD (__INTTAB_CPU5 + 0x19A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_205)); } > pfls5
    .inttab_tc5_0CE (__INTTAB_CPU5 + 0x19C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_206)); } > pfls5
    .inttab_tc5_0CF (__INTTAB_CPU5 + 0x19E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_207)); } > pfls5
    .inttab_tc5_0D0 (__INTTAB_CPU5 + 0x1A00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_208)); } > pfls5
    .inttab_tc5_0D1 (__INTTAB_CPU5 + 0x1A20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_209)); } > pfls5
    .inttab_tc5_0D2 (__INTTAB_CPU5 + 0x1A40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_210)); } > pfls5
    .inttab_tc5_0D3 (__INTTAB_CPU5 + 0x1A60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_211)); } > pfls5
    .inttab_tc5_0D4 (__INTTAB_CPU5 + 0x1A80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_212)); } > pfls5
    .inttab_tc5_0D5 (__INTTAB_CPU5 + 0x1AA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_213)); } > pfls5
    .inttab_tc5_0D6 (__INTTAB_CPU5 + 0x1AC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_214)); } > pfls5
    .inttab_tc5_0D7 (__INTTAB_CPU5 + 0x1AE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_215)); } > pfls5
    .inttab_tc5_0D8 (__INTTAB_CPU5 + 0x1B00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_216)); } > pfls5
    .inttab_tc5_0D9 (__INTTAB_CPU5 + 0x1B20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_217)); } > pfls5
    .inttab_tc5_0DA (__INTTAB_CPU5 + 0x1B40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_218)); } > pfls5
    .inttab_tc5_0DB (__INTTAB_CPU5 + 0x1B60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_219)); } > pfls5
    .inttab_tc5_0DC (__INTTAB_CPU5 + 0x1B80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_220)); } > pfls5
    .inttab_tc5_0DD (__INTTAB_CPU5 + 0x1BA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_221)); } > pfls5
    .inttab_tc5_0DE (__INTTAB_CPU5 + 0x1BC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_222)); } > pfls5
    .inttab_tc5_0DF (__INTTAB_CPU5 + 0x1BE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_223)); } > pfls5
    .inttab_tc5_0E0 (__INTTAB_CPU5 + 0x1C00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_224)); } > pfls5
    .inttab_tc5_0E1 (__INTTAB_CPU5 + 0x1C20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_225)); } > pfls5
    .inttab_tc5_0E2 (__INTTAB_CPU5 + 0x1C40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_226)); } > pfls5
    .inttab_tc5_0E3 (__INTTAB_CPU5 + 0x1C60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_227)); } > pfls5
    .inttab_tc5_0E4 (__INTTAB_CPU5 + 0x1C80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_228)); } > pfls5
    .inttab_tc5_0E5 (__INTTAB_CPU5 + 0x1CA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_229)); } > pfls5
    .inttab_tc5_0E6 (__INTTAB_CPU5 + 0x1CC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_230)); } > pfls5
    .inttab_tc5_0E7 (__INTTAB_CPU5 + 0x1CE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_231)); } > pfls5
    .inttab_tc5_0E8 (__INTTAB_CPU5 + 0x1D00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_232)); } > pfls5
    .inttab_tc5_0E9 (__INTTAB_CPU5 + 0x1D20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_233)); } > pfls5
    .inttab_tc5_0EA (__INTTAB_CPU5 + 0x1D40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_234)); } > pfls5
    .inttab_tc5_0EB (__INTTAB_CPU5 + 0x1D60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_235)); } > pfls5
    .inttab_tc5_0EC (__INTTAB_CPU5 + 0x1D80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_236)); } > pfls5
    .inttab_tc5_0ED (__INTTAB_CPU5 + 0x1DA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_237)); } > pfls5
    .inttab_tc5_0EE (__INTTAB_CPU5 + 0x1DC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_238)); } > pfls5
    .inttab_tc5_0EF (__INTTAB_CPU5 + 0x1DE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_239)); } > pfls5
    .inttab_tc5_0F0 (__INTTAB_CPU5 + 0x1E00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_240)); } > pfls5
    .inttab_tc5_0F1 (__INTTAB_CPU5 + 0x1E20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_241)); } > pfls5
    .inttab_tc5_0F2 (__INTTAB_CPU5 + 0x1E40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_242)); } > pfls5
    .inttab_tc5_0F3 (__INTTAB_CPU5 + 0x1E60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_243)); } > pfls5
    .inttab_tc5_0F4 (__INTTAB_CPU5 + 0x1E80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_244)); } > pfls5
    .inttab_tc5_0F5 (__INTTAB_CPU5 + 0x1EA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_245)); } > pfls5
    .inttab_tc5_0F6 (__INTTAB_CPU5 + 0x1EC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_246)); } > pfls5
    .inttab_tc5_0F7 (__INTTAB_CPU5 + 0x1EE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_247)); } > pfls5
    .inttab_tc5_0F8 (__INTTAB_CPU5 + 0x1F00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_248)); } > pfls5
    .inttab_tc5_0F9 (__INTTAB_CPU5 + 0x1F20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_249)); } > pfls5
    .inttab_tc5_0FA (__INTTAB_CPU5 + 0x1F40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_250)); } > pfls5
    .inttab_tc5_0FB (__INTTAB_CPU5 + 0x1F60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_251)); } > pfls5
    .inttab_tc5_0FC (__INTTAB_CPU5 + 0x1F80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_252)); } > pfls5
    .inttab_tc5_0FD (__INTTAB_CPU5 + 0x1FA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_253)); } > pfls5
    .inttab_tc5_0FE (__INTTAB_CPU5 + 0x1FC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_254)); } > pfls5
    .inttab_tc5_0FF (__INTTAB_CPU5 + 0x1FE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc5_255)); } > pfls5
}

