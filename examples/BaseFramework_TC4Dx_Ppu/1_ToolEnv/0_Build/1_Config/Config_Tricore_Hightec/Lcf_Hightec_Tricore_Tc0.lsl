/* Default linker script, for normal executables */
OUTPUT_FORMAT("elf32-tricore")
OUTPUT_ARCH(tricore)
ENTRY(_START)

__TRICORE_DERIVATE_MEMORY_MAP__ = 0x4D0;

LCF_CSA0_SIZE = 8k;
LCF_USTACK0_SIZE = 2k;
LCF_ISTACK0_SIZE = 1k;

LCF_HEAP_SIZE = 4k;

LCF_PPU_FLASH_SIZE  = 1M;
LCF_PPU_LMURAM_SIZE = 512k;
LCF_PPU_CSM_SIZE    = 512k;

LCF_DSPR0_START = 0x70000000;
LCF_DSPR0_SIZE  = 240K;

LCF_CSA0_OFFSET =    (LCF_DSPR0_SIZE - 1k - LCF_CSA0_SIZE);
LCF_ISTACK0_OFFSET = (LCF_CSA0_OFFSET - 256 - LCF_ISTACK0_SIZE);
LCF_USTACK0_OFFSET = (LCF_ISTACK0_OFFSET - 256 - LCF_USTACK0_SIZE);

LCF_HEAP0_OFFSET =   (LCF_USTACK0_OFFSET - LCF_HEAP_SIZE);

LCF_INTVEC0_START = 0x803FE000;

LCF_TRAPVEC0_START = 0x80000100;

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
__INTTAB_CPU0 = LCF_INTVEC0_START;

RESET = LCF_STARTPTR_NC_CPU0;

MEMORY
{
    dsram0 (w!x): org = 0x70000000, len = 240K
    psram0 (w!x): org = 0x70100000, len = 64K
    
    psram_local (w!x): org = 0xc0000000, len = 64K
	dsram_local (w!x): org = 0xd0000000, len = 240K
    
    pfls0 (rx): org = 0x80000000, len = 4M
    pfls0_nc (rx): org = 0xa0000000, len = 4M
    
    pfls5 (rx): org = 0x81200000, len = 2M
    pfls5_nc (rx): org = 0xA1200000, len = 2M

    
    /*ucb (rx): org = 0xae400000, len = 80K*/
	ucb_bmhd0 (rx): org = 0xae404800, len = 2K
	ucb_bmhd1 (rx): org = 0xae405000, len = 2K
    ucb_bmhd2 (rx): org = 0xae405800, len = 2K
	ucb_bmhd3 (rx): org = 0xae406000, len = 2K
	ucb_usercfg_org(rx): org = 0xae408800, len = 2K
	ucb_usercfg_cpy(rx): org = 0xae409000, len = 2K
    
    cpu0_dlmu (w!x): org = 0x90000000, len = 512K
    cpu0_dlmu_nc (w!x): org = 0xb0000000, len = 512K
    
    lmuram (w!x): org = 0x90400000, len = 5M
    lmuram_nc (w!x): org = 0xb0400000, len = 5M

    ppu_csm (w!x): org = 0x92080000, len = 512k
    ppu_csm_nc (w!x): org = 0xb2080000, len = 512k

}

/* map cached and non cached addresses */
REGION_MIRROR("pfls0", "pfls0_nc")
REGION_MIRROR("pfls5", "pfls5_nc")
REGION_MIRROR("cpu0_dlmu", "cpu0_dlmu_nc")
REGION_MIRROR("lmuram", "lmuram_nc")
REGION_MIRROR("ppu_csm", "ppu_csm_nc")

/*Un comment one of the below statement groups to enable CpuX DMI RAM to hold global variables*/
REGION_ALIAS( default_ram , dsram0)
REGION_ALIAS( default_rom , pfls0)

    /*Fixed memory Allocations for _START*/
    
    SECTIONS
    {
		.start_tc0 (LCF_STARTPTR_NC_CPU0) : { KEEP (*(.start)); } > pfls0_nc
		.interface_const (0x80000020) : { __IF_CONST = .; KEEP (*(.interface_const)); } > pfls0
		.traptab_tc0 (LCF_TRAPVEC0_START) : { PROVIDE(__TRAPTAB_CPU0 = .); KEEP (*(.traptab_cpu0)); } > pfls0
		PROVIDE(__IF_CONST = 0x80000020);
		PROVIDE(__START0 = LCF_STARTPTR_NC_CPU0);
	        PROVIDE(__START1 = LCF_STARTPTR_NC_CPU1);
		PROVIDE(__START2 = LCF_STARTPTR_NC_CPU2);
		PROVIDE(__START3 = LCF_STARTPTR_NC_CPU3);
		PROVIDE(__START4 = LCF_STARTPTR_NC_CPU4);
                PROVIDE(__START5 = LCF_STARTPTR_NC_CPU5);

    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU0 = 0); /* Not used */
    }                     

    /*Fixed memory Allocations for BMHD*/
    SECTIONS
    {
        .bmhd_0_org (0xae404800) : { KEEP (*(.bmhd_0_orig)); } > ucb_bmhd0
        .bmhd_1_org (0xae405000) : { KEEP (*(.bmhd_1_orig)); } > ucb_bmhd1
        .bmhd_2_org (0xae405800) : { KEEP (*(.bmhd_2_orig)); } > ucb_bmhd2
        .bmhd_3_org (0xae406000) : { KEEP (*(.bmhd_3_orig)); } > ucb_bmhd3
        .usercfg_0_org (0xae408800) : { KEEP (*(.usercfg_0_orig)); } > ucb_usercfg_org
        .usercfg_0_cpy (0xae409000) : { KEEP (*(.usercfg_0_copy)); } > ucb_usercfg_cpy
		
    }
    /*Near Absolute Addressable Data Sections*/
    SECTIONS
    {
        .CPU0.zdata (LCF_DSPR0_START):
        {
            *Ifx_Ssw_Tc0.* (.zdata) *Ifx_Ssw_Tc0.* (.zdata.*)
            *Cpu0_Main.* (.zdata) *Cpu0_Main.* (.zdata.*)
            *(.zdata_cpu0) *(.zdata_cpu0.*)
            . = ALIGN(2);
        } > dsram0 AT> default_rom
        
        .CPU0.zbss (NOLOAD): ALIGN(4)
        {
            *Ifx_Ssw_Tc0.* (.zbss) *Ifx_Ssw_Tc0.* (.zbss.*)
            *Cpu0_Main.* (.zbss) *Cpu0_Main.* (.zbss.*)
            *(.zbss_cpu0)*(.zbss_cpu0.*)

        } > dsram0
    }
    
    /*Near Absolute Data, selectable by toolchain*/
    SECTIONS
    {
        .zdata_powerOn : ALIGN(4) 
        {
            *(.zdata.dsprPowerOnInit.cpu0.32bit)
            *(.zdata.dsprPowerOnInit.cpu0.16bit)
            *(.zdata.dsprPowerOnInit.cpu0.8bit)
            . = ALIGN(2);
        } > default_ram AT> default_rom
        
        .zdata : ALIGN(4) 
        {
            *(.zdata.dsprInit.cpu0.32bit)
            *(.zdata.dsprInit.cpu0.16bit)
            *(.zdata.dsprInit.cpu0.8bit)
            *(.zdata) *(.zdata.*)
            *(.gnu.linkonce.z.*)
            . = ALIGN(2);
        } > default_ram AT> default_rom
        
        .zbss_powerOn (NOLOAD) : ALIGN(4)
        {
            *(.zbss.dsprPowerOnClear.cpu0.32bit)
            *(.zbss.dsprPowerOnClear.cpu0.16bit)
            *(.zbss.dsprPowerOnClear.cpu0.8bit)
        } > default_ram
        
        .zbss_noClear (NOLOAD) : ALIGN(4)
        {
            *(.zbss.dsprNoInit.cpu0.32bit)
            *(.zbss.dsprNoInit.cpu0.16bit)
            *(.zbss.dsprNoInit.cpu0.8bit)
        } > default_ram
        
        .zbss (NOLOAD) : ALIGN(4)
        {
            *(.zbss.dsprClearOnInit.cpu0.32bit)
            *(.zbss.dsprClearOnInit.cpu0.16bit)
            *(.zbss.dsprClearOnInit.cpu0.8bit)
            *(.zbss) *(.zbss.*)
            *(.bbss) *(.bbss.*)
            *(.gnu.linkonce.zb.*)
        } > default_ram
    }

/*Near Absolute Const, selectable with patterns and user defined sections*/
    SECTIONS
    {
        /*Cpu0_dlmu also is the segment start, all the near lmu data shll be located here*/
        .lmuzdata : ALIGN(4)
        {
            *(.zlmudata) *(.zlmudata.*)
            . = ALIGN(2);
        } > cpu0_dlmu AT> default_rom
        
        .zbss (NOLOAD) : ALIGN(4)
        {
            *(.zlmubss)
            *(.zlmubss.*)
        } > cpu0_dlmu
    }
    
    /*Near Absolute Const, selectable with patterns and user defined sections*/
    SECTIONS
    {
        .zrodata : ALIGN(4)
        {
        *Ifx_Ssw_Tc?.* (.zrodata) *Ifx_Ssw_Tc?.* (.zrodata.*)
        *Cpu?_Main.* (.zrodata) *Cpu?_Main.* (.zrodata.*)
        *(.zrodata_cpu?) *(.zrodata_cpu?.*)		
    
            *(.zrodata.const.cpu0.32bit)
            *(.zrodata.const.cpu0.16bit)
            *(.zrodata.const.cpu0.8bit)
            *(.zrodata.config.cpu0.32bit)
            *(.zrodata.config.cpu0.16bit)
            *(.zrodata.config.cpu0.8bit)
            *(.zrodata) *(.zrodata.*)
        } > pfls0
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
    } > lmuram AT> default_rom
    
    .sbss4 : ALIGN(4)
    {
        *(.bss_a9) *(.bss_a9.*)
        *(.a9sbss) *(.a9sbss.*)
    } > lmuram
    
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
    /*DSRAM0 Sections*/
    .CPU0.data : ALIGN(4)
    {
        *Ifx_Ssw_Tc0.* (.data) *Ifx_Ssw_Tc0.* (.data.*)
        *Cpu0_Main.* (.data) *Cpu0_Main.* (.data.*)
        *(.data_cpu0) *(.data_cpu0.*)
        . = ALIGN(2);
    } > dsram0 AT> default_rom
    
    .CPU0.bss (NOLOAD): ALIGN(4)
    {
        *Ifx_Ssw_Tc0.* (.bss) *Ifx_Ssw_Tc0.* (.bss.*)
        *Cpu0_Main.* (.bss) *Cpu0_Main.* (.bss.*)
        *(.bss_cpu0) *(.bss_cpu0.*)

    } > dsram0
    
    /*DLMU0 Sections*/
    .CPU0.lmudata : ALIGN(4) 
    {
         *(.lmudata_cpu0) *(.lmudata_cpu0.*)
        . = ALIGN(2);
    } > cpu0_dlmu AT> default_rom
    
    .CPU0.lmubss (NOLOAD) : ALIGN(4) 
    {
        *(.lmubss_cpu0) *(.lmubss_cpu0.*)   
    } > cpu0_dlmu
}

/*Far Data Sections, selectable by toolchain*/
SECTIONS
{
    .data : ALIGN(4)
    {
        *(.data.farDsprInit.cpu0.32bit)
        *(.data.farDsprInit.cpu0.16bit)
        *(.data.farDsprInit.cpu0.8bit)
        *(.data) *(.data.*)
        *(.gnu.linkonce.d.*)
        . = ALIGN(2);
    } > default_ram AT> default_rom
	
	.bss_noClear (NOLOAD) : ALIGN(4)
    {
        *(.bss.farDsprNoInit.cpu0.32bit)
        *(.bss.farDsprNoInit.cpu0.16bit)
        *(.bss.farDsprNoInit.cpu0.8bit)
    } > default_ram
	
    
    .bss (NOLOAD) : ALIGN(4)
    {
        *(.bss.farDsprClearOnInit.cpu0.32bit)
        *(.bss.farDsprClearOnInit.cpu0.16bit)
        *(.bss.farDsprClearOnInit.cpu0.8bit)
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
    } > cpu0_dlmu AT> default_rom
    
    .lmubss : ALIGN(4) 
    {
        *(.lmubss) *(.lmubss.*)
        *(.uncached.lmubss) *(.uncached.lmubss.*)
    } > cpu0_dlmu
    
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
        .CPU0.ustack (LCF_DSPR0_START + LCF_USTACK0_OFFSET)(NOLOAD):
        { PROVIDE(__USTACK0_END = .);    . = . + LCF_USTACK0_SIZE;    PROVIDE(__USTACK0 = .); } > dsram0
        
        .CPU0.istack (LCF_DSPR0_START + LCF_ISTACK0_OFFSET)(NOLOAD):
        { PROVIDE(__ISTACK0_END = .);    . = . + LCF_ISTACK0_SIZE;    PROVIDE(__ISTACK0 = .); } > dsram0
        
        .CPU0.csa (LCF_DSPR0_START + LCF_CSA0_OFFSET)(NOLOAD):
        { PROVIDE(__CSA0 = .);    . = . + LCF_CSA0_SIZE;    PROVIDE(__CSA0_END = .); } > dsram0
    }

/*Far Const Sections, selectable with patterns and user defined sections*/
SECTIONS
{
    .CPU0.rodata : ALIGN(4) 
    {
        *Ifx_Ssw_Tc0.* (.rodata) *Ifx_Ssw_Tc0.* (.rodata.*)
        *Cpu0_Main.* (.rodata) *Cpu0_Main.* (.rodata.*)
		*(.rodata_cpu0) *(.rodata_cpu0.*)
    } > pfls0
}

/*Far Const Sections, selectable by toolchain*/
SECTIONS
{
    .rodata : 
    {
        *(.rodata.farConst.cpu0.32bit)
        *(.rodata.farConst.cpu0.16bit)
        *(.rodata.farConst.cpu0.8bit)
		*(.rodata) *(.rodata.*)
    *(.gnu.linkonce.r.*)
    /*
     * Create the clear and copy tables that tell the startup code
     * which memory areas to clear and to copy, respectively.
     */
    . = ALIGN(4) ;
    PROVIDE(__clear_table = .);
    LONG(0 + ADDR(.CPU0.zbss));       LONG(SIZEOF(.CPU0.zbss));
    LONG(0 + ADDR(.CPU0.bss));        LONG(SIZEOF(.CPU0.bss));
    LONG(0 + ADDR(.CPU0.lmubss));     LONG(SIZEOF(.CPU0.lmubss));
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
    LONG(LOADADDR(.CPU0.zdata));      LONG(0 + ADDR(.CPU0.zdata));      LONG(SIZEOF(.CPU0.zdata));
    LONG(LOADADDR(.CPU0.data));       LONG(0 + ADDR(.CPU0.data));       LONG(SIZEOF(.CPU0.data));
    LONG(LOADADDR(.CPU0.lmudata));    LONG(0 + ADDR(.CPU0.lmudata));    LONG(SIZEOF(.CPU0.lmudata));
    LONG(LOADADDR(.zdata));           LONG(0 + ADDR(.zdata));           LONG(SIZEOF(.zdata));
    LONG(LOADADDR(.sdata));           LONG(0 + ADDR(.sdata));           LONG(SIZEOF(.sdata));
    LONG(LOADADDR(.data));            LONG(0 + ADDR(.data));            LONG(SIZEOF(.data));
    LONG(LOADADDR(.lmudata));         LONG(0 + ADDR(.lmudata));         LONG(SIZEOF(.lmudata));
    LONG(LOADADDR(.sdata4));          LONG(0 + ADDR(.sdata4));          LONG(SIZEOF(.sdata4));
    LONG(LOADADDR(.CPU0.psram_text)); LONG(0 + ADDR(.CPU0.psram_text)); LONG(SIZEOF(.CPU0.psram_text));
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
    .CPU0.text : ALIGN(4) 
    {
        *Ifx_Ssw_Tc0.*(.text) *Ifx_Ssw_Tc0.*(.text.*)
        *Cpu0_Main.*(.text) *Cpu0_Main.*(.text.*)
        *(.text_cpu0) *(.text_cpu0.*)
        . = ALIGN(4);
    } > pfls0
	
    /* VDK TSPI Functions */
    .tspi :
     {
        *(.tspi)
        . = ALIGN(8);
    } > pfls0
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
    
    } > pfls0
    
    .fini :
    {
        PROVIDE(__fini_start = .);
        KEEP(*(.fini))
        KEEP(*(.fini*))
        PROVIDE(__fini_end = .);
        . = ALIGN(8);
    } > pfls0
    
    /*
     * Code executed before calling main extra section for C++ constructor init
     *  -------------------------End-----------------------------------------
     */
    .CPU0.psram_text  : ALIGN(4) 
    {
        *(.psram_text_cpu0) *(.psram_text_cpu0.*)
        *(.cpu0_psram) *(.cpu0_psram.*)
        . = ALIGN(4);
    } > psram0 AT> pfls0
}

/*Code Sections, selectable by toolchain*/

SECTIONS
{
    .text : 
    {
        *(.text.fast.pfls.cpu0)
        *(.text.slow.pfls.cpu0)
        *(.text.5ms.pfls.cpu0)
        *(.text.10ms.pfls.cpu0)
        *(.text.callout.pfls.cpu0)
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
        /*CPU0 Interrupt Vector Table*/
        .inttab_tc0_000 (__INTTAB_CPU0 + 0x0000) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_0  )); } > pfls0
        .inttab_tc0_001 (__INTTAB_CPU0 + 0x0020) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_1  )); } > pfls0
        .inttab_tc0_002 (__INTTAB_CPU0 + 0x0040) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_2  )); } > pfls0
        .inttab_tc0_003 (__INTTAB_CPU0 + 0x0060) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_3  )); } > pfls0
        .inttab_tc0_004 (__INTTAB_CPU0 + 0x0080) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_4  )); } > pfls0
        .inttab_tc0_005 (__INTTAB_CPU0 + 0x00A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_5  )); } > pfls0
        .inttab_tc0_006 (__INTTAB_CPU0 + 0x00C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_6  )); } > pfls0
        .inttab_tc0_007 (__INTTAB_CPU0 + 0x00E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_7  )); } > pfls0
        .inttab_tc0_008 (__INTTAB_CPU0 + 0x0100) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_8  )); } > pfls0
        .inttab_tc0_009 (__INTTAB_CPU0 + 0x0120) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_9  )); } > pfls0
        .inttab_tc0_00A (__INTTAB_CPU0 + 0x0140) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_10 )); } > pfls0
        .inttab_tc0_00B (__INTTAB_CPU0 + 0x0160) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_11 )); } > pfls0
        .inttab_tc0_00C (__INTTAB_CPU0 + 0x0180) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_12 )); } > pfls0
        .inttab_tc0_00D (__INTTAB_CPU0 + 0x01A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_13 )); } > pfls0
        .inttab_tc0_00E (__INTTAB_CPU0 + 0x01C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_14 )); } > pfls0
        .inttab_tc0_00F (__INTTAB_CPU0 + 0x01E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_15 )); } > pfls0
        .inttab_tc0_010 (__INTTAB_CPU0 + 0x0200) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_16 )); } > pfls0
        .inttab_tc0_011 (__INTTAB_CPU0 + 0x0220) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_17 )); } > pfls0
        .inttab_tc0_012 (__INTTAB_CPU0 + 0x0240) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_18 )); } > pfls0
        .inttab_tc0_013 (__INTTAB_CPU0 + 0x0260) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_19 )); } > pfls0
        .inttab_tc0_014 (__INTTAB_CPU0 + 0x0280) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_20 )); } > pfls0
        .inttab_tc0_015 (__INTTAB_CPU0 + 0x02A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_21 )); } > pfls0
        .inttab_tc0_016 (__INTTAB_CPU0 + 0x02C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_22 )); } > pfls0
        .inttab_tc0_017 (__INTTAB_CPU0 + 0x02E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_23 )); } > pfls0
        .inttab_tc0_018 (__INTTAB_CPU0 + 0x0300) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_24 )); } > pfls0
        .inttab_tc0_019 (__INTTAB_CPU0 + 0x0320) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_25 )); } > pfls0
        .inttab_tc0_01A (__INTTAB_CPU0 + 0x0340) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_26 )); } > pfls0
        .inttab_tc0_01B (__INTTAB_CPU0 + 0x0360) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_27 )); } > pfls0
        .inttab_tc0_01C (__INTTAB_CPU0 + 0x0380) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_28 )); } > pfls0
        .inttab_tc0_01D (__INTTAB_CPU0 + 0x03A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_29 )); } > pfls0
        .inttab_tc0_01E (__INTTAB_CPU0 + 0x03C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_30 )); } > pfls0
        .inttab_tc0_01F (__INTTAB_CPU0 + 0x03E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_31 )); } > pfls0
        .inttab_tc0_020 (__INTTAB_CPU0 + 0x0400) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_32 )); } > pfls0
        .inttab_tc0_021 (__INTTAB_CPU0 + 0x0420) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_33 )); } > pfls0
        .inttab_tc0_022 (__INTTAB_CPU0 + 0x0440) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_34 )); } > pfls0
        .inttab_tc0_023 (__INTTAB_CPU0 + 0x0460) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_35 )); } > pfls0
        .inttab_tc0_024 (__INTTAB_CPU0 + 0x0480) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_36 )); } > pfls0
        .inttab_tc0_025 (__INTTAB_CPU0 + 0x04A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_37 )); } > pfls0
        .inttab_tc0_026 (__INTTAB_CPU0 + 0x04C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_38 )); } > pfls0
        .inttab_tc0_027 (__INTTAB_CPU0 + 0x04E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_39 )); } > pfls0
        .inttab_tc0_028 (__INTTAB_CPU0 + 0x0500) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_40 )); } > pfls0
        .inttab_tc0_029 (__INTTAB_CPU0 + 0x0520) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_41 )); } > pfls0
        .inttab_tc0_02A (__INTTAB_CPU0 + 0x0540) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_42 )); } > pfls0
        .inttab_tc0_02B (__INTTAB_CPU0 + 0x0560) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_43 )); } > pfls0
        .inttab_tc0_02C (__INTTAB_CPU0 + 0x0580) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_44 )); } > pfls0
        .inttab_tc0_02D (__INTTAB_CPU0 + 0x05A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_45 )); } > pfls0
        .inttab_tc0_02E (__INTTAB_CPU0 + 0x05C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_46 )); } > pfls0
        .inttab_tc0_02F (__INTTAB_CPU0 + 0x05E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_47 )); } > pfls0
        .inttab_tc0_030 (__INTTAB_CPU0 + 0x0600) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_48 )); } > pfls0
        .inttab_tc0_031 (__INTTAB_CPU0 + 0x0620) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_49 )); } > pfls0
        .inttab_tc0_032 (__INTTAB_CPU0 + 0x0640) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_50 )); } > pfls0
        .inttab_tc0_033 (__INTTAB_CPU0 + 0x0660) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_51 )); } > pfls0
        .inttab_tc0_034 (__INTTAB_CPU0 + 0x0680) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_52 )); } > pfls0
        .inttab_tc0_035 (__INTTAB_CPU0 + 0x06A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_53 )); } > pfls0
        .inttab_tc0_036 (__INTTAB_CPU0 + 0x06C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_54 )); } > pfls0
        .inttab_tc0_037 (__INTTAB_CPU0 + 0x06E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_55 )); } > pfls0
        .inttab_tc0_038 (__INTTAB_CPU0 + 0x0700) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_56 )); } > pfls0
        .inttab_tc0_039 (__INTTAB_CPU0 + 0x0720) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_57 )); } > pfls0
        .inttab_tc0_03A (__INTTAB_CPU0 + 0x0740) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_58 )); } > pfls0
        .inttab_tc0_03B (__INTTAB_CPU0 + 0x0760) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_59 )); } > pfls0
        .inttab_tc0_03C (__INTTAB_CPU0 + 0x0780) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_60 )); } > pfls0
        .inttab_tc0_03D (__INTTAB_CPU0 + 0x07A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_61 )); } > pfls0
        .inttab_tc0_03E (__INTTAB_CPU0 + 0x07C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_62 )); } > pfls0
        .inttab_tc0_03F (__INTTAB_CPU0 + 0x07E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_63 )); } > pfls0
        .inttab_tc0_040 (__INTTAB_CPU0 + 0x0800) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_64 )); } > pfls0
        .inttab_tc0_041 (__INTTAB_CPU0 + 0x0820) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_65 )); } > pfls0
        .inttab_tc0_042 (__INTTAB_CPU0 + 0x0840) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_66 )); } > pfls0
        .inttab_tc0_043 (__INTTAB_CPU0 + 0x0860) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_67 )); } > pfls0
        .inttab_tc0_044 (__INTTAB_CPU0 + 0x0880) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_68 )); } > pfls0
        .inttab_tc0_045 (__INTTAB_CPU0 + 0x08A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_69 )); } > pfls0
        .inttab_tc0_046 (__INTTAB_CPU0 + 0x08C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_70 )); } > pfls0
        .inttab_tc0_047 (__INTTAB_CPU0 + 0x08E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_71 )); } > pfls0
        .inttab_tc0_048 (__INTTAB_CPU0 + 0x0900) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_72 )); } > pfls0
        .inttab_tc0_049 (__INTTAB_CPU0 + 0x0920) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_73 )); } > pfls0
        .inttab_tc0_04A (__INTTAB_CPU0 + 0x0940) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_74 )); } > pfls0
        .inttab_tc0_04B (__INTTAB_CPU0 + 0x0960) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_75 )); } > pfls0
        .inttab_tc0_04C (__INTTAB_CPU0 + 0x0980) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_76 )); } > pfls0
        .inttab_tc0_04D (__INTTAB_CPU0 + 0x09A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_77 )); } > pfls0
        .inttab_tc0_04E (__INTTAB_CPU0 + 0x09C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_78 )); } > pfls0
        .inttab_tc0_04F (__INTTAB_CPU0 + 0x09E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_79 )); } > pfls0
        .inttab_tc0_050 (__INTTAB_CPU0 + 0x0A00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_80 )); } > pfls0
        .inttab_tc0_051 (__INTTAB_CPU0 + 0x0A20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_81 )); } > pfls0
        .inttab_tc0_052 (__INTTAB_CPU0 + 0x0A40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_82 )); } > pfls0
        .inttab_tc0_053 (__INTTAB_CPU0 + 0x0A60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_83 )); } > pfls0
        .inttab_tc0_054 (__INTTAB_CPU0 + 0x0A80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_84 )); } > pfls0
        .inttab_tc0_055 (__INTTAB_CPU0 + 0x0AA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_85 )); } > pfls0
        .inttab_tc0_056 (__INTTAB_CPU0 + 0x0AC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_86 )); } > pfls0
        .inttab_tc0_057 (__INTTAB_CPU0 + 0x0AE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_87 )); } > pfls0
        .inttab_tc0_058 (__INTTAB_CPU0 + 0x0B00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_88 )); } > pfls0
        .inttab_tc0_059 (__INTTAB_CPU0 + 0x0B20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_89 )); } > pfls0
        .inttab_tc0_05A (__INTTAB_CPU0 + 0x0B40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_90 )); } > pfls0
        .inttab_tc0_05B (__INTTAB_CPU0 + 0x0B60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_91 )); } > pfls0
        .inttab_tc0_05C (__INTTAB_CPU0 + 0x0B80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_92 )); } > pfls0
        .inttab_tc0_05D (__INTTAB_CPU0 + 0x0BA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_93 )); } > pfls0
        .inttab_tc0_05E (__INTTAB_CPU0 + 0x0BC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_94 )); } > pfls0
        .inttab_tc0_05F (__INTTAB_CPU0 + 0x0BE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_95 )); } > pfls0
        .inttab_tc0_060 (__INTTAB_CPU0 + 0x0C00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_96 )); } > pfls0
        .inttab_tc0_061 (__INTTAB_CPU0 + 0x0C20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_97 )); } > pfls0
        .inttab_tc0_062 (__INTTAB_CPU0 + 0x0C40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_98 )); } > pfls0
        .inttab_tc0_063 (__INTTAB_CPU0 + 0x0C60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_99 )); } > pfls0
        .inttab_tc0_064 (__INTTAB_CPU0 + 0x0C80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_100)); } > pfls0
        .inttab_tc0_065 (__INTTAB_CPU0 + 0x0CA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_101)); } > pfls0
        .inttab_tc0_066 (__INTTAB_CPU0 + 0x0CC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_102)); } > pfls0
        .inttab_tc0_067 (__INTTAB_CPU0 + 0x0CE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_103)); } > pfls0
        .inttab_tc0_068 (__INTTAB_CPU0 + 0x0D00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_104)); } > pfls0
        .inttab_tc0_069 (__INTTAB_CPU0 + 0x0D20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_105)); } > pfls0
        .inttab_tc0_06A (__INTTAB_CPU0 + 0x0D40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_106)); } > pfls0
        .inttab_tc0_06B (__INTTAB_CPU0 + 0x0D60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_107)); } > pfls0
        .inttab_tc0_06C (__INTTAB_CPU0 + 0x0D80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_108)); } > pfls0
        .inttab_tc0_06D (__INTTAB_CPU0 + 0x0DA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_109)); } > pfls0
        .inttab_tc0_06E (__INTTAB_CPU0 + 0x0DC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_110)); } > pfls0
        .inttab_tc0_06F (__INTTAB_CPU0 + 0x0DE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_111)); } > pfls0
        .inttab_tc0_070 (__INTTAB_CPU0 + 0x0E00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_112)); } > pfls0
        .inttab_tc0_071 (__INTTAB_CPU0 + 0x0E20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_113)); } > pfls0
        .inttab_tc0_072 (__INTTAB_CPU0 + 0x0E40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_114)); } > pfls0
        .inttab_tc0_073 (__INTTAB_CPU0 + 0x0E60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_115)); } > pfls0
        .inttab_tc0_074 (__INTTAB_CPU0 + 0x0E80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_116)); } > pfls0
        .inttab_tc0_075 (__INTTAB_CPU0 + 0x0EA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_117)); } > pfls0
        .inttab_tc0_076 (__INTTAB_CPU0 + 0x0EC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_118)); } > pfls0
        .inttab_tc0_077 (__INTTAB_CPU0 + 0x0EE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_119)); } > pfls0
        .inttab_tc0_078 (__INTTAB_CPU0 + 0x0F00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_120)); } > pfls0
        .inttab_tc0_079 (__INTTAB_CPU0 + 0x0F20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_121)); } > pfls0
        .inttab_tc0_07A (__INTTAB_CPU0 + 0x0F40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_122)); } > pfls0
        .inttab_tc0_07B (__INTTAB_CPU0 + 0x0F60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_123)); } > pfls0
        .inttab_tc0_07C (__INTTAB_CPU0 + 0x0F80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_124)); } > pfls0
        .inttab_tc0_07D (__INTTAB_CPU0 + 0x0FA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_125)); } > pfls0
        .inttab_tc0_07E (__INTTAB_CPU0 + 0x0FC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_126)); } > pfls0
        .inttab_tc0_07F (__INTTAB_CPU0 + 0x0FE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_127)); } > pfls0
        .inttab_tc0_080 (__INTTAB_CPU0 + 0x1000) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_128)); } > pfls0
        .inttab_tc0_081 (__INTTAB_CPU0 + 0x1020) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_129)); } > pfls0
        .inttab_tc0_082 (__INTTAB_CPU0 + 0x1040) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_130)); } > pfls0
        .inttab_tc0_083 (__INTTAB_CPU0 + 0x1060) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_131)); } > pfls0
        .inttab_tc0_084 (__INTTAB_CPU0 + 0x1080) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_132)); } > pfls0
        .inttab_tc0_085 (__INTTAB_CPU0 + 0x10A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_133)); } > pfls0
        .inttab_tc0_086 (__INTTAB_CPU0 + 0x10C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_134)); } > pfls0
        .inttab_tc0_087 (__INTTAB_CPU0 + 0x10E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_135)); } > pfls0
        .inttab_tc0_088 (__INTTAB_CPU0 + 0x1100) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_136)); } > pfls0
        .inttab_tc0_089 (__INTTAB_CPU0 + 0x1120) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_137)); } > pfls0
        .inttab_tc0_08A (__INTTAB_CPU0 + 0x1140) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_138)); } > pfls0
        .inttab_tc0_08B (__INTTAB_CPU0 + 0x1160) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_139)); } > pfls0
        .inttab_tc0_08C (__INTTAB_CPU0 + 0x1180) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_140)); } > pfls0
        .inttab_tc0_08D (__INTTAB_CPU0 + 0x11A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_141)); } > pfls0
        .inttab_tc0_08E (__INTTAB_CPU0 + 0x11C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_142)); } > pfls0
        .inttab_tc0_08F (__INTTAB_CPU0 + 0x11E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_143)); } > pfls0
        .inttab_tc0_090 (__INTTAB_CPU0 + 0x1200) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_144)); } > pfls0
        .inttab_tc0_091 (__INTTAB_CPU0 + 0x1220) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_145)); } > pfls0
        .inttab_tc0_092 (__INTTAB_CPU0 + 0x1240) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_146)); } > pfls0
        .inttab_tc0_093 (__INTTAB_CPU0 + 0x1260) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_147)); } > pfls0
        .inttab_tc0_094 (__INTTAB_CPU0 + 0x1280) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_148)); } > pfls0
        .inttab_tc0_095 (__INTTAB_CPU0 + 0x12A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_149)); } > pfls0
        .inttab_tc0_096 (__INTTAB_CPU0 + 0x12C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_150)); } > pfls0
        .inttab_tc0_097 (__INTTAB_CPU0 + 0x12E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_151)); } > pfls0
        .inttab_tc0_098 (__INTTAB_CPU0 + 0x1300) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_152)); } > pfls0
        .inttab_tc0_099 (__INTTAB_CPU0 + 0x1320) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_153)); } > pfls0
        .inttab_tc0_09A (__INTTAB_CPU0 + 0x1340) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_154)); } > pfls0
        .inttab_tc0_09B (__INTTAB_CPU0 + 0x1360) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_155)); } > pfls0
        .inttab_tc0_09C (__INTTAB_CPU0 + 0x1380) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_156)); } > pfls0
        .inttab_tc0_09D (__INTTAB_CPU0 + 0x13A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_157)); } > pfls0
        .inttab_tc0_09E (__INTTAB_CPU0 + 0x13C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_158)); } > pfls0
        .inttab_tc0_09F (__INTTAB_CPU0 + 0x13E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_159)); } > pfls0
        .inttab_tc0_0A0 (__INTTAB_CPU0 + 0x1400) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_160)); } > pfls0
        .inttab_tc0_0A1 (__INTTAB_CPU0 + 0x1420) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_161)); } > pfls0
        .inttab_tc0_0A2 (__INTTAB_CPU0 + 0x1440) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_162)); } > pfls0
        .inttab_tc0_0A3 (__INTTAB_CPU0 + 0x1460) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_163)); } > pfls0
        .inttab_tc0_0A4 (__INTTAB_CPU0 + 0x1480) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_164)); } > pfls0
        .inttab_tc0_0A5 (__INTTAB_CPU0 + 0x14A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_165)); } > pfls0
        .inttab_tc0_0A6 (__INTTAB_CPU0 + 0x14C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_166)); } > pfls0
        .inttab_tc0_0A7 (__INTTAB_CPU0 + 0x14E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_167)); } > pfls0
        .inttab_tc0_0A8 (__INTTAB_CPU0 + 0x1500) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_168)); } > pfls0
        .inttab_tc0_0A9 (__INTTAB_CPU0 + 0x1520) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_169)); } > pfls0
        .inttab_tc0_0AA (__INTTAB_CPU0 + 0x1540) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_170)); } > pfls0
        .inttab_tc0_0AB (__INTTAB_CPU0 + 0x1560) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_171)); } > pfls0
        .inttab_tc0_0AC (__INTTAB_CPU0 + 0x1580) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_172)); } > pfls0
        .inttab_tc0_0AD (__INTTAB_CPU0 + 0x15A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_173)); } > pfls0
        .inttab_tc0_0AE (__INTTAB_CPU0 + 0x15C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_174)); } > pfls0
        .inttab_tc0_0AF (__INTTAB_CPU0 + 0x15E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_175)); } > pfls0
        .inttab_tc0_0B0 (__INTTAB_CPU0 + 0x1600) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_176)); } > pfls0
        .inttab_tc0_0B1 (__INTTAB_CPU0 + 0x1620) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_177)); } > pfls0
        .inttab_tc0_0B2 (__INTTAB_CPU0 + 0x1640) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_178)); } > pfls0
        .inttab_tc0_0B3 (__INTTAB_CPU0 + 0x1660) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_179)); } > pfls0
        .inttab_tc0_0B4 (__INTTAB_CPU0 + 0x1680) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_180)); } > pfls0
        .inttab_tc0_0B5 (__INTTAB_CPU0 + 0x16A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_181)); } > pfls0
        .inttab_tc0_0B6 (__INTTAB_CPU0 + 0x16C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_182)); } > pfls0
        .inttab_tc0_0B7 (__INTTAB_CPU0 + 0x16E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_183)); } > pfls0
        .inttab_tc0_0B8 (__INTTAB_CPU0 + 0x1700) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_184)); } > pfls0
        .inttab_tc0_0B9 (__INTTAB_CPU0 + 0x1720) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_185)); } > pfls0
        .inttab_tc0_0BA (__INTTAB_CPU0 + 0x1740) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_186)); } > pfls0
        .inttab_tc0_0BB (__INTTAB_CPU0 + 0x1760) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_187)); } > pfls0
        .inttab_tc0_0BC (__INTTAB_CPU0 + 0x1780) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_188)); } > pfls0
        .inttab_tc0_0BD (__INTTAB_CPU0 + 0x17A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_189)); } > pfls0
        .inttab_tc0_0BE (__INTTAB_CPU0 + 0x17C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_190)); } > pfls0
        .inttab_tc0_0BF (__INTTAB_CPU0 + 0x17E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_191)); } > pfls0
        .inttab_tc0_0C0 (__INTTAB_CPU0 + 0x1800) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_192)); } > pfls0
        .inttab_tc0_0C1 (__INTTAB_CPU0 + 0x1820) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_193)); } > pfls0
        .inttab_tc0_0C2 (__INTTAB_CPU0 + 0x1840) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_194)); } > pfls0
        .inttab_tc0_0C3 (__INTTAB_CPU0 + 0x1860) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_195)); } > pfls0
        .inttab_tc0_0C4 (__INTTAB_CPU0 + 0x1880) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_196)); } > pfls0
        .inttab_tc0_0C5 (__INTTAB_CPU0 + 0x18A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_197)); } > pfls0
        .inttab_tc0_0C6 (__INTTAB_CPU0 + 0x18C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_198)); } > pfls0
        .inttab_tc0_0C7 (__INTTAB_CPU0 + 0x18E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_199)); } > pfls0
        .inttab_tc0_0C8 (__INTTAB_CPU0 + 0x1900) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_200)); } > pfls0
        .inttab_tc0_0C9 (__INTTAB_CPU0 + 0x1920) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_201)); } > pfls0
        .inttab_tc0_0CA (__INTTAB_CPU0 + 0x1940) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_202)); } > pfls0
        .inttab_tc0_0CB (__INTTAB_CPU0 + 0x1960) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_203)); } > pfls0
        .inttab_tc0_0CC (__INTTAB_CPU0 + 0x1980) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_204)); } > pfls0
        .inttab_tc0_0CD (__INTTAB_CPU0 + 0x19A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_205)); } > pfls0
        .inttab_tc0_0CE (__INTTAB_CPU0 + 0x19C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_206)); } > pfls0
        .inttab_tc0_0CF (__INTTAB_CPU0 + 0x19E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_207)); } > pfls0
        .inttab_tc0_0D0 (__INTTAB_CPU0 + 0x1A00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_208)); } > pfls0
        .inttab_tc0_0D1 (__INTTAB_CPU0 + 0x1A20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_209)); } > pfls0
        .inttab_tc0_0D2 (__INTTAB_CPU0 + 0x1A40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_210)); } > pfls0
        .inttab_tc0_0D3 (__INTTAB_CPU0 + 0x1A60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_211)); } > pfls0
        .inttab_tc0_0D4 (__INTTAB_CPU0 + 0x1A80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_212)); } > pfls0
        .inttab_tc0_0D5 (__INTTAB_CPU0 + 0x1AA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_213)); } > pfls0
        .inttab_tc0_0D6 (__INTTAB_CPU0 + 0x1AC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_214)); } > pfls0
        .inttab_tc0_0D7 (__INTTAB_CPU0 + 0x1AE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_215)); } > pfls0
        .inttab_tc0_0D8 (__INTTAB_CPU0 + 0x1B00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_216)); } > pfls0
        .inttab_tc0_0D9 (__INTTAB_CPU0 + 0x1B20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_217)); } > pfls0
        .inttab_tc0_0DA (__INTTAB_CPU0 + 0x1B40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_218)); } > pfls0
        .inttab_tc0_0DB (__INTTAB_CPU0 + 0x1B60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_219)); } > pfls0
        .inttab_tc0_0DC (__INTTAB_CPU0 + 0x1B80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_220)); } > pfls0
        .inttab_tc0_0DD (__INTTAB_CPU0 + 0x1BA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_221)); } > pfls0
        .inttab_tc0_0DE (__INTTAB_CPU0 + 0x1BC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_222)); } > pfls0
        .inttab_tc0_0DF (__INTTAB_CPU0 + 0x1BE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_223)); } > pfls0
        .inttab_tc0_0E0 (__INTTAB_CPU0 + 0x1C00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_224)); } > pfls0
        .inttab_tc0_0E1 (__INTTAB_CPU0 + 0x1C20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_225)); } > pfls0
        .inttab_tc0_0E2 (__INTTAB_CPU0 + 0x1C40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_226)); } > pfls0
        .inttab_tc0_0E3 (__INTTAB_CPU0 + 0x1C60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_227)); } > pfls0
        .inttab_tc0_0E4 (__INTTAB_CPU0 + 0x1C80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_228)); } > pfls0
        .inttab_tc0_0E5 (__INTTAB_CPU0 + 0x1CA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_229)); } > pfls0
        .inttab_tc0_0E6 (__INTTAB_CPU0 + 0x1CC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_230)); } > pfls0
        .inttab_tc0_0E7 (__INTTAB_CPU0 + 0x1CE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_231)); } > pfls0
        .inttab_tc0_0E8 (__INTTAB_CPU0 + 0x1D00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_232)); } > pfls0
        .inttab_tc0_0E9 (__INTTAB_CPU0 + 0x1D20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_233)); } > pfls0
        .inttab_tc0_0EA (__INTTAB_CPU0 + 0x1D40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_234)); } > pfls0
        .inttab_tc0_0EB (__INTTAB_CPU0 + 0x1D60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_235)); } > pfls0
        .inttab_tc0_0EC (__INTTAB_CPU0 + 0x1D80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_236)); } > pfls0
        .inttab_tc0_0ED (__INTTAB_CPU0 + 0x1DA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_237)); } > pfls0
        .inttab_tc0_0EE (__INTTAB_CPU0 + 0x1DC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_238)); } > pfls0
        .inttab_tc0_0EF (__INTTAB_CPU0 + 0x1DE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_239)); } > pfls0
        .inttab_tc0_0F0 (__INTTAB_CPU0 + 0x1E00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_240)); } > pfls0
        .inttab_tc0_0F1 (__INTTAB_CPU0 + 0x1E20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_241)); } > pfls0
        .inttab_tc0_0F2 (__INTTAB_CPU0 + 0x1E40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_242)); } > pfls0
        .inttab_tc0_0F3 (__INTTAB_CPU0 + 0x1E60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_243)); } > pfls0
        .inttab_tc0_0F4 (__INTTAB_CPU0 + 0x1E80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_244)); } > pfls0
        .inttab_tc0_0F5 (__INTTAB_CPU0 + 0x1EA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_245)); } > pfls0
        .inttab_tc0_0F6 (__INTTAB_CPU0 + 0x1EC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_246)); } > pfls0
        .inttab_tc0_0F7 (__INTTAB_CPU0 + 0x1EE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_247)); } > pfls0
        .inttab_tc0_0F8 (__INTTAB_CPU0 + 0x1F00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_248)); } > pfls0
        .inttab_tc0_0F9 (__INTTAB_CPU0 + 0x1F20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_249)); } > pfls0
        .inttab_tc0_0FA (__INTTAB_CPU0 + 0x1F40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_250)); } > pfls0
        .inttab_tc0_0FB (__INTTAB_CPU0 + 0x1F60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_251)); } > pfls0
        .inttab_tc0_0FC (__INTTAB_CPU0 + 0x1F80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_252)); } > pfls0
        .inttab_tc0_0FD (__INTTAB_CPU0 + 0x1FA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_253)); } > pfls0
        .inttab_tc0_0FE (__INTTAB_CPU0 + 0x1FC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_254)); } > pfls0
        .inttab_tc0_0FF (__INTTAB_CPU0 + 0x1FE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc0_255)); } > pfls0
    }
    

