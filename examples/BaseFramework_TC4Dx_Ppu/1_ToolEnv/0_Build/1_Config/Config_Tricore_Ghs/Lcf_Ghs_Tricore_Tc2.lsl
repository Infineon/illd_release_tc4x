DEFAULTS {

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
__INTTAB_CPU2 = LCF_INTVEC2_START;
}

MEMORY
{
    dsram2 : ORIGIN = 0x50000000, LENGTH = 240K
    psram2 : ORIGIN = 0x50100000, LENGTH = 64K

    psram_local : ORIGIN = 0xc0000000, LENGTH = 64K
    dsram_local : ORIGIN = 0xd0000000, LENGTH = 240K

    pfls2 : ORIGIN = 0x80800000, LENGTH = 2M
    pfls2_nc : ORIGIN = 0xA0800000, LENGTH = 2M


    pfls5 : ORIGIN = 0x81200000, LENGTH = 2M
    pfls5_nc : ORIGIN = 0xA1200000, LENGTH = 2M

    cpu2_dlmu : ORIGIN = 0x90100000, LENGTH= 512K
    cpu2_dlmu_nc : ORIGIN = 0xb0100000, LENGTH = 512K
    
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

	.CPU2_zdata ABS ALIGN(4) :
    {
        "Ifx_Ssw_Tc2.*(.zdata)" "Ifx_Ssw_Tc2.*(.zdata.*)"
        "Cpu2_Main.*(.zdata)" "Cpu2_Main.*(.zdata.*)"
        "*(.zdata_cpu2)" "*(.zdata_cpu2.*)"
    } > dsram2
    .CPU2_zbss ABS CLEAR ALIGN(4) :
    {
        "Ifx_Ssw_Tc2.*(.zbss)" "Ifx_Ssw_Tc2.*(.zbss.*)"
        "Cpu2_Main.*(.zbss)" "Cpu2_Main.*(.zbss.*)"
        "*(.zbss_cpu2)" "*(.zbss_cpu2.*)"
    } > .


    /*Un comment one of the below statement groups to enable CpuX DMI RAM to hold global variables*/
    //.GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram5
    //.GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram4
    //.GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram3
    .GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram2
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
		 .CPU2_data ALIGN(4) :
			{
				"Ifx_Ssw_Tc2.*(.data)" "Ifx_Ssw_Tc2.*(.data.*)"
				"Cpu2_Main.*(.data)" "Cpu2_Main.*(.data.*)"
				"*(.data_cpu2)" "*(.data_cpu2.*)"
			} > dsram2
			.CPU2_bss CLEAR ALIGN(4) :
			{
				"Ifx_Ssw_Tc2.*(.bss)" "Ifx_Ssw_Tc2.*(.bss.*)"
				"Cpu2_Main.*(.bss)" "Cpu2_Main.*(.bss.*)"
				"*(.bss_cpu2)" "*(.bss_cpu2.*)"
			} > .

		/*Un comment one of the below statement groups to enable CpuX DMI RAM to hold global variables*/
		//.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram5
		//.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram4
		//.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram3
		.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram2
		//.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram1
		//.GLOBAL_data          ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram0
		.GLOBAL_bss  CLEAR    ALIGN(4) : { "*(.bss)" "*(.bss.*)" } > .
    
    /* Reserve space for dynamic allocation */
    .heap                 ALIGN(4) PAD(LCF_HEAP_SIZE) : > .

    /* Stack and CSA defines */

    .CPU2.ustack BIND(LCF_DSPR2_START + LCF_USTACK2_OFFSET) : { __USTACK2_END = . ;. = . + LCF_USTACK2_SIZE; __USTACK2 = . ; } > dsram2
    .CPU2.istack BIND(LCF_DSPR2_START + LCF_ISTACK2_OFFSET) : { __ISTACK2_END = . ;. = . + LCF_ISTACK2_SIZE; __ISTACK2 = . ; } > .
    .CPU2.csa BIND(LCF_DSPR2_START + LCF_CSA2_OFFSET) :       { __CSA2 = . ; . = . + LCF_CSA2_SIZE; __CSA2_END = . ; } > .


    /* PSRAM Sections */
    .CPU2_psram_text ALIGN(2) : { "*(.psram_text_cpu2)" "*(.psram_text_cpu2.*)" "*(.cpu2_psram)" "*(.cpu2_psram.*)" } > psram2

    /DISCARD/ :
    { 
        *(.traptab_cpu0)
        *(.traptab_cpu1)
        *(.traptab_cpu3)
        *(.traptab_cpu4)
        *(.traptab_cpu5)
        *(.interface_const)
    }
    /* Fixed memory Allocations for _START for CPU 1 to 5 */
    .start_tc2 (LCF_STARTPTR_NC_CPU2) : AT(LCF_STARTPTR_CPU2) { PROVIDE(_start_cpu2 = .); *(.start_cpu2) } > pfls2_nc
    .start_res2 (LCF_STARTPTR_CPU2 + SIZEOF(.start_tc2)) : {} > pfls2
    .traptab_tc2 (LCF_TRAPVEC2_START) : { PROVIDE(__TRAPTAB_CPU2 = .); *(.traptab_cpu2) . = align(32);} > pfls2
    PROVIDE(__START0 = LCF_STARTPTR_NC_CPU0);
    PROVIDE(__START1 = LCF_STARTPTR_NC_CPU1);
    PROVIDE(__START2 = LCF_STARTPTR_NC_CPU2);
    PROVIDE(__START3 = LCF_STARTPTR_NC_CPU3);
    PROVIDE(__START4 = LCF_STARTPTR_NC_CPU4);
    PROVIDE(__START5 = LCF_STARTPTR_NC_CPU5);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU0 = 0); /* Not used */
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU1 = 0);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU2 = 1);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU3 = 0);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU4 = 0);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU5 = 0);
    /* Near absolute RAM sections */
    .GLOBAL_zrodata ABS   ALIGN(4) : { "Ifx_Ssw_Tc?.*(.zrodata)" "Cpu?_Main.*(.zrodata)" "*(.zrodata)" } > pfls2
	    .CPU2_rodata ALIGN(4) :
    {
        "Ifx_Ssw_Tc2.*(.rodata)" "Ifx_Ssw_Tc2.*(.rodata.*)"
        "Cpu2_Main.*(.rodata)" "Cpu2_Main.*(.rodata.*)"
        "*(.rodata_cpu2)" "*(.rodata_cpu2.*)"
    } > pfls2
    
    /* Small addressable ROM sections */
    /*Un comment one of the below statement groups to enable CpuX FLASHs to hold global constants*/
    //.GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls5
    //.GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls4
    //.GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls3
    .GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls2
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
    /*Un comment one of the below statement groups to enable CpuX FLASHs to hold global code sections*/
    //.GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls5
    //.GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls4
    //.GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls3
    .GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls2
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
    /*Un comment one of the below statement groups to enable CpuX FLASHs to hold global copy data sections*/
    //.ROM.CPU0_zdata       ROM(.CPU0_zdata) : > pfls5
    //.ROM.CPU0_zdata       ROM(.CPU0_zdata) : > pfls4
    //.ROM.CPU0_zdata       ROM(.CPU0_zdata) : > pfls3
    .ROM.CPU2_zdata       ROM(.CPU2_zdata) : > pfls2
    //.ROM.CPU0_zdata       ROM(.CPU0_zdata) : > pfls1
    //.ROM.CPU2_zdata       ROM(.CPU0_zdata) : > pfls0
    .ROM.CPU2_data         ROM(.CPU2_data) : > .

    .ROM.GLOBAL_zdata      ROM(.GLOBAL_zdata) : > .
    .ROM.GLOBAL_data       ROM(.GLOBAL_data) : > .
    .ROM.GLOBAL_sdata      ROM(.GLOBAL_sdata) : > .
    .ROM.CPU2_lmudata      ROM(.CPU2_lmudata) : > .

    .ROM.GLOBAL_lmuzdata   ROM(.GLOBAL_lmuzdata) : > .
    .ROM.GLOBAL_a9data     ROM(.GLOBAL_a9data) : > .
    .ROM.GLOBAL_lmudata    ROM(.GLOBAL_lmudata) : > .

    .ROM.CPU2_psram_text   ROM(.CPU2_psram_text) : > .


    /* Interrupt vector table located at PFLS2 */
    .inttab_tc2_000 BIND (__INTTAB_CPU2 + 0x0000) ALIGN(8) : { *(.intvec_tc2_0    ) *(.intvec_tc2_0x   0) *(.intvec_tc2_ 0x0) } > pfls2
    .inttab_tc2_001 BIND (__INTTAB_CPU2 + 0x0020) ALIGN(8) : { *(.intvec_tc2_1    ) *(.intvec_tc2_0x   1) *(.intvec_tc2_ 0x1) } > .
    .inttab_tc2_002 BIND (__INTTAB_CPU2 + 0x0040) ALIGN(8) : { *(.intvec_tc2_2    ) *(.intvec_tc2_0x   2) *(.intvec_tc2_ 0x2) } > .
    .inttab_tc2_003 BIND (__INTTAB_CPU2 + 0x0060) ALIGN(8) : { *(.intvec_tc2_3    ) *(.intvec_tc2_0x   3) *(.intvec_tc2_ 0x3) } > .
    .inttab_tc2_004 BIND (__INTTAB_CPU2 + 0x0080) ALIGN(8) : { *(.intvec_tc2_4    ) *(.intvec_tc2_0x   4) *(.intvec_tc2_ 0x4) } > .
    .inttab_tc2_005 BIND (__INTTAB_CPU2 + 0x00A0) ALIGN(8) : { *(.intvec_tc2_5    ) *(.intvec_tc2_0x   5) *(.intvec_tc2_ 0x5) } > .
    .inttab_tc2_006 BIND (__INTTAB_CPU2 + 0x00C0) ALIGN(8) : { *(.intvec_tc2_6    ) *(.intvec_tc2_0x   6) *(.intvec_tc2_ 0x6) } > .
    .inttab_tc2_007 BIND (__INTTAB_CPU2 + 0x00E0) ALIGN(8) : { *(.intvec_tc2_7    ) *(.intvec_tc2_0x   7) *(.intvec_tc2_ 0x7) } > .
    .inttab_tc2_008 BIND (__INTTAB_CPU2 + 0x0100) ALIGN(8) : { *(.intvec_tc2_8    ) *(.intvec_tc2_0x   8) *(.intvec_tc2_ 0x8) } > .
    .inttab_tc2_009 BIND (__INTTAB_CPU2 + 0x0120) ALIGN(8) : { *(.intvec_tc2_9    ) *(.intvec_tc2_0x   9) *(.intvec_tc2_ 0x9) } > .
    .inttab_tc2_00A BIND (__INTTAB_CPU2 + 0x0140) ALIGN(8) : { *(.intvec_tc2_10   ) *(.intvec_tc2_0x   A) *(.intvec_tc2_ 0xa) } > .
    .inttab_tc2_00B BIND (__INTTAB_CPU2 + 0x0160) ALIGN(8) : { *(.intvec_tc2_11   ) *(.intvec_tc2_0x   B) *(.intvec_tc2_ 0xb) } > .
    .inttab_tc2_00C BIND (__INTTAB_CPU2 + 0x0180) ALIGN(8) : { *(.intvec_tc2_12   ) *(.intvec_tc2_0x   C) *(.intvec_tc2_ 0xc) } > .
    .inttab_tc2_00D BIND (__INTTAB_CPU2 + 0x01A0) ALIGN(8) : { *(.intvec_tc2_13   ) *(.intvec_tc2_0x   D) *(.intvec_tc2_ 0xd) } > .
    .inttab_tc2_00E BIND (__INTTAB_CPU2 + 0x01C0) ALIGN(8) : { *(.intvec_tc2_14   ) *(.intvec_tc2_0x   E) *(.intvec_tc2_ 0xe) } > .
    .inttab_tc2_00F BIND (__INTTAB_CPU2 + 0x01E0) ALIGN(8) : { *(.intvec_tc2_15   ) *(.intvec_tc2_0x   F) *(.intvec_tc2_ 0xf) } > .
    .inttab_tc2_010 BIND (__INTTAB_CPU2 + 0x0200) ALIGN(8) : { *(.intvec_tc2_16   ) *(.intvec_tc2_0x  10) *(.intvec_tc2_0x10) } > .
    .inttab_tc2_011 BIND (__INTTAB_CPU2 + 0x0220) ALIGN(8) : { *(.intvec_tc2_17   ) *(.intvec_tc2_0x  11) *(.intvec_tc2_0x11) } > .
    .inttab_tc2_012 BIND (__INTTAB_CPU2 + 0x0240) ALIGN(8) : { *(.intvec_tc2_18   ) *(.intvec_tc2_0x  12) *(.intvec_tc2_0x12) } > .
    .inttab_tc2_013 BIND (__INTTAB_CPU2 + 0x0260) ALIGN(8) : { *(.intvec_tc2_19   ) *(.intvec_tc2_0x  13) *(.intvec_tc2_0x13) } > .
    .inttab_tc2_014 BIND (__INTTAB_CPU2 + 0x0280) ALIGN(8) : { *(.intvec_tc2_20   ) *(.intvec_tc2_0x  14) *(.intvec_tc2_0x14) } > .
    .inttab_tc2_015 BIND (__INTTAB_CPU2 + 0x02A0) ALIGN(8) : { *(.intvec_tc2_21   ) *(.intvec_tc2_0x  15) *(.intvec_tc2_0x15) } > .
    .inttab_tc2_016 BIND (__INTTAB_CPU2 + 0x02C0) ALIGN(8) : { *(.intvec_tc2_22   ) *(.intvec_tc2_0x  16) *(.intvec_tc2_0x16) } > .
    .inttab_tc2_017 BIND (__INTTAB_CPU2 + 0x02E0) ALIGN(8) : { *(.intvec_tc2_23   ) *(.intvec_tc2_0x  17) *(.intvec_tc2_0x17) } > .
    .inttab_tc2_018 BIND (__INTTAB_CPU2 + 0x0300) ALIGN(8) : { *(.intvec_tc2_24   ) *(.intvec_tc2_0x  18) *(.intvec_tc2_0x18) } > .
    .inttab_tc2_019 BIND (__INTTAB_CPU2 + 0x0320) ALIGN(8) : { *(.intvec_tc2_25   ) *(.intvec_tc2_0x  19) *(.intvec_tc2_0x19) } > .
    .inttab_tc2_01A BIND (__INTTAB_CPU2 + 0x0340) ALIGN(8) : { *(.intvec_tc2_26   ) *(.intvec_tc2_0x  1A) *(.intvec_tc2_0x1a) } > .
    .inttab_tc2_01B BIND (__INTTAB_CPU2 + 0x0360) ALIGN(8) : { *(.intvec_tc2_27   ) *(.intvec_tc2_0x  1B) *(.intvec_tc2_0x1b) } > .
    .inttab_tc2_01C BIND (__INTTAB_CPU2 + 0x0380) ALIGN(8) : { *(.intvec_tc2_28   ) *(.intvec_tc2_0x  1C) *(.intvec_tc2_0x1c) } > .
    .inttab_tc2_01D BIND (__INTTAB_CPU2 + 0x03A0) ALIGN(8) : { *(.intvec_tc2_29   ) *(.intvec_tc2_0x  1D) *(.intvec_tc2_0x1d) } > .
    .inttab_tc2_01E BIND (__INTTAB_CPU2 + 0x03C0) ALIGN(8) : { *(.intvec_tc2_30   ) *(.intvec_tc2_0x  1E) *(.intvec_tc2_0x1e) } > .
    .inttab_tc2_01F BIND (__INTTAB_CPU2 + 0x03E0) ALIGN(8) : { *(.intvec_tc2_31   ) *(.intvec_tc2_0x  1F) *(.intvec_tc2_0x1f) } > .
    .inttab_tc2_020 BIND (__INTTAB_CPU2 + 0x0400) ALIGN(8) : { *(.intvec_tc2_32   ) *(.intvec_tc2_0x  20) *(.intvec_tc2_0x20) } > .
    .inttab_tc2_021 BIND (__INTTAB_CPU2 + 0x0420) ALIGN(8) : { *(.intvec_tc2_33   ) *(.intvec_tc2_0x  21) *(.intvec_tc2_0x21) } > .
    .inttab_tc2_022 BIND (__INTTAB_CPU2 + 0x0440) ALIGN(8) : { *(.intvec_tc2_34   ) *(.intvec_tc2_0x  22) *(.intvec_tc2_0x22) } > .
    .inttab_tc2_023 BIND (__INTTAB_CPU2 + 0x0460) ALIGN(8) : { *(.intvec_tc2_35   ) *(.intvec_tc2_0x  23) *(.intvec_tc2_0x23) } > .
    .inttab_tc2_024 BIND (__INTTAB_CPU2 + 0x0480) ALIGN(8) : { *(.intvec_tc2_36   ) *(.intvec_tc2_0x  24) *(.intvec_tc2_0x24) } > .
    .inttab_tc2_025 BIND (__INTTAB_CPU2 + 0x04A0) ALIGN(8) : { *(.intvec_tc2_37   ) *(.intvec_tc2_0x  25) *(.intvec_tc2_0x25) } > .
    .inttab_tc2_026 BIND (__INTTAB_CPU2 + 0x04C0) ALIGN(8) : { *(.intvec_tc2_38   ) *(.intvec_tc2_0x  26) *(.intvec_tc2_0x26) } > .
    .inttab_tc2_027 BIND (__INTTAB_CPU2 + 0x04E0) ALIGN(8) : { *(.intvec_tc2_39   ) *(.intvec_tc2_0x  27) *(.intvec_tc2_0x27) } > .
    .inttab_tc2_028 BIND (__INTTAB_CPU2 + 0x0500) ALIGN(8) : { *(.intvec_tc2_40   ) *(.intvec_tc2_0x  28) *(.intvec_tc2_0x28) } > .
    .inttab_tc2_029 BIND (__INTTAB_CPU2 + 0x0520) ALIGN(8) : { *(.intvec_tc2_41   ) *(.intvec_tc2_0x  29) *(.intvec_tc2_0x29) } > .
    .inttab_tc2_02A BIND (__INTTAB_CPU2 + 0x0540) ALIGN(8) : { *(.intvec_tc2_42   ) *(.intvec_tc2_0x  2A) *(.intvec_tc2_0x2a) } > .
    .inttab_tc2_02B BIND (__INTTAB_CPU2 + 0x0560) ALIGN(8) : { *(.intvec_tc2_43   ) *(.intvec_tc2_0x  2B) *(.intvec_tc2_0x2b) } > .
    .inttab_tc2_02C BIND (__INTTAB_CPU2 + 0x0580) ALIGN(8) : { *(.intvec_tc2_44   ) *(.intvec_tc2_0x  2C) *(.intvec_tc2_0x2c) } > .
    .inttab_tc2_02D BIND (__INTTAB_CPU2 + 0x05A0) ALIGN(8) : { *(.intvec_tc2_45   ) *(.intvec_tc2_0x  2D) *(.intvec_tc2_0x2d) } > .
    .inttab_tc2_02E BIND (__INTTAB_CPU2 + 0x05C0) ALIGN(8) : { *(.intvec_tc2_46   ) *(.intvec_tc2_0x  2E) *(.intvec_tc2_0x2e) } > .
    .inttab_tc2_02F BIND (__INTTAB_CPU2 + 0x05E0) ALIGN(8) : { *(.intvec_tc2_47   ) *(.intvec_tc2_0x  2F) *(.intvec_tc2_0x2f) } > .
    .inttab_tc2_030 BIND (__INTTAB_CPU2 + 0x0600) ALIGN(8) : { *(.intvec_tc2_48   ) *(.intvec_tc2_0x  30) *(.intvec_tc2_0x30) } > .
    .inttab_tc2_031 BIND (__INTTAB_CPU2 + 0x0620) ALIGN(8) : { *(.intvec_tc2_49   ) *(.intvec_tc2_0x  31) *(.intvec_tc2_0x31) } > .
    .inttab_tc2_032 BIND (__INTTAB_CPU2 + 0x0640) ALIGN(8) : { *(.intvec_tc2_50   ) *(.intvec_tc2_0x  32) *(.intvec_tc2_0x32) } > .
    .inttab_tc2_033 BIND (__INTTAB_CPU2 + 0x0660) ALIGN(8) : { *(.intvec_tc2_51   ) *(.intvec_tc2_0x  33) *(.intvec_tc2_0x33) } > .
    .inttab_tc2_034 BIND (__INTTAB_CPU2 + 0x0680) ALIGN(8) : { *(.intvec_tc2_52   ) *(.intvec_tc2_0x  34) *(.intvec_tc2_0x34) } > .
    .inttab_tc2_035 BIND (__INTTAB_CPU2 + 0x06A0) ALIGN(8) : { *(.intvec_tc2_53   ) *(.intvec_tc2_0x  35) *(.intvec_tc2_0x35) } > .
    .inttab_tc2_036 BIND (__INTTAB_CPU2 + 0x06C0) ALIGN(8) : { *(.intvec_tc2_54   ) *(.intvec_tc2_0x  36) *(.intvec_tc2_0x36) } > .
    .inttab_tc2_037 BIND (__INTTAB_CPU2 + 0x06E0) ALIGN(8) : { *(.intvec_tc2_55   ) *(.intvec_tc2_0x  37) *(.intvec_tc2_0x37) } > .
    .inttab_tc2_038 BIND (__INTTAB_CPU2 + 0x0700) ALIGN(8) : { *(.intvec_tc2_56   ) *(.intvec_tc2_0x  38) *(.intvec_tc2_0x38) } > .
    .inttab_tc2_039 BIND (__INTTAB_CPU2 + 0x0720) ALIGN(8) : { *(.intvec_tc2_57   ) *(.intvec_tc2_0x  39) *(.intvec_tc2_0x39) } > .
    .inttab_tc2_03A BIND (__INTTAB_CPU2 + 0x0740) ALIGN(8) : { *(.intvec_tc2_58   ) *(.intvec_tc2_0x  3A) *(.intvec_tc2_0x3a) } > .
    .inttab_tc2_03B BIND (__INTTAB_CPU2 + 0x0760) ALIGN(8) : { *(.intvec_tc2_59   ) *(.intvec_tc2_0x  3B) *(.intvec_tc2_0x3b) } > .
    .inttab_tc2_03C BIND (__INTTAB_CPU2 + 0x0780) ALIGN(8) : { *(.intvec_tc2_60   ) *(.intvec_tc2_0x  3C) *(.intvec_tc2_0x3c) } > .
    .inttab_tc2_03D BIND (__INTTAB_CPU2 + 0x07A0) ALIGN(8) : { *(.intvec_tc2_61   ) *(.intvec_tc2_0x  3D) *(.intvec_tc2_0x3d) } > .
    .inttab_tc2_03E BIND (__INTTAB_CPU2 + 0x07C0) ALIGN(8) : { *(.intvec_tc2_62   ) *(.intvec_tc2_0x  3E) *(.intvec_tc2_0x3e) } > .
    .inttab_tc2_03F BIND (__INTTAB_CPU2 + 0x07E0) ALIGN(8) : { *(.intvec_tc2_63   ) *(.intvec_tc2_0x  3F) *(.intvec_tc2_0x3f) } > .
    .inttab_tc2_040 BIND (__INTTAB_CPU2 + 0x0800) ALIGN(8) : { *(.intvec_tc2_64   ) *(.intvec_tc2_0x  40) *(.intvec_tc2_0x40) } > .
    .inttab_tc2_041 BIND (__INTTAB_CPU2 + 0x0820) ALIGN(8) : { *(.intvec_tc2_65   ) *(.intvec_tc2_0x  41) *(.intvec_tc2_0x41) } > .
    .inttab_tc2_042 BIND (__INTTAB_CPU2 + 0x0840) ALIGN(8) : { *(.intvec_tc2_66   ) *(.intvec_tc2_0x  42) *(.intvec_tc2_0x42) } > .
    .inttab_tc2_043 BIND (__INTTAB_CPU2 + 0x0860) ALIGN(8) : { *(.intvec_tc2_67   ) *(.intvec_tc2_0x  43) *(.intvec_tc2_0x43) } > .
    .inttab_tc2_044 BIND (__INTTAB_CPU2 + 0x0880) ALIGN(8) : { *(.intvec_tc2_68   ) *(.intvec_tc2_0x  44) *(.intvec_tc2_0x44) } > .
    .inttab_tc2_045 BIND (__INTTAB_CPU2 + 0x08A0) ALIGN(8) : { *(.intvec_tc2_69   ) *(.intvec_tc2_0x  45) *(.intvec_tc2_0x45) } > .
    .inttab_tc2_046 BIND (__INTTAB_CPU2 + 0x08C0) ALIGN(8) : { *(.intvec_tc2_70   ) *(.intvec_tc2_0x  46) *(.intvec_tc2_0x46) } > .
    .inttab_tc2_047 BIND (__INTTAB_CPU2 + 0x08E0) ALIGN(8) : { *(.intvec_tc2_71   ) *(.intvec_tc2_0x  47) *(.intvec_tc2_0x47) } > .
    .inttab_tc2_048 BIND (__INTTAB_CPU2 + 0x0900) ALIGN(8) : { *(.intvec_tc2_72   ) *(.intvec_tc2_0x  48) *(.intvec_tc2_0x48) } > .
    .inttab_tc2_049 BIND (__INTTAB_CPU2 + 0x0920) ALIGN(8) : { *(.intvec_tc2_73   ) *(.intvec_tc2_0x  49) *(.intvec_tc2_0x49) } > .
    .inttab_tc2_04A BIND (__INTTAB_CPU2 + 0x0940) ALIGN(8) : { *(.intvec_tc2_74   ) *(.intvec_tc2_0x  4A) *(.intvec_tc2_0x4a) } > .
    .inttab_tc2_04B BIND (__INTTAB_CPU2 + 0x0960) ALIGN(8) : { *(.intvec_tc2_75   ) *(.intvec_tc2_0x  4B) *(.intvec_tc2_0x4b) } > .
    .inttab_tc2_04C BIND (__INTTAB_CPU2 + 0x0980) ALIGN(8) : { *(.intvec_tc2_76   ) *(.intvec_tc2_0x  4C) *(.intvec_tc2_0x4c) } > .
    .inttab_tc2_04D BIND (__INTTAB_CPU2 + 0x09A0) ALIGN(8) : { *(.intvec_tc2_77   ) *(.intvec_tc2_0x  4D) *(.intvec_tc2_0x4d) } > .
    .inttab_tc2_04E BIND (__INTTAB_CPU2 + 0x09C0) ALIGN(8) : { *(.intvec_tc2_78   ) *(.intvec_tc2_0x  4E) *(.intvec_tc2_0x4e) } > .
    .inttab_tc2_04F BIND (__INTTAB_CPU2 + 0x09E0) ALIGN(8) : { *(.intvec_tc2_79   ) *(.intvec_tc2_0x  4F) *(.intvec_tc2_0x4f) } > .
    .inttab_tc2_050 BIND (__INTTAB_CPU2 + 0x0A00) ALIGN(8) : { *(.intvec_tc2_80   ) *(.intvec_tc2_0x  50) *(.intvec_tc2_0x50) } > .
    .inttab_tc2_051 BIND (__INTTAB_CPU2 + 0x0A20) ALIGN(8) : { *(.intvec_tc2_81   ) *(.intvec_tc2_0x  51) *(.intvec_tc2_0x51) } > .
    .inttab_tc2_052 BIND (__INTTAB_CPU2 + 0x0A40) ALIGN(8) : { *(.intvec_tc2_82   ) *(.intvec_tc2_0x  52) *(.intvec_tc2_0x52) } > .
    .inttab_tc2_053 BIND (__INTTAB_CPU2 + 0x0A60) ALIGN(8) : { *(.intvec_tc2_83   ) *(.intvec_tc2_0x  53) *(.intvec_tc2_0x53) } > .
    .inttab_tc2_054 BIND (__INTTAB_CPU2 + 0x0A80) ALIGN(8) : { *(.intvec_tc2_84   ) *(.intvec_tc2_0x  54) *(.intvec_tc2_0x54) } > .
    .inttab_tc2_055 BIND (__INTTAB_CPU2 + 0x0AA0) ALIGN(8) : { *(.intvec_tc2_85   ) *(.intvec_tc2_0x  55) *(.intvec_tc2_0x55) } > .
    .inttab_tc2_056 BIND (__INTTAB_CPU2 + 0x0AC0) ALIGN(8) : { *(.intvec_tc2_86   ) *(.intvec_tc2_0x  56) *(.intvec_tc2_0x56) } > .
    .inttab_tc2_057 BIND (__INTTAB_CPU2 + 0x0AE0) ALIGN(8) : { *(.intvec_tc2_87   ) *(.intvec_tc2_0x  57) *(.intvec_tc2_0x57) } > .
    .inttab_tc2_058 BIND (__INTTAB_CPU2 + 0x0B00) ALIGN(8) : { *(.intvec_tc2_88   ) *(.intvec_tc2_0x  58) *(.intvec_tc2_0x58) } > .
    .inttab_tc2_059 BIND (__INTTAB_CPU2 + 0x0B20) ALIGN(8) : { *(.intvec_tc2_89   ) *(.intvec_tc2_0x  59) *(.intvec_tc2_0x59) } > .
    .inttab_tc2_05A BIND (__INTTAB_CPU2 + 0x0B40) ALIGN(8) : { *(.intvec_tc2_90   ) *(.intvec_tc2_0x  5A) *(.intvec_tc2_0x5a) } > .
    .inttab_tc2_05B BIND (__INTTAB_CPU2 + 0x0B60) ALIGN(8) : { *(.intvec_tc2_91   ) *(.intvec_tc2_0x  5B) *(.intvec_tc2_0x5b) } > .
    .inttab_tc2_05C BIND (__INTTAB_CPU2 + 0x0B80) ALIGN(8) : { *(.intvec_tc2_92   ) *(.intvec_tc2_0x  5C) *(.intvec_tc2_0x5c) } > .
    .inttab_tc2_05D BIND (__INTTAB_CPU2 + 0x0BA0) ALIGN(8) : { *(.intvec_tc2_93   ) *(.intvec_tc2_0x  5D) *(.intvec_tc2_0x5d) } > .
    .inttab_tc2_05E BIND (__INTTAB_CPU2 + 0x0BC0) ALIGN(8) : { *(.intvec_tc2_94   ) *(.intvec_tc2_0x  5E) *(.intvec_tc2_0x5e) } > .
    .inttab_tc2_05F BIND (__INTTAB_CPU2 + 0x0BE0) ALIGN(8) : { *(.intvec_tc2_95   ) *(.intvec_tc2_0x  5F) *(.intvec_tc2_0x5f) } > .
    .inttab_tc2_060 BIND (__INTTAB_CPU2 + 0x0C00) ALIGN(8) : { *(.intvec_tc2_96   ) *(.intvec_tc2_0x  60) *(.intvec_tc2_0x60) } > .
    .inttab_tc2_061 BIND (__INTTAB_CPU2 + 0x0C20) ALIGN(8) : { *(.intvec_tc2_97   ) *(.intvec_tc2_0x  61) *(.intvec_tc2_0x61) } > .
    .inttab_tc2_062 BIND (__INTTAB_CPU2 + 0x0C40) ALIGN(8) : { *(.intvec_tc2_98   ) *(.intvec_tc2_0x  62) *(.intvec_tc2_0x62) } > .
    .inttab_tc2_063 BIND (__INTTAB_CPU2 + 0x0C60) ALIGN(8) : { *(.intvec_tc2_99   ) *(.intvec_tc2_0x  63) *(.intvec_tc2_0x63) } > .
    .inttab_tc2_064 BIND (__INTTAB_CPU2 + 0x0C80) ALIGN(8) : { *(.intvec_tc2_100  ) *(.intvec_tc2_0x  64) *(.intvec_tc2_0x64) } > .
    .inttab_tc2_065 BIND (__INTTAB_CPU2 + 0x0CA0) ALIGN(8) : { *(.intvec_tc2_101  ) *(.intvec_tc2_0x  65) *(.intvec_tc2_0x65) } > .
    .inttab_tc2_066 BIND (__INTTAB_CPU2 + 0x0CC0) ALIGN(8) : { *(.intvec_tc2_102  ) *(.intvec_tc2_0x  66) *(.intvec_tc2_0x66) } > .
    .inttab_tc2_067 BIND (__INTTAB_CPU2 + 0x0CE0) ALIGN(8) : { *(.intvec_tc2_103  ) *(.intvec_tc2_0x  67) *(.intvec_tc2_0x67) } > .
    .inttab_tc2_068 BIND (__INTTAB_CPU2 + 0x0D00) ALIGN(8) : { *(.intvec_tc2_104  ) *(.intvec_tc2_0x  68) *(.intvec_tc2_0x68) } > .
    .inttab_tc2_069 BIND (__INTTAB_CPU2 + 0x0D20) ALIGN(8) : { *(.intvec_tc2_105  ) *(.intvec_tc2_0x  69) *(.intvec_tc2_0x69) } > .
    .inttab_tc2_06A BIND (__INTTAB_CPU2 + 0x0D40) ALIGN(8) : { *(.intvec_tc2_106  ) *(.intvec_tc2_0x  6A) *(.intvec_tc2_0x6a) } > .
    .inttab_tc2_06B BIND (__INTTAB_CPU2 + 0x0D60) ALIGN(8) : { *(.intvec_tc2_107  ) *(.intvec_tc2_0x  6B) *(.intvec_tc2_0x6b) } > .
    .inttab_tc2_06C BIND (__INTTAB_CPU2 + 0x0D80) ALIGN(8) : { *(.intvec_tc2_108  ) *(.intvec_tc2_0x  6C) *(.intvec_tc2_0x6c) } > .
    .inttab_tc2_06D BIND (__INTTAB_CPU2 + 0x0DA0) ALIGN(8) : { *(.intvec_tc2_109  ) *(.intvec_tc2_0x  6D) *(.intvec_tc2_0x6d) } > .
    .inttab_tc2_06E BIND (__INTTAB_CPU2 + 0x0DC0) ALIGN(8) : { *(.intvec_tc2_110  ) *(.intvec_tc2_0x  6E) *(.intvec_tc2_0x6e) } > .
    .inttab_tc2_06F BIND (__INTTAB_CPU2 + 0x0DE0) ALIGN(8) : { *(.intvec_tc2_111  ) *(.intvec_tc2_0x  6F) *(.intvec_tc2_0x6f) } > .
    .inttab_tc2_070 BIND (__INTTAB_CPU2 + 0x0E00) ALIGN(8) : { *(.intvec_tc2_112  ) *(.intvec_tc2_0x  70) *(.intvec_tc2_0x70) } > .
    .inttab_tc2_071 BIND (__INTTAB_CPU2 + 0x0E20) ALIGN(8) : { *(.intvec_tc2_113  ) *(.intvec_tc2_0x  71) *(.intvec_tc2_0x71) } > .
    .inttab_tc2_072 BIND (__INTTAB_CPU2 + 0x0E40) ALIGN(8) : { *(.intvec_tc2_114  ) *(.intvec_tc2_0x  72) *(.intvec_tc2_0x72) } > .
    .inttab_tc2_073 BIND (__INTTAB_CPU2 + 0x0E60) ALIGN(8) : { *(.intvec_tc2_115  ) *(.intvec_tc2_0x  73) *(.intvec_tc2_0x73) } > .
    .inttab_tc2_074 BIND (__INTTAB_CPU2 + 0x0E80) ALIGN(8) : { *(.intvec_tc2_116  ) *(.intvec_tc2_0x  74) *(.intvec_tc2_0x74) } > .
    .inttab_tc2_075 BIND (__INTTAB_CPU2 + 0x0EA0) ALIGN(8) : { *(.intvec_tc2_117  ) *(.intvec_tc2_0x  75) *(.intvec_tc2_0x75) } > .
    .inttab_tc2_076 BIND (__INTTAB_CPU2 + 0x0EC0) ALIGN(8) : { *(.intvec_tc2_118  ) *(.intvec_tc2_0x  76) *(.intvec_tc2_0x76) } > .
    .inttab_tc2_077 BIND (__INTTAB_CPU2 + 0x0EE0) ALIGN(8) : { *(.intvec_tc2_119  ) *(.intvec_tc2_0x  77) *(.intvec_tc2_0x77) } > .
    .inttab_tc2_078 BIND (__INTTAB_CPU2 + 0x0F00) ALIGN(8) : { *(.intvec_tc2_120  ) *(.intvec_tc2_0x  78) *(.intvec_tc2_0x78) } > .
    .inttab_tc2_079 BIND (__INTTAB_CPU2 + 0x0F20) ALIGN(8) : { *(.intvec_tc2_121  ) *(.intvec_tc2_0x  79) *(.intvec_tc2_0x79) } > .
    .inttab_tc2_07A BIND (__INTTAB_CPU2 + 0x0F40) ALIGN(8) : { *(.intvec_tc2_122  ) *(.intvec_tc2_0x  7A) *(.intvec_tc2_0x7a) } > .
    .inttab_tc2_07B BIND (__INTTAB_CPU2 + 0x0F60) ALIGN(8) : { *(.intvec_tc2_123  ) *(.intvec_tc2_0x  7B) *(.intvec_tc2_0x7b) } > .
    .inttab_tc2_07C BIND (__INTTAB_CPU2 + 0x0F80) ALIGN(8) : { *(.intvec_tc2_124  ) *(.intvec_tc2_0x  7C) *(.intvec_tc2_0x7c) } > .
    .inttab_tc2_07D BIND (__INTTAB_CPU2 + 0x0FA0) ALIGN(8) : { *(.intvec_tc2_125  ) *(.intvec_tc2_0x  7D) *(.intvec_tc2_0x7d) } > .
    .inttab_tc2_07E BIND (__INTTAB_CPU2 + 0x0FC0) ALIGN(8) : { *(.intvec_tc2_126  ) *(.intvec_tc2_0x  7E) *(.intvec_tc2_0x7e) } > .
    .inttab_tc2_07F BIND (__INTTAB_CPU2 + 0x0FE0) ALIGN(8) : { *(.intvec_tc2_127  ) *(.intvec_tc2_0x  7F) *(.intvec_tc2_0x7f) } > .
    .inttab_tc2_080 BIND (__INTTAB_CPU2 + 0x1000) ALIGN(8) : { *(.intvec_tc2_128  ) *(.intvec_tc2_0x  80) *(.intvec_tc2_0x80) } > .
    .inttab_tc2_081 BIND (__INTTAB_CPU2 + 0x1020) ALIGN(8) : { *(.intvec_tc2_129  ) *(.intvec_tc2_0x  81) *(.intvec_tc2_0x81) } > .
    .inttab_tc2_082 BIND (__INTTAB_CPU2 + 0x1040) ALIGN(8) : { *(.intvec_tc2_130  ) *(.intvec_tc2_0x  82) *(.intvec_tc2_0x82) } > .
    .inttab_tc2_083 BIND (__INTTAB_CPU2 + 0x1060) ALIGN(8) : { *(.intvec_tc2_131  ) *(.intvec_tc2_0x  83) *(.intvec_tc2_0x83) } > .
    .inttab_tc2_084 BIND (__INTTAB_CPU2 + 0x1080) ALIGN(8) : { *(.intvec_tc2_132  ) *(.intvec_tc2_0x  84) *(.intvec_tc2_0x84) } > .
    .inttab_tc2_085 BIND (__INTTAB_CPU2 + 0x10A0) ALIGN(8) : { *(.intvec_tc2_133  ) *(.intvec_tc2_0x  85) *(.intvec_tc2_0x85) } > .
    .inttab_tc2_086 BIND (__INTTAB_CPU2 + 0x10C0) ALIGN(8) : { *(.intvec_tc2_134  ) *(.intvec_tc2_0x  86) *(.intvec_tc2_0x86) } > .
    .inttab_tc2_087 BIND (__INTTAB_CPU2 + 0x10E0) ALIGN(8) : { *(.intvec_tc2_135  ) *(.intvec_tc2_0x  87) *(.intvec_tc2_0x87) } > .
    .inttab_tc2_088 BIND (__INTTAB_CPU2 + 0x1100) ALIGN(8) : { *(.intvec_tc2_136  ) *(.intvec_tc2_0x  88) *(.intvec_tc2_0x88) } > .
    .inttab_tc2_089 BIND (__INTTAB_CPU2 + 0x1120) ALIGN(8) : { *(.intvec_tc2_137  ) *(.intvec_tc2_0x  89) *(.intvec_tc2_0x89) } > .
    .inttab_tc2_08A BIND (__INTTAB_CPU2 + 0x1140) ALIGN(8) : { *(.intvec_tc2_138  ) *(.intvec_tc2_0x  8A) *(.intvec_tc2_0x8a) } > .
    .inttab_tc2_08B BIND (__INTTAB_CPU2 + 0x1160) ALIGN(8) : { *(.intvec_tc2_139  ) *(.intvec_tc2_0x  8B) *(.intvec_tc2_0x8b) } > .
    .inttab_tc2_08C BIND (__INTTAB_CPU2 + 0x1180) ALIGN(8) : { *(.intvec_tc2_140  ) *(.intvec_tc2_0x  8C) *(.intvec_tc2_0x8c) } > .
    .inttab_tc2_08D BIND (__INTTAB_CPU2 + 0x11A0) ALIGN(8) : { *(.intvec_tc2_141  ) *(.intvec_tc2_0x  8D) *(.intvec_tc2_0x8d) } > .
    .inttab_tc2_08E BIND (__INTTAB_CPU2 + 0x11C0) ALIGN(8) : { *(.intvec_tc2_142  ) *(.intvec_tc2_0x  8E) *(.intvec_tc2_0x8e) } > .
    .inttab_tc2_08F BIND (__INTTAB_CPU2 + 0x11E0) ALIGN(8) : { *(.intvec_tc2_143  ) *(.intvec_tc2_0x  8F) *(.intvec_tc2_0x8f) } > .
    .inttab_tc2_090 BIND (__INTTAB_CPU2 + 0x1200) ALIGN(8) : { *(.intvec_tc2_144  ) *(.intvec_tc2_0x  90) *(.intvec_tc2_0x90) } > .
    .inttab_tc2_091 BIND (__INTTAB_CPU2 + 0x1220) ALIGN(8) : { *(.intvec_tc2_145  ) *(.intvec_tc2_0x  91) *(.intvec_tc2_0x91) } > .
    .inttab_tc2_092 BIND (__INTTAB_CPU2 + 0x1240) ALIGN(8) : { *(.intvec_tc2_146  ) *(.intvec_tc2_0x  92) *(.intvec_tc2_0x92) } > .
    .inttab_tc2_093 BIND (__INTTAB_CPU2 + 0x1260) ALIGN(8) : { *(.intvec_tc2_147  ) *(.intvec_tc2_0x  93) *(.intvec_tc2_0x93) } > .
    .inttab_tc2_094 BIND (__INTTAB_CPU2 + 0x1280) ALIGN(8) : { *(.intvec_tc2_148  ) *(.intvec_tc2_0x  94) *(.intvec_tc2_0x94) } > .
    .inttab_tc2_095 BIND (__INTTAB_CPU2 + 0x12A0) ALIGN(8) : { *(.intvec_tc2_149  ) *(.intvec_tc2_0x  95) *(.intvec_tc2_0x95) } > .
    .inttab_tc2_096 BIND (__INTTAB_CPU2 + 0x12C0) ALIGN(8) : { *(.intvec_tc2_150  ) *(.intvec_tc2_0x  96) *(.intvec_tc2_0x96) } > .
    .inttab_tc2_097 BIND (__INTTAB_CPU2 + 0x12E0) ALIGN(8) : { *(.intvec_tc2_151  ) *(.intvec_tc2_0x  97) *(.intvec_tc2_0x97) } > .
    .inttab_tc2_098 BIND (__INTTAB_CPU2 + 0x1300) ALIGN(8) : { *(.intvec_tc2_152  ) *(.intvec_tc2_0x  98) *(.intvec_tc2_0x98) } > .
    .inttab_tc2_099 BIND (__INTTAB_CPU2 + 0x1320) ALIGN(8) : { *(.intvec_tc2_153  ) *(.intvec_tc2_0x  99) *(.intvec_tc2_0x99) } > .
    .inttab_tc2_09A BIND (__INTTAB_CPU2 + 0x1340) ALIGN(8) : { *(.intvec_tc2_154  ) *(.intvec_tc2_0x  9A) *(.intvec_tc2_0x9a) } > .
    .inttab_tc2_09B BIND (__INTTAB_CPU2 + 0x1360) ALIGN(8) : { *(.intvec_tc2_155  ) *(.intvec_tc2_0x  9B) *(.intvec_tc2_0x9b) } > .
    .inttab_tc2_09C BIND (__INTTAB_CPU2 + 0x1380) ALIGN(8) : { *(.intvec_tc2_156  ) *(.intvec_tc2_0x  9C) *(.intvec_tc2_0x9c) } > .
    .inttab_tc2_09D BIND (__INTTAB_CPU2 + 0x13A0) ALIGN(8) : { *(.intvec_tc2_157  ) *(.intvec_tc2_0x  9D) *(.intvec_tc2_0x9d) } > .
    .inttab_tc2_09E BIND (__INTTAB_CPU2 + 0x13C0) ALIGN(8) : { *(.intvec_tc2_158  ) *(.intvec_tc2_0x  9E) *(.intvec_tc2_0x9e) } > .
    .inttab_tc2_09F BIND (__INTTAB_CPU2 + 0x13E0) ALIGN(8) : { *(.intvec_tc2_159  ) *(.intvec_tc2_0x  9F) *(.intvec_tc2_0x9f) } > .
    .inttab_tc2_0A0 BIND (__INTTAB_CPU2 + 0x1400) ALIGN(8) : { *(.intvec_tc2_160  ) *(.intvec_tc2_0x  A0) *(.intvec_tc2_0xa0) } > .
    .inttab_tc2_0A1 BIND (__INTTAB_CPU2 + 0x1420) ALIGN(8) : { *(.intvec_tc2_161  ) *(.intvec_tc2_0x  A1) *(.intvec_tc2_0xa1) } > .
    .inttab_tc2_0A2 BIND (__INTTAB_CPU2 + 0x1440) ALIGN(8) : { *(.intvec_tc2_162  ) *(.intvec_tc2_0x  A2) *(.intvec_tc2_0xa2) } > .
    .inttab_tc2_0A3 BIND (__INTTAB_CPU2 + 0x1460) ALIGN(8) : { *(.intvec_tc2_163  ) *(.intvec_tc2_0x  A3) *(.intvec_tc2_0xa3) } > .
    .inttab_tc2_0A4 BIND (__INTTAB_CPU2 + 0x1480) ALIGN(8) : { *(.intvec_tc2_164  ) *(.intvec_tc2_0x  A4) *(.intvec_tc2_0xa4) } > .
    .inttab_tc2_0A5 BIND (__INTTAB_CPU2 + 0x14A0) ALIGN(8) : { *(.intvec_tc2_165  ) *(.intvec_tc2_0x  A5) *(.intvec_tc2_0xa5) } > .
    .inttab_tc2_0A6 BIND (__INTTAB_CPU2 + 0x14C0) ALIGN(8) : { *(.intvec_tc2_166  ) *(.intvec_tc2_0x  A6) *(.intvec_tc2_0xa6) } > .
    .inttab_tc2_0A7 BIND (__INTTAB_CPU2 + 0x14E0) ALIGN(8) : { *(.intvec_tc2_167  ) *(.intvec_tc2_0x  A7) *(.intvec_tc2_0xa7) } > .
    .inttab_tc2_0A8 BIND (__INTTAB_CPU2 + 0x1500) ALIGN(8) : { *(.intvec_tc2_168  ) *(.intvec_tc2_0x  A8) *(.intvec_tc2_0xa8) } > .
    .inttab_tc2_0A9 BIND (__INTTAB_CPU2 + 0x1520) ALIGN(8) : { *(.intvec_tc2_169  ) *(.intvec_tc2_0x  A9) *(.intvec_tc2_0xa9) } > .
    .inttab_tc2_0AA BIND (__INTTAB_CPU2 + 0x1540) ALIGN(8) : { *(.intvec_tc2_170  ) *(.intvec_tc2_0x  AA) *(.intvec_tc2_0xaa) } > .
    .inttab_tc2_0AB BIND (__INTTAB_CPU2 + 0x1560) ALIGN(8) : { *(.intvec_tc2_171  ) *(.intvec_tc2_0x  AB) *(.intvec_tc2_0xab) } > .
    .inttab_tc2_0AC BIND (__INTTAB_CPU2 + 0x1580) ALIGN(8) : { *(.intvec_tc2_172  ) *(.intvec_tc2_0x  AC) *(.intvec_tc2_0xac) } > .
    .inttab_tc2_0AD BIND (__INTTAB_CPU2 + 0x15A0) ALIGN(8) : { *(.intvec_tc2_173  ) *(.intvec_tc2_0x  AD) *(.intvec_tc2_0xad) } > .
    .inttab_tc2_0AE BIND (__INTTAB_CPU2 + 0x15C0) ALIGN(8) : { *(.intvec_tc2_174  ) *(.intvec_tc2_0x  AE) *(.intvec_tc2_0xae) } > .
    .inttab_tc2_0AF BIND (__INTTAB_CPU2 + 0x15E0) ALIGN(8) : { *(.intvec_tc2_175  ) *(.intvec_tc2_0x  AF) *(.intvec_tc2_0xaf) } > .
    .inttab_tc2_0B0 BIND (__INTTAB_CPU2 + 0x1600) ALIGN(8) : { *(.intvec_tc2_176  ) *(.intvec_tc2_0x  B0) *(.intvec_tc2_0xb0) } > .
    .inttab_tc2_0B1 BIND (__INTTAB_CPU2 + 0x1620) ALIGN(8) : { *(.intvec_tc2_177  ) *(.intvec_tc2_0x  B1) *(.intvec_tc2_0xb1) } > .
    .inttab_tc2_0B2 BIND (__INTTAB_CPU2 + 0x1640) ALIGN(8) : { *(.intvec_tc2_178  ) *(.intvec_tc2_0x  B2) *(.intvec_tc2_0xb2) } > .
    .inttab_tc2_0B3 BIND (__INTTAB_CPU2 + 0x1660) ALIGN(8) : { *(.intvec_tc2_179  ) *(.intvec_tc2_0x  B3) *(.intvec_tc2_0xb3) } > .
    .inttab_tc2_0B4 BIND (__INTTAB_CPU2 + 0x1680) ALIGN(8) : { *(.intvec_tc2_180  ) *(.intvec_tc2_0x  B4) *(.intvec_tc2_0xb4) } > .
    .inttab_tc2_0B5 BIND (__INTTAB_CPU2 + 0x16A0) ALIGN(8) : { *(.intvec_tc2_181  ) *(.intvec_tc2_0x  B5) *(.intvec_tc2_0xb5) } > .
    .inttab_tc2_0B6 BIND (__INTTAB_CPU2 + 0x16C0) ALIGN(8) : { *(.intvec_tc2_182  ) *(.intvec_tc2_0x  B6) *(.intvec_tc2_0xb6) } > .
    .inttab_tc2_0B7 BIND (__INTTAB_CPU2 + 0x16E0) ALIGN(8) : { *(.intvec_tc2_183  ) *(.intvec_tc2_0x  B7) *(.intvec_tc2_0xb7) } > .
    .inttab_tc2_0B8 BIND (__INTTAB_CPU2 + 0x1700) ALIGN(8) : { *(.intvec_tc2_184  ) *(.intvec_tc2_0x  B8) *(.intvec_tc2_0xb8) } > .
    .inttab_tc2_0B9 BIND (__INTTAB_CPU2 + 0x1720) ALIGN(8) : { *(.intvec_tc2_185  ) *(.intvec_tc2_0x  B9) *(.intvec_tc2_0xb9) } > .
    .inttab_tc2_0BA BIND (__INTTAB_CPU2 + 0x1740) ALIGN(8) : { *(.intvec_tc2_186  ) *(.intvec_tc2_0x  BA) *(.intvec_tc2_0xba) } > .
    .inttab_tc2_0BB BIND (__INTTAB_CPU2 + 0x1760) ALIGN(8) : { *(.intvec_tc2_187  ) *(.intvec_tc2_0x  BB) *(.intvec_tc2_0xbb) } > .
    .inttab_tc2_0BC BIND (__INTTAB_CPU2 + 0x1780) ALIGN(8) : { *(.intvec_tc2_188  ) *(.intvec_tc2_0x  BC) *(.intvec_tc2_0xbc) } > .
    .inttab_tc2_0BD BIND (__INTTAB_CPU2 + 0x17A0) ALIGN(8) : { *(.intvec_tc2_189  ) *(.intvec_tc2_0x  BD) *(.intvec_tc2_0xbd) } > .
    .inttab_tc2_0BE BIND (__INTTAB_CPU2 + 0x17C0) ALIGN(8) : { *(.intvec_tc2_190  ) *(.intvec_tc2_0x  BE) *(.intvec_tc2_0xbe) } > .
    .inttab_tc2_0BF BIND (__INTTAB_CPU2 + 0x17E0) ALIGN(8) : { *(.intvec_tc2_191  ) *(.intvec_tc2_0x  BF) *(.intvec_tc2_0xbf) } > .
    .inttab_tc2_0C0 BIND (__INTTAB_CPU2 + 0x1800) ALIGN(8) : { *(.intvec_tc2_192  ) *(.intvec_tc2_0x  C0) *(.intvec_tc2_0xc0) } > .
    .inttab_tc2_0C1 BIND (__INTTAB_CPU2 + 0x1820) ALIGN(8) : { *(.intvec_tc2_193  ) *(.intvec_tc2_0x  C1) *(.intvec_tc2_0xc1) } > .
    .inttab_tc2_0C2 BIND (__INTTAB_CPU2 + 0x1840) ALIGN(8) : { *(.intvec_tc2_194  ) *(.intvec_tc2_0x  C2) *(.intvec_tc2_0xc2) } > .
    .inttab_tc2_0C3 BIND (__INTTAB_CPU2 + 0x1860) ALIGN(8) : { *(.intvec_tc2_195  ) *(.intvec_tc2_0x  C3) *(.intvec_tc2_0xc3) } > .
    .inttab_tc2_0C4 BIND (__INTTAB_CPU2 + 0x1880) ALIGN(8) : { *(.intvec_tc2_196  ) *(.intvec_tc2_0x  C4) *(.intvec_tc2_0xc4) } > .
    .inttab_tc2_0C5 BIND (__INTTAB_CPU2 + 0x18A0) ALIGN(8) : { *(.intvec_tc2_197  ) *(.intvec_tc2_0x  C5) *(.intvec_tc2_0xc5) } > .
    .inttab_tc2_0C6 BIND (__INTTAB_CPU2 + 0x18C0) ALIGN(8) : { *(.intvec_tc2_198  ) *(.intvec_tc2_0x  C6) *(.intvec_tc2_0xc6) } > .
    .inttab_tc2_0C7 BIND (__INTTAB_CPU2 + 0x18E0) ALIGN(8) : { *(.intvec_tc2_199  ) *(.intvec_tc2_0x  C7) *(.intvec_tc2_0xc7) } > .
    .inttab_tc2_0C8 BIND (__INTTAB_CPU2 + 0x1900) ALIGN(8) : { *(.intvec_tc2_200  ) *(.intvec_tc2_0x  C8) *(.intvec_tc2_0xc8) } > .
    .inttab_tc2_0C9 BIND (__INTTAB_CPU2 + 0x1920) ALIGN(8) : { *(.intvec_tc2_201  ) *(.intvec_tc2_0x  C9) *(.intvec_tc2_0xc9) } > .
    .inttab_tc2_0CA BIND (__INTTAB_CPU2 + 0x1940) ALIGN(8) : { *(.intvec_tc2_202  ) *(.intvec_tc2_0x  CA) *(.intvec_tc2_0xca) } > .
    .inttab_tc2_0CB BIND (__INTTAB_CPU2 + 0x1960) ALIGN(8) : { *(.intvec_tc2_203  ) *(.intvec_tc2_0x  CB) *(.intvec_tc2_0xcb) } > .
    .inttab_tc2_0CC BIND (__INTTAB_CPU2 + 0x1980) ALIGN(8) : { *(.intvec_tc2_204  ) *(.intvec_tc2_0x  CC) *(.intvec_tc2_0xcc) } > .
    .inttab_tc2_0CD BIND (__INTTAB_CPU2 + 0x19A0) ALIGN(8) : { *(.intvec_tc2_205  ) *(.intvec_tc2_0x  CD) *(.intvec_tc2_0xcd) } > .
    .inttab_tc2_0CE BIND (__INTTAB_CPU2 + 0x19C0) ALIGN(8) : { *(.intvec_tc2_206  ) *(.intvec_tc2_0x  CE) *(.intvec_tc2_0xce) } > .
    .inttab_tc2_0CF BIND (__INTTAB_CPU2 + 0x19E0) ALIGN(8) : { *(.intvec_tc2_207  ) *(.intvec_tc2_0x  CF) *(.intvec_tc2_0xcf) } > .
    .inttab_tc2_0D0 BIND (__INTTAB_CPU2 + 0x1A00) ALIGN(8) : { *(.intvec_tc2_208  ) *(.intvec_tc2_0x  D0) *(.intvec_tc2_0xd0) } > .
    .inttab_tc2_0D1 BIND (__INTTAB_CPU2 + 0x1A20) ALIGN(8) : { *(.intvec_tc2_209  ) *(.intvec_tc2_0x  D1) *(.intvec_tc2_0xd1) } > .
    .inttab_tc2_0D2 BIND (__INTTAB_CPU2 + 0x1A40) ALIGN(8) : { *(.intvec_tc2_210  ) *(.intvec_tc2_0x  D2) *(.intvec_tc2_0xd2) } > .
    .inttab_tc2_0D3 BIND (__INTTAB_CPU2 + 0x1A60) ALIGN(8) : { *(.intvec_tc2_211  ) *(.intvec_tc2_0x  D3) *(.intvec_tc2_0xd3) } > .
    .inttab_tc2_0D4 BIND (__INTTAB_CPU2 + 0x1A80) ALIGN(8) : { *(.intvec_tc2_212  ) *(.intvec_tc2_0x  D4) *(.intvec_tc2_0xd4) } > .
    .inttab_tc2_0D5 BIND (__INTTAB_CPU2 + 0x1AA0) ALIGN(8) : { *(.intvec_tc2_213  ) *(.intvec_tc2_0x  D5) *(.intvec_tc2_0xd5) } > .
    .inttab_tc2_0D6 BIND (__INTTAB_CPU2 + 0x1AC0) ALIGN(8) : { *(.intvec_tc2_214  ) *(.intvec_tc2_0x  D6) *(.intvec_tc2_0xd6) } > .
    .inttab_tc2_0D7 BIND (__INTTAB_CPU2 + 0x1AE0) ALIGN(8) : { *(.intvec_tc2_215  ) *(.intvec_tc2_0x  D7) *(.intvec_tc2_0xd7) } > .
    .inttab_tc2_0D8 BIND (__INTTAB_CPU2 + 0x1B00) ALIGN(8) : { *(.intvec_tc2_216  ) *(.intvec_tc2_0x  D8) *(.intvec_tc2_0xd8) } > .
    .inttab_tc2_0D9 BIND (__INTTAB_CPU2 + 0x1B20) ALIGN(8) : { *(.intvec_tc2_217  ) *(.intvec_tc2_0x  D9) *(.intvec_tc2_0xd9) } > .
    .inttab_tc2_0DA BIND (__INTTAB_CPU2 + 0x1B40) ALIGN(8) : { *(.intvec_tc2_218  ) *(.intvec_tc2_0x  DA) *(.intvec_tc2_0xda) } > .
    .inttab_tc2_0DB BIND (__INTTAB_CPU2 + 0x1B60) ALIGN(8) : { *(.intvec_tc2_219  ) *(.intvec_tc2_0x  DB) *(.intvec_tc2_0xdb) } > .
    .inttab_tc2_0DC BIND (__INTTAB_CPU2 + 0x1B80) ALIGN(8) : { *(.intvec_tc2_220  ) *(.intvec_tc2_0x  DC) *(.intvec_tc2_0xdc) } > .
    .inttab_tc2_0DD BIND (__INTTAB_CPU2 + 0x1BA0) ALIGN(8) : { *(.intvec_tc2_221  ) *(.intvec_tc2_0x  DD) *(.intvec_tc2_0xdd) } > .
    .inttab_tc2_0DE BIND (__INTTAB_CPU2 + 0x1BC0) ALIGN(8) : { *(.intvec_tc2_222  ) *(.intvec_tc2_0x  DE) *(.intvec_tc2_0xde) } > .
    .inttab_tc2_0DF BIND (__INTTAB_CPU2 + 0x1BE0) ALIGN(8) : { *(.intvec_tc2_223  ) *(.intvec_tc2_0x  DF) *(.intvec_tc2_0xdf) } > .
    .inttab_tc2_0E0 BIND (__INTTAB_CPU2 + 0x1C00) ALIGN(8) : { *(.intvec_tc2_224  ) *(.intvec_tc2_0x  E0) *(.intvec_tc2_0xe0) } > .
    .inttab_tc2_0E1 BIND (__INTTAB_CPU2 + 0x1C20) ALIGN(8) : { *(.intvec_tc2_225  ) *(.intvec_tc2_0x  E1) *(.intvec_tc2_0xe1) } > .
    .inttab_tc2_0E2 BIND (__INTTAB_CPU2 + 0x1C40) ALIGN(8) : { *(.intvec_tc2_226  ) *(.intvec_tc2_0x  E2) *(.intvec_tc2_0xe2) } > .
    .inttab_tc2_0E3 BIND (__INTTAB_CPU2 + 0x1C60) ALIGN(8) : { *(.intvec_tc2_227  ) *(.intvec_tc2_0x  E3) *(.intvec_tc2_0xe3) } > .
    .inttab_tc2_0E4 BIND (__INTTAB_CPU2 + 0x1C80) ALIGN(8) : { *(.intvec_tc2_228  ) *(.intvec_tc2_0x  E4) *(.intvec_tc2_0xe4) } > .
    .inttab_tc2_0E5 BIND (__INTTAB_CPU2 + 0x1CA0) ALIGN(8) : { *(.intvec_tc2_229  ) *(.intvec_tc2_0x  E5) *(.intvec_tc2_0xe5) } > .
    .inttab_tc2_0E6 BIND (__INTTAB_CPU2 + 0x1CC0) ALIGN(8) : { *(.intvec_tc2_230  ) *(.intvec_tc2_0x  E6) *(.intvec_tc2_0xe6) } > .
    .inttab_tc2_0E7 BIND (__INTTAB_CPU2 + 0x1CE0) ALIGN(8) : { *(.intvec_tc2_231  ) *(.intvec_tc2_0x  E7) *(.intvec_tc2_0xe7) } > .
    .inttab_tc2_0E8 BIND (__INTTAB_CPU2 + 0x1D00) ALIGN(8) : { *(.intvec_tc2_232  ) *(.intvec_tc2_0x  E8) *(.intvec_tc2_0xe8) } > .
    .inttab_tc2_0E9 BIND (__INTTAB_CPU2 + 0x1D20) ALIGN(8) : { *(.intvec_tc2_233  ) *(.intvec_tc2_0x  E9) *(.intvec_tc2_0xe9) } > .
    .inttab_tc2_0EA BIND (__INTTAB_CPU2 + 0x1D40) ALIGN(8) : { *(.intvec_tc2_234  ) *(.intvec_tc2_0x  EA) *(.intvec_tc2_0xea) } > .
    .inttab_tc2_0EB BIND (__INTTAB_CPU2 + 0x1D60) ALIGN(8) : { *(.intvec_tc2_235  ) *(.intvec_tc2_0x  EB) *(.intvec_tc2_0xeb) } > .
    .inttab_tc2_0EC BIND (__INTTAB_CPU2 + 0x1D80) ALIGN(8) : { *(.intvec_tc2_236  ) *(.intvec_tc2_0x  EC) *(.intvec_tc2_0xec) } > .
    .inttab_tc2_0ED BIND (__INTTAB_CPU2 + 0x1DA0) ALIGN(8) : { *(.intvec_tc2_237  ) *(.intvec_tc2_0x  ED) *(.intvec_tc2_0xed) } > .
    .inttab_tc2_0EE BIND (__INTTAB_CPU2 + 0x1DC0) ALIGN(8) : { *(.intvec_tc2_238  ) *(.intvec_tc2_0x  EE) *(.intvec_tc2_0xee) } > .
    .inttab_tc2_0EF BIND (__INTTAB_CPU2 + 0x1DE0) ALIGN(8) : { *(.intvec_tc2_239  ) *(.intvec_tc2_0x  EF) *(.intvec_tc2_0xef) } > .
    .inttab_tc2_0F0 BIND (__INTTAB_CPU2 + 0x1E00) ALIGN(8) : { *(.intvec_tc2_240  ) *(.intvec_tc2_0x  F0) *(.intvec_tc2_0xf0) } > .
    .inttab_tc2_0F1 BIND (__INTTAB_CPU2 + 0x1E20) ALIGN(8) : { *(.intvec_tc2_241  ) *(.intvec_tc2_0x  F1) *(.intvec_tc2_0xf1) } > .
    .inttab_tc2_0F2 BIND (__INTTAB_CPU2 + 0x1E40) ALIGN(8) : { *(.intvec_tc2_242  ) *(.intvec_tc2_0x  F2) *(.intvec_tc2_0xf2) } > .
    .inttab_tc2_0F3 BIND (__INTTAB_CPU2 + 0x1E60) ALIGN(8) : { *(.intvec_tc2_243  ) *(.intvec_tc2_0x  F3) *(.intvec_tc2_0xf3) } > .
    .inttab_tc2_0F4 BIND (__INTTAB_CPU2 + 0x1E80) ALIGN(8) : { *(.intvec_tc2_244  ) *(.intvec_tc2_0x  F4) *(.intvec_tc2_0xf4) } > .
    .inttab_tc2_0F5 BIND (__INTTAB_CPU2 + 0x1EA0) ALIGN(8) : { *(.intvec_tc2_245  ) *(.intvec_tc2_0x  F5) *(.intvec_tc2_0xf5) } > .
    .inttab_tc2_0F6 BIND (__INTTAB_CPU2 + 0x1EC0) ALIGN(8) : { *(.intvec_tc2_246  ) *(.intvec_tc2_0x  F6) *(.intvec_tc2_0xf6) } > .
    .inttab_tc2_0F7 BIND (__INTTAB_CPU2 + 0x1EE0) ALIGN(8) : { *(.intvec_tc2_247  ) *(.intvec_tc2_0x  F7) *(.intvec_tc2_0xf7) } > .
    .inttab_tc2_0F8 BIND (__INTTAB_CPU2 + 0x1F00) ALIGN(8) : { *(.intvec_tc2_248  ) *(.intvec_tc2_0x  F8) *(.intvec_tc2_0xf8) } > .
    .inttab_tc2_0F9 BIND (__INTTAB_CPU2 + 0x1F20) ALIGN(8) : { *(.intvec_tc2_249  ) *(.intvec_tc2_0x  F9) *(.intvec_tc2_0xf9) } > .
    .inttab_tc2_0FA BIND (__INTTAB_CPU2 + 0x1F40) ALIGN(8) : { *(.intvec_tc2_250  ) *(.intvec_tc2_0x  FA) *(.intvec_tc2_0xfa) } > .
    .inttab_tc2_0FB BIND (__INTTAB_CPU2 + 0x1F60) ALIGN(8) : { *(.intvec_tc2_251  ) *(.intvec_tc2_0x  FB) *(.intvec_tc2_0xfb) } > .
    .inttab_tc2_0FC BIND (__INTTAB_CPU2 + 0x1F80) ALIGN(8) : { *(.intvec_tc2_252  ) *(.intvec_tc2_0x  FC) *(.intvec_tc2_0xfc) } > .
    .inttab_tc2_0FD BIND (__INTTAB_CPU2 + 0x1FA0) ALIGN(8) : { *(.intvec_tc2_253  ) *(.intvec_tc2_0x  FD) *(.intvec_tc2_0xfd) } > .
    .inttab_tc2_0FE BIND (__INTTAB_CPU2 + 0x1FC0) ALIGN(8) : { *(.intvec_tc2_254  ) *(.intvec_tc2_0x  FE) *(.intvec_tc2_0xfe) } > .
    .inttab_tc2_0FF BIND (__INTTAB_CPU2 + 0x1FE0) ALIGN(8) : { *(.intvec_tc2_255  ) *(.intvec_tc2_0x  FF) *(.intvec_tc2_0xff) } > .

    .ppu_code (MEMENDADDR(pfls5) - LCF_PPU_FLASH_SIZE) : {.+= LCF_PPU_FLASH_SIZE;}
    PROVIDE(__PPU_IF_CONSTANTS = ADDR(.ppu_code));
    PROVIDE(__PPU_CODE_START   = ADDR(.ppu_code));
    PROVIDE(__PPU_CODE_END     = ENDADDR(.ppu_code));

    /* LMU memory sections */
    /* Near absolute LMURAM sections */
    .GLOBAL_lmuzdata ABS       ALIGN(4) : { *(.zlmudata) } > cpu2_dlmu
    .GLOBAL_lmuzbss  ABS CLEAR ALIGN(4) : { *(.zlmubss) } > .

    /* Far addressable LMURAM sections */
    .CPU2_lmudata       ALIGN(4) : { "*(.lmudata_cpu2)" } > cpu2_dlmu
    .CPU2_lmubss        ALIGN(4) : { "*(.lmubss_cpu2)" } > .

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
    PROVIDE(__ghs_ramstart  = MEMADDR(psram2));
    PROVIDE(__ghs_ramend    = MEMENDADDR(psram2));
    PROVIDE(__ghs_romstart  = MEMADDR(pfls2));
    PROVIDE(__ghs_romend    = MEMENDADDR(pfls2));

//
// These special symbols mark the bounds of RAM and ROM images of boot code.
// They are used by the GHS startup code (_start and __ghs_ind_crt0).
//
    PROVIDE(__ghs_rambootcodestart  = 0);
    PROVIDE(__ghs_rambootcodeend    = 0);
    PROVIDE(__ghs_rombootcodestart  = ADDR(.start_tc2));
    PROVIDE(__ghs_rombootcodeend    = ENDADDR(.secinfo));
    PROVIDE(__INTTAB_CPU2= __INTTAB_CPU2);
}
