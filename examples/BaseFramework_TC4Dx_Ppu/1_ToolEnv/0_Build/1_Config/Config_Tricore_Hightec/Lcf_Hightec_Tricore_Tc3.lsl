/* Default linker script, for normal executables */
OUTPUT_FORMAT("elf32-tricore")
OUTPUT_ARCH(tricore)
ENTRY(_START3)

__TRICORE_DERIVATE_MEMORY_MAP__ = 0x4D0;

LCF_CSA3_SIZE = 8k;
LCF_USTACK3_SIZE = 2k;
LCF_ISTACK3_SIZE = 1k;

LCF_HEAP_SIZE = 4k;

LCF_PPU_FLASH_SIZE  = 1M;
LCF_PPU_LMURAM_SIZE = 512k;
LCF_PPU_CSM_SIZE    = 512k;

LCF_DSPR3_START = 0x40000000;
LCF_DSPR3_SIZE  = 240K;


LCF_CSA3_OFFSET =    (LCF_DSPR3_SIZE - 1k - LCF_CSA3_SIZE);
LCF_ISTACK3_OFFSET = (LCF_CSA3_OFFSET - 256 - LCF_ISTACK3_SIZE);
LCF_USTACK3_OFFSET = (LCF_ISTACK3_OFFSET - 256 - LCF_USTACK3_SIZE);

LCF_HEAP3_OFFSET =   (LCF_USTACK3_OFFSET - LCF_HEAP_SIZE);

LCF_INTVEC3_START = 0x80DFE000;


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

__INTTAB_CPU3 = LCF_INTVEC3_START;


RESET = LCF_STARTPTR_NC_CPU3;

MEMORY
{
    dsram3 (w!x): org = 0x40000000, len = 240K
    psram3 (w!x): org = 0x40100000, len = 64K
    
    psram_local (w!x): org = 0xc0000000, len = 64K
	dsram_local (w!x): org = 0xd0000000, len = 240K
    
    pfls3 (rx): org = 0x80A00000, len = 4M
    pfls3_nc (rx): org = 0xA0A00000, len = 4M

    
    pfls5 (rx): org = 0x81200000, len = 2M
    pfls5_nc (rx): org = 0xA1200000, len = 2M


    
    cpu3_dlmu (w!x): org = 0x90180000, len = 512K
    cpu3_dlmu_nc (w!x): org = 0xb0180000, len = 512K
    
    lmuram (w!x): org = 0x90400000, len = 5M
    lmuram_nc (w!x): org = 0xb0400000, len = 5M



    ppu_csm (w!x): org = 0x92080000, len = 512k
    ppu_csm_nc (w!x): org = 0xb2080000, len = 512k
}

/* map cached and non cached addresses */
REGION_MIRROR("pfls3", "pfls3_nc")
REGION_MIRROR("pfls5", "pfls5_nc")
REGION_MIRROR("cpu3_dlmu", "cpu3_dlmu_nc")
REGION_MIRROR("lmuram", "lmuram_nc")
REGION_MIRROR("ppu_csm", "ppu_csm_nc")

/*Un comment one of the below statement groups to enable CpuX DMI RAM to hold global variables*/

REGION_ALIAS( default_ram , dsram3)
REGION_ALIAS( default_rom , pfls3)


    /* Fixed memory Allocations for _START */
    SECTIONS
    {

    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU3 = 1);
    }                     



    SECTIONS
    {
		.start_tc3 (LCF_STARTPTR_NC_CPU3) :  { KEEP (*(.start_cpu3)); } > pfls3_nc
        .traptab_tc3 (LCF_TRAPVEC3_START) : { PROVIDE(__TRAPTAB_CPU3 = .); KEEP (*(.traptab_cpu3)); } > pfls3
		 PROVIDE(__START3 = LCF_STARTPTR_NC_CPU3);
	}

    /*Near Absolute Addressable Data Sections*/
    SECTIONS
    {
        .CPU3.zdata (LCF_DSPR3_START):
        {
            *Ifx_Ssw_Tc3.* (.zdata) *Ifx_Ssw_Tc3.* (.zdata.*)
            *Cpu3_Main.* (.zdata) *Cpu3_Main.* (.zdata.*)
            *(.zdata_cpu3) *(.zdata_cpu3.*)
            . = ALIGN(2);
        } > dsram3 AT> default_rom
        
        .CPU3.zbss (NOLOAD): ALIGN(4)
        {
            *Ifx_Ssw_Tc3.* (.zbss) *Ifx_Ssw_Tc3.* (.zbss.*)
            *Cpu3_Main.* (.zbss) *Cpu3_Main.* (.zbss.*)
            *(.zbss_cpu3)*(.zbss_cpu3.*)

        } > dsram3
    }

    /*Near Absolute Data, selectable by toolchain*/
    SECTIONS
    {
        .zdata_powerOn : ALIGN(4) 
        {
            *(.zdata.dsprPowerOnInit.cpu3.32bit)
            *(.zdata.dsprPowerOnInit.cpu3.16bit)
            *(.zdata.dsprPowerOnInit.cpu3.8bit)

            . = ALIGN(2);

        } > default_ram AT> default_rom
        
        .zdata : ALIGN(4) 
        {
            *(.zdata.dsprInit.cpu3.32bit)
            *(.zdata.dsprInit.cpu3.16bit)
            *(.zdata.dsprInit.cpu3.8bit)
            *(.zdata) *(.zdata.*)
            *(.gnu.linkonce.z.*)

            . = ALIGN(2);

        } > default_ram AT> default_rom
        
        .zbss_powerOn (NOLOAD) : ALIGN(4)
        {
            *(.zbss.dsprPowerOnClear.cpu3.32bit)
            *(.zbss.dsprPowerOnClear.cpu3.16bit)
            *(.zbss.dsprPowerOnClear.cpu3.8bit)
        } > default_ram
        
        .zbss_noClear (NOLOAD) : ALIGN(4)
        {
            *(.zbss.dsprNoInit.cpu3.32bit)
            *(.zbss.dsprNoInit.cpu3.16bit)
            *(.zbss.dsprNoInit.cpu3.8bit)
        } > default_ram
        
        .zbss (NOLOAD) : ALIGN(4)
        {
            *(.zbss.dsprClearOnInit.cpu3.32bit)
            *(.zbss.dsprClearOnInit.cpu3.16bit)
            *(.zbss.dsprClearOnInit.cpu3.8bit)
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
    
            *(.zrodata.const.cpu3.32bit)
            *(.zrodata.const.cpu3.16bit)
            *(.zrodata.const.cpu3.8bit)
            *(.zrodata.config.cpu3.32bit)
            *(.zrodata.config.cpu3.16bit)
            *(.zrodata.config.cpu3.8bit)
            *(.zrodata) *(.zrodata.*)
        } > pfls3
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
    } > cpu3_dlmu AT> default_rom
    
    .sbss4 : ALIGN(4)
    {
        *(.bss_a9) *(.bss_a9.*)
        *(.a9sbss) *(.a9sbss.*)
    } > cpu3_dlmu
    
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
    /*DSRAM3 Sections*/
    .CPU3.data : ALIGN(4)
    {
        *Ifx_Ssw_Tc3.* (.data) *Ifx_Ssw_Tc3.* (.data.*)
        *Cpu3_Main.* (.data) *Cpu3_Main.* (.data.*)
        *(.data_cpu3) *(.data_cpu3.*)
        . = ALIGN(2);
    } > dsram3 AT> default_rom
    
    .CPU3.bss (NOLOAD): ALIGN(4)
    {
        *Ifx_Ssw_Tc3.* (.bss) *Ifx_Ssw_Tc3.* (.bss.*)
        *Cpu3_Main.* (.bss) *Cpu3_Main.* (.bss.*)
        *(.bss_cpu3) *(.bss_cpu3.*)

    } > dsram3
    
    /*DLMU3 Sections*/
    .CPU3.lmudata : ALIGN(4) 
    {
         *(.lmudata_cpu3) *(.lmudata_cpu3.*)
        . = ALIGN(2);
    } > cpu3_dlmu AT> default_rom
    
    .CPU3.lmubss (NOLOAD) : ALIGN(4) 
    {
        *(.lmubss_cpu3) *(.lmubss_cpu3.*)   
    } > cpu3_dlmu
}

/*Far Data Sections, selectable by toolchain*/
SECTIONS
{
    
    .data : ALIGN(4)
    {
        *(.data.farDsprInit.cpu3.32bit)
        *(.data.farDsprInit.cpu3.16bit)
        *(.data.farDsprInit.cpu3.8bit)
        *(.data) *(.data.*)
        *(.gnu.linkonce.d.*)
        . = ALIGN(2);
    } > default_ram AT> default_rom
	
	.bss_noClear (NOLOAD) : ALIGN(4)
    {
        *(.bss.farDsprNoInit.cpu3.32bit)
        *(.bss.farDsprNoInit.cpu3.16bit)
        *(.bss.farDsprNoInit.cpu3.8bit)
    } > default_ram
    
    .bss (NOLOAD) : ALIGN(4)
    {
        *(.bss.farDsprClearOnInit.cpu3.32bit)
        *(.bss.farDsprClearOnInit.cpu3.16bit)
        *(.bss.farDsprClearOnInit.cpu3.8bit)
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
    } > cpu3_dlmu AT> default_rom
    
    .lmubss : ALIGN(4) 
    {
        *(.lmubss) *(.lmubss.*)
        *(.uncached.lmubss) *(.uncached.lmubss.*)
    } > cpu3_dlmu


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
        .CPU3.ustack (LCF_DSPR3_START + LCF_USTACK3_OFFSET)(NOLOAD):
        { PROVIDE(__USTACK3_END = .);    . = . + LCF_USTACK3_SIZE;    PROVIDE(__USTACK3 = .); } > dsram3
        
        .CPU3.istack (LCF_DSPR3_START + LCF_ISTACK3_OFFSET)(NOLOAD):
        { PROVIDE(__ISTACK3_END = .);    . = . + LCF_ISTACK3_SIZE;    PROVIDE(__ISTACK3 = .); } > dsram3
        
        .CPU3.csa (LCF_DSPR3_START + LCF_CSA3_OFFSET)(NOLOAD):
        { PROVIDE(__CSA3 = .);    . = . + LCF_CSA3_SIZE;    PROVIDE(__CSA3_END = .); } > dsram3
    }

/*Far Const Sections, selectable with patterns and user defined sections*/
SECTIONS
{
    .CPU3.rodata : ALIGN(4) 
    {
        *Ifx_Ssw_Tc3.* (.rodata) *Ifx_Ssw_Tc3.* (.rodata.*)
        *Cpu3_Main.* (.rodata) *Cpu3_Main.* (.rodata.*)
		*(.rodata_cpu3) *(.rodata_cpu3.*)
    } > pfls3
}

/*Far Const Sections, selectable by toolchain*/
SECTIONS
{
    .rodata : 
    {
        *(.rodata.farConst.cpu3.32bit)
        *(.rodata.farConst.cpu3.16bit)
        *(.rodata.farConst.cpu3.8bit)
		*(.rodata) *(.rodata.*)
    *(.gnu.linkonce.r.*)
    /*
     * Create the clear and copy tables that tell the startup code
     * which memory areas to clear and to copy, respectively.
     */
    . = ALIGN(4) ;
    PROVIDE(__clear_table = .);
    LONG(0 + ADDR(.CPU3.zbss));       LONG(SIZEOF(.CPU3.zbss));
    LONG(0 + ADDR(.CPU3.bss));        LONG(SIZEOF(.CPU3.bss));
    LONG(0 + ADDR(.CPU3.lmubss));     LONG(SIZEOF(.CPU3.lmubss));
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
    LONG(LOADADDR(.CPU3.zdata));      LONG(0 + ADDR(.CPU3.zdata));      LONG(SIZEOF(.CPU3.zdata));
    LONG(LOADADDR(.CPU3.data));       LONG(0 + ADDR(.CPU3.data));       LONG(SIZEOF(.CPU3.data));
    LONG(LOADADDR(.CPU3.lmudata));    LONG(0 + ADDR(.CPU3.lmudata));    LONG(SIZEOF(.CPU3.lmudata));
    LONG(LOADADDR(.zdata));           LONG(0 + ADDR(.zdata));           LONG(SIZEOF(.zdata));
    LONG(LOADADDR(.sdata));           LONG(0 + ADDR(.sdata));           LONG(SIZEOF(.sdata));
    LONG(LOADADDR(.data));            LONG(0 + ADDR(.data));            LONG(SIZEOF(.data));
    LONG(LOADADDR(.lmudata));         LONG(0 + ADDR(.lmudata));         LONG(SIZEOF(.lmudata));
    LONG(LOADADDR(.sdata4));          LONG(0 + ADDR(.sdata4));          LONG(SIZEOF(.sdata4));
    LONG(LOADADDR(.CPU3.psram_text)); LONG(0 + ADDR(.CPU3.psram_text)); LONG(SIZEOF(.CPU3.psram_text));
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
    .CPU3.text : ALIGN(4) 
    {
        *Ifx_Ssw_Tc3.*(.text) *Ifx_Ssw_Tc3.*(.text.*)
        *Cpu3_Main.*(.text) *Cpu3_Main.*(.text.*)
        *(.text_cpu3) *(.text_cpu3.*)
        . = ALIGN(4);
    } > pfls3
	
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
    
    } > pfls3
    
    .fini :
    {
        PROVIDE(__fini_start = .);
        KEEP(*(.fini))
        KEEP(*(.fini*))
        PROVIDE(__fini_end = .);
        . = ALIGN(8);
    } > pfls3
    
    /*
     * Code executed before calling main extra section for C++ constructor init
     *  -------------------------End-----------------------------------------
     */
    .CPU3.psram_text  : ALIGN(4) 
    {
        *(.psram_text_cpu3) *(.psram_text_cpu3.*)
        *(.cpu3_psram) *(.cpu3_psram.*)
        . = ALIGN(4);
    } > psram3 AT> pfls3
}

/*Code Sections, selectable by toolchain*/
SECTIONS
{
    .text :
    {
        *(.text.fast.pfls.cpu3)
        *(.text.slow.pfls.cpu3)
        *(.text.5ms.pfls.cpu3)
        *(.text.10ms.pfls.cpu3)
        *(.text.callout.pfls.cpu3)
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
        /*CPU3 Interrupt Vector Table*/
        .inttab_tc3_000 (__INTTAB_CPU3 + 0x0000) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_0  )); } > pfls3
        .inttab_tc3_001 (__INTTAB_CPU3 + 0x0020) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_1  )); } > pfls3
        .inttab_tc3_002 (__INTTAB_CPU3 + 0x0040) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_2  )); } > pfls3
        .inttab_tc3_003 (__INTTAB_CPU3 + 0x0060) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_3  )); } > pfls3
        .inttab_tc3_004 (__INTTAB_CPU3 + 0x0080) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_4  )); } > pfls3
        .inttab_tc3_005 (__INTTAB_CPU3 + 0x00A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_5  )); } > pfls3
        .inttab_tc3_006 (__INTTAB_CPU3 + 0x00C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_6  )); } > pfls3
        .inttab_tc3_007 (__INTTAB_CPU3 + 0x00E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_7  )); } > pfls3
        .inttab_tc3_008 (__INTTAB_CPU3 + 0x0100) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_8  )); } > pfls3
        .inttab_tc3_009 (__INTTAB_CPU3 + 0x0120) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_9  )); } > pfls3
        .inttab_tc3_00A (__INTTAB_CPU3 + 0x0140) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_10 )); } > pfls3
        .inttab_tc3_00B (__INTTAB_CPU3 + 0x0160) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_11 )); } > pfls3
        .inttab_tc3_00C (__INTTAB_CPU3 + 0x0180) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_12 )); } > pfls3
        .inttab_tc3_00D (__INTTAB_CPU3 + 0x01A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_13 )); } > pfls3
        .inttab_tc3_00E (__INTTAB_CPU3 + 0x01C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_14 )); } > pfls3
        .inttab_tc3_00F (__INTTAB_CPU3 + 0x01E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_15 )); } > pfls3
        .inttab_tc3_010 (__INTTAB_CPU3 + 0x0200) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_16 )); } > pfls3
        .inttab_tc3_011 (__INTTAB_CPU3 + 0x0220) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_17 )); } > pfls3
        .inttab_tc3_012 (__INTTAB_CPU3 + 0x0240) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_18 )); } > pfls3
        .inttab_tc3_013 (__INTTAB_CPU3 + 0x0260) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_19 )); } > pfls3
        .inttab_tc3_014 (__INTTAB_CPU3 + 0x0280) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_20 )); } > pfls3
        .inttab_tc3_015 (__INTTAB_CPU3 + 0x02A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_21 )); } > pfls3
        .inttab_tc3_016 (__INTTAB_CPU3 + 0x02C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_22 )); } > pfls3
        .inttab_tc3_017 (__INTTAB_CPU3 + 0x02E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_23 )); } > pfls3
        .inttab_tc3_018 (__INTTAB_CPU3 + 0x0300) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_24 )); } > pfls3
        .inttab_tc3_019 (__INTTAB_CPU3 + 0x0320) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_25 )); } > pfls3
        .inttab_tc3_01A (__INTTAB_CPU3 + 0x0340) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_26 )); } > pfls3
        .inttab_tc3_01B (__INTTAB_CPU3 + 0x0360) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_27 )); } > pfls3
        .inttab_tc3_01C (__INTTAB_CPU3 + 0x0380) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_28 )); } > pfls3
        .inttab_tc3_01D (__INTTAB_CPU3 + 0x03A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_29 )); } > pfls3
        .inttab_tc3_01E (__INTTAB_CPU3 + 0x03C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_30 )); } > pfls3
        .inttab_tc3_01F (__INTTAB_CPU3 + 0x03E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_31 )); } > pfls3
        .inttab_tc3_020 (__INTTAB_CPU3 + 0x0400) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_32 )); } > pfls3
        .inttab_tc3_021 (__INTTAB_CPU3 + 0x0420) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_33 )); } > pfls3
        .inttab_tc3_022 (__INTTAB_CPU3 + 0x0440) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_34 )); } > pfls3
        .inttab_tc3_023 (__INTTAB_CPU3 + 0x0460) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_35 )); } > pfls3
        .inttab_tc3_024 (__INTTAB_CPU3 + 0x0480) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_36 )); } > pfls3
        .inttab_tc3_025 (__INTTAB_CPU3 + 0x04A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_37 )); } > pfls3
        .inttab_tc3_026 (__INTTAB_CPU3 + 0x04C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_38 )); } > pfls3
        .inttab_tc3_027 (__INTTAB_CPU3 + 0x04E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_39 )); } > pfls3
        .inttab_tc3_028 (__INTTAB_CPU3 + 0x0500) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_40 )); } > pfls3
        .inttab_tc3_029 (__INTTAB_CPU3 + 0x0520) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_41 )); } > pfls3
        .inttab_tc3_02A (__INTTAB_CPU3 + 0x0540) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_42 )); } > pfls3
        .inttab_tc3_02B (__INTTAB_CPU3 + 0x0560) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_43 )); } > pfls3
        .inttab_tc3_02C (__INTTAB_CPU3 + 0x0580) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_44 )); } > pfls3
        .inttab_tc3_02D (__INTTAB_CPU3 + 0x05A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_45 )); } > pfls3
        .inttab_tc3_02E (__INTTAB_CPU3 + 0x05C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_46 )); } > pfls3
        .inttab_tc3_02F (__INTTAB_CPU3 + 0x05E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_47 )); } > pfls3
        .inttab_tc3_030 (__INTTAB_CPU3 + 0x0600) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_48 )); } > pfls3
        .inttab_tc3_031 (__INTTAB_CPU3 + 0x0620) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_49 )); } > pfls3
        .inttab_tc3_032 (__INTTAB_CPU3 + 0x0640) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_50 )); } > pfls3
        .inttab_tc3_033 (__INTTAB_CPU3 + 0x0660) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_51 )); } > pfls3
        .inttab_tc3_034 (__INTTAB_CPU3 + 0x0680) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_52 )); } > pfls3
        .inttab_tc3_035 (__INTTAB_CPU3 + 0x06A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_53 )); } > pfls3
        .inttab_tc3_036 (__INTTAB_CPU3 + 0x06C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_54 )); } > pfls3
        .inttab_tc3_037 (__INTTAB_CPU3 + 0x06E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_55 )); } > pfls3
        .inttab_tc3_038 (__INTTAB_CPU3 + 0x0700) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_56 )); } > pfls3
        .inttab_tc3_039 (__INTTAB_CPU3 + 0x0720) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_57 )); } > pfls3
        .inttab_tc3_03A (__INTTAB_CPU3 + 0x0740) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_58 )); } > pfls3
        .inttab_tc3_03B (__INTTAB_CPU3 + 0x0760) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_59 )); } > pfls3
        .inttab_tc3_03C (__INTTAB_CPU3 + 0x0780) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_60 )); } > pfls3
        .inttab_tc3_03D (__INTTAB_CPU3 + 0x07A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_61 )); } > pfls3
        .inttab_tc3_03E (__INTTAB_CPU3 + 0x07C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_62 )); } > pfls3
        .inttab_tc3_03F (__INTTAB_CPU3 + 0x07E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_63 )); } > pfls3
        .inttab_tc3_040 (__INTTAB_CPU3 + 0x0800) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_64 )); } > pfls3
        .inttab_tc3_041 (__INTTAB_CPU3 + 0x0820) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_65 )); } > pfls3
        .inttab_tc3_042 (__INTTAB_CPU3 + 0x0840) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_66 )); } > pfls3
        .inttab_tc3_043 (__INTTAB_CPU3 + 0x0860) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_67 )); } > pfls3
        .inttab_tc3_044 (__INTTAB_CPU3 + 0x0880) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_68 )); } > pfls3
        .inttab_tc3_045 (__INTTAB_CPU3 + 0x08A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_69 )); } > pfls3
        .inttab_tc3_046 (__INTTAB_CPU3 + 0x08C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_70 )); } > pfls3
        .inttab_tc3_047 (__INTTAB_CPU3 + 0x08E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_71 )); } > pfls3
        .inttab_tc3_048 (__INTTAB_CPU3 + 0x0900) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_72 )); } > pfls3
        .inttab_tc3_049 (__INTTAB_CPU3 + 0x0920) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_73 )); } > pfls3
        .inttab_tc3_04A (__INTTAB_CPU3 + 0x0940) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_74 )); } > pfls3
        .inttab_tc3_04B (__INTTAB_CPU3 + 0x0960) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_75 )); } > pfls3
        .inttab_tc3_04C (__INTTAB_CPU3 + 0x0980) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_76 )); } > pfls3
        .inttab_tc3_04D (__INTTAB_CPU3 + 0x09A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_77 )); } > pfls3
        .inttab_tc3_04E (__INTTAB_CPU3 + 0x09C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_78 )); } > pfls3
        .inttab_tc3_04F (__INTTAB_CPU3 + 0x09E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_79 )); } > pfls3
        .inttab_tc3_050 (__INTTAB_CPU3 + 0x0A00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_80 )); } > pfls3
        .inttab_tc3_051 (__INTTAB_CPU3 + 0x0A20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_81 )); } > pfls3
        .inttab_tc3_052 (__INTTAB_CPU3 + 0x0A40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_82 )); } > pfls3
        .inttab_tc3_053 (__INTTAB_CPU3 + 0x0A60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_83 )); } > pfls3
        .inttab_tc3_054 (__INTTAB_CPU3 + 0x0A80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_84 )); } > pfls3
        .inttab_tc3_055 (__INTTAB_CPU3 + 0x0AA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_85 )); } > pfls3
        .inttab_tc3_056 (__INTTAB_CPU3 + 0x0AC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_86 )); } > pfls3
        .inttab_tc3_057 (__INTTAB_CPU3 + 0x0AE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_87 )); } > pfls3
        .inttab_tc3_058 (__INTTAB_CPU3 + 0x0B00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_88 )); } > pfls3
        .inttab_tc3_059 (__INTTAB_CPU3 + 0x0B20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_89 )); } > pfls3
        .inttab_tc3_05A (__INTTAB_CPU3 + 0x0B40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_90 )); } > pfls3
        .inttab_tc3_05B (__INTTAB_CPU3 + 0x0B60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_91 )); } > pfls3
        .inttab_tc3_05C (__INTTAB_CPU3 + 0x0B80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_92 )); } > pfls3
        .inttab_tc3_05D (__INTTAB_CPU3 + 0x0BA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_93 )); } > pfls3
        .inttab_tc3_05E (__INTTAB_CPU3 + 0x0BC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_94 )); } > pfls3
        .inttab_tc3_05F (__INTTAB_CPU3 + 0x0BE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_95 )); } > pfls3
        .inttab_tc3_060 (__INTTAB_CPU3 + 0x0C00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_96 )); } > pfls3
        .inttab_tc3_061 (__INTTAB_CPU3 + 0x0C20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_97 )); } > pfls3
        .inttab_tc3_062 (__INTTAB_CPU3 + 0x0C40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_98 )); } > pfls3
        .inttab_tc3_063 (__INTTAB_CPU3 + 0x0C60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_99 )); } > pfls3
        .inttab_tc3_064 (__INTTAB_CPU3 + 0x0C80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_100)); } > pfls3
        .inttab_tc3_065 (__INTTAB_CPU3 + 0x0CA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_101)); } > pfls3
        .inttab_tc3_066 (__INTTAB_CPU3 + 0x0CC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_102)); } > pfls3
        .inttab_tc3_067 (__INTTAB_CPU3 + 0x0CE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_103)); } > pfls3
        .inttab_tc3_068 (__INTTAB_CPU3 + 0x0D00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_104)); } > pfls3
        .inttab_tc3_069 (__INTTAB_CPU3 + 0x0D20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_105)); } > pfls3
        .inttab_tc3_06A (__INTTAB_CPU3 + 0x0D40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_106)); } > pfls3
        .inttab_tc3_06B (__INTTAB_CPU3 + 0x0D60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_107)); } > pfls3
        .inttab_tc3_06C (__INTTAB_CPU3 + 0x0D80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_108)); } > pfls3
        .inttab_tc3_06D (__INTTAB_CPU3 + 0x0DA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_109)); } > pfls3
        .inttab_tc3_06E (__INTTAB_CPU3 + 0x0DC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_110)); } > pfls3
        .inttab_tc3_06F (__INTTAB_CPU3 + 0x0DE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_111)); } > pfls3
        .inttab_tc3_070 (__INTTAB_CPU3 + 0x0E00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_112)); } > pfls3
        .inttab_tc3_071 (__INTTAB_CPU3 + 0x0E20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_113)); } > pfls3
        .inttab_tc3_072 (__INTTAB_CPU3 + 0x0E40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_114)); } > pfls3
        .inttab_tc3_073 (__INTTAB_CPU3 + 0x0E60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_115)); } > pfls3
        .inttab_tc3_074 (__INTTAB_CPU3 + 0x0E80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_116)); } > pfls3
        .inttab_tc3_075 (__INTTAB_CPU3 + 0x0EA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_117)); } > pfls3
        .inttab_tc3_076 (__INTTAB_CPU3 + 0x0EC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_118)); } > pfls3
        .inttab_tc3_077 (__INTTAB_CPU3 + 0x0EE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_119)); } > pfls3
        .inttab_tc3_078 (__INTTAB_CPU3 + 0x0F00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_120)); } > pfls3
        .inttab_tc3_079 (__INTTAB_CPU3 + 0x0F20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_121)); } > pfls3
        .inttab_tc3_07A (__INTTAB_CPU3 + 0x0F40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_122)); } > pfls3
        .inttab_tc3_07B (__INTTAB_CPU3 + 0x0F60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_123)); } > pfls3
        .inttab_tc3_07C (__INTTAB_CPU3 + 0x0F80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_124)); } > pfls3
        .inttab_tc3_07D (__INTTAB_CPU3 + 0x0FA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_125)); } > pfls3
        .inttab_tc3_07E (__INTTAB_CPU3 + 0x0FC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_126)); } > pfls3
        .inttab_tc3_07F (__INTTAB_CPU3 + 0x0FE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_127)); } > pfls3
        .inttab_tc3_080 (__INTTAB_CPU3 + 0x1000) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_128)); } > pfls3
        .inttab_tc3_081 (__INTTAB_CPU3 + 0x1020) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_129)); } > pfls3
        .inttab_tc3_082 (__INTTAB_CPU3 + 0x1040) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_130)); } > pfls3
        .inttab_tc3_083 (__INTTAB_CPU3 + 0x1060) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_131)); } > pfls3
        .inttab_tc3_084 (__INTTAB_CPU3 + 0x1080) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_132)); } > pfls3
        .inttab_tc3_085 (__INTTAB_CPU3 + 0x10A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_133)); } > pfls3
        .inttab_tc3_086 (__INTTAB_CPU3 + 0x10C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_134)); } > pfls3
        .inttab_tc3_087 (__INTTAB_CPU3 + 0x10E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_135)); } > pfls3
        .inttab_tc3_088 (__INTTAB_CPU3 + 0x1100) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_136)); } > pfls3
        .inttab_tc3_089 (__INTTAB_CPU3 + 0x1120) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_137)); } > pfls3
        .inttab_tc3_08A (__INTTAB_CPU3 + 0x1140) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_138)); } > pfls3
        .inttab_tc3_08B (__INTTAB_CPU3 + 0x1160) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_139)); } > pfls3
        .inttab_tc3_08C (__INTTAB_CPU3 + 0x1180) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_140)); } > pfls3
        .inttab_tc3_08D (__INTTAB_CPU3 + 0x11A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_141)); } > pfls3
        .inttab_tc3_08E (__INTTAB_CPU3 + 0x11C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_142)); } > pfls3
        .inttab_tc3_08F (__INTTAB_CPU3 + 0x11E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_143)); } > pfls3
        .inttab_tc3_090 (__INTTAB_CPU3 + 0x1200) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_144)); } > pfls3
        .inttab_tc3_091 (__INTTAB_CPU3 + 0x1220) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_145)); } > pfls3
        .inttab_tc3_092 (__INTTAB_CPU3 + 0x1240) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_146)); } > pfls3
        .inttab_tc3_093 (__INTTAB_CPU3 + 0x1260) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_147)); } > pfls3
        .inttab_tc3_094 (__INTTAB_CPU3 + 0x1280) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_148)); } > pfls3
        .inttab_tc3_095 (__INTTAB_CPU3 + 0x12A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_149)); } > pfls3
        .inttab_tc3_096 (__INTTAB_CPU3 + 0x12C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_150)); } > pfls3
        .inttab_tc3_097 (__INTTAB_CPU3 + 0x12E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_151)); } > pfls3
        .inttab_tc3_098 (__INTTAB_CPU3 + 0x1300) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_152)); } > pfls3
        .inttab_tc3_099 (__INTTAB_CPU3 + 0x1320) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_153)); } > pfls3
        .inttab_tc3_09A (__INTTAB_CPU3 + 0x1340) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_154)); } > pfls3
        .inttab_tc3_09B (__INTTAB_CPU3 + 0x1360) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_155)); } > pfls3
        .inttab_tc3_09C (__INTTAB_CPU3 + 0x1380) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_156)); } > pfls3
        .inttab_tc3_09D (__INTTAB_CPU3 + 0x13A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_157)); } > pfls3
        .inttab_tc3_09E (__INTTAB_CPU3 + 0x13C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_158)); } > pfls3
        .inttab_tc3_09F (__INTTAB_CPU3 + 0x13E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_159)); } > pfls3
        .inttab_tc3_0A0 (__INTTAB_CPU3 + 0x1400) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_160)); } > pfls3
        .inttab_tc3_0A1 (__INTTAB_CPU3 + 0x1420) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_161)); } > pfls3
        .inttab_tc3_0A2 (__INTTAB_CPU3 + 0x1440) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_162)); } > pfls3
        .inttab_tc3_0A3 (__INTTAB_CPU3 + 0x1460) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_163)); } > pfls3
        .inttab_tc3_0A4 (__INTTAB_CPU3 + 0x1480) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_164)); } > pfls3
        .inttab_tc3_0A5 (__INTTAB_CPU3 + 0x14A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_165)); } > pfls3
        .inttab_tc3_0A6 (__INTTAB_CPU3 + 0x14C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_166)); } > pfls3
        .inttab_tc3_0A7 (__INTTAB_CPU3 + 0x14E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_167)); } > pfls3
        .inttab_tc3_0A8 (__INTTAB_CPU3 + 0x1500) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_168)); } > pfls3
        .inttab_tc3_0A9 (__INTTAB_CPU3 + 0x1520) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_169)); } > pfls3
        .inttab_tc3_0AA (__INTTAB_CPU3 + 0x1540) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_170)); } > pfls3
        .inttab_tc3_0AB (__INTTAB_CPU3 + 0x1560) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_171)); } > pfls3
        .inttab_tc3_0AC (__INTTAB_CPU3 + 0x1580) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_172)); } > pfls3
        .inttab_tc3_0AD (__INTTAB_CPU3 + 0x15A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_173)); } > pfls3
        .inttab_tc3_0AE (__INTTAB_CPU3 + 0x15C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_174)); } > pfls3
        .inttab_tc3_0AF (__INTTAB_CPU3 + 0x15E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_175)); } > pfls3
        .inttab_tc3_0B0 (__INTTAB_CPU3 + 0x1600) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_176)); } > pfls3
        .inttab_tc3_0B1 (__INTTAB_CPU3 + 0x1620) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_177)); } > pfls3
        .inttab_tc3_0B2 (__INTTAB_CPU3 + 0x1640) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_178)); } > pfls3
        .inttab_tc3_0B3 (__INTTAB_CPU3 + 0x1660) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_179)); } > pfls3
        .inttab_tc3_0B4 (__INTTAB_CPU3 + 0x1680) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_180)); } > pfls3
        .inttab_tc3_0B5 (__INTTAB_CPU3 + 0x16A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_181)); } > pfls3
        .inttab_tc3_0B6 (__INTTAB_CPU3 + 0x16C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_182)); } > pfls3
        .inttab_tc3_0B7 (__INTTAB_CPU3 + 0x16E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_183)); } > pfls3
        .inttab_tc3_0B8 (__INTTAB_CPU3 + 0x1700) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_184)); } > pfls3
        .inttab_tc3_0B9 (__INTTAB_CPU3 + 0x1720) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_185)); } > pfls3
        .inttab_tc3_0BA (__INTTAB_CPU3 + 0x1740) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_186)); } > pfls3
        .inttab_tc3_0BB (__INTTAB_CPU3 + 0x1760) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_187)); } > pfls3
        .inttab_tc3_0BC (__INTTAB_CPU3 + 0x1780) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_188)); } > pfls3
        .inttab_tc3_0BD (__INTTAB_CPU3 + 0x17A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_189)); } > pfls3
        .inttab_tc3_0BE (__INTTAB_CPU3 + 0x17C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_190)); } > pfls3
        .inttab_tc3_0BF (__INTTAB_CPU3 + 0x17E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_191)); } > pfls3
        .inttab_tc3_0C0 (__INTTAB_CPU3 + 0x1800) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_192)); } > pfls3
        .inttab_tc3_0C1 (__INTTAB_CPU3 + 0x1820) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_193)); } > pfls3
        .inttab_tc3_0C2 (__INTTAB_CPU3 + 0x1840) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_194)); } > pfls3
        .inttab_tc3_0C3 (__INTTAB_CPU3 + 0x1860) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_195)); } > pfls3
        .inttab_tc3_0C4 (__INTTAB_CPU3 + 0x1880) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_196)); } > pfls3
        .inttab_tc3_0C5 (__INTTAB_CPU3 + 0x18A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_197)); } > pfls3
        .inttab_tc3_0C6 (__INTTAB_CPU3 + 0x18C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_198)); } > pfls3
        .inttab_tc3_0C7 (__INTTAB_CPU3 + 0x18E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_199)); } > pfls3
        .inttab_tc3_0C8 (__INTTAB_CPU3 + 0x1900) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_200)); } > pfls3
        .inttab_tc3_0C9 (__INTTAB_CPU3 + 0x1920) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_201)); } > pfls3
        .inttab_tc3_0CA (__INTTAB_CPU3 + 0x1940) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_202)); } > pfls3
        .inttab_tc3_0CB (__INTTAB_CPU3 + 0x1960) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_203)); } > pfls3
        .inttab_tc3_0CC (__INTTAB_CPU3 + 0x1980) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_204)); } > pfls3
        .inttab_tc3_0CD (__INTTAB_CPU3 + 0x19A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_205)); } > pfls3
        .inttab_tc3_0CE (__INTTAB_CPU3 + 0x19C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_206)); } > pfls3
        .inttab_tc3_0CF (__INTTAB_CPU3 + 0x19E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_207)); } > pfls3
        .inttab_tc3_0D0 (__INTTAB_CPU3 + 0x1A00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_208)); } > pfls3
        .inttab_tc3_0D1 (__INTTAB_CPU3 + 0x1A20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_209)); } > pfls3
        .inttab_tc3_0D2 (__INTTAB_CPU3 + 0x1A40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_210)); } > pfls3
        .inttab_tc3_0D3 (__INTTAB_CPU3 + 0x1A60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_211)); } > pfls3
        .inttab_tc3_0D4 (__INTTAB_CPU3 + 0x1A80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_212)); } > pfls3
        .inttab_tc3_0D5 (__INTTAB_CPU3 + 0x1AA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_213)); } > pfls3
        .inttab_tc3_0D6 (__INTTAB_CPU3 + 0x1AC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_214)); } > pfls3
        .inttab_tc3_0D7 (__INTTAB_CPU3 + 0x1AE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_215)); } > pfls3
        .inttab_tc3_0D8 (__INTTAB_CPU3 + 0x1B00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_216)); } > pfls3
        .inttab_tc3_0D9 (__INTTAB_CPU3 + 0x1B20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_217)); } > pfls3
        .inttab_tc3_0DA (__INTTAB_CPU3 + 0x1B40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_218)); } > pfls3
        .inttab_tc3_0DB (__INTTAB_CPU3 + 0x1B60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_219)); } > pfls3
        .inttab_tc3_0DC (__INTTAB_CPU3 + 0x1B80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_220)); } > pfls3
        .inttab_tc3_0DD (__INTTAB_CPU3 + 0x1BA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_221)); } > pfls3
        .inttab_tc3_0DE (__INTTAB_CPU3 + 0x1BC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_222)); } > pfls3
        .inttab_tc3_0DF (__INTTAB_CPU3 + 0x1BE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_223)); } > pfls3
        .inttab_tc3_0E0 (__INTTAB_CPU3 + 0x1C00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_224)); } > pfls3
        .inttab_tc3_0E1 (__INTTAB_CPU3 + 0x1C20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_225)); } > pfls3
        .inttab_tc3_0E2 (__INTTAB_CPU3 + 0x1C40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_226)); } > pfls3
        .inttab_tc3_0E3 (__INTTAB_CPU3 + 0x1C60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_227)); } > pfls3
        .inttab_tc3_0E4 (__INTTAB_CPU3 + 0x1C80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_228)); } > pfls3
        .inttab_tc3_0E5 (__INTTAB_CPU3 + 0x1CA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_229)); } > pfls3
        .inttab_tc3_0E6 (__INTTAB_CPU3 + 0x1CC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_230)); } > pfls3
        .inttab_tc3_0E7 (__INTTAB_CPU3 + 0x1CE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_231)); } > pfls3
        .inttab_tc3_0E8 (__INTTAB_CPU3 + 0x1D00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_232)); } > pfls3
        .inttab_tc3_0E9 (__INTTAB_CPU3 + 0x1D20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_233)); } > pfls3
        .inttab_tc3_0EA (__INTTAB_CPU3 + 0x1D40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_234)); } > pfls3
        .inttab_tc3_0EB (__INTTAB_CPU3 + 0x1D60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_235)); } > pfls3
        .inttab_tc3_0EC (__INTTAB_CPU3 + 0x1D80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_236)); } > pfls3
        .inttab_tc3_0ED (__INTTAB_CPU3 + 0x1DA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_237)); } > pfls3
        .inttab_tc3_0EE (__INTTAB_CPU3 + 0x1DC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_238)); } > pfls3
        .inttab_tc3_0EF (__INTTAB_CPU3 + 0x1DE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_239)); } > pfls3
        .inttab_tc3_0F0 (__INTTAB_CPU3 + 0x1E00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_240)); } > pfls3
        .inttab_tc3_0F1 (__INTTAB_CPU3 + 0x1E20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_241)); } > pfls3
        .inttab_tc3_0F2 (__INTTAB_CPU3 + 0x1E40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_242)); } > pfls3
        .inttab_tc3_0F3 (__INTTAB_CPU3 + 0x1E60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_243)); } > pfls3
        .inttab_tc3_0F4 (__INTTAB_CPU3 + 0x1E80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_244)); } > pfls3
        .inttab_tc3_0F5 (__INTTAB_CPU3 + 0x1EA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_245)); } > pfls3
        .inttab_tc3_0F6 (__INTTAB_CPU3 + 0x1EC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_246)); } > pfls3
        .inttab_tc3_0F7 (__INTTAB_CPU3 + 0x1EE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_247)); } > pfls3
        .inttab_tc3_0F8 (__INTTAB_CPU3 + 0x1F00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_248)); } > pfls3
        .inttab_tc3_0F9 (__INTTAB_CPU3 + 0x1F20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_249)); } > pfls3
        .inttab_tc3_0FA (__INTTAB_CPU3 + 0x1F40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_250)); } > pfls3
        .inttab_tc3_0FB (__INTTAB_CPU3 + 0x1F60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_251)); } > pfls3
        .inttab_tc3_0FC (__INTTAB_CPU3 + 0x1F80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_252)); } > pfls3
        .inttab_tc3_0FD (__INTTAB_CPU3 + 0x1FA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_253)); } > pfls3
        .inttab_tc3_0FE (__INTTAB_CPU3 + 0x1FC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_254)); } > pfls3
        .inttab_tc3_0FF (__INTTAB_CPU3 + 0x1FE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc3_255)); } > pfls3
    }


