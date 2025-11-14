/* Default linker script, for normal executables */
OUTPUT_FORMAT("elf32-tricore")
OUTPUT_ARCH(tricore)
ENTRY(_START1)

__TRICORE_DERIVATE_MEMORY_MAP__ = 0x4D0;

LCF_CSA1_SIZE = 8k;
LCF_USTACK1_SIZE = 2k;
LCF_ISTACK1_SIZE = 1k;

LCF_HEAP_SIZE = 4k;

LCF_PPU_FLASH_SIZE  = 1M;
LCF_PPU_LMURAM_SIZE = 512k;
LCF_PPU_CSM_SIZE    = 512k;

LCF_DSPR1_START = 0x60000000;
LCF_DSPR1_SIZE = 240k;

LCF_CSA1_OFFSET =    (LCF_DSPR1_SIZE - 1k - LCF_CSA1_SIZE);
LCF_ISTACK1_OFFSET = (LCF_CSA1_OFFSET - 256 - LCF_ISTACK1_SIZE);
LCF_USTACK1_OFFSET = (LCF_ISTACK1_OFFSET - 256 - LCF_USTACK1_SIZE);

LCF_HEAP1_OFFSET =   (LCF_USTACK1_OFFSET - LCF_HEAP_SIZE);

LCF_INTVEC1_START = 0x807FE000;

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
__INTTAB_CPU1 = LCF_INTVEC1_START;

RESET = LCF_STARTPTR_NC_CPU1;

MEMORY
{   
    dsram1 (w!x): org = 0x60000000, len = 240K
    psram1 (w!x): org = 0x60100000, len = 64K
    
    psram_local (w!x): org = 0xc0000000, len = 64K
	dsram_local (w!x): org = 0xd0000000, len = 240K
    
    pfls1 (rx): org = 0x80400000, len = 4M
    pfls1_nc (rx): org = 0xa0400000, len = 4M
    
    pfls5 (rx): org = 0x81200000, len = 2M
    pfls5_nc (rx): org = 0xA1200000, len = 2M

    
    cpu1_dlmu (w!x): org = 0x90080000, len = 512K
    cpu1_dlmu_nc (w!x): org = 0xb0080000, len = 512K
    
    lmuram (w!x): org = 0x90400000, len = 5M
    lmuram_nc (w!x): org = 0xb0400000, len = 5M

    ppu_csm (w!x): org = 0x92080000, len = 512k
    ppu_csm_nc (w!x): org = 0xb2080000, len = 512k
}

/* map cached and non cached addresses */
REGION_MIRROR("pfls1", "pfls1_nc")
REGION_MIRROR("pfls5", "pfls5_nc")
REGION_MIRROR("cpu1_dlmu", "cpu1_dlmu_nc")
REGION_MIRROR("lmuram", "lmuram_nc")
REGION_MIRROR("ppu_csm", "ppu_csm_nc")

/*Un comment one of the below statement groups to enable CpuX DMI RAM to hold global variables*/

REGION_ALIAS( default_ram , dsram1)
REGION_ALIAS( default_rom , pfls1)



    /*Fixed memory Allocations for _START*/
    
    SECTIONS
    {
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU1 = 1);
    }                     



    SECTIONS
    {
		.start_tc1 (LCF_STARTPTR_NC_CPU1) :  { KEEP (*(.start_cpu1)); } > pfls1_nc
        .traptab_tc1 (LCF_TRAPVEC1_START) : { PROVIDE(__TRAPTAB_CPU1 = .); KEEP (*(.traptab_cpu1)); } > pfls1
		 PROVIDE(__START1 = LCF_STARTPTR_NC_CPU1);
	}

    /*Near Absolute Addressable Data Sections*/
    SECTIONS
    {
        .CPU1.zdata (LCF_DSPR1_START):
        {
            *Ifx_Ssw_Tc1.* (.zdata) *Ifx_Ssw_Tc1.* (.zdata.*)
            *Cpu1_Main.* (.zdata) *Cpu1_Main.* (.zdata.*)
            *(.zdata_cpu1) *(.zdata_cpu1.*)
            . = ALIGN(2);
        } > dsram1 AT> default_rom
        
        .CPU1.zbss (NOLOAD): ALIGN(4)
        {
            *Ifx_Ssw_Tc1.* (.zbss) *Ifx_Ssw_Tc1.* (.zbss.*)
            *Cpu1_Main.* (.zbss) *Cpu1_Main.* (.zbss.*)
            *(.zbss_cpu1)*(.zbss_cpu1.*)

        } > dsram1
    }
    
    /*Near Absolute Data, selectable by toolchain*/
    SECTIONS
    {
        .zdata_powerOn : ALIGN(4) 
        {
            *(.zdata.dsprPowerOnInit.cpu1.32bit)
            *(.zdata.dsprPowerOnInit.cpu1.16bit)
            *(.zdata.dsprPowerOnInit.cpu1.8bit)
            . = ALIGN(2);
        } > default_ram AT> default_rom
        
        .zdata : ALIGN(4) 
        {
            *(.zdata.dsprInit.cpu1.32bit)
            *(.zdata.dsprInit.cpu1.16bit)
            *(.zdata.dsprInit.cpu1.8bit)
            *(.zdata) *(.zdata.*)
            *(.gnu.linkonce.z.*)
            . = ALIGN(2);
        } > default_ram AT> default_rom
        
        .zbss_powerOn (NOLOAD) : ALIGN(4)
        {
            *(.zbss.dsprPowerOnClear.cpu1.32bit)
            *(.zbss.dsprPowerOnClear.cpu1.16bit)
            *(.zbss.dsprPowerOnClear.cpu1.8bit)
        } > default_ram
        
        .zbss_noClear (NOLOAD) : ALIGN(4)
        {
            *(.zbss.dsprNoInit.cpu1.32bit)
            *(.zbss.dsprNoInit.cpu1.16bit)
            *(.zbss.dsprNoInit.cpu1.8bit)
        } > default_ram
        
        .zbss (NOLOAD) : ALIGN(4)
        {
            *(.zbss.dsprClearOnInit.cpu1.32bit)
            *(.zbss.dsprClearOnInit.cpu1.16bit)
            *(.zbss.dsprClearOnInit.cpu1.8bit)
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
    
            *(.zrodata.const.cpu1.32bit)
            *(.zrodata.const.cpu1.16bit)
            *(.zrodata.const.cpu1.8bit)
            *(.zrodata.config.cpu1.32bit)
            *(.zrodata.config.cpu1.16bit)
            *(.zrodata.config.cpu1.8bit)
            *(.zrodata) *(.zrodata.*)
        } > pfls1
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
    } > cpu1_dlmu AT> default_rom
    
    .sbss4 : ALIGN(4)
    {
        *(.bss_a9) *(.bss_a9.*)
        *(.a9sbss) *(.a9sbss.*)
    } > cpu1_dlmu
    
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
    /*DSRAM1 Sections*/
    .CPU1.data : ALIGN(4)
    {
        *Ifx_Ssw_Tc1.* (.data) *Ifx_Ssw_Tc1.* (.data.*)
        *Cpu1_Main.* (.data) *Cpu1_Main.* (.data.*)
        *(.data_cpu1) *(.data_cpu1.*)
        . = ALIGN(2);
    } > dsram1 AT> default_rom
    
    .CPU1.bss (NOLOAD): ALIGN(4)
    {
        *Ifx_Ssw_Tc1.* (.bss) *Ifx_Ssw_Tc1.* (.bss.*)
        *Cpu1_Main.* (.bss) *Cpu1_Main.* (.bss.*)
        *(.bss_cpu1) *(.bss_cpu1.*)

    } > dsram1
    
    /*DLMU1 Sections*/
    .CPU1.lmudata : ALIGN(4) 
    {
         *(.lmudata_cpu1) *(.lmudata_cpu1.*)
        . = ALIGN(2);
    } > cpu1_dlmu AT> default_rom
    
    .CPU1.lmubss (NOLOAD) : ALIGN(4) 
    {
        *(.lmubss_cpu1) *(.lmubss_cpu1.*)   
    } > cpu1_dlmu
}

/*Far Data Sections, selectable by toolchain*/

SECTIONS
{
    .data : ALIGN(4)
    {
        *(.data.farDsprInit.cpu1.32bit)
        *(.data.farDsprInit.cpu1.16bit)
        *(.data.farDsprInit.cpu1.8bit)
        *(.data) *(.data.*)
        *(.gnu.linkonce.d.*)
        . = ALIGN(2);
    } > default_ram AT> default_rom
	
	.bss_noClear (NOLOAD) : ALIGN(4)
    {
        *(.bss.farDsprNoInit.cpu1.32bit)
        *(.bss.farDsprNoInit.cpu1.16bit)
        *(.bss.farDsprNoInit.cpu1.8bit)
    } > default_ram
	
    
    .bss (NOLOAD) : ALIGN(4)
    {
        *(.bss.farDsprClearOnInit.cpu1.32bit)
        *(.bss.farDsprClearOnInit.cpu1.16bit)
        *(.bss.farDsprClearOnInit.cpu1.8bit)
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
    } > cpu1_dlmu AT> default_rom
    
    .lmubss : ALIGN(4) 
    {
        *(.lmubss) *(.lmubss.*)
        *(.uncached.lmubss) *(.uncached.lmubss.*)
    } > cpu1_dlmu


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
        .CPU1.ustack (LCF_DSPR1_START + LCF_USTACK1_OFFSET)(NOLOAD):
        { PROVIDE(__USTACK1_END = .);    . = . + LCF_USTACK1_SIZE;    PROVIDE(__USTACK1 = .); } > dsram1
        
        .CPU1.istack (LCF_DSPR1_START + LCF_ISTACK1_OFFSET)(NOLOAD):
        { PROVIDE(__ISTACK1_END = .);    . = . + LCF_ISTACK1_SIZE;    PROVIDE(__ISTACK1 = .); } > dsram1
        
        .CPU1.csa (LCF_DSPR1_START + LCF_CSA1_OFFSET)(NOLOAD):
        { PROVIDE(__CSA1 = .);    . = . + LCF_CSA1_SIZE;    PROVIDE(__CSA1_END = .); } > dsram1
    }
/*Far Const Sections, selectable with patterns and user defined sections*/

SECTIONS
{
    .CPU1.rodata : ALIGN(4) 
    {
        *Ifx_Ssw_Tc1.* (.rodata) *Ifx_Ssw_Tc1.* (.rodata.*)
        *Cpu1_Main.* (.rodata) *Cpu1_Main.* (.rodata.*)
		*(.rodata_cpu1) *(.rodata_cpu1.*)
    } > pfls1
}

/*Far Const Sections, selectable by toolchain*/

SECTIONS
{
    .rodata : 
    {
        *(.rodata.farConst.cpu1.32bit)
        *(.rodata.farConst.cpu1.16bit)
        *(.rodata.farConst.cpu1.8bit)
		*(.rodata) *(.rodata.*)
    *(.gnu.linkonce.r.*)
    /*
     * Create the clear and copy tables that tell the startup code
     * which memory areas to clear and to copy, respectively.
     */
    . = ALIGN(4) ;
    PROVIDE(__clear_table = .);
    LONG(0 + ADDR(.CPU1.zbss));       LONG(SIZEOF(.CPU1.zbss));
    LONG(0 + ADDR(.CPU1.bss));        LONG(SIZEOF(.CPU1.bss));
    LONG(0 + ADDR(.CPU1.lmubss));     LONG(SIZEOF(.CPU1.lmubss));
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
    LONG(LOADADDR(.CPU1.zdata));      LONG(0 + ADDR(.CPU1.zdata));      LONG(SIZEOF(.CPU1.zdata));
    LONG(LOADADDR(.CPU1.data));       LONG(0 + ADDR(.CPU1.data));       LONG(SIZEOF(.CPU1.data));
    LONG(LOADADDR(.CPU1.lmudata));    LONG(0 + ADDR(.CPU1.lmudata));    LONG(SIZEOF(.CPU1.lmudata));
    LONG(LOADADDR(.zdata));           LONG(0 + ADDR(.zdata));           LONG(SIZEOF(.zdata));
    LONG(LOADADDR(.sdata));           LONG(0 + ADDR(.sdata));           LONG(SIZEOF(.sdata));
    LONG(LOADADDR(.data));            LONG(0 + ADDR(.data));            LONG(SIZEOF(.data));
    LONG(LOADADDR(.lmudata));         LONG(0 + ADDR(.lmudata));         LONG(SIZEOF(.lmudata));
    LONG(LOADADDR(.sdata4));          LONG(0 + ADDR(.sdata4));          LONG(SIZEOF(.sdata4));
    LONG(LOADADDR(.CPU1.psram_text)); LONG(0 + ADDR(.CPU1.psram_text)); LONG(SIZEOF(.CPU1.psram_text));
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
    .CPU1.text : ALIGN(4) 
    {
        *Ifx_Ssw_Tc1.*(.text) *Ifx_Ssw_Tc1.*(.text.*)
        *Cpu1_Main.*(.text) *Cpu1_Main.*(.text.*)
        *(.text_cpu1) *(.text_cpu1.*)
        . = ALIGN(4);
    } > pfls1
	
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
    
    } > pfls1
    
    .fini :
    {
        PROVIDE(__fini_start = .);
        KEEP(*(.fini))
        KEEP(*(.fini*))
        PROVIDE(__fini_end = .);
        . = ALIGN(8);
    } > pfls1
    
    /*
     * Code executed before calling main extra section for C++ constructor init
     *  -------------------------End-----------------------------------------
     */
    .CPU1.psram_text  : ALIGN(4) 
    {
        *(.psram_text_cpu1) *(.psram_text_cpu1.*)
        *(.cpu1_psram) *(.cpu1_psram.*)
        . = ALIGN(4);
    } > psram1 AT> pfls1

}

/*Code Sections, selectable by toolchain*/
SECTIONS
{
    .text :
    {
        *(.text.fast.pfls.cpu1)
        *(.text.slow.pfls.cpu1)
        *(.text.5ms.pfls.cpu1)
        *(.text.10ms.pfls.cpu1)
        *(.text.callout.pfls.cpu1)
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

   .ppu_code (ORIGIN(pfls5) + LENGTH(pfls5) - LCF_PPU_FLASH_SIZE) (NOLOAD) :
    {
        PROVIDE(__PPU_IF_CONSTANTS = .);
        PROVIDE(__PPU_CODE_START = .);
        . += LCF_PPU_FLASH_SIZE;
        PROVIDE(__PPU_CODE_END = .);
    } > pfls5

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
        /*CPU1 Interrupt Vector Table*/
        .inttab_tc1_000 (__INTTAB_CPU1 + 0x0000) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_0  )); } > pfls1
        .inttab_tc1_001 (__INTTAB_CPU1 + 0x0020) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_1  )); } > pfls1
        .inttab_tc1_002 (__INTTAB_CPU1 + 0x0040) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_2  )); } > pfls1
        .inttab_tc1_003 (__INTTAB_CPU1 + 0x0060) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_3  )); } > pfls1
        .inttab_tc1_004 (__INTTAB_CPU1 + 0x0080) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_4  )); } > pfls1
        .inttab_tc1_005 (__INTTAB_CPU1 + 0x00A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_5  )); } > pfls1
        .inttab_tc1_006 (__INTTAB_CPU1 + 0x00C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_6  )); } > pfls1
        .inttab_tc1_007 (__INTTAB_CPU1 + 0x00E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_7  )); } > pfls1
        .inttab_tc1_008 (__INTTAB_CPU1 + 0x0100) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_8  )); } > pfls1
        .inttab_tc1_009 (__INTTAB_CPU1 + 0x0120) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_9  )); } > pfls1
        .inttab_tc1_00A (__INTTAB_CPU1 + 0x0140) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_10 )); } > pfls1
        .inttab_tc1_00B (__INTTAB_CPU1 + 0x0160) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_11 )); } > pfls1
        .inttab_tc1_00C (__INTTAB_CPU1 + 0x0180) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_12 )); } > pfls1
        .inttab_tc1_00D (__INTTAB_CPU1 + 0x01A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_13 )); } > pfls1
        .inttab_tc1_00E (__INTTAB_CPU1 + 0x01C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_14 )); } > pfls1
        .inttab_tc1_00F (__INTTAB_CPU1 + 0x01E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_15 )); } > pfls1
        .inttab_tc1_010 (__INTTAB_CPU1 + 0x0200) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_16 )); } > pfls1
        .inttab_tc1_011 (__INTTAB_CPU1 + 0x0220) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_17 )); } > pfls1
        .inttab_tc1_012 (__INTTAB_CPU1 + 0x0240) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_18 )); } > pfls1
        .inttab_tc1_013 (__INTTAB_CPU1 + 0x0260) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_19 )); } > pfls1
        .inttab_tc1_014 (__INTTAB_CPU1 + 0x0280) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_20 )); } > pfls1
        .inttab_tc1_015 (__INTTAB_CPU1 + 0x02A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_21 )); } > pfls1
        .inttab_tc1_016 (__INTTAB_CPU1 + 0x02C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_22 )); } > pfls1
        .inttab_tc1_017 (__INTTAB_CPU1 + 0x02E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_23 )); } > pfls1
        .inttab_tc1_018 (__INTTAB_CPU1 + 0x0300) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_24 )); } > pfls1
        .inttab_tc1_019 (__INTTAB_CPU1 + 0x0320) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_25 )); } > pfls1
        .inttab_tc1_01A (__INTTAB_CPU1 + 0x0340) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_26 )); } > pfls1
        .inttab_tc1_01B (__INTTAB_CPU1 + 0x0360) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_27 )); } > pfls1
        .inttab_tc1_01C (__INTTAB_CPU1 + 0x0380) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_28 )); } > pfls1
        .inttab_tc1_01D (__INTTAB_CPU1 + 0x03A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_29 )); } > pfls1
        .inttab_tc1_01E (__INTTAB_CPU1 + 0x03C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_30 )); } > pfls1
        .inttab_tc1_01F (__INTTAB_CPU1 + 0x03E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_31 )); } > pfls1
        .inttab_tc1_020 (__INTTAB_CPU1 + 0x0400) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_32 )); } > pfls1
        .inttab_tc1_021 (__INTTAB_CPU1 + 0x0420) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_33 )); } > pfls1
        .inttab_tc1_022 (__INTTAB_CPU1 + 0x0440) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_34 )); } > pfls1
        .inttab_tc1_023 (__INTTAB_CPU1 + 0x0460) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_35 )); } > pfls1
        .inttab_tc1_024 (__INTTAB_CPU1 + 0x0480) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_36 )); } > pfls1
        .inttab_tc1_025 (__INTTAB_CPU1 + 0x04A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_37 )); } > pfls1
        .inttab_tc1_026 (__INTTAB_CPU1 + 0x04C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_38 )); } > pfls1
        .inttab_tc1_027 (__INTTAB_CPU1 + 0x04E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_39 )); } > pfls1
        .inttab_tc1_028 (__INTTAB_CPU1 + 0x0500) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_40 )); } > pfls1
        .inttab_tc1_029 (__INTTAB_CPU1 + 0x0520) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_41 )); } > pfls1
        .inttab_tc1_02A (__INTTAB_CPU1 + 0x0540) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_42 )); } > pfls1
        .inttab_tc1_02B (__INTTAB_CPU1 + 0x0560) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_43 )); } > pfls1
        .inttab_tc1_02C (__INTTAB_CPU1 + 0x0580) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_44 )); } > pfls1
        .inttab_tc1_02D (__INTTAB_CPU1 + 0x05A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_45 )); } > pfls1
        .inttab_tc1_02E (__INTTAB_CPU1 + 0x05C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_46 )); } > pfls1
        .inttab_tc1_02F (__INTTAB_CPU1 + 0x05E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_47 )); } > pfls1
        .inttab_tc1_030 (__INTTAB_CPU1 + 0x0600) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_48 )); } > pfls1
        .inttab_tc1_031 (__INTTAB_CPU1 + 0x0620) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_49 )); } > pfls1
        .inttab_tc1_032 (__INTTAB_CPU1 + 0x0640) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_50 )); } > pfls1
        .inttab_tc1_033 (__INTTAB_CPU1 + 0x0660) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_51 )); } > pfls1
        .inttab_tc1_034 (__INTTAB_CPU1 + 0x0680) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_52 )); } > pfls1
        .inttab_tc1_035 (__INTTAB_CPU1 + 0x06A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_53 )); } > pfls1
        .inttab_tc1_036 (__INTTAB_CPU1 + 0x06C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_54 )); } > pfls1
        .inttab_tc1_037 (__INTTAB_CPU1 + 0x06E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_55 )); } > pfls1
        .inttab_tc1_038 (__INTTAB_CPU1 + 0x0700) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_56 )); } > pfls1
        .inttab_tc1_039 (__INTTAB_CPU1 + 0x0720) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_57 )); } > pfls1
        .inttab_tc1_03A (__INTTAB_CPU1 + 0x0740) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_58 )); } > pfls1
        .inttab_tc1_03B (__INTTAB_CPU1 + 0x0760) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_59 )); } > pfls1
        .inttab_tc1_03C (__INTTAB_CPU1 + 0x0780) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_60 )); } > pfls1
        .inttab_tc1_03D (__INTTAB_CPU1 + 0x07A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_61 )); } > pfls1
        .inttab_tc1_03E (__INTTAB_CPU1 + 0x07C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_62 )); } > pfls1
        .inttab_tc1_03F (__INTTAB_CPU1 + 0x07E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_63 )); } > pfls1
        .inttab_tc1_040 (__INTTAB_CPU1 + 0x0800) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_64 )); } > pfls1
        .inttab_tc1_041 (__INTTAB_CPU1 + 0x0820) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_65 )); } > pfls1
        .inttab_tc1_042 (__INTTAB_CPU1 + 0x0840) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_66 )); } > pfls1
        .inttab_tc1_043 (__INTTAB_CPU1 + 0x0860) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_67 )); } > pfls1
        .inttab_tc1_044 (__INTTAB_CPU1 + 0x0880) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_68 )); } > pfls1
        .inttab_tc1_045 (__INTTAB_CPU1 + 0x08A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_69 )); } > pfls1
        .inttab_tc1_046 (__INTTAB_CPU1 + 0x08C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_70 )); } > pfls1
        .inttab_tc1_047 (__INTTAB_CPU1 + 0x08E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_71 )); } > pfls1
        .inttab_tc1_048 (__INTTAB_CPU1 + 0x0900) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_72 )); } > pfls1
        .inttab_tc1_049 (__INTTAB_CPU1 + 0x0920) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_73 )); } > pfls1
        .inttab_tc1_04A (__INTTAB_CPU1 + 0x0940) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_74 )); } > pfls1
        .inttab_tc1_04B (__INTTAB_CPU1 + 0x0960) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_75 )); } > pfls1
        .inttab_tc1_04C (__INTTAB_CPU1 + 0x0980) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_76 )); } > pfls1
        .inttab_tc1_04D (__INTTAB_CPU1 + 0x09A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_77 )); } > pfls1
        .inttab_tc1_04E (__INTTAB_CPU1 + 0x09C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_78 )); } > pfls1
        .inttab_tc1_04F (__INTTAB_CPU1 + 0x09E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_79 )); } > pfls1
        .inttab_tc1_050 (__INTTAB_CPU1 + 0x0A00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_80 )); } > pfls1
        .inttab_tc1_051 (__INTTAB_CPU1 + 0x0A20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_81 )); } > pfls1
        .inttab_tc1_052 (__INTTAB_CPU1 + 0x0A40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_82 )); } > pfls1
        .inttab_tc1_053 (__INTTAB_CPU1 + 0x0A60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_83 )); } > pfls1
        .inttab_tc1_054 (__INTTAB_CPU1 + 0x0A80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_84 )); } > pfls1
        .inttab_tc1_055 (__INTTAB_CPU1 + 0x0AA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_85 )); } > pfls1
        .inttab_tc1_056 (__INTTAB_CPU1 + 0x0AC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_86 )); } > pfls1
        .inttab_tc1_057 (__INTTAB_CPU1 + 0x0AE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_87 )); } > pfls1
        .inttab_tc1_058 (__INTTAB_CPU1 + 0x0B00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_88 )); } > pfls1
        .inttab_tc1_059 (__INTTAB_CPU1 + 0x0B20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_89 )); } > pfls1
        .inttab_tc1_05A (__INTTAB_CPU1 + 0x0B40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_90 )); } > pfls1
        .inttab_tc1_05B (__INTTAB_CPU1 + 0x0B60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_91 )); } > pfls1
        .inttab_tc1_05C (__INTTAB_CPU1 + 0x0B80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_92 )); } > pfls1
        .inttab_tc1_05D (__INTTAB_CPU1 + 0x0BA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_93 )); } > pfls1
        .inttab_tc1_05E (__INTTAB_CPU1 + 0x0BC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_94 )); } > pfls1
        .inttab_tc1_05F (__INTTAB_CPU1 + 0x0BE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_95 )); } > pfls1
        .inttab_tc1_060 (__INTTAB_CPU1 + 0x0C00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_96 )); } > pfls1
        .inttab_tc1_061 (__INTTAB_CPU1 + 0x0C20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_97 )); } > pfls1
        .inttab_tc1_062 (__INTTAB_CPU1 + 0x0C40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_98 )); } > pfls1
        .inttab_tc1_063 (__INTTAB_CPU1 + 0x0C60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_99 )); } > pfls1
        .inttab_tc1_064 (__INTTAB_CPU1 + 0x0C80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_100)); } > pfls1
        .inttab_tc1_065 (__INTTAB_CPU1 + 0x0CA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_101)); } > pfls1
        .inttab_tc1_066 (__INTTAB_CPU1 + 0x0CC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_102)); } > pfls1
        .inttab_tc1_067 (__INTTAB_CPU1 + 0x0CE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_103)); } > pfls1
        .inttab_tc1_068 (__INTTAB_CPU1 + 0x0D00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_104)); } > pfls1
        .inttab_tc1_069 (__INTTAB_CPU1 + 0x0D20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_105)); } > pfls1
        .inttab_tc1_06A (__INTTAB_CPU1 + 0x0D40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_106)); } > pfls1
        .inttab_tc1_06B (__INTTAB_CPU1 + 0x0D60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_107)); } > pfls1
        .inttab_tc1_06C (__INTTAB_CPU1 + 0x0D80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_108)); } > pfls1
        .inttab_tc1_06D (__INTTAB_CPU1 + 0x0DA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_109)); } > pfls1
        .inttab_tc1_06E (__INTTAB_CPU1 + 0x0DC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_110)); } > pfls1
        .inttab_tc1_06F (__INTTAB_CPU1 + 0x0DE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_111)); } > pfls1
        .inttab_tc1_070 (__INTTAB_CPU1 + 0x0E00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_112)); } > pfls1
        .inttab_tc1_071 (__INTTAB_CPU1 + 0x0E20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_113)); } > pfls1
        .inttab_tc1_072 (__INTTAB_CPU1 + 0x0E40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_114)); } > pfls1
        .inttab_tc1_073 (__INTTAB_CPU1 + 0x0E60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_115)); } > pfls1
        .inttab_tc1_074 (__INTTAB_CPU1 + 0x0E80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_116)); } > pfls1
        .inttab_tc1_075 (__INTTAB_CPU1 + 0x0EA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_117)); } > pfls1
        .inttab_tc1_076 (__INTTAB_CPU1 + 0x0EC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_118)); } > pfls1
        .inttab_tc1_077 (__INTTAB_CPU1 + 0x0EE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_119)); } > pfls1
        .inttab_tc1_078 (__INTTAB_CPU1 + 0x0F00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_120)); } > pfls1
        .inttab_tc1_079 (__INTTAB_CPU1 + 0x0F20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_121)); } > pfls1
        .inttab_tc1_07A (__INTTAB_CPU1 + 0x0F40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_122)); } > pfls1
        .inttab_tc1_07B (__INTTAB_CPU1 + 0x0F60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_123)); } > pfls1
        .inttab_tc1_07C (__INTTAB_CPU1 + 0x0F80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_124)); } > pfls1
        .inttab_tc1_07D (__INTTAB_CPU1 + 0x0FA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_125)); } > pfls1
        .inttab_tc1_07E (__INTTAB_CPU1 + 0x0FC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_126)); } > pfls1
        .inttab_tc1_07F (__INTTAB_CPU1 + 0x0FE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_127)); } > pfls1
        .inttab_tc1_080 (__INTTAB_CPU1 + 0x1000) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_128)); } > pfls1
        .inttab_tc1_081 (__INTTAB_CPU1 + 0x1020) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_129)); } > pfls1
        .inttab_tc1_082 (__INTTAB_CPU1 + 0x1040) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_130)); } > pfls1
        .inttab_tc1_083 (__INTTAB_CPU1 + 0x1060) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_131)); } > pfls1
        .inttab_tc1_084 (__INTTAB_CPU1 + 0x1080) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_132)); } > pfls1
        .inttab_tc1_085 (__INTTAB_CPU1 + 0x10A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_133)); } > pfls1
        .inttab_tc1_086 (__INTTAB_CPU1 + 0x10C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_134)); } > pfls1
        .inttab_tc1_087 (__INTTAB_CPU1 + 0x10E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_135)); } > pfls1
        .inttab_tc1_088 (__INTTAB_CPU1 + 0x1100) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_136)); } > pfls1
        .inttab_tc1_089 (__INTTAB_CPU1 + 0x1120) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_137)); } > pfls1
        .inttab_tc1_08A (__INTTAB_CPU1 + 0x1140) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_138)); } > pfls1
        .inttab_tc1_08B (__INTTAB_CPU1 + 0x1160) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_139)); } > pfls1
        .inttab_tc1_08C (__INTTAB_CPU1 + 0x1180) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_140)); } > pfls1
        .inttab_tc1_08D (__INTTAB_CPU1 + 0x11A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_141)); } > pfls1
        .inttab_tc1_08E (__INTTAB_CPU1 + 0x11C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_142)); } > pfls1
        .inttab_tc1_08F (__INTTAB_CPU1 + 0x11E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_143)); } > pfls1
        .inttab_tc1_090 (__INTTAB_CPU1 + 0x1200) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_144)); } > pfls1
        .inttab_tc1_091 (__INTTAB_CPU1 + 0x1220) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_145)); } > pfls1
        .inttab_tc1_092 (__INTTAB_CPU1 + 0x1240) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_146)); } > pfls1
        .inttab_tc1_093 (__INTTAB_CPU1 + 0x1260) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_147)); } > pfls1
        .inttab_tc1_094 (__INTTAB_CPU1 + 0x1280) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_148)); } > pfls1
        .inttab_tc1_095 (__INTTAB_CPU1 + 0x12A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_149)); } > pfls1
        .inttab_tc1_096 (__INTTAB_CPU1 + 0x12C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_150)); } > pfls1
        .inttab_tc1_097 (__INTTAB_CPU1 + 0x12E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_151)); } > pfls1
        .inttab_tc1_098 (__INTTAB_CPU1 + 0x1300) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_152)); } > pfls1
        .inttab_tc1_099 (__INTTAB_CPU1 + 0x1320) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_153)); } > pfls1
        .inttab_tc1_09A (__INTTAB_CPU1 + 0x1340) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_154)); } > pfls1
        .inttab_tc1_09B (__INTTAB_CPU1 + 0x1360) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_155)); } > pfls1
        .inttab_tc1_09C (__INTTAB_CPU1 + 0x1380) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_156)); } > pfls1
        .inttab_tc1_09D (__INTTAB_CPU1 + 0x13A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_157)); } > pfls1
        .inttab_tc1_09E (__INTTAB_CPU1 + 0x13C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_158)); } > pfls1
        .inttab_tc1_09F (__INTTAB_CPU1 + 0x13E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_159)); } > pfls1
        .inttab_tc1_0A0 (__INTTAB_CPU1 + 0x1400) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_160)); } > pfls1
        .inttab_tc1_0A1 (__INTTAB_CPU1 + 0x1420) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_161)); } > pfls1
        .inttab_tc1_0A2 (__INTTAB_CPU1 + 0x1440) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_162)); } > pfls1
        .inttab_tc1_0A3 (__INTTAB_CPU1 + 0x1460) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_163)); } > pfls1
        .inttab_tc1_0A4 (__INTTAB_CPU1 + 0x1480) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_164)); } > pfls1
        .inttab_tc1_0A5 (__INTTAB_CPU1 + 0x14A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_165)); } > pfls1
        .inttab_tc1_0A6 (__INTTAB_CPU1 + 0x14C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_166)); } > pfls1
        .inttab_tc1_0A7 (__INTTAB_CPU1 + 0x14E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_167)); } > pfls1
        .inttab_tc1_0A8 (__INTTAB_CPU1 + 0x1500) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_168)); } > pfls1
        .inttab_tc1_0A9 (__INTTAB_CPU1 + 0x1520) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_169)); } > pfls1
        .inttab_tc1_0AA (__INTTAB_CPU1 + 0x1540) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_170)); } > pfls1
        .inttab_tc1_0AB (__INTTAB_CPU1 + 0x1560) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_171)); } > pfls1
        .inttab_tc1_0AC (__INTTAB_CPU1 + 0x1580) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_172)); } > pfls1
        .inttab_tc1_0AD (__INTTAB_CPU1 + 0x15A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_173)); } > pfls1
        .inttab_tc1_0AE (__INTTAB_CPU1 + 0x15C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_174)); } > pfls1
        .inttab_tc1_0AF (__INTTAB_CPU1 + 0x15E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_175)); } > pfls1
        .inttab_tc1_0B0 (__INTTAB_CPU1 + 0x1600) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_176)); } > pfls1
        .inttab_tc1_0B1 (__INTTAB_CPU1 + 0x1620) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_177)); } > pfls1
        .inttab_tc1_0B2 (__INTTAB_CPU1 + 0x1640) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_178)); } > pfls1
        .inttab_tc1_0B3 (__INTTAB_CPU1 + 0x1660) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_179)); } > pfls1
        .inttab_tc1_0B4 (__INTTAB_CPU1 + 0x1680) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_180)); } > pfls1
        .inttab_tc1_0B5 (__INTTAB_CPU1 + 0x16A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_181)); } > pfls1
        .inttab_tc1_0B6 (__INTTAB_CPU1 + 0x16C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_182)); } > pfls1
        .inttab_tc1_0B7 (__INTTAB_CPU1 + 0x16E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_183)); } > pfls1
        .inttab_tc1_0B8 (__INTTAB_CPU1 + 0x1700) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_184)); } > pfls1
        .inttab_tc1_0B9 (__INTTAB_CPU1 + 0x1720) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_185)); } > pfls1
        .inttab_tc1_0BA (__INTTAB_CPU1 + 0x1740) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_186)); } > pfls1
        .inttab_tc1_0BB (__INTTAB_CPU1 + 0x1760) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_187)); } > pfls1
        .inttab_tc1_0BC (__INTTAB_CPU1 + 0x1780) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_188)); } > pfls1
        .inttab_tc1_0BD (__INTTAB_CPU1 + 0x17A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_189)); } > pfls1
        .inttab_tc1_0BE (__INTTAB_CPU1 + 0x17C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_190)); } > pfls1
        .inttab_tc1_0BF (__INTTAB_CPU1 + 0x17E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_191)); } > pfls1
        .inttab_tc1_0C0 (__INTTAB_CPU1 + 0x1800) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_192)); } > pfls1
        .inttab_tc1_0C1 (__INTTAB_CPU1 + 0x1820) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_193)); } > pfls1
        .inttab_tc1_0C2 (__INTTAB_CPU1 + 0x1840) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_194)); } > pfls1
        .inttab_tc1_0C3 (__INTTAB_CPU1 + 0x1860) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_195)); } > pfls1
        .inttab_tc1_0C4 (__INTTAB_CPU1 + 0x1880) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_196)); } > pfls1
        .inttab_tc1_0C5 (__INTTAB_CPU1 + 0x18A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_197)); } > pfls1
        .inttab_tc1_0C6 (__INTTAB_CPU1 + 0x18C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_198)); } > pfls1
        .inttab_tc1_0C7 (__INTTAB_CPU1 + 0x18E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_199)); } > pfls1
        .inttab_tc1_0C8 (__INTTAB_CPU1 + 0x1900) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_200)); } > pfls1
        .inttab_tc1_0C9 (__INTTAB_CPU1 + 0x1920) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_201)); } > pfls1
        .inttab_tc1_0CA (__INTTAB_CPU1 + 0x1940) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_202)); } > pfls1
        .inttab_tc1_0CB (__INTTAB_CPU1 + 0x1960) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_203)); } > pfls1
        .inttab_tc1_0CC (__INTTAB_CPU1 + 0x1980) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_204)); } > pfls1
        .inttab_tc1_0CD (__INTTAB_CPU1 + 0x19A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_205)); } > pfls1
        .inttab_tc1_0CE (__INTTAB_CPU1 + 0x19C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_206)); } > pfls1
        .inttab_tc1_0CF (__INTTAB_CPU1 + 0x19E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_207)); } > pfls1
        .inttab_tc1_0D0 (__INTTAB_CPU1 + 0x1A00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_208)); } > pfls1
        .inttab_tc1_0D1 (__INTTAB_CPU1 + 0x1A20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_209)); } > pfls1
        .inttab_tc1_0D2 (__INTTAB_CPU1 + 0x1A40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_210)); } > pfls1
        .inttab_tc1_0D3 (__INTTAB_CPU1 + 0x1A60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_211)); } > pfls1
        .inttab_tc1_0D4 (__INTTAB_CPU1 + 0x1A80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_212)); } > pfls1
        .inttab_tc1_0D5 (__INTTAB_CPU1 + 0x1AA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_213)); } > pfls1
        .inttab_tc1_0D6 (__INTTAB_CPU1 + 0x1AC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_214)); } > pfls1
        .inttab_tc1_0D7 (__INTTAB_CPU1 + 0x1AE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_215)); } > pfls1
        .inttab_tc1_0D8 (__INTTAB_CPU1 + 0x1B00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_216)); } > pfls1
        .inttab_tc1_0D9 (__INTTAB_CPU1 + 0x1B20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_217)); } > pfls1
        .inttab_tc1_0DA (__INTTAB_CPU1 + 0x1B40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_218)); } > pfls1
        .inttab_tc1_0DB (__INTTAB_CPU1 + 0x1B60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_219)); } > pfls1
        .inttab_tc1_0DC (__INTTAB_CPU1 + 0x1B80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_220)); } > pfls1
        .inttab_tc1_0DD (__INTTAB_CPU1 + 0x1BA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_221)); } > pfls1
        .inttab_tc1_0DE (__INTTAB_CPU1 + 0x1BC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_222)); } > pfls1
        .inttab_tc1_0DF (__INTTAB_CPU1 + 0x1BE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_223)); } > pfls1
        .inttab_tc1_0E0 (__INTTAB_CPU1 + 0x1C00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_224)); } > pfls1
        .inttab_tc1_0E1 (__INTTAB_CPU1 + 0x1C20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_225)); } > pfls1
        .inttab_tc1_0E2 (__INTTAB_CPU1 + 0x1C40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_226)); } > pfls1
        .inttab_tc1_0E3 (__INTTAB_CPU1 + 0x1C60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_227)); } > pfls1
        .inttab_tc1_0E4 (__INTTAB_CPU1 + 0x1C80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_228)); } > pfls1
        .inttab_tc1_0E5 (__INTTAB_CPU1 + 0x1CA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_229)); } > pfls1
        .inttab_tc1_0E6 (__INTTAB_CPU1 + 0x1CC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_230)); } > pfls1
        .inttab_tc1_0E7 (__INTTAB_CPU1 + 0x1CE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_231)); } > pfls1
        .inttab_tc1_0E8 (__INTTAB_CPU1 + 0x1D00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_232)); } > pfls1
        .inttab_tc1_0E9 (__INTTAB_CPU1 + 0x1D20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_233)); } > pfls1
        .inttab_tc1_0EA (__INTTAB_CPU1 + 0x1D40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_234)); } > pfls1
        .inttab_tc1_0EB (__INTTAB_CPU1 + 0x1D60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_235)); } > pfls1
        .inttab_tc1_0EC (__INTTAB_CPU1 + 0x1D80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_236)); } > pfls1
        .inttab_tc1_0ED (__INTTAB_CPU1 + 0x1DA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_237)); } > pfls1
        .inttab_tc1_0EE (__INTTAB_CPU1 + 0x1DC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_238)); } > pfls1
        .inttab_tc1_0EF (__INTTAB_CPU1 + 0x1DE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_239)); } > pfls1
        .inttab_tc1_0F0 (__INTTAB_CPU1 + 0x1E00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_240)); } > pfls1
        .inttab_tc1_0F1 (__INTTAB_CPU1 + 0x1E20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_241)); } > pfls1
        .inttab_tc1_0F2 (__INTTAB_CPU1 + 0x1E40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_242)); } > pfls1
        .inttab_tc1_0F3 (__INTTAB_CPU1 + 0x1E60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_243)); } > pfls1
        .inttab_tc1_0F4 (__INTTAB_CPU1 + 0x1E80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_244)); } > pfls1
        .inttab_tc1_0F5 (__INTTAB_CPU1 + 0x1EA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_245)); } > pfls1
        .inttab_tc1_0F6 (__INTTAB_CPU1 + 0x1EC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_246)); } > pfls1
        .inttab_tc1_0F7 (__INTTAB_CPU1 + 0x1EE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_247)); } > pfls1
        .inttab_tc1_0F8 (__INTTAB_CPU1 + 0x1F00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_248)); } > pfls1
        .inttab_tc1_0F9 (__INTTAB_CPU1 + 0x1F20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_249)); } > pfls1
        .inttab_tc1_0FA (__INTTAB_CPU1 + 0x1F40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_250)); } > pfls1
        .inttab_tc1_0FB (__INTTAB_CPU1 + 0x1F60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_251)); } > pfls1
        .inttab_tc1_0FC (__INTTAB_CPU1 + 0x1F80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_252)); } > pfls1
        .inttab_tc1_0FD (__INTTAB_CPU1 + 0x1FA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_253)); } > pfls1
        .inttab_tc1_0FE (__INTTAB_CPU1 + 0x1FC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_254)); } > pfls1
        .inttab_tc1_0FF (__INTTAB_CPU1 + 0x1FE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc1_255)); } > pfls1
    }
    

