DEFAULTS {
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

LCF_INTVEC5_START = 0x813FE000 - LCF_PPU_FLASH_SIZE;


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
}

MEMORY
{
    dsram5 : ORIGIN = 0x20000000, LENGTH = 240K
    psram5 : ORIGIN = 0x20100000, LENGTH = 64K

    pfls5 : ORIGIN = 0x81200000, LENGTH = 2M
    pfls5_nc : ORIGIN = 0xA1200000, LENGTH = 2M

    cpu5_dlmu : ORIGIN = 0x90280000, LENGTH= 512K
    cpu5_dlmu_nc : ORIGIN = 0xb0280000, LENGTH = 512K

    lmuram : ORIGIN = 0x90400000, LENGTH = 5M
    lmuram_nc : ORIGIN = 0xb0400000, LENGTH = 5M

    ppu_csm : ORIGIN = 0x92080000, len = 512K
    ppu_csm_nc : ORIGIN = 0xb2080000, len = 512K
}

//
// Program layout for starting in ROM, copying data to RAM,
// and continuing to execute out of ROM.
//
// This defaults to using internal memory.  To use external SRAM too (if
// mpserv_standard.mbs configures it) change the "." for .data to "extsram_mem".

SECTIONS
{
    /* DSRAM Sections */
    /* Near absolute RAM sections */

	.CPU5_zdata ABS ALIGN(4) :
    {
        "Ifx_Ssw_Tc5.*(.zdata)" "Ifx_Ssw_Tc5.*(.zdata.*)"
        "Cpu5_Main.*(.zdata)" "Cpu5_Main.*(.zdata.*)"
        "*(.zdata_cpu5)" "*(.zdata_cpu5.*)"
    } > dsram5
    .CPU5_zbss ABS CLEAR ALIGN(4) :
    {
        "Ifx_Ssw_Tc5.*(.zbss)" "Ifx_Ssw_Tc5.*(.zbss.*)"
        "Cpu5_Main.*(.zbss)" "Cpu5_Main.*(.zbss.*)"
        "*(.zbss_cpu5)" "*(.zbss_cpu5.*)"
    } > .

    /*Un comment one of the below statement groups to enable CpuX DMI RAM to hold global variables*/
    .GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram5
    //.GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram4
    //.GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram3
    //.GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram2
    //.GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram1
    //.GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram0
    .GLOBAL_zbss  ABS CLEAR ALIGN(4) : { "*(.zbss)"  "*(.zbss.*)" } > .

    /* Small addressable RAM sections */
    .GLOBAL_sdata ALIGN(4) :
    {
        PROVIDE(__A0_MEM = .);
        "*(.sdata)" "*(.sdata.*)"
        "*(.data_a0)" "*(.data_a0.*)"
    } > .
    .GLOBAL_sbss CLEAR :
    {
        "*(.sbss)" "*(.sbss.*)"
        "*(.bss_a0)" "*(.bss_a0.*)"
    } > .                  
    PROVIDE(_SMALL_DATA_ = __A0_MEM);
		/* The .fixaddr and .fixtype section contain information needed for PIC and
		   PID modes.  These are currently not used with TriCore. */
		.fixaddr                       : > .
		.fixtype                       : > .

    /* Far addressable RAM sections */
    /* Far addressable CPU specific RAM sections */
	

		 .CPU5_data ALIGN(4) :
			{
				"Ifx_Ssw_Tc5.*(.data)" "Ifx_Ssw_Tc5.*(.data.*)"
				"Cpu5_Main.*(.data)" "Cpu5_Main.*(.data.*)"
				"*(.data_cpu5)" "*(.data_cpu5.*)"
			} > dsram5
			.CPU5_bss CLEAR ALIGN(4) :
			{
				"Ifx_Ssw_Tc5.*(.bss)" "Ifx_Ssw_Tc5.*(.bss.*)"
				"Cpu5_Main.*(.bss)" "Cpu5_Main.*(.bss.*)"
				"*(.bss_cpu5)" "*(.bss_cpu5.*)"
			} > .
		/*Un comment one of the below statement groups to enable CpuX DMI RAM to hold global variables*/
		.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram5
		//.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram4
		//.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram3
		//.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram2
		//.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram1
		//.GLOBAL_data          ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram0
		.GLOBAL_bss  CLEAR    ALIGN(4) : { "*(.bss)" "*(.bss.*)" } > .
		
		/* Reserve space for dynamic allocation */
		.heap                 ALIGN(4) PAD(LCF_HEAP_SIZE) : > .

    /* Stack and CSA defines */
    .CPU5.ustack BIND(LCF_DSPR5_START + LCF_USTACK5_OFFSET) : { __USTACK5_END = . ;. = . + LCF_USTACK5_SIZE; __USTACK5 = . ; } > dsram5
    .CPU5.istack BIND(LCF_DSPR5_START + LCF_ISTACK5_OFFSET) : { __ISTACK5_END = . ;. = . + LCF_ISTACK5_SIZE; __ISTACK5 = . ; } > .
    .CPU5.csa BIND(LCF_DSPR5_START + LCF_CSA5_OFFSET) :       { __CSA5 = . ; . = . + LCF_CSA5_SIZE; __CSA5_END = . ; } > .

    /* PSRAM Sections */
    .CPU5_psram_text ALIGN(2) : { "*(.psram_text_cpu5)" "*(.psram_text_cpu5.*)" "*(.cpu5_psram)" "*(.cpu5_psram.*)" } > psram5

    /DISCARD/ :
    { 
        *(.traptab_cpu0)
        *(.traptab_cpu1)
        *(.traptab_cpu2)
        *(.traptab_cpu3)
        *(.traptab_cpu4)
        *(.interface_const)
    }

    /* Fixed memory Allocations for _START */
    .start_tc5 (LCF_STARTPTR_NC_CPU5) : AT(LCF_STARTPTR_CPU5) { PROVIDE(_start_cpu5 = .); *(.start_cpu5) } > pfls5_nc
    .start_res5 (LCF_STARTPTR_CPU5 + SIZEOF(.start_tc5)) : {} > pfls5
    .traptab_tc5 (LCF_TRAPVEC5_START) : { PROVIDE(__TRAPTAB_CPU5 = .); *(.traptab_cpu5) . = align(32);} > pfls5
    PROVIDE(__START0 = LCF_STARTPTR_NC_CPU0);
    PROVIDE(__START1 = LCF_STARTPTR_NC_CPU1);
    PROVIDE(__START2 = LCF_STARTPTR_NC_CPU2);
    PROVIDE(__START3 = LCF_STARTPTR_NC_CPU3);
    PROVIDE(__START4 = LCF_STARTPTR_NC_CPU4);
    PROVIDE(__START5 = LCF_STARTPTR_NC_CPU5);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU5 = 1);

    /* Near absolute RAM sections */
    .GLOBAL_zrodata ABS   ALIGN(4) : { "Ifx_Ssw_Tc?.*(.zrodata)" "Cpu?_Main.*(.zrodata)" "*(.zrodata)" } > pfls5
	    .CPU5_rodata ALIGN(4) :
    {
        "Ifx_Ssw_Tc5.*(.rodata)" "Ifx_Ssw_Tc5.*(.rodata.*)"
        "Cpu5_Main.*(.rodata)" "Cpu5_Main.*(.rodata.*)"
        "*(.rodata_cpu5)" "*(.rodata_cpu5.*)"
    } > pfls5
    
    /* Small addressable ROM sections */
    /*Un comment one of the below statement groups to enable CpuX FLASHs to hold global constants*/
    .GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls5
    //.GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls4
    //.GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls3
    //.GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls2
    //.GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls1
    //.GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls0
    PROVIDE(_LITERAL_DATA_ = __A1_MEM);
    .GLOBAL_a8rodata        ALIGN(4) : { PROVIDE(__A8_MEM = .); "*(.a8srodata)" "*(.a8srodata.*)" "*(.rodata_a8)" "*(.rodata_a8.*)"} > .
    PROVIDE(_SMALL_DATA_A8_ = __A8_MEM);
    
    /* Far addressable ROM sections */
    .GLOBAL_rodata        ALIGN(4) :
    {
        "*(.rodata.farConst.cpu0.32bit)"
        "*(.rodata.farConst.cpu0.16bit)"
        "*(.rodata.farConst.cpu0.8bit)"
                                       "*(.rodata)" "*(.rodata.*)" 
									   "*(.ldata)" "*(.ldata.*)"
										} > .

    /* Code sections */
	.CPU5_text            ALIGN(2) : { "Ifx_Ssw_Tc5.*(.text)" "Ifx_Ssw_Tc5.*(.text.*)" "Cpu5_Main.*(.text)" "Cpu5_Main.*(.text.*)" "*(.text_cpu5)" "*(.text_cpu5)" } > pfls5
    /*Un comment one of the below statement groups to enable CpuX FLASHs to hold global code sections*/
    .GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls5
    //.GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls4
    //.GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls3
    //.GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls2
    //.GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls1
    //.GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls0

    /* The .syscall section is a special section that allows communication
        between the application and the MULTI debugger and/or simulator */
    .syscall              ALIGN(2) : > .
    
    /* The .secinfo section contains information about how to initialize
       memory when your application loads.  It tells us which sections of
       RAM need to be zero-initialized and which sections need to be copied
       from ROM. */
    .secinfo              ALIGN(4) : > .
	
    /* Copy initialization data */
    .ROM.CPU5_zdata         ROM(.CPU5_zdata) : > pfls5
    .ROM.CPU5_data         ROM(.CPU5_data) : > .

		.ROM.GLOBAL_zdata      ROM(.GLOBAL_zdata) : > .
		.ROM.GLOBAL_data       ROM(.GLOBAL_data) : > .
		.ROM.GLOBAL_sdata      ROM(.GLOBAL_sdata) : > .
    .ROM.CPU5_lmudata      ROM(.CPU5_lmudata) : > .

    .ROM.GLOBAL_lmuzdata   ROM(.GLOBAL_lmuzdata) : > .
    .ROM.GLOBAL_a9data   ROM(.GLOBAL_a9data) : > .
    .ROM.GLOBAL_lmudata    ROM(.GLOBAL_lmudata) : > .

    .ROM.CPU5_psram_text   ROM(.CPU5_psram_text) : > .

    /* Interrupt vector table located at PFLS5 */
    .inttab_tc5_000 BIND (__INTTAB_CPU5 + 0x0000) ALIGN(8) : { *(.intvec_tc5_0    ) *(.intvec_tc5_0x   0) *(.intvec_tc5_ 0x0) } > pfls5
    .inttab_tc5_001 BIND (__INTTAB_CPU5 + 0x0020) ALIGN(8) : { *(.intvec_tc5_1    ) *(.intvec_tc5_0x   1) *(.intvec_tc5_ 0x1) } > .
    .inttab_tc5_002 BIND (__INTTAB_CPU5 + 0x0040) ALIGN(8) : { *(.intvec_tc5_2    ) *(.intvec_tc5_0x   2) *(.intvec_tc5_ 0x2) } > .
    .inttab_tc5_003 BIND (__INTTAB_CPU5 + 0x0060) ALIGN(8) : { *(.intvec_tc5_3    ) *(.intvec_tc5_0x   3) *(.intvec_tc5_ 0x3) } > .
    .inttab_tc5_004 BIND (__INTTAB_CPU5 + 0x0080) ALIGN(8) : { *(.intvec_tc5_4    ) *(.intvec_tc5_0x   4) *(.intvec_tc5_ 0x4) } > .
    .inttab_tc5_005 BIND (__INTTAB_CPU5 + 0x00A0) ALIGN(8) : { *(.intvec_tc5_5    ) *(.intvec_tc5_0x   5) *(.intvec_tc5_ 0x5) } > .
    .inttab_tc5_006 BIND (__INTTAB_CPU5 + 0x00C0) ALIGN(8) : { *(.intvec_tc5_6    ) *(.intvec_tc5_0x   6) *(.intvec_tc5_ 0x6) } > .
    .inttab_tc5_007 BIND (__INTTAB_CPU5 + 0x00E0) ALIGN(8) : { *(.intvec_tc5_7    ) *(.intvec_tc5_0x   7) *(.intvec_tc5_ 0x7) } > .
    .inttab_tc5_008 BIND (__INTTAB_CPU5 + 0x0100) ALIGN(8) : { *(.intvec_tc5_8    ) *(.intvec_tc5_0x   8) *(.intvec_tc5_ 0x8) } > .
    .inttab_tc5_009 BIND (__INTTAB_CPU5 + 0x0120) ALIGN(8) : { *(.intvec_tc5_9    ) *(.intvec_tc5_0x   9) *(.intvec_tc5_ 0x9) } > .
    .inttab_tc5_00A BIND (__INTTAB_CPU5 + 0x0140) ALIGN(8) : { *(.intvec_tc5_10   ) *(.intvec_tc5_0x   A) *(.intvec_tc5_ 0xa) } > .
    .inttab_tc5_00B BIND (__INTTAB_CPU5 + 0x0160) ALIGN(8) : { *(.intvec_tc5_11   ) *(.intvec_tc5_0x   B) *(.intvec_tc5_ 0xb) } > .
    .inttab_tc5_00C BIND (__INTTAB_CPU5 + 0x0180) ALIGN(8) : { *(.intvec_tc5_12   ) *(.intvec_tc5_0x   C) *(.intvec_tc5_ 0xc) } > .
    .inttab_tc5_00D BIND (__INTTAB_CPU5 + 0x01A0) ALIGN(8) : { *(.intvec_tc5_13   ) *(.intvec_tc5_0x   D) *(.intvec_tc5_ 0xd) } > .
    .inttab_tc5_00E BIND (__INTTAB_CPU5 + 0x01C0) ALIGN(8) : { *(.intvec_tc5_14   ) *(.intvec_tc5_0x   E) *(.intvec_tc5_ 0xe) } > .
    .inttab_tc5_00F BIND (__INTTAB_CPU5 + 0x01E0) ALIGN(8) : { *(.intvec_tc5_15   ) *(.intvec_tc5_0x   F) *(.intvec_tc5_ 0xf) } > .
    .inttab_tc5_010 BIND (__INTTAB_CPU5 + 0x0200) ALIGN(8) : { *(.intvec_tc5_16   ) *(.intvec_tc5_0x  10) *(.intvec_tc5_0x10) } > .
    .inttab_tc5_011 BIND (__INTTAB_CPU5 + 0x0220) ALIGN(8) : { *(.intvec_tc5_17   ) *(.intvec_tc5_0x  11) *(.intvec_tc5_0x11) } > .
    .inttab_tc5_012 BIND (__INTTAB_CPU5 + 0x0240) ALIGN(8) : { *(.intvec_tc5_18   ) *(.intvec_tc5_0x  12) *(.intvec_tc5_0x12) } > .
    .inttab_tc5_013 BIND (__INTTAB_CPU5 + 0x0260) ALIGN(8) : { *(.intvec_tc5_19   ) *(.intvec_tc5_0x  13) *(.intvec_tc5_0x13) } > .
    .inttab_tc5_014 BIND (__INTTAB_CPU5 + 0x0280) ALIGN(8) : { *(.intvec_tc5_20   ) *(.intvec_tc5_0x  14) *(.intvec_tc5_0x14) } > .
    .inttab_tc5_015 BIND (__INTTAB_CPU5 + 0x02A0) ALIGN(8) : { *(.intvec_tc5_21   ) *(.intvec_tc5_0x  15) *(.intvec_tc5_0x15) } > .
    .inttab_tc5_016 BIND (__INTTAB_CPU5 + 0x02C0) ALIGN(8) : { *(.intvec_tc5_22   ) *(.intvec_tc5_0x  16) *(.intvec_tc5_0x16) } > .
    .inttab_tc5_017 BIND (__INTTAB_CPU5 + 0x02E0) ALIGN(8) : { *(.intvec_tc5_23   ) *(.intvec_tc5_0x  17) *(.intvec_tc5_0x17) } > .
    .inttab_tc5_018 BIND (__INTTAB_CPU5 + 0x0300) ALIGN(8) : { *(.intvec_tc5_24   ) *(.intvec_tc5_0x  18) *(.intvec_tc5_0x18) } > .
    .inttab_tc5_019 BIND (__INTTAB_CPU5 + 0x0320) ALIGN(8) : { *(.intvec_tc5_25   ) *(.intvec_tc5_0x  19) *(.intvec_tc5_0x19) } > .
    .inttab_tc5_01A BIND (__INTTAB_CPU5 + 0x0340) ALIGN(8) : { *(.intvec_tc5_26   ) *(.intvec_tc5_0x  1A) *(.intvec_tc5_0x1a) } > .
    .inttab_tc5_01B BIND (__INTTAB_CPU5 + 0x0360) ALIGN(8) : { *(.intvec_tc5_27   ) *(.intvec_tc5_0x  1B) *(.intvec_tc5_0x1b) } > .
    .inttab_tc5_01C BIND (__INTTAB_CPU5 + 0x0380) ALIGN(8) : { *(.intvec_tc5_28   ) *(.intvec_tc5_0x  1C) *(.intvec_tc5_0x1c) } > .
    .inttab_tc5_01D BIND (__INTTAB_CPU5 + 0x03A0) ALIGN(8) : { *(.intvec_tc5_29   ) *(.intvec_tc5_0x  1D) *(.intvec_tc5_0x1d) } > .
    .inttab_tc5_01E BIND (__INTTAB_CPU5 + 0x03C0) ALIGN(8) : { *(.intvec_tc5_30   ) *(.intvec_tc5_0x  1E) *(.intvec_tc5_0x1e) } > .
    .inttab_tc5_01F BIND (__INTTAB_CPU5 + 0x03E0) ALIGN(8) : { *(.intvec_tc5_31   ) *(.intvec_tc5_0x  1F) *(.intvec_tc5_0x1f) } > .
    .inttab_tc5_020 BIND (__INTTAB_CPU5 + 0x0400) ALIGN(8) : { *(.intvec_tc5_32   ) *(.intvec_tc5_0x  20) *(.intvec_tc5_0x20) } > .
    .inttab_tc5_021 BIND (__INTTAB_CPU5 + 0x0420) ALIGN(8) : { *(.intvec_tc5_33   ) *(.intvec_tc5_0x  21) *(.intvec_tc5_0x21) } > .
    .inttab_tc5_022 BIND (__INTTAB_CPU5 + 0x0440) ALIGN(8) : { *(.intvec_tc5_34   ) *(.intvec_tc5_0x  22) *(.intvec_tc5_0x22) } > .
    .inttab_tc5_023 BIND (__INTTAB_CPU5 + 0x0460) ALIGN(8) : { *(.intvec_tc5_35   ) *(.intvec_tc5_0x  23) *(.intvec_tc5_0x23) } > .
    .inttab_tc5_024 BIND (__INTTAB_CPU5 + 0x0480) ALIGN(8) : { *(.intvec_tc5_36   ) *(.intvec_tc5_0x  24) *(.intvec_tc5_0x24) } > .
    .inttab_tc5_025 BIND (__INTTAB_CPU5 + 0x04A0) ALIGN(8) : { *(.intvec_tc5_37   ) *(.intvec_tc5_0x  25) *(.intvec_tc5_0x25) } > .
    .inttab_tc5_026 BIND (__INTTAB_CPU5 + 0x04C0) ALIGN(8) : { *(.intvec_tc5_38   ) *(.intvec_tc5_0x  26) *(.intvec_tc5_0x26) } > .
    .inttab_tc5_027 BIND (__INTTAB_CPU5 + 0x04E0) ALIGN(8) : { *(.intvec_tc5_39   ) *(.intvec_tc5_0x  27) *(.intvec_tc5_0x27) } > .
    .inttab_tc5_028 BIND (__INTTAB_CPU5 + 0x0500) ALIGN(8) : { *(.intvec_tc5_40   ) *(.intvec_tc5_0x  28) *(.intvec_tc5_0x28) } > .
    .inttab_tc5_029 BIND (__INTTAB_CPU5 + 0x0520) ALIGN(8) : { *(.intvec_tc5_41   ) *(.intvec_tc5_0x  29) *(.intvec_tc5_0x29) } > .
    .inttab_tc5_02A BIND (__INTTAB_CPU5 + 0x0540) ALIGN(8) : { *(.intvec_tc5_42   ) *(.intvec_tc5_0x  2A) *(.intvec_tc5_0x2a) } > .
    .inttab_tc5_02B BIND (__INTTAB_CPU5 + 0x0560) ALIGN(8) : { *(.intvec_tc5_43   ) *(.intvec_tc5_0x  2B) *(.intvec_tc5_0x2b) } > .
    .inttab_tc5_02C BIND (__INTTAB_CPU5 + 0x0580) ALIGN(8) : { *(.intvec_tc5_44   ) *(.intvec_tc5_0x  2C) *(.intvec_tc5_0x2c) } > .
    .inttab_tc5_02D BIND (__INTTAB_CPU5 + 0x05A0) ALIGN(8) : { *(.intvec_tc5_45   ) *(.intvec_tc5_0x  2D) *(.intvec_tc5_0x2d) } > .
    .inttab_tc5_02E BIND (__INTTAB_CPU5 + 0x05C0) ALIGN(8) : { *(.intvec_tc5_46   ) *(.intvec_tc5_0x  2E) *(.intvec_tc5_0x2e) } > .
    .inttab_tc5_02F BIND (__INTTAB_CPU5 + 0x05E0) ALIGN(8) : { *(.intvec_tc5_47   ) *(.intvec_tc5_0x  2F) *(.intvec_tc5_0x2f) } > .
    .inttab_tc5_030 BIND (__INTTAB_CPU5 + 0x0600) ALIGN(8) : { *(.intvec_tc5_48   ) *(.intvec_tc5_0x  30) *(.intvec_tc5_0x30) } > .
    .inttab_tc5_031 BIND (__INTTAB_CPU5 + 0x0620) ALIGN(8) : { *(.intvec_tc5_49   ) *(.intvec_tc5_0x  31) *(.intvec_tc5_0x31) } > .
    .inttab_tc5_032 BIND (__INTTAB_CPU5 + 0x0640) ALIGN(8) : { *(.intvec_tc5_50   ) *(.intvec_tc5_0x  32) *(.intvec_tc5_0x32) } > .
    .inttab_tc5_033 BIND (__INTTAB_CPU5 + 0x0660) ALIGN(8) : { *(.intvec_tc5_51   ) *(.intvec_tc5_0x  33) *(.intvec_tc5_0x33) } > .
    .inttab_tc5_034 BIND (__INTTAB_CPU5 + 0x0680) ALIGN(8) : { *(.intvec_tc5_52   ) *(.intvec_tc5_0x  34) *(.intvec_tc5_0x34) } > .
    .inttab_tc5_035 BIND (__INTTAB_CPU5 + 0x06A0) ALIGN(8) : { *(.intvec_tc5_53   ) *(.intvec_tc5_0x  35) *(.intvec_tc5_0x35) } > .
    .inttab_tc5_036 BIND (__INTTAB_CPU5 + 0x06C0) ALIGN(8) : { *(.intvec_tc5_54   ) *(.intvec_tc5_0x  36) *(.intvec_tc5_0x36) } > .
    .inttab_tc5_037 BIND (__INTTAB_CPU5 + 0x06E0) ALIGN(8) : { *(.intvec_tc5_55   ) *(.intvec_tc5_0x  37) *(.intvec_tc5_0x37) } > .
    .inttab_tc5_038 BIND (__INTTAB_CPU5 + 0x0700) ALIGN(8) : { *(.intvec_tc5_56   ) *(.intvec_tc5_0x  38) *(.intvec_tc5_0x38) } > .
    .inttab_tc5_039 BIND (__INTTAB_CPU5 + 0x0720) ALIGN(8) : { *(.intvec_tc5_57   ) *(.intvec_tc5_0x  39) *(.intvec_tc5_0x39) } > .
    .inttab_tc5_03A BIND (__INTTAB_CPU5 + 0x0740) ALIGN(8) : { *(.intvec_tc5_58   ) *(.intvec_tc5_0x  3A) *(.intvec_tc5_0x3a) } > .
    .inttab_tc5_03B BIND (__INTTAB_CPU5 + 0x0760) ALIGN(8) : { *(.intvec_tc5_59   ) *(.intvec_tc5_0x  3B) *(.intvec_tc5_0x3b) } > .
    .inttab_tc5_03C BIND (__INTTAB_CPU5 + 0x0780) ALIGN(8) : { *(.intvec_tc5_60   ) *(.intvec_tc5_0x  3C) *(.intvec_tc5_0x3c) } > .
    .inttab_tc5_03D BIND (__INTTAB_CPU5 + 0x07A0) ALIGN(8) : { *(.intvec_tc5_61   ) *(.intvec_tc5_0x  3D) *(.intvec_tc5_0x3d) } > .
    .inttab_tc5_03E BIND (__INTTAB_CPU5 + 0x07C0) ALIGN(8) : { *(.intvec_tc5_62   ) *(.intvec_tc5_0x  3E) *(.intvec_tc5_0x3e) } > .
    .inttab_tc5_03F BIND (__INTTAB_CPU5 + 0x07E0) ALIGN(8) : { *(.intvec_tc5_63   ) *(.intvec_tc5_0x  3F) *(.intvec_tc5_0x3f) } > .
    .inttab_tc5_040 BIND (__INTTAB_CPU5 + 0x0800) ALIGN(8) : { *(.intvec_tc5_64   ) *(.intvec_tc5_0x  40) *(.intvec_tc5_0x40) } > .
    .inttab_tc5_041 BIND (__INTTAB_CPU5 + 0x0820) ALIGN(8) : { *(.intvec_tc5_65   ) *(.intvec_tc5_0x  41) *(.intvec_tc5_0x41) } > .
    .inttab_tc5_042 BIND (__INTTAB_CPU5 + 0x0840) ALIGN(8) : { *(.intvec_tc5_66   ) *(.intvec_tc5_0x  42) *(.intvec_tc5_0x42) } > .
    .inttab_tc5_043 BIND (__INTTAB_CPU5 + 0x0860) ALIGN(8) : { *(.intvec_tc5_67   ) *(.intvec_tc5_0x  43) *(.intvec_tc5_0x43) } > .
    .inttab_tc5_044 BIND (__INTTAB_CPU5 + 0x0880) ALIGN(8) : { *(.intvec_tc5_68   ) *(.intvec_tc5_0x  44) *(.intvec_tc5_0x44) } > .
    .inttab_tc5_045 BIND (__INTTAB_CPU5 + 0x08A0) ALIGN(8) : { *(.intvec_tc5_69   ) *(.intvec_tc5_0x  45) *(.intvec_tc5_0x45) } > .
    .inttab_tc5_046 BIND (__INTTAB_CPU5 + 0x08C0) ALIGN(8) : { *(.intvec_tc5_70   ) *(.intvec_tc5_0x  46) *(.intvec_tc5_0x46) } > .
    .inttab_tc5_047 BIND (__INTTAB_CPU5 + 0x08E0) ALIGN(8) : { *(.intvec_tc5_71   ) *(.intvec_tc5_0x  47) *(.intvec_tc5_0x47) } > .
    .inttab_tc5_048 BIND (__INTTAB_CPU5 + 0x0900) ALIGN(8) : { *(.intvec_tc5_72   ) *(.intvec_tc5_0x  48) *(.intvec_tc5_0x48) } > .
    .inttab_tc5_049 BIND (__INTTAB_CPU5 + 0x0920) ALIGN(8) : { *(.intvec_tc5_73   ) *(.intvec_tc5_0x  49) *(.intvec_tc5_0x49) } > .
    .inttab_tc5_04A BIND (__INTTAB_CPU5 + 0x0940) ALIGN(8) : { *(.intvec_tc5_74   ) *(.intvec_tc5_0x  4A) *(.intvec_tc5_0x4a) } > .
    .inttab_tc5_04B BIND (__INTTAB_CPU5 + 0x0960) ALIGN(8) : { *(.intvec_tc5_75   ) *(.intvec_tc5_0x  4B) *(.intvec_tc5_0x4b) } > .
    .inttab_tc5_04C BIND (__INTTAB_CPU5 + 0x0980) ALIGN(8) : { *(.intvec_tc5_76   ) *(.intvec_tc5_0x  4C) *(.intvec_tc5_0x4c) } > .
    .inttab_tc5_04D BIND (__INTTAB_CPU5 + 0x09A0) ALIGN(8) : { *(.intvec_tc5_77   ) *(.intvec_tc5_0x  4D) *(.intvec_tc5_0x4d) } > .
    .inttab_tc5_04E BIND (__INTTAB_CPU5 + 0x09C0) ALIGN(8) : { *(.intvec_tc5_78   ) *(.intvec_tc5_0x  4E) *(.intvec_tc5_0x4e) } > .
    .inttab_tc5_04F BIND (__INTTAB_CPU5 + 0x09E0) ALIGN(8) : { *(.intvec_tc5_79   ) *(.intvec_tc5_0x  4F) *(.intvec_tc5_0x4f) } > .
    .inttab_tc5_050 BIND (__INTTAB_CPU5 + 0x0A00) ALIGN(8) : { *(.intvec_tc5_80   ) *(.intvec_tc5_0x  50) *(.intvec_tc5_0x50) } > .
    .inttab_tc5_051 BIND (__INTTAB_CPU5 + 0x0A20) ALIGN(8) : { *(.intvec_tc5_81   ) *(.intvec_tc5_0x  51) *(.intvec_tc5_0x51) } > .
    .inttab_tc5_052 BIND (__INTTAB_CPU5 + 0x0A40) ALIGN(8) : { *(.intvec_tc5_82   ) *(.intvec_tc5_0x  52) *(.intvec_tc5_0x52) } > .
    .inttab_tc5_053 BIND (__INTTAB_CPU5 + 0x0A60) ALIGN(8) : { *(.intvec_tc5_83   ) *(.intvec_tc5_0x  53) *(.intvec_tc5_0x53) } > .
    .inttab_tc5_054 BIND (__INTTAB_CPU5 + 0x0A80) ALIGN(8) : { *(.intvec_tc5_84   ) *(.intvec_tc5_0x  54) *(.intvec_tc5_0x54) } > .
    .inttab_tc5_055 BIND (__INTTAB_CPU5 + 0x0AA0) ALIGN(8) : { *(.intvec_tc5_85   ) *(.intvec_tc5_0x  55) *(.intvec_tc5_0x55) } > .
    .inttab_tc5_056 BIND (__INTTAB_CPU5 + 0x0AC0) ALIGN(8) : { *(.intvec_tc5_86   ) *(.intvec_tc5_0x  56) *(.intvec_tc5_0x56) } > .
    .inttab_tc5_057 BIND (__INTTAB_CPU5 + 0x0AE0) ALIGN(8) : { *(.intvec_tc5_87   ) *(.intvec_tc5_0x  57) *(.intvec_tc5_0x57) } > .
    .inttab_tc5_058 BIND (__INTTAB_CPU5 + 0x0B00) ALIGN(8) : { *(.intvec_tc5_88   ) *(.intvec_tc5_0x  58) *(.intvec_tc5_0x58) } > .
    .inttab_tc5_059 BIND (__INTTAB_CPU5 + 0x0B20) ALIGN(8) : { *(.intvec_tc5_89   ) *(.intvec_tc5_0x  59) *(.intvec_tc5_0x59) } > .
    .inttab_tc5_05A BIND (__INTTAB_CPU5 + 0x0B40) ALIGN(8) : { *(.intvec_tc5_90   ) *(.intvec_tc5_0x  5A) *(.intvec_tc5_0x5a) } > .
    .inttab_tc5_05B BIND (__INTTAB_CPU5 + 0x0B60) ALIGN(8) : { *(.intvec_tc5_91   ) *(.intvec_tc5_0x  5B) *(.intvec_tc5_0x5b) } > .
    .inttab_tc5_05C BIND (__INTTAB_CPU5 + 0x0B80) ALIGN(8) : { *(.intvec_tc5_92   ) *(.intvec_tc5_0x  5C) *(.intvec_tc5_0x5c) } > .
    .inttab_tc5_05D BIND (__INTTAB_CPU5 + 0x0BA0) ALIGN(8) : { *(.intvec_tc5_93   ) *(.intvec_tc5_0x  5D) *(.intvec_tc5_0x5d) } > .
    .inttab_tc5_05E BIND (__INTTAB_CPU5 + 0x0BC0) ALIGN(8) : { *(.intvec_tc5_94   ) *(.intvec_tc5_0x  5E) *(.intvec_tc5_0x5e) } > .
    .inttab_tc5_05F BIND (__INTTAB_CPU5 + 0x0BE0) ALIGN(8) : { *(.intvec_tc5_95   ) *(.intvec_tc5_0x  5F) *(.intvec_tc5_0x5f) } > .
    .inttab_tc5_060 BIND (__INTTAB_CPU5 + 0x0C00) ALIGN(8) : { *(.intvec_tc5_96   ) *(.intvec_tc5_0x  60) *(.intvec_tc5_0x60) } > .
    .inttab_tc5_061 BIND (__INTTAB_CPU5 + 0x0C20) ALIGN(8) : { *(.intvec_tc5_97   ) *(.intvec_tc5_0x  61) *(.intvec_tc5_0x61) } > .
    .inttab_tc5_062 BIND (__INTTAB_CPU5 + 0x0C40) ALIGN(8) : { *(.intvec_tc5_98   ) *(.intvec_tc5_0x  62) *(.intvec_tc5_0x62) } > .
    .inttab_tc5_063 BIND (__INTTAB_CPU5 + 0x0C60) ALIGN(8) : { *(.intvec_tc5_99   ) *(.intvec_tc5_0x  63) *(.intvec_tc5_0x63) } > .
    .inttab_tc5_064 BIND (__INTTAB_CPU5 + 0x0C80) ALIGN(8) : { *(.intvec_tc5_100  ) *(.intvec_tc5_0x  64) *(.intvec_tc5_0x64) } > .
    .inttab_tc5_065 BIND (__INTTAB_CPU5 + 0x0CA0) ALIGN(8) : { *(.intvec_tc5_101  ) *(.intvec_tc5_0x  65) *(.intvec_tc5_0x65) } > .
    .inttab_tc5_066 BIND (__INTTAB_CPU5 + 0x0CC0) ALIGN(8) : { *(.intvec_tc5_102  ) *(.intvec_tc5_0x  66) *(.intvec_tc5_0x66) } > .
    .inttab_tc5_067 BIND (__INTTAB_CPU5 + 0x0CE0) ALIGN(8) : { *(.intvec_tc5_103  ) *(.intvec_tc5_0x  67) *(.intvec_tc5_0x67) } > .
    .inttab_tc5_068 BIND (__INTTAB_CPU5 + 0x0D00) ALIGN(8) : { *(.intvec_tc5_104  ) *(.intvec_tc5_0x  68) *(.intvec_tc5_0x68) } > .
    .inttab_tc5_069 BIND (__INTTAB_CPU5 + 0x0D20) ALIGN(8) : { *(.intvec_tc5_105  ) *(.intvec_tc5_0x  69) *(.intvec_tc5_0x69) } > .
    .inttab_tc5_06A BIND (__INTTAB_CPU5 + 0x0D40) ALIGN(8) : { *(.intvec_tc5_106  ) *(.intvec_tc5_0x  6A) *(.intvec_tc5_0x6a) } > .
    .inttab_tc5_06B BIND (__INTTAB_CPU5 + 0x0D60) ALIGN(8) : { *(.intvec_tc5_107  ) *(.intvec_tc5_0x  6B) *(.intvec_tc5_0x6b) } > .
    .inttab_tc5_06C BIND (__INTTAB_CPU5 + 0x0D80) ALIGN(8) : { *(.intvec_tc5_108  ) *(.intvec_tc5_0x  6C) *(.intvec_tc5_0x6c) } > .
    .inttab_tc5_06D BIND (__INTTAB_CPU5 + 0x0DA0) ALIGN(8) : { *(.intvec_tc5_109  ) *(.intvec_tc5_0x  6D) *(.intvec_tc5_0x6d) } > .
    .inttab_tc5_06E BIND (__INTTAB_CPU5 + 0x0DC0) ALIGN(8) : { *(.intvec_tc5_110  ) *(.intvec_tc5_0x  6E) *(.intvec_tc5_0x6e) } > .
    .inttab_tc5_06F BIND (__INTTAB_CPU5 + 0x0DE0) ALIGN(8) : { *(.intvec_tc5_111  ) *(.intvec_tc5_0x  6F) *(.intvec_tc5_0x6f) } > .
    .inttab_tc5_070 BIND (__INTTAB_CPU5 + 0x0E00) ALIGN(8) : { *(.intvec_tc5_112  ) *(.intvec_tc5_0x  70) *(.intvec_tc5_0x70) } > .
    .inttab_tc5_071 BIND (__INTTAB_CPU5 + 0x0E20) ALIGN(8) : { *(.intvec_tc5_113  ) *(.intvec_tc5_0x  71) *(.intvec_tc5_0x71) } > .
    .inttab_tc5_072 BIND (__INTTAB_CPU5 + 0x0E40) ALIGN(8) : { *(.intvec_tc5_114  ) *(.intvec_tc5_0x  72) *(.intvec_tc5_0x72) } > .
    .inttab_tc5_073 BIND (__INTTAB_CPU5 + 0x0E60) ALIGN(8) : { *(.intvec_tc5_115  ) *(.intvec_tc5_0x  73) *(.intvec_tc5_0x73) } > .
    .inttab_tc5_074 BIND (__INTTAB_CPU5 + 0x0E80) ALIGN(8) : { *(.intvec_tc5_116  ) *(.intvec_tc5_0x  74) *(.intvec_tc5_0x74) } > .
    .inttab_tc5_075 BIND (__INTTAB_CPU5 + 0x0EA0) ALIGN(8) : { *(.intvec_tc5_117  ) *(.intvec_tc5_0x  75) *(.intvec_tc5_0x75) } > .
    .inttab_tc5_076 BIND (__INTTAB_CPU5 + 0x0EC0) ALIGN(8) : { *(.intvec_tc5_118  ) *(.intvec_tc5_0x  76) *(.intvec_tc5_0x76) } > .
    .inttab_tc5_077 BIND (__INTTAB_CPU5 + 0x0EE0) ALIGN(8) : { *(.intvec_tc5_119  ) *(.intvec_tc5_0x  77) *(.intvec_tc5_0x77) } > .
    .inttab_tc5_078 BIND (__INTTAB_CPU5 + 0x0F00) ALIGN(8) : { *(.intvec_tc5_120  ) *(.intvec_tc5_0x  78) *(.intvec_tc5_0x78) } > .
    .inttab_tc5_079 BIND (__INTTAB_CPU5 + 0x0F20) ALIGN(8) : { *(.intvec_tc5_121  ) *(.intvec_tc5_0x  79) *(.intvec_tc5_0x79) } > .
    .inttab_tc5_07A BIND (__INTTAB_CPU5 + 0x0F40) ALIGN(8) : { *(.intvec_tc5_122  ) *(.intvec_tc5_0x  7A) *(.intvec_tc5_0x7a) } > .
    .inttab_tc5_07B BIND (__INTTAB_CPU5 + 0x0F60) ALIGN(8) : { *(.intvec_tc5_123  ) *(.intvec_tc5_0x  7B) *(.intvec_tc5_0x7b) } > .
    .inttab_tc5_07C BIND (__INTTAB_CPU5 + 0x0F80) ALIGN(8) : { *(.intvec_tc5_124  ) *(.intvec_tc5_0x  7C) *(.intvec_tc5_0x7c) } > .
    .inttab_tc5_07D BIND (__INTTAB_CPU5 + 0x0FA0) ALIGN(8) : { *(.intvec_tc5_125  ) *(.intvec_tc5_0x  7D) *(.intvec_tc5_0x7d) } > .
    .inttab_tc5_07E BIND (__INTTAB_CPU5 + 0x0FC0) ALIGN(8) : { *(.intvec_tc5_126  ) *(.intvec_tc5_0x  7E) *(.intvec_tc5_0x7e) } > .
    .inttab_tc5_07F BIND (__INTTAB_CPU5 + 0x0FE0) ALIGN(8) : { *(.intvec_tc5_127  ) *(.intvec_tc5_0x  7F) *(.intvec_tc5_0x7f) } > .
    .inttab_tc5_080 BIND (__INTTAB_CPU5 + 0x1000) ALIGN(8) : { *(.intvec_tc5_128  ) *(.intvec_tc5_0x  80) *(.intvec_tc5_0x80) } > .
    .inttab_tc5_081 BIND (__INTTAB_CPU5 + 0x1020) ALIGN(8) : { *(.intvec_tc5_129  ) *(.intvec_tc5_0x  81) *(.intvec_tc5_0x81) } > .
    .inttab_tc5_082 BIND (__INTTAB_CPU5 + 0x1040) ALIGN(8) : { *(.intvec_tc5_130  ) *(.intvec_tc5_0x  82) *(.intvec_tc5_0x82) } > .
    .inttab_tc5_083 BIND (__INTTAB_CPU5 + 0x1060) ALIGN(8) : { *(.intvec_tc5_131  ) *(.intvec_tc5_0x  83) *(.intvec_tc5_0x83) } > .
    .inttab_tc5_084 BIND (__INTTAB_CPU5 + 0x1080) ALIGN(8) : { *(.intvec_tc5_132  ) *(.intvec_tc5_0x  84) *(.intvec_tc5_0x84) } > .
    .inttab_tc5_085 BIND (__INTTAB_CPU5 + 0x10A0) ALIGN(8) : { *(.intvec_tc5_133  ) *(.intvec_tc5_0x  85) *(.intvec_tc5_0x85) } > .
    .inttab_tc5_086 BIND (__INTTAB_CPU5 + 0x10C0) ALIGN(8) : { *(.intvec_tc5_134  ) *(.intvec_tc5_0x  86) *(.intvec_tc5_0x86) } > .
    .inttab_tc5_087 BIND (__INTTAB_CPU5 + 0x10E0) ALIGN(8) : { *(.intvec_tc5_135  ) *(.intvec_tc5_0x  87) *(.intvec_tc5_0x87) } > .
    .inttab_tc5_088 BIND (__INTTAB_CPU5 + 0x1100) ALIGN(8) : { *(.intvec_tc5_136  ) *(.intvec_tc5_0x  88) *(.intvec_tc5_0x88) } > .
    .inttab_tc5_089 BIND (__INTTAB_CPU5 + 0x1120) ALIGN(8) : { *(.intvec_tc5_137  ) *(.intvec_tc5_0x  89) *(.intvec_tc5_0x89) } > .
    .inttab_tc5_08A BIND (__INTTAB_CPU5 + 0x1140) ALIGN(8) : { *(.intvec_tc5_138  ) *(.intvec_tc5_0x  8A) *(.intvec_tc5_0x8a) } > .
    .inttab_tc5_08B BIND (__INTTAB_CPU5 + 0x1160) ALIGN(8) : { *(.intvec_tc5_139  ) *(.intvec_tc5_0x  8B) *(.intvec_tc5_0x8b) } > .
    .inttab_tc5_08C BIND (__INTTAB_CPU5 + 0x1180) ALIGN(8) : { *(.intvec_tc5_140  ) *(.intvec_tc5_0x  8C) *(.intvec_tc5_0x8c) } > .
    .inttab_tc5_08D BIND (__INTTAB_CPU5 + 0x11A0) ALIGN(8) : { *(.intvec_tc5_141  ) *(.intvec_tc5_0x  8D) *(.intvec_tc5_0x8d) } > .
    .inttab_tc5_08E BIND (__INTTAB_CPU5 + 0x11C0) ALIGN(8) : { *(.intvec_tc5_142  ) *(.intvec_tc5_0x  8E) *(.intvec_tc5_0x8e) } > .
    .inttab_tc5_08F BIND (__INTTAB_CPU5 + 0x11E0) ALIGN(8) : { *(.intvec_tc5_143  ) *(.intvec_tc5_0x  8F) *(.intvec_tc5_0x8f) } > .
    .inttab_tc5_090 BIND (__INTTAB_CPU5 + 0x1200) ALIGN(8) : { *(.intvec_tc5_144  ) *(.intvec_tc5_0x  90) *(.intvec_tc5_0x90) } > .
    .inttab_tc5_091 BIND (__INTTAB_CPU5 + 0x1220) ALIGN(8) : { *(.intvec_tc5_145  ) *(.intvec_tc5_0x  91) *(.intvec_tc5_0x91) } > .
    .inttab_tc5_092 BIND (__INTTAB_CPU5 + 0x1240) ALIGN(8) : { *(.intvec_tc5_146  ) *(.intvec_tc5_0x  92) *(.intvec_tc5_0x92) } > .
    .inttab_tc5_093 BIND (__INTTAB_CPU5 + 0x1260) ALIGN(8) : { *(.intvec_tc5_147  ) *(.intvec_tc5_0x  93) *(.intvec_tc5_0x93) } > .
    .inttab_tc5_094 BIND (__INTTAB_CPU5 + 0x1280) ALIGN(8) : { *(.intvec_tc5_148  ) *(.intvec_tc5_0x  94) *(.intvec_tc5_0x94) } > .
    .inttab_tc5_095 BIND (__INTTAB_CPU5 + 0x12A0) ALIGN(8) : { *(.intvec_tc5_149  ) *(.intvec_tc5_0x  95) *(.intvec_tc5_0x95) } > .
    .inttab_tc5_096 BIND (__INTTAB_CPU5 + 0x12C0) ALIGN(8) : { *(.intvec_tc5_150  ) *(.intvec_tc5_0x  96) *(.intvec_tc5_0x96) } > .
    .inttab_tc5_097 BIND (__INTTAB_CPU5 + 0x12E0) ALIGN(8) : { *(.intvec_tc5_151  ) *(.intvec_tc5_0x  97) *(.intvec_tc5_0x97) } > .
    .inttab_tc5_098 BIND (__INTTAB_CPU5 + 0x1300) ALIGN(8) : { *(.intvec_tc5_152  ) *(.intvec_tc5_0x  98) *(.intvec_tc5_0x98) } > .
    .inttab_tc5_099 BIND (__INTTAB_CPU5 + 0x1320) ALIGN(8) : { *(.intvec_tc5_153  ) *(.intvec_tc5_0x  99) *(.intvec_tc5_0x99) } > .
    .inttab_tc5_09A BIND (__INTTAB_CPU5 + 0x1340) ALIGN(8) : { *(.intvec_tc5_154  ) *(.intvec_tc5_0x  9A) *(.intvec_tc5_0x9a) } > .
    .inttab_tc5_09B BIND (__INTTAB_CPU5 + 0x1360) ALIGN(8) : { *(.intvec_tc5_155  ) *(.intvec_tc5_0x  9B) *(.intvec_tc5_0x9b) } > .
    .inttab_tc5_09C BIND (__INTTAB_CPU5 + 0x1380) ALIGN(8) : { *(.intvec_tc5_156  ) *(.intvec_tc5_0x  9C) *(.intvec_tc5_0x9c) } > .
    .inttab_tc5_09D BIND (__INTTAB_CPU5 + 0x13A0) ALIGN(8) : { *(.intvec_tc5_157  ) *(.intvec_tc5_0x  9D) *(.intvec_tc5_0x9d) } > .
    .inttab_tc5_09E BIND (__INTTAB_CPU5 + 0x13C0) ALIGN(8) : { *(.intvec_tc5_158  ) *(.intvec_tc5_0x  9E) *(.intvec_tc5_0x9e) } > .
    .inttab_tc5_09F BIND (__INTTAB_CPU5 + 0x13E0) ALIGN(8) : { *(.intvec_tc5_159  ) *(.intvec_tc5_0x  9F) *(.intvec_tc5_0x9f) } > .
    .inttab_tc5_0A0 BIND (__INTTAB_CPU5 + 0x1400) ALIGN(8) : { *(.intvec_tc5_160  ) *(.intvec_tc5_0x  A0) *(.intvec_tc5_0xa0) } > .
    .inttab_tc5_0A1 BIND (__INTTAB_CPU5 + 0x1420) ALIGN(8) : { *(.intvec_tc5_161  ) *(.intvec_tc5_0x  A1) *(.intvec_tc5_0xa1) } > .
    .inttab_tc5_0A2 BIND (__INTTAB_CPU5 + 0x1440) ALIGN(8) : { *(.intvec_tc5_162  ) *(.intvec_tc5_0x  A2) *(.intvec_tc5_0xa2) } > .
    .inttab_tc5_0A3 BIND (__INTTAB_CPU5 + 0x1460) ALIGN(8) : { *(.intvec_tc5_163  ) *(.intvec_tc5_0x  A3) *(.intvec_tc5_0xa3) } > .
    .inttab_tc5_0A4 BIND (__INTTAB_CPU5 + 0x1480) ALIGN(8) : { *(.intvec_tc5_164  ) *(.intvec_tc5_0x  A4) *(.intvec_tc5_0xa4) } > .
    .inttab_tc5_0A5 BIND (__INTTAB_CPU5 + 0x14A0) ALIGN(8) : { *(.intvec_tc5_165  ) *(.intvec_tc5_0x  A5) *(.intvec_tc5_0xa5) } > .
    .inttab_tc5_0A6 BIND (__INTTAB_CPU5 + 0x14C0) ALIGN(8) : { *(.intvec_tc5_166  ) *(.intvec_tc5_0x  A6) *(.intvec_tc5_0xa6) } > .
    .inttab_tc5_0A7 BIND (__INTTAB_CPU5 + 0x14E0) ALIGN(8) : { *(.intvec_tc5_167  ) *(.intvec_tc5_0x  A7) *(.intvec_tc5_0xa7) } > .
    .inttab_tc5_0A8 BIND (__INTTAB_CPU5 + 0x1500) ALIGN(8) : { *(.intvec_tc5_168  ) *(.intvec_tc5_0x  A8) *(.intvec_tc5_0xa8) } > .
    .inttab_tc5_0A9 BIND (__INTTAB_CPU5 + 0x1520) ALIGN(8) : { *(.intvec_tc5_169  ) *(.intvec_tc5_0x  A9) *(.intvec_tc5_0xa9) } > .
    .inttab_tc5_0AA BIND (__INTTAB_CPU5 + 0x1540) ALIGN(8) : { *(.intvec_tc5_170  ) *(.intvec_tc5_0x  AA) *(.intvec_tc5_0xaa) } > .
    .inttab_tc5_0AB BIND (__INTTAB_CPU5 + 0x1560) ALIGN(8) : { *(.intvec_tc5_171  ) *(.intvec_tc5_0x  AB) *(.intvec_tc5_0xab) } > .
    .inttab_tc5_0AC BIND (__INTTAB_CPU5 + 0x1580) ALIGN(8) : { *(.intvec_tc5_172  ) *(.intvec_tc5_0x  AC) *(.intvec_tc5_0xac) } > .
    .inttab_tc5_0AD BIND (__INTTAB_CPU5 + 0x15A0) ALIGN(8) : { *(.intvec_tc5_173  ) *(.intvec_tc5_0x  AD) *(.intvec_tc5_0xad) } > .
    .inttab_tc5_0AE BIND (__INTTAB_CPU5 + 0x15C0) ALIGN(8) : { *(.intvec_tc5_174  ) *(.intvec_tc5_0x  AE) *(.intvec_tc5_0xae) } > .
    .inttab_tc5_0AF BIND (__INTTAB_CPU5 + 0x15E0) ALIGN(8) : { *(.intvec_tc5_175  ) *(.intvec_tc5_0x  AF) *(.intvec_tc5_0xaf) } > .
    .inttab_tc5_0B0 BIND (__INTTAB_CPU5 + 0x1600) ALIGN(8) : { *(.intvec_tc5_176  ) *(.intvec_tc5_0x  B0) *(.intvec_tc5_0xb0) } > .
    .inttab_tc5_0B1 BIND (__INTTAB_CPU5 + 0x1620) ALIGN(8) : { *(.intvec_tc5_177  ) *(.intvec_tc5_0x  B1) *(.intvec_tc5_0xb1) } > .
    .inttab_tc5_0B2 BIND (__INTTAB_CPU5 + 0x1640) ALIGN(8) : { *(.intvec_tc5_178  ) *(.intvec_tc5_0x  B2) *(.intvec_tc5_0xb2) } > .
    .inttab_tc5_0B3 BIND (__INTTAB_CPU5 + 0x1660) ALIGN(8) : { *(.intvec_tc5_179  ) *(.intvec_tc5_0x  B3) *(.intvec_tc5_0xb3) } > .
    .inttab_tc5_0B4 BIND (__INTTAB_CPU5 + 0x1680) ALIGN(8) : { *(.intvec_tc5_180  ) *(.intvec_tc5_0x  B4) *(.intvec_tc5_0xb4) } > .
    .inttab_tc5_0B5 BIND (__INTTAB_CPU5 + 0x16A0) ALIGN(8) : { *(.intvec_tc5_181  ) *(.intvec_tc5_0x  B5) *(.intvec_tc5_0xb5) } > .
    .inttab_tc5_0B6 BIND (__INTTAB_CPU5 + 0x16C0) ALIGN(8) : { *(.intvec_tc5_182  ) *(.intvec_tc5_0x  B6) *(.intvec_tc5_0xb6) } > .
    .inttab_tc5_0B7 BIND (__INTTAB_CPU5 + 0x16E0) ALIGN(8) : { *(.intvec_tc5_183  ) *(.intvec_tc5_0x  B7) *(.intvec_tc5_0xb7) } > .
    .inttab_tc5_0B8 BIND (__INTTAB_CPU5 + 0x1700) ALIGN(8) : { *(.intvec_tc5_184  ) *(.intvec_tc5_0x  B8) *(.intvec_tc5_0xb8) } > .
    .inttab_tc5_0B9 BIND (__INTTAB_CPU5 + 0x1720) ALIGN(8) : { *(.intvec_tc5_185  ) *(.intvec_tc5_0x  B9) *(.intvec_tc5_0xb9) } > .
    .inttab_tc5_0BA BIND (__INTTAB_CPU5 + 0x1740) ALIGN(8) : { *(.intvec_tc5_186  ) *(.intvec_tc5_0x  BA) *(.intvec_tc5_0xba) } > .
    .inttab_tc5_0BB BIND (__INTTAB_CPU5 + 0x1760) ALIGN(8) : { *(.intvec_tc5_187  ) *(.intvec_tc5_0x  BB) *(.intvec_tc5_0xbb) } > .
    .inttab_tc5_0BC BIND (__INTTAB_CPU5 + 0x1780) ALIGN(8) : { *(.intvec_tc5_188  ) *(.intvec_tc5_0x  BC) *(.intvec_tc5_0xbc) } > .
    .inttab_tc5_0BD BIND (__INTTAB_CPU5 + 0x17A0) ALIGN(8) : { *(.intvec_tc5_189  ) *(.intvec_tc5_0x  BD) *(.intvec_tc5_0xbd) } > .
    .inttab_tc5_0BE BIND (__INTTAB_CPU5 + 0x17C0) ALIGN(8) : { *(.intvec_tc5_190  ) *(.intvec_tc5_0x  BE) *(.intvec_tc5_0xbe) } > .
    .inttab_tc5_0BF BIND (__INTTAB_CPU5 + 0x17E0) ALIGN(8) : { *(.intvec_tc5_191  ) *(.intvec_tc5_0x  BF) *(.intvec_tc5_0xbf) } > .
    .inttab_tc5_0C0 BIND (__INTTAB_CPU5 + 0x1800) ALIGN(8) : { *(.intvec_tc5_192  ) *(.intvec_tc5_0x  C0) *(.intvec_tc5_0xc0) } > .
    .inttab_tc5_0C1 BIND (__INTTAB_CPU5 + 0x1820) ALIGN(8) : { *(.intvec_tc5_193  ) *(.intvec_tc5_0x  C1) *(.intvec_tc5_0xc1) } > .
    .inttab_tc5_0C2 BIND (__INTTAB_CPU5 + 0x1840) ALIGN(8) : { *(.intvec_tc5_194  ) *(.intvec_tc5_0x  C2) *(.intvec_tc5_0xc2) } > .
    .inttab_tc5_0C3 BIND (__INTTAB_CPU5 + 0x1860) ALIGN(8) : { *(.intvec_tc5_195  ) *(.intvec_tc5_0x  C3) *(.intvec_tc5_0xc3) } > .
    .inttab_tc5_0C4 BIND (__INTTAB_CPU5 + 0x1880) ALIGN(8) : { *(.intvec_tc5_196  ) *(.intvec_tc5_0x  C4) *(.intvec_tc5_0xc4) } > .
    .inttab_tc5_0C5 BIND (__INTTAB_CPU5 + 0x18A0) ALIGN(8) : { *(.intvec_tc5_197  ) *(.intvec_tc5_0x  C5) *(.intvec_tc5_0xc5) } > .
    .inttab_tc5_0C6 BIND (__INTTAB_CPU5 + 0x18C0) ALIGN(8) : { *(.intvec_tc5_198  ) *(.intvec_tc5_0x  C6) *(.intvec_tc5_0xc6) } > .
    .inttab_tc5_0C7 BIND (__INTTAB_CPU5 + 0x18E0) ALIGN(8) : { *(.intvec_tc5_199  ) *(.intvec_tc5_0x  C7) *(.intvec_tc5_0xc7) } > .
    .inttab_tc5_0C8 BIND (__INTTAB_CPU5 + 0x1900) ALIGN(8) : { *(.intvec_tc5_200  ) *(.intvec_tc5_0x  C8) *(.intvec_tc5_0xc8) } > .
    .inttab_tc5_0C9 BIND (__INTTAB_CPU5 + 0x1920) ALIGN(8) : { *(.intvec_tc5_201  ) *(.intvec_tc5_0x  C9) *(.intvec_tc5_0xc9) } > .
    .inttab_tc5_0CA BIND (__INTTAB_CPU5 + 0x1940) ALIGN(8) : { *(.intvec_tc5_202  ) *(.intvec_tc5_0x  CA) *(.intvec_tc5_0xca) } > .
    .inttab_tc5_0CB BIND (__INTTAB_CPU5 + 0x1960) ALIGN(8) : { *(.intvec_tc5_203  ) *(.intvec_tc5_0x  CB) *(.intvec_tc5_0xcb) } > .
    .inttab_tc5_0CC BIND (__INTTAB_CPU5 + 0x1980) ALIGN(8) : { *(.intvec_tc5_204  ) *(.intvec_tc5_0x  CC) *(.intvec_tc5_0xcc) } > .
    .inttab_tc5_0CD BIND (__INTTAB_CPU5 + 0x19A0) ALIGN(8) : { *(.intvec_tc5_205  ) *(.intvec_tc5_0x  CD) *(.intvec_tc5_0xcd) } > .
    .inttab_tc5_0CE BIND (__INTTAB_CPU5 + 0x19C0) ALIGN(8) : { *(.intvec_tc5_206  ) *(.intvec_tc5_0x  CE) *(.intvec_tc5_0xce) } > .
    .inttab_tc5_0CF BIND (__INTTAB_CPU5 + 0x19E0) ALIGN(8) : { *(.intvec_tc5_207  ) *(.intvec_tc5_0x  CF) *(.intvec_tc5_0xcf) } > .
    .inttab_tc5_0D0 BIND (__INTTAB_CPU5 + 0x1A00) ALIGN(8) : { *(.intvec_tc5_208  ) *(.intvec_tc5_0x  D0) *(.intvec_tc5_0xd0) } > .
    .inttab_tc5_0D1 BIND (__INTTAB_CPU5 + 0x1A20) ALIGN(8) : { *(.intvec_tc5_209  ) *(.intvec_tc5_0x  D1) *(.intvec_tc5_0xd1) } > .
    .inttab_tc5_0D2 BIND (__INTTAB_CPU5 + 0x1A40) ALIGN(8) : { *(.intvec_tc5_210  ) *(.intvec_tc5_0x  D2) *(.intvec_tc5_0xd2) } > .
    .inttab_tc5_0D3 BIND (__INTTAB_CPU5 + 0x1A60) ALIGN(8) : { *(.intvec_tc5_211  ) *(.intvec_tc5_0x  D3) *(.intvec_tc5_0xd3) } > .
    .inttab_tc5_0D4 BIND (__INTTAB_CPU5 + 0x1A80) ALIGN(8) : { *(.intvec_tc5_212  ) *(.intvec_tc5_0x  D4) *(.intvec_tc5_0xd4) } > .
    .inttab_tc5_0D5 BIND (__INTTAB_CPU5 + 0x1AA0) ALIGN(8) : { *(.intvec_tc5_213  ) *(.intvec_tc5_0x  D5) *(.intvec_tc5_0xd5) } > .
    .inttab_tc5_0D6 BIND (__INTTAB_CPU5 + 0x1AC0) ALIGN(8) : { *(.intvec_tc5_214  ) *(.intvec_tc5_0x  D6) *(.intvec_tc5_0xd6) } > .
    .inttab_tc5_0D7 BIND (__INTTAB_CPU5 + 0x1AE0) ALIGN(8) : { *(.intvec_tc5_215  ) *(.intvec_tc5_0x  D7) *(.intvec_tc5_0xd7) } > .
    .inttab_tc5_0D8 BIND (__INTTAB_CPU5 + 0x1B00) ALIGN(8) : { *(.intvec_tc5_216  ) *(.intvec_tc5_0x  D8) *(.intvec_tc5_0xd8) } > .
    .inttab_tc5_0D9 BIND (__INTTAB_CPU5 + 0x1B20) ALIGN(8) : { *(.intvec_tc5_217  ) *(.intvec_tc5_0x  D9) *(.intvec_tc5_0xd9) } > .
    .inttab_tc5_0DA BIND (__INTTAB_CPU5 + 0x1B40) ALIGN(8) : { *(.intvec_tc5_218  ) *(.intvec_tc5_0x  DA) *(.intvec_tc5_0xda) } > .
    .inttab_tc5_0DB BIND (__INTTAB_CPU5 + 0x1B60) ALIGN(8) : { *(.intvec_tc5_219  ) *(.intvec_tc5_0x  DB) *(.intvec_tc5_0xdb) } > .
    .inttab_tc5_0DC BIND (__INTTAB_CPU5 + 0x1B80) ALIGN(8) : { *(.intvec_tc5_220  ) *(.intvec_tc5_0x  DC) *(.intvec_tc5_0xdc) } > .
    .inttab_tc5_0DD BIND (__INTTAB_CPU5 + 0x1BA0) ALIGN(8) : { *(.intvec_tc5_221  ) *(.intvec_tc5_0x  DD) *(.intvec_tc5_0xdd) } > .
    .inttab_tc5_0DE BIND (__INTTAB_CPU5 + 0x1BC0) ALIGN(8) : { *(.intvec_tc5_222  ) *(.intvec_tc5_0x  DE) *(.intvec_tc5_0xde) } > .
    .inttab_tc5_0DF BIND (__INTTAB_CPU5 + 0x1BE0) ALIGN(8) : { *(.intvec_tc5_223  ) *(.intvec_tc5_0x  DF) *(.intvec_tc5_0xdf) } > .
    .inttab_tc5_0E0 BIND (__INTTAB_CPU5 + 0x1C00) ALIGN(8) : { *(.intvec_tc5_224  ) *(.intvec_tc5_0x  E0) *(.intvec_tc5_0xe0) } > .
    .inttab_tc5_0E1 BIND (__INTTAB_CPU5 + 0x1C20) ALIGN(8) : { *(.intvec_tc5_225  ) *(.intvec_tc5_0x  E1) *(.intvec_tc5_0xe1) } > .
    .inttab_tc5_0E2 BIND (__INTTAB_CPU5 + 0x1C40) ALIGN(8) : { *(.intvec_tc5_226  ) *(.intvec_tc5_0x  E2) *(.intvec_tc5_0xe2) } > .
    .inttab_tc5_0E3 BIND (__INTTAB_CPU5 + 0x1C60) ALIGN(8) : { *(.intvec_tc5_227  ) *(.intvec_tc5_0x  E3) *(.intvec_tc5_0xe3) } > .
    .inttab_tc5_0E4 BIND (__INTTAB_CPU5 + 0x1C80) ALIGN(8) : { *(.intvec_tc5_228  ) *(.intvec_tc5_0x  E4) *(.intvec_tc5_0xe4) } > .
    .inttab_tc5_0E5 BIND (__INTTAB_CPU5 + 0x1CA0) ALIGN(8) : { *(.intvec_tc5_229  ) *(.intvec_tc5_0x  E5) *(.intvec_tc5_0xe5) } > .
    .inttab_tc5_0E6 BIND (__INTTAB_CPU5 + 0x1CC0) ALIGN(8) : { *(.intvec_tc5_230  ) *(.intvec_tc5_0x  E6) *(.intvec_tc5_0xe6) } > .
    .inttab_tc5_0E7 BIND (__INTTAB_CPU5 + 0x1CE0) ALIGN(8) : { *(.intvec_tc5_231  ) *(.intvec_tc5_0x  E7) *(.intvec_tc5_0xe7) } > .
    .inttab_tc5_0E8 BIND (__INTTAB_CPU5 + 0x1D00) ALIGN(8) : { *(.intvec_tc5_232  ) *(.intvec_tc5_0x  E8) *(.intvec_tc5_0xe8) } > .
    .inttab_tc5_0E9 BIND (__INTTAB_CPU5 + 0x1D20) ALIGN(8) : { *(.intvec_tc5_233  ) *(.intvec_tc5_0x  E9) *(.intvec_tc5_0xe9) } > .
    .inttab_tc5_0EA BIND (__INTTAB_CPU5 + 0x1D40) ALIGN(8) : { *(.intvec_tc5_234  ) *(.intvec_tc5_0x  EA) *(.intvec_tc5_0xea) } > .
    .inttab_tc5_0EB BIND (__INTTAB_CPU5 + 0x1D60) ALIGN(8) : { *(.intvec_tc5_235  ) *(.intvec_tc5_0x  EB) *(.intvec_tc5_0xeb) } > .
    .inttab_tc5_0EC BIND (__INTTAB_CPU5 + 0x1D80) ALIGN(8) : { *(.intvec_tc5_236  ) *(.intvec_tc5_0x  EC) *(.intvec_tc5_0xec) } > .
    .inttab_tc5_0ED BIND (__INTTAB_CPU5 + 0x1DA0) ALIGN(8) : { *(.intvec_tc5_237  ) *(.intvec_tc5_0x  ED) *(.intvec_tc5_0xed) } > .
    .inttab_tc5_0EE BIND (__INTTAB_CPU5 + 0x1DC0) ALIGN(8) : { *(.intvec_tc5_238  ) *(.intvec_tc5_0x  EE) *(.intvec_tc5_0xee) } > .
    .inttab_tc5_0EF BIND (__INTTAB_CPU5 + 0x1DE0) ALIGN(8) : { *(.intvec_tc5_239  ) *(.intvec_tc5_0x  EF) *(.intvec_tc5_0xef) } > .
    .inttab_tc5_0F0 BIND (__INTTAB_CPU5 + 0x1E00) ALIGN(8) : { *(.intvec_tc5_240  ) *(.intvec_tc5_0x  F0) *(.intvec_tc5_0xf0) } > .
    .inttab_tc5_0F1 BIND (__INTTAB_CPU5 + 0x1E20) ALIGN(8) : { *(.intvec_tc5_241  ) *(.intvec_tc5_0x  F1) *(.intvec_tc5_0xf1) } > .
    .inttab_tc5_0F2 BIND (__INTTAB_CPU5 + 0x1E40) ALIGN(8) : { *(.intvec_tc5_242  ) *(.intvec_tc5_0x  F2) *(.intvec_tc5_0xf2) } > .
    .inttab_tc5_0F3 BIND (__INTTAB_CPU5 + 0x1E60) ALIGN(8) : { *(.intvec_tc5_243  ) *(.intvec_tc5_0x  F3) *(.intvec_tc5_0xf3) } > .
    .inttab_tc5_0F4 BIND (__INTTAB_CPU5 + 0x1E80) ALIGN(8) : { *(.intvec_tc5_244  ) *(.intvec_tc5_0x  F4) *(.intvec_tc5_0xf4) } > .
    .inttab_tc5_0F5 BIND (__INTTAB_CPU5 + 0x1EA0) ALIGN(8) : { *(.intvec_tc5_245  ) *(.intvec_tc5_0x  F5) *(.intvec_tc5_0xf5) } > .
    .inttab_tc5_0F6 BIND (__INTTAB_CPU5 + 0x1EC0) ALIGN(8) : { *(.intvec_tc5_246  ) *(.intvec_tc5_0x  F6) *(.intvec_tc5_0xf6) } > .
    .inttab_tc5_0F7 BIND (__INTTAB_CPU5 + 0x1EE0) ALIGN(8) : { *(.intvec_tc5_247  ) *(.intvec_tc5_0x  F7) *(.intvec_tc5_0xf7) } > .
    .inttab_tc5_0F8 BIND (__INTTAB_CPU5 + 0x1F00) ALIGN(8) : { *(.intvec_tc5_248  ) *(.intvec_tc5_0x  F8) *(.intvec_tc5_0xf8) } > .
    .inttab_tc5_0F9 BIND (__INTTAB_CPU5 + 0x1F20) ALIGN(8) : { *(.intvec_tc5_249  ) *(.intvec_tc5_0x  F9) *(.intvec_tc5_0xf9) } > .
    .inttab_tc5_0FA BIND (__INTTAB_CPU5 + 0x1F40) ALIGN(8) : { *(.intvec_tc5_250  ) *(.intvec_tc5_0x  FA) *(.intvec_tc5_0xfa) } > .
    .inttab_tc5_0FB BIND (__INTTAB_CPU5 + 0x1F60) ALIGN(8) : { *(.intvec_tc5_251  ) *(.intvec_tc5_0x  FB) *(.intvec_tc5_0xfb) } > .
    .inttab_tc5_0FC BIND (__INTTAB_CPU5 + 0x1F80) ALIGN(8) : { *(.intvec_tc5_252  ) *(.intvec_tc5_0x  FC) *(.intvec_tc5_0xfc) } > .
    .inttab_tc5_0FD BIND (__INTTAB_CPU5 + 0x1FA0) ALIGN(8) : { *(.intvec_tc5_253  ) *(.intvec_tc5_0x  FD) *(.intvec_tc5_0xfd) } > .
    .inttab_tc5_0FE BIND (__INTTAB_CPU5 + 0x1FC0) ALIGN(8) : { *(.intvec_tc5_254  ) *(.intvec_tc5_0x  FE) *(.intvec_tc5_0xfe) } > .
    .inttab_tc5_0FF BIND (__INTTAB_CPU5 + 0x1FE0) ALIGN(8) : { *(.intvec_tc5_255  ) *(.intvec_tc5_0x  FF) *(.intvec_tc5_0xff) } > .

    .ppu_code (MEMENDADDR(pfls5) - LCF_PPU_FLASH_SIZE) : {.+= LCF_PPU_FLASH_SIZE;}
    PROVIDE(__PPU_IF_CONSTANTS = ADDR(.ppu_code));
    PROVIDE(__PPU_CODE_START   = ADDR(.ppu_code));
    PROVIDE(__PPU_CODE_END     = ENDADDR(.ppu_code));
    /* LMU memory sections */
    /* Near absolute LMURAM sections */
    .GLOBAL_lmuzdata ABS       ALIGN(4) : { *(.zlmudata) } > cpu5_dlmu
    .GLOBAL_lmuzbss  ABS CLEAR ALIGN(4) : { *(.zlmubss) } > .

    /* Far addressable LMURAM sections */
    .CPU5_lmudata       ALIGN(4) : { "*(.lmudata_cpu5)" } > cpu5_dlmu
    .CPU5_lmubss        ALIGN(4) : { "*(.lmubss_cpu5)" } > .

    /* LMURAM sections for shared data*/
    .GLOBAL_sharedvariables CLEAR  ALIGN(4) : 
    { 
        PROVIDE(__SHARED_DATA = .);
        *(.sharedvar)
    } > lmuram_nc

    /* Small addressable LMURAM sections */
   .GLOBAL_a9data ALIGN(4) : 
    {
        PROVIDE(__A9_MEM = .);
        "*(.data_a9)" "*(.data_a9.*)"
    } > lmuram_nc
    .GLOBAL_a9bss      CLEAR          : { "*(.bss_a9)" "*(.bss_a9.*)" } > .
	 /* Far addressable LMURAM sections */
    .GLOBAL_lmudata            ALIGN(4) : { *(.lmudata) } > .
    .GLOBAL_lmubss       CLEAR ALIGN(4) : { *(.lmubss) } > .
    PROVIDE(_SMALL_DATA_A9_ = __A9_MEM);

    // Reserve the location of non cached area into the cached area
    .GLOBAL_sharedvariables_res :
    { 
        .+= SIZEOF(.GLOBAL_sharedvariables);
        .+= SIZEOF(.GLOBAL_a9data);
        .+= SIZEOF(.GLOBAL_a9bss);
        .+= SIZEOF(.GLOBAL_lmudata);
        .+= SIZEOF(.GLOBAL_lmubss);
    } > lmuram

    PROVIDE(__SHARED_LMURAM_START = ADDR(.GLOBAL_sharedvariables_res));
    PROVIDE(__SHARED_LMURAM_END = MEMENDADDR(lmuram_nc));

    /* LMU7 reserved for PPU Usage*/
    .ppu_lmuram  (MEMENDADDR(lmuram) - LCF_PPU_LMURAM_SIZE) CLEAR  ALIGN(4) : 
    { 
        PROVIDE(__PPU_LMURAM_START = .);
        .+= LCF_PPU_LMURAM_SIZE;
        PROVIDE(__PPU_LMURAM_END = .);
    } > lmuram

    /* PPUCSM sections for where PPU RAM code and data are placed*/
    .ppu_csm   (MEMADDR(ppu_csm_nc)) CLEAR  ALIGN(4) : 
    { 
        PROVIDE(__PPU_CSM_START = .);
        .+= MEMENDADDR(ppu_csm_nc) - MEMADDR(ppu_csm_nc);
        PROVIDE(__PPU_CSM_END = .);
    } > ppu_csm_nc
// These special symbols mark the bounds of RAM and ROM memory.
// They are used by the MULTI debugger.
//
    PROVIDE(__ghs_ramstart  = MEMADDR(psram5));
    PROVIDE(__ghs_ramend    = MEMENDADDR(psram5));
    PROVIDE(__ghs_romstart  = MEMADDR(pfls5));
    PROVIDE(__ghs_romend    = MEMENDADDR(pfls5));

//
// These special symbols mark the bounds of RAM and ROM images of boot code.
// They are used by the GHS startup code (_start and __ghs_ind_crt0).
//
    PROVIDE(__ghs_rambootcodestart  = 0);
    PROVIDE(__ghs_rambootcodeend    = 0);
    PROVIDE(__ghs_rombootcodestart  = ADDR(.start_tc5));
    PROVIDE(__ghs_rombootcodeend    = ENDADDR(.secinfo));
    PROVIDE(__INTTAB_CPU5= __INTTAB_CPU5);
}
