DEFAULTS {

LCF_CSA3_SIZE    = 8k;
LCF_USTACK3_SIZE = 2k;
LCF_ISTACK3_SIZE = 1k;

LCF_HEAP_SIZE = 4k;

LCF_PPU_FLASH_SIZE  = 1M;
LCF_PPU_LMURAM_SIZE = 512k;
LCF_PPU_CSM_SIZE    = 512k;

LCF_DSPR3_START = 0x40000000;
LCF_DSPR3_SIZE  = 240K;


LCF_CSA3_OFFSET    = (LCF_DSPR3_SIZE - 1k - LCF_CSA3_SIZE);
LCF_ISTACK3_OFFSET = (LCF_CSA3_OFFSET - 256 - LCF_ISTACK3_SIZE);
LCF_USTACK3_OFFSET = (LCF_ISTACK3_OFFSET - 256 - LCF_USTACK3_SIZE);

LCF_HEAP3_OFFSET = (LCF_USTACK3_OFFSET - LCF_HEAP_SIZE);

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
}

MEMORY
{
    dsram3 : ORIGIN = 0x40000000, LENGTH = 240K
    psram3 : ORIGIN = 0x40100000, LENGTH = 64K


    psram_local : ORIGIN = 0xc0000000, LENGTH = 64K
    dsram_local : ORIGIN = 0xd0000000, LENGTH = 240K

    pfls3 : ORIGIN = 0x80A00000, LENGTH = 4M
    pfls3_nc : ORIGIN = 0xA0A00000, LENGTH = 4M

    pfls5 : ORIGIN = 0x81200000, LENGTH = 2M
    pfls5_nc : ORIGIN = 0xA1200000, LENGTH = 2M

    cpu3_dlmu : ORIGIN = 0x90180000, LENGTH= 512K
    cpu3_dlmu_nc : ORIGIN = 0xb0180000, LENGTH = 512K

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

	.CPU3_zdata ABS ALIGN(4) :
    {
        "Ifx_Ssw_Tc3.*(.zdata)" "Ifx_Ssw_Tc3.*(.zdata.*)"
        "Cpu3_Main.*(.zdata)" "Cpu3_Main.*(.zdata.*)"
        "*(.zdata_cpu3)" "*(.zdata_cpu3.*)"
    } > dsram3
    .CPU3_zbss ABS CLEAR ALIGN(4) :
    {
        "Ifx_Ssw_Tc3.*(.zbss)" "Ifx_Ssw_Tc3.*(.zbss.*)"
        "Cpu3_Main.*(.zbss)" "Cpu3_Main.*(.zbss.*)"
        "*(.zbss_cpu3)" "*(.zbss_cpu3.*)"
    } > .

    /*Un comment one of the below statement groups to enable CpuX DMI RAM to hold global variables*/
    //.GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram5
    //.GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram4
    .GLOBAL_zdata ABS       ALIGN(4) : { "*(.zdata)"  "*(.zdata.*)" } > dsram3
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
		 .CPU3_data ALIGN(4) :
			{
				"Ifx_Ssw_Tc3.*(.data)" "Ifx_Ssw_Tc3.*(.data.*)"
				"Cpu3_Main.*(.data)" "Cpu3_Main.*(.data.*)"
				"*(.data_cpu3)" "*(.data_cpu3.*)"
			} > dsram3
			.CPU3_bss CLEAR ALIGN(4) :
			{
				"Ifx_Ssw_Tc3.*(.bss)" "Ifx_Ssw_Tc3.*(.bss.*)"
				"Cpu3_Main.*(.bss)" "Cpu3_Main.*(.bss.*)"
				"*(.bss_cpu3)" "*(.bss_cpu3.*)"
			} > .

		/*Un comment one of the below statement groups to enable CpuX DMI RAM to hold global variables*/
		//.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram5
		//.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram4
		.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram3
		//.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram2
		//.GLOBAL_data       ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram1
		//.GLOBAL_data          ALIGN(4) : { "*(.data)"  "*(.data.*)" } > dsram0
		.GLOBAL_bss  CLEAR    ALIGN(4) : { "*(.bss)" "*(.bss.*)" } > .
    
    /* Reserve space for dynamic allocation */
    .heap                 ALIGN(4) PAD(LCF_HEAP_SIZE) : > .

    /* Stack and CSA defines */

    .CPU3.ustack BIND(LCF_DSPR3_START + LCF_USTACK3_OFFSET) : { __USTACK3_END = . ;. = . + LCF_USTACK3_SIZE; __USTACK3 = . ; } > dsram3
    .CPU3.istack BIND(LCF_DSPR3_START + LCF_ISTACK3_OFFSET) : { __ISTACK3_END = . ;. = . + LCF_ISTACK3_SIZE; __ISTACK3 = . ; } > .
    .CPU3.csa BIND(LCF_DSPR3_START + LCF_CSA3_OFFSET) :       { __CSA3 = . ; . = . + LCF_CSA3_SIZE; __CSA3_END = . ; } > .

    /* PSRAM Sections */
    .CPU3_psram_text ALIGN(2) : { "*(.psram_text_cpu3)" "*(.psram_text_cpu3.*)" "*(.cpu3_psram)" "*(.cpu3_psram.*)" } > psram3

    /DISCARD/ :
    { 
        *(.traptab_cpu0)
        *(.traptab_cpu1)
        *(.traptab_cpu2)
        *(.traptab_cpu4)
        *(.traptab_cpu5)
        *(.interface_const)
    }
    /* Fixed memory Allocations for _START for CPU 1 to 5 */
    .start_tc3 (LCF_STARTPTR_NC_CPU3) : AT(LCF_STARTPTR_CPU3) { PROVIDE(_start_cpu3 = .); *(.start_cpu3) } > pfls3_nc
    .start_res3 (LCF_STARTPTR_CPU3 + SIZEOF(.start_tc3)) : {} > pfls3
    .traptab_tc3 (LCF_TRAPVEC3_START) : { PROVIDE(__TRAPTAB_CPU3 = .); *(.traptab_cpu3) . = align(32);} > pfls3
    PROVIDE(__START0 = LCF_STARTPTR_NC_CPU0);
    PROVIDE(__START1 = LCF_STARTPTR_NC_CPU1);
    PROVIDE(__START2 = LCF_STARTPTR_NC_CPU2);
    PROVIDE(__START3 = LCF_STARTPTR_NC_CPU3);
    PROVIDE(__START4 = LCF_STARTPTR_NC_CPU4);
    PROVIDE(__START5 = LCF_STARTPTR_NC_CPU5);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU0 = 0); /* Not used */
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU1 = 0);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU2 = 0);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU3 = 1);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU4 = 0);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU5 = 0);
    /* Near absolute RAM sections */
    .GLOBAL_zrodata ABS   ALIGN(4) : { "Ifx_Ssw_Tc?.*(.zrodata)" "Cpu?_Main.*(.zrodata)" "*(.zrodata)" } > pfls3
	    .CPU3_rodata ALIGN(4) :
    {
        "Ifx_Ssw_Tc3.*(.rodata)" "Ifx_Ssw_Tc3.*(.rodata.*)"
        "Cpu3_Main.*(.rodata)" "Cpu3_Main.*(.rodata.*)"
        "*(.rodata_cpu3)" "*(.rodata_cpu3.*)"
    } > pfls3
    
    /* Small addressable ROM sections */
    /*Un comment one of the below statement groups to enable CpuX FLASHs to hold global constants*/
    //.GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls5
    //.GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls4
    .GLOBAL_a1rodata         ALIGN(4) : { PROVIDE(__A1_MEM = .); "*(.rodata_a1)" "*(.rodata_a1.*)" "*(.ldata)" "*(.ldata.*)" } > pfls3
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
	.CPU3_text            ALIGN(2) : { "Ifx_Ssw_Tc3.*(.text)" "Ifx_Ssw_Tc3.*(.text.*)" "Cpu3_Main.*(.text)" "Cpu3_Main.*(.text.*)" "*(.text_cpu3)" "*(.text_cpu3)" } > pfls3
    /*Un comment one of the below statement groups to enable CpuX FLASHs to hold global code sections*/
    //.GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls5
    //.GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls4
    .GLOBAL_text          ALIGN(2) : { "*(.text)" "*(.text.*)" } > pfls3
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
    /*Un comment one of the below statement groups to enable CpuX FLASHs to hold global copy data sections*/
    //.ROM.CPU0_zdata       ROM(.CPU0_zdata) : > pfls5
    //.ROM.CPU0_zdata       ROM(.CPU0_zdata) : > pfls4
    .ROM.CPU3_zdata       ROM(.CPU3_zdata) : > pfls3
    //.ROM.CPU0_zdata       ROM(.CPU0_zdata) : > pfls2
    //.ROM.CPU0_zdata       ROM(.CPU0_zdata) : > pfls1
   // .ROM.CPU0_zdata       ROM(.CPU0_zdata) : > pfls0
    .ROM.CPU3_data         ROM(.CPU3_data) : > .


    .ROM.GLOBAL_zdata      ROM(.GLOBAL_zdata) : > .
    .ROM.GLOBAL_data       ROM(.GLOBAL_data) : > .
    .ROM.GLOBAL_sdata      ROM(.GLOBAL_sdata) : > .
    .ROM.CPU3_lmudata      ROM(.CPU3_lmudata) : > .

    .ROM.GLOBAL_lmuzdata   ROM(.GLOBAL_lmuzdata) : > .
    .ROM.GLOBAL_a9data     ROM(.GLOBAL_a9data) : > .
    .ROM.GLOBAL_lmudata    ROM(.GLOBAL_lmudata) : > .

    .ROM.CPU3_psram_text   ROM(.CPU3_psram_text) : > .

    /* Interrupt vector table located at PFLS3 */
    .inttab_tc3_000 BIND (__INTTAB_CPU3 + 0x0000) ALIGN(8) : { *(.intvec_tc3_0    ) *(.intvec_tc3_0x   0) *(.intvec_tc3_ 0x0) } > pfls3
    .inttab_tc3_001 BIND (__INTTAB_CPU3 + 0x0020) ALIGN(8) : { *(.intvec_tc3_1    ) *(.intvec_tc3_0x   1) *(.intvec_tc3_ 0x1) } > .
    .inttab_tc3_002 BIND (__INTTAB_CPU3 + 0x0040) ALIGN(8) : { *(.intvec_tc3_2    ) *(.intvec_tc3_0x   2) *(.intvec_tc3_ 0x2) } > .
    .inttab_tc3_003 BIND (__INTTAB_CPU3 + 0x0060) ALIGN(8) : { *(.intvec_tc3_3    ) *(.intvec_tc3_0x   3) *(.intvec_tc3_ 0x3) } > .
    .inttab_tc3_004 BIND (__INTTAB_CPU3 + 0x0080) ALIGN(8) : { *(.intvec_tc3_4    ) *(.intvec_tc3_0x   4) *(.intvec_tc3_ 0x4) } > .
    .inttab_tc3_005 BIND (__INTTAB_CPU3 + 0x00A0) ALIGN(8) : { *(.intvec_tc3_5    ) *(.intvec_tc3_0x   5) *(.intvec_tc3_ 0x5) } > .
    .inttab_tc3_006 BIND (__INTTAB_CPU3 + 0x00C0) ALIGN(8) : { *(.intvec_tc3_6    ) *(.intvec_tc3_0x   6) *(.intvec_tc3_ 0x6) } > .
    .inttab_tc3_007 BIND (__INTTAB_CPU3 + 0x00E0) ALIGN(8) : { *(.intvec_tc3_7    ) *(.intvec_tc3_0x   7) *(.intvec_tc3_ 0x7) } > .
    .inttab_tc3_008 BIND (__INTTAB_CPU3 + 0x0100) ALIGN(8) : { *(.intvec_tc3_8    ) *(.intvec_tc3_0x   8) *(.intvec_tc3_ 0x8) } > .
    .inttab_tc3_009 BIND (__INTTAB_CPU3 + 0x0120) ALIGN(8) : { *(.intvec_tc3_9    ) *(.intvec_tc3_0x   9) *(.intvec_tc3_ 0x9) } > .
    .inttab_tc3_00A BIND (__INTTAB_CPU3 + 0x0140) ALIGN(8) : { *(.intvec_tc3_10   ) *(.intvec_tc3_0x   A) *(.intvec_tc3_ 0xa) } > .
    .inttab_tc3_00B BIND (__INTTAB_CPU3 + 0x0160) ALIGN(8) : { *(.intvec_tc3_11   ) *(.intvec_tc3_0x   B) *(.intvec_tc3_ 0xb) } > .
    .inttab_tc3_00C BIND (__INTTAB_CPU3 + 0x0180) ALIGN(8) : { *(.intvec_tc3_12   ) *(.intvec_tc3_0x   C) *(.intvec_tc3_ 0xc) } > .
    .inttab_tc3_00D BIND (__INTTAB_CPU3 + 0x01A0) ALIGN(8) : { *(.intvec_tc3_13   ) *(.intvec_tc3_0x   D) *(.intvec_tc3_ 0xd) } > .
    .inttab_tc3_00E BIND (__INTTAB_CPU3 + 0x01C0) ALIGN(8) : { *(.intvec_tc3_14   ) *(.intvec_tc3_0x   E) *(.intvec_tc3_ 0xe) } > .
    .inttab_tc3_00F BIND (__INTTAB_CPU3 + 0x01E0) ALIGN(8) : { *(.intvec_tc3_15   ) *(.intvec_tc3_0x   F) *(.intvec_tc3_ 0xf) } > .
    .inttab_tc3_010 BIND (__INTTAB_CPU3 + 0x0200) ALIGN(8) : { *(.intvec_tc3_16   ) *(.intvec_tc3_0x  10) *(.intvec_tc3_0x10) } > .
    .inttab_tc3_011 BIND (__INTTAB_CPU3 + 0x0220) ALIGN(8) : { *(.intvec_tc3_17   ) *(.intvec_tc3_0x  11) *(.intvec_tc3_0x11) } > .
    .inttab_tc3_012 BIND (__INTTAB_CPU3 + 0x0240) ALIGN(8) : { *(.intvec_tc3_18   ) *(.intvec_tc3_0x  12) *(.intvec_tc3_0x12) } > .
    .inttab_tc3_013 BIND (__INTTAB_CPU3 + 0x0260) ALIGN(8) : { *(.intvec_tc3_19   ) *(.intvec_tc3_0x  13) *(.intvec_tc3_0x13) } > .
    .inttab_tc3_014 BIND (__INTTAB_CPU3 + 0x0280) ALIGN(8) : { *(.intvec_tc3_20   ) *(.intvec_tc3_0x  14) *(.intvec_tc3_0x14) } > .
    .inttab_tc3_015 BIND (__INTTAB_CPU3 + 0x02A0) ALIGN(8) : { *(.intvec_tc3_21   ) *(.intvec_tc3_0x  15) *(.intvec_tc3_0x15) } > .
    .inttab_tc3_016 BIND (__INTTAB_CPU3 + 0x02C0) ALIGN(8) : { *(.intvec_tc3_22   ) *(.intvec_tc3_0x  16) *(.intvec_tc3_0x16) } > .
    .inttab_tc3_017 BIND (__INTTAB_CPU3 + 0x02E0) ALIGN(8) : { *(.intvec_tc3_23   ) *(.intvec_tc3_0x  17) *(.intvec_tc3_0x17) } > .
    .inttab_tc3_018 BIND (__INTTAB_CPU3 + 0x0300) ALIGN(8) : { *(.intvec_tc3_24   ) *(.intvec_tc3_0x  18) *(.intvec_tc3_0x18) } > .
    .inttab_tc3_019 BIND (__INTTAB_CPU3 + 0x0320) ALIGN(8) : { *(.intvec_tc3_25   ) *(.intvec_tc3_0x  19) *(.intvec_tc3_0x19) } > .
    .inttab_tc3_01A BIND (__INTTAB_CPU3 + 0x0340) ALIGN(8) : { *(.intvec_tc3_26   ) *(.intvec_tc3_0x  1A) *(.intvec_tc3_0x1a) } > .
    .inttab_tc3_01B BIND (__INTTAB_CPU3 + 0x0360) ALIGN(8) : { *(.intvec_tc3_27   ) *(.intvec_tc3_0x  1B) *(.intvec_tc3_0x1b) } > .
    .inttab_tc3_01C BIND (__INTTAB_CPU3 + 0x0380) ALIGN(8) : { *(.intvec_tc3_28   ) *(.intvec_tc3_0x  1C) *(.intvec_tc3_0x1c) } > .
    .inttab_tc3_01D BIND (__INTTAB_CPU3 + 0x03A0) ALIGN(8) : { *(.intvec_tc3_29   ) *(.intvec_tc3_0x  1D) *(.intvec_tc3_0x1d) } > .
    .inttab_tc3_01E BIND (__INTTAB_CPU3 + 0x03C0) ALIGN(8) : { *(.intvec_tc3_30   ) *(.intvec_tc3_0x  1E) *(.intvec_tc3_0x1e) } > .
    .inttab_tc3_01F BIND (__INTTAB_CPU3 + 0x03E0) ALIGN(8) : { *(.intvec_tc3_31   ) *(.intvec_tc3_0x  1F) *(.intvec_tc3_0x1f) } > .
    .inttab_tc3_020 BIND (__INTTAB_CPU3 + 0x0400) ALIGN(8) : { *(.intvec_tc3_32   ) *(.intvec_tc3_0x  20) *(.intvec_tc3_0x20) } > .
    .inttab_tc3_021 BIND (__INTTAB_CPU3 + 0x0420) ALIGN(8) : { *(.intvec_tc3_33   ) *(.intvec_tc3_0x  21) *(.intvec_tc3_0x21) } > .
    .inttab_tc3_022 BIND (__INTTAB_CPU3 + 0x0440) ALIGN(8) : { *(.intvec_tc3_34   ) *(.intvec_tc3_0x  22) *(.intvec_tc3_0x22) } > .
    .inttab_tc3_023 BIND (__INTTAB_CPU3 + 0x0460) ALIGN(8) : { *(.intvec_tc3_35   ) *(.intvec_tc3_0x  23) *(.intvec_tc3_0x23) } > .
    .inttab_tc3_024 BIND (__INTTAB_CPU3 + 0x0480) ALIGN(8) : { *(.intvec_tc3_36   ) *(.intvec_tc3_0x  24) *(.intvec_tc3_0x24) } > .
    .inttab_tc3_025 BIND (__INTTAB_CPU3 + 0x04A0) ALIGN(8) : { *(.intvec_tc3_37   ) *(.intvec_tc3_0x  25) *(.intvec_tc3_0x25) } > .
    .inttab_tc3_026 BIND (__INTTAB_CPU3 + 0x04C0) ALIGN(8) : { *(.intvec_tc3_38   ) *(.intvec_tc3_0x  26) *(.intvec_tc3_0x26) } > .
    .inttab_tc3_027 BIND (__INTTAB_CPU3 + 0x04E0) ALIGN(8) : { *(.intvec_tc3_39   ) *(.intvec_tc3_0x  27) *(.intvec_tc3_0x27) } > .
    .inttab_tc3_028 BIND (__INTTAB_CPU3 + 0x0500) ALIGN(8) : { *(.intvec_tc3_40   ) *(.intvec_tc3_0x  28) *(.intvec_tc3_0x28) } > .
    .inttab_tc3_029 BIND (__INTTAB_CPU3 + 0x0520) ALIGN(8) : { *(.intvec_tc3_41   ) *(.intvec_tc3_0x  29) *(.intvec_tc3_0x29) } > .
    .inttab_tc3_02A BIND (__INTTAB_CPU3 + 0x0540) ALIGN(8) : { *(.intvec_tc3_42   ) *(.intvec_tc3_0x  2A) *(.intvec_tc3_0x2a) } > .
    .inttab_tc3_02B BIND (__INTTAB_CPU3 + 0x0560) ALIGN(8) : { *(.intvec_tc3_43   ) *(.intvec_tc3_0x  2B) *(.intvec_tc3_0x2b) } > .
    .inttab_tc3_02C BIND (__INTTAB_CPU3 + 0x0580) ALIGN(8) : { *(.intvec_tc3_44   ) *(.intvec_tc3_0x  2C) *(.intvec_tc3_0x2c) } > .
    .inttab_tc3_02D BIND (__INTTAB_CPU3 + 0x05A0) ALIGN(8) : { *(.intvec_tc3_45   ) *(.intvec_tc3_0x  2D) *(.intvec_tc3_0x2d) } > .
    .inttab_tc3_02E BIND (__INTTAB_CPU3 + 0x05C0) ALIGN(8) : { *(.intvec_tc3_46   ) *(.intvec_tc3_0x  2E) *(.intvec_tc3_0x2e) } > .
    .inttab_tc3_02F BIND (__INTTAB_CPU3 + 0x05E0) ALIGN(8) : { *(.intvec_tc3_47   ) *(.intvec_tc3_0x  2F) *(.intvec_tc3_0x2f) } > .
    .inttab_tc3_030 BIND (__INTTAB_CPU3 + 0x0600) ALIGN(8) : { *(.intvec_tc3_48   ) *(.intvec_tc3_0x  30) *(.intvec_tc3_0x30) } > .
    .inttab_tc3_031 BIND (__INTTAB_CPU3 + 0x0620) ALIGN(8) : { *(.intvec_tc3_49   ) *(.intvec_tc3_0x  31) *(.intvec_tc3_0x31) } > .
    .inttab_tc3_032 BIND (__INTTAB_CPU3 + 0x0640) ALIGN(8) : { *(.intvec_tc3_50   ) *(.intvec_tc3_0x  32) *(.intvec_tc3_0x32) } > .
    .inttab_tc3_033 BIND (__INTTAB_CPU3 + 0x0660) ALIGN(8) : { *(.intvec_tc3_51   ) *(.intvec_tc3_0x  33) *(.intvec_tc3_0x33) } > .
    .inttab_tc3_034 BIND (__INTTAB_CPU3 + 0x0680) ALIGN(8) : { *(.intvec_tc3_52   ) *(.intvec_tc3_0x  34) *(.intvec_tc3_0x34) } > .
    .inttab_tc3_035 BIND (__INTTAB_CPU3 + 0x06A0) ALIGN(8) : { *(.intvec_tc3_53   ) *(.intvec_tc3_0x  35) *(.intvec_tc3_0x35) } > .
    .inttab_tc3_036 BIND (__INTTAB_CPU3 + 0x06C0) ALIGN(8) : { *(.intvec_tc3_54   ) *(.intvec_tc3_0x  36) *(.intvec_tc3_0x36) } > .
    .inttab_tc3_037 BIND (__INTTAB_CPU3 + 0x06E0) ALIGN(8) : { *(.intvec_tc3_55   ) *(.intvec_tc3_0x  37) *(.intvec_tc3_0x37) } > .
    .inttab_tc3_038 BIND (__INTTAB_CPU3 + 0x0700) ALIGN(8) : { *(.intvec_tc3_56   ) *(.intvec_tc3_0x  38) *(.intvec_tc3_0x38) } > .
    .inttab_tc3_039 BIND (__INTTAB_CPU3 + 0x0720) ALIGN(8) : { *(.intvec_tc3_57   ) *(.intvec_tc3_0x  39) *(.intvec_tc3_0x39) } > .
    .inttab_tc3_03A BIND (__INTTAB_CPU3 + 0x0740) ALIGN(8) : { *(.intvec_tc3_58   ) *(.intvec_tc3_0x  3A) *(.intvec_tc3_0x3a) } > .
    .inttab_tc3_03B BIND (__INTTAB_CPU3 + 0x0760) ALIGN(8) : { *(.intvec_tc3_59   ) *(.intvec_tc3_0x  3B) *(.intvec_tc3_0x3b) } > .
    .inttab_tc3_03C BIND (__INTTAB_CPU3 + 0x0780) ALIGN(8) : { *(.intvec_tc3_60   ) *(.intvec_tc3_0x  3C) *(.intvec_tc3_0x3c) } > .
    .inttab_tc3_03D BIND (__INTTAB_CPU3 + 0x07A0) ALIGN(8) : { *(.intvec_tc3_61   ) *(.intvec_tc3_0x  3D) *(.intvec_tc3_0x3d) } > .
    .inttab_tc3_03E BIND (__INTTAB_CPU3 + 0x07C0) ALIGN(8) : { *(.intvec_tc3_62   ) *(.intvec_tc3_0x  3E) *(.intvec_tc3_0x3e) } > .
    .inttab_tc3_03F BIND (__INTTAB_CPU3 + 0x07E0) ALIGN(8) : { *(.intvec_tc3_63   ) *(.intvec_tc3_0x  3F) *(.intvec_tc3_0x3f) } > .
    .inttab_tc3_040 BIND (__INTTAB_CPU3 + 0x0800) ALIGN(8) : { *(.intvec_tc3_64   ) *(.intvec_tc3_0x  40) *(.intvec_tc3_0x40) } > .
    .inttab_tc3_041 BIND (__INTTAB_CPU3 + 0x0820) ALIGN(8) : { *(.intvec_tc3_65   ) *(.intvec_tc3_0x  41) *(.intvec_tc3_0x41) } > .
    .inttab_tc3_042 BIND (__INTTAB_CPU3 + 0x0840) ALIGN(8) : { *(.intvec_tc3_66   ) *(.intvec_tc3_0x  42) *(.intvec_tc3_0x42) } > .
    .inttab_tc3_043 BIND (__INTTAB_CPU3 + 0x0860) ALIGN(8) : { *(.intvec_tc3_67   ) *(.intvec_tc3_0x  43) *(.intvec_tc3_0x43) } > .
    .inttab_tc3_044 BIND (__INTTAB_CPU3 + 0x0880) ALIGN(8) : { *(.intvec_tc3_68   ) *(.intvec_tc3_0x  44) *(.intvec_tc3_0x44) } > .
    .inttab_tc3_045 BIND (__INTTAB_CPU3 + 0x08A0) ALIGN(8) : { *(.intvec_tc3_69   ) *(.intvec_tc3_0x  45) *(.intvec_tc3_0x45) } > .
    .inttab_tc3_046 BIND (__INTTAB_CPU3 + 0x08C0) ALIGN(8) : { *(.intvec_tc3_70   ) *(.intvec_tc3_0x  46) *(.intvec_tc3_0x46) } > .
    .inttab_tc3_047 BIND (__INTTAB_CPU3 + 0x08E0) ALIGN(8) : { *(.intvec_tc3_71   ) *(.intvec_tc3_0x  47) *(.intvec_tc3_0x47) } > .
    .inttab_tc3_048 BIND (__INTTAB_CPU3 + 0x0900) ALIGN(8) : { *(.intvec_tc3_72   ) *(.intvec_tc3_0x  48) *(.intvec_tc3_0x48) } > .
    .inttab_tc3_049 BIND (__INTTAB_CPU3 + 0x0920) ALIGN(8) : { *(.intvec_tc3_73   ) *(.intvec_tc3_0x  49) *(.intvec_tc3_0x49) } > .
    .inttab_tc3_04A BIND (__INTTAB_CPU3 + 0x0940) ALIGN(8) : { *(.intvec_tc3_74   ) *(.intvec_tc3_0x  4A) *(.intvec_tc3_0x4a) } > .
    .inttab_tc3_04B BIND (__INTTAB_CPU3 + 0x0960) ALIGN(8) : { *(.intvec_tc3_75   ) *(.intvec_tc3_0x  4B) *(.intvec_tc3_0x4b) } > .
    .inttab_tc3_04C BIND (__INTTAB_CPU3 + 0x0980) ALIGN(8) : { *(.intvec_tc3_76   ) *(.intvec_tc3_0x  4C) *(.intvec_tc3_0x4c) } > .
    .inttab_tc3_04D BIND (__INTTAB_CPU3 + 0x09A0) ALIGN(8) : { *(.intvec_tc3_77   ) *(.intvec_tc3_0x  4D) *(.intvec_tc3_0x4d) } > .
    .inttab_tc3_04E BIND (__INTTAB_CPU3 + 0x09C0) ALIGN(8) : { *(.intvec_tc3_78   ) *(.intvec_tc3_0x  4E) *(.intvec_tc3_0x4e) } > .
    .inttab_tc3_04F BIND (__INTTAB_CPU3 + 0x09E0) ALIGN(8) : { *(.intvec_tc3_79   ) *(.intvec_tc3_0x  4F) *(.intvec_tc3_0x4f) } > .
    .inttab_tc3_050 BIND (__INTTAB_CPU3 + 0x0A00) ALIGN(8) : { *(.intvec_tc3_80   ) *(.intvec_tc3_0x  50) *(.intvec_tc3_0x50) } > .
    .inttab_tc3_051 BIND (__INTTAB_CPU3 + 0x0A20) ALIGN(8) : { *(.intvec_tc3_81   ) *(.intvec_tc3_0x  51) *(.intvec_tc3_0x51) } > .
    .inttab_tc3_052 BIND (__INTTAB_CPU3 + 0x0A40) ALIGN(8) : { *(.intvec_tc3_82   ) *(.intvec_tc3_0x  52) *(.intvec_tc3_0x52) } > .
    .inttab_tc3_053 BIND (__INTTAB_CPU3 + 0x0A60) ALIGN(8) : { *(.intvec_tc3_83   ) *(.intvec_tc3_0x  53) *(.intvec_tc3_0x53) } > .
    .inttab_tc3_054 BIND (__INTTAB_CPU3 + 0x0A80) ALIGN(8) : { *(.intvec_tc3_84   ) *(.intvec_tc3_0x  54) *(.intvec_tc3_0x54) } > .
    .inttab_tc3_055 BIND (__INTTAB_CPU3 + 0x0AA0) ALIGN(8) : { *(.intvec_tc3_85   ) *(.intvec_tc3_0x  55) *(.intvec_tc3_0x55) } > .
    .inttab_tc3_056 BIND (__INTTAB_CPU3 + 0x0AC0) ALIGN(8) : { *(.intvec_tc3_86   ) *(.intvec_tc3_0x  56) *(.intvec_tc3_0x56) } > .
    .inttab_tc3_057 BIND (__INTTAB_CPU3 + 0x0AE0) ALIGN(8) : { *(.intvec_tc3_87   ) *(.intvec_tc3_0x  57) *(.intvec_tc3_0x57) } > .
    .inttab_tc3_058 BIND (__INTTAB_CPU3 + 0x0B00) ALIGN(8) : { *(.intvec_tc3_88   ) *(.intvec_tc3_0x  58) *(.intvec_tc3_0x58) } > .
    .inttab_tc3_059 BIND (__INTTAB_CPU3 + 0x0B20) ALIGN(8) : { *(.intvec_tc3_89   ) *(.intvec_tc3_0x  59) *(.intvec_tc3_0x59) } > .
    .inttab_tc3_05A BIND (__INTTAB_CPU3 + 0x0B40) ALIGN(8) : { *(.intvec_tc3_90   ) *(.intvec_tc3_0x  5A) *(.intvec_tc3_0x5a) } > .
    .inttab_tc3_05B BIND (__INTTAB_CPU3 + 0x0B60) ALIGN(8) : { *(.intvec_tc3_91   ) *(.intvec_tc3_0x  5B) *(.intvec_tc3_0x5b) } > .
    .inttab_tc3_05C BIND (__INTTAB_CPU3 + 0x0B80) ALIGN(8) : { *(.intvec_tc3_92   ) *(.intvec_tc3_0x  5C) *(.intvec_tc3_0x5c) } > .
    .inttab_tc3_05D BIND (__INTTAB_CPU3 + 0x0BA0) ALIGN(8) : { *(.intvec_tc3_93   ) *(.intvec_tc3_0x  5D) *(.intvec_tc3_0x5d) } > .
    .inttab_tc3_05E BIND (__INTTAB_CPU3 + 0x0BC0) ALIGN(8) : { *(.intvec_tc3_94   ) *(.intvec_tc3_0x  5E) *(.intvec_tc3_0x5e) } > .
    .inttab_tc3_05F BIND (__INTTAB_CPU3 + 0x0BE0) ALIGN(8) : { *(.intvec_tc3_95   ) *(.intvec_tc3_0x  5F) *(.intvec_tc3_0x5f) } > .
    .inttab_tc3_060 BIND (__INTTAB_CPU3 + 0x0C00) ALIGN(8) : { *(.intvec_tc3_96   ) *(.intvec_tc3_0x  60) *(.intvec_tc3_0x60) } > .
    .inttab_tc3_061 BIND (__INTTAB_CPU3 + 0x0C20) ALIGN(8) : { *(.intvec_tc3_97   ) *(.intvec_tc3_0x  61) *(.intvec_tc3_0x61) } > .
    .inttab_tc3_062 BIND (__INTTAB_CPU3 + 0x0C40) ALIGN(8) : { *(.intvec_tc3_98   ) *(.intvec_tc3_0x  62) *(.intvec_tc3_0x62) } > .
    .inttab_tc3_063 BIND (__INTTAB_CPU3 + 0x0C60) ALIGN(8) : { *(.intvec_tc3_99   ) *(.intvec_tc3_0x  63) *(.intvec_tc3_0x63) } > .
    .inttab_tc3_064 BIND (__INTTAB_CPU3 + 0x0C80) ALIGN(8) : { *(.intvec_tc3_100  ) *(.intvec_tc3_0x  64) *(.intvec_tc3_0x64) } > .
    .inttab_tc3_065 BIND (__INTTAB_CPU3 + 0x0CA0) ALIGN(8) : { *(.intvec_tc3_101  ) *(.intvec_tc3_0x  65) *(.intvec_tc3_0x65) } > .
    .inttab_tc3_066 BIND (__INTTAB_CPU3 + 0x0CC0) ALIGN(8) : { *(.intvec_tc3_102  ) *(.intvec_tc3_0x  66) *(.intvec_tc3_0x66) } > .
    .inttab_tc3_067 BIND (__INTTAB_CPU3 + 0x0CE0) ALIGN(8) : { *(.intvec_tc3_103  ) *(.intvec_tc3_0x  67) *(.intvec_tc3_0x67) } > .
    .inttab_tc3_068 BIND (__INTTAB_CPU3 + 0x0D00) ALIGN(8) : { *(.intvec_tc3_104  ) *(.intvec_tc3_0x  68) *(.intvec_tc3_0x68) } > .
    .inttab_tc3_069 BIND (__INTTAB_CPU3 + 0x0D20) ALIGN(8) : { *(.intvec_tc3_105  ) *(.intvec_tc3_0x  69) *(.intvec_tc3_0x69) } > .
    .inttab_tc3_06A BIND (__INTTAB_CPU3 + 0x0D40) ALIGN(8) : { *(.intvec_tc3_106  ) *(.intvec_tc3_0x  6A) *(.intvec_tc3_0x6a) } > .
    .inttab_tc3_06B BIND (__INTTAB_CPU3 + 0x0D60) ALIGN(8) : { *(.intvec_tc3_107  ) *(.intvec_tc3_0x  6B) *(.intvec_tc3_0x6b) } > .
    .inttab_tc3_06C BIND (__INTTAB_CPU3 + 0x0D80) ALIGN(8) : { *(.intvec_tc3_108  ) *(.intvec_tc3_0x  6C) *(.intvec_tc3_0x6c) } > .
    .inttab_tc3_06D BIND (__INTTAB_CPU3 + 0x0DA0) ALIGN(8) : { *(.intvec_tc3_109  ) *(.intvec_tc3_0x  6D) *(.intvec_tc3_0x6d) } > .
    .inttab_tc3_06E BIND (__INTTAB_CPU3 + 0x0DC0) ALIGN(8) : { *(.intvec_tc3_110  ) *(.intvec_tc3_0x  6E) *(.intvec_tc3_0x6e) } > .
    .inttab_tc3_06F BIND (__INTTAB_CPU3 + 0x0DE0) ALIGN(8) : { *(.intvec_tc3_111  ) *(.intvec_tc3_0x  6F) *(.intvec_tc3_0x6f) } > .
    .inttab_tc3_070 BIND (__INTTAB_CPU3 + 0x0E00) ALIGN(8) : { *(.intvec_tc3_112  ) *(.intvec_tc3_0x  70) *(.intvec_tc3_0x70) } > .
    .inttab_tc3_071 BIND (__INTTAB_CPU3 + 0x0E20) ALIGN(8) : { *(.intvec_tc3_113  ) *(.intvec_tc3_0x  71) *(.intvec_tc3_0x71) } > .
    .inttab_tc3_072 BIND (__INTTAB_CPU3 + 0x0E40) ALIGN(8) : { *(.intvec_tc3_114  ) *(.intvec_tc3_0x  72) *(.intvec_tc3_0x72) } > .
    .inttab_tc3_073 BIND (__INTTAB_CPU3 + 0x0E60) ALIGN(8) : { *(.intvec_tc3_115  ) *(.intvec_tc3_0x  73) *(.intvec_tc3_0x73) } > .
    .inttab_tc3_074 BIND (__INTTAB_CPU3 + 0x0E80) ALIGN(8) : { *(.intvec_tc3_116  ) *(.intvec_tc3_0x  74) *(.intvec_tc3_0x74) } > .
    .inttab_tc3_075 BIND (__INTTAB_CPU3 + 0x0EA0) ALIGN(8) : { *(.intvec_tc3_117  ) *(.intvec_tc3_0x  75) *(.intvec_tc3_0x75) } > .
    .inttab_tc3_076 BIND (__INTTAB_CPU3 + 0x0EC0) ALIGN(8) : { *(.intvec_tc3_118  ) *(.intvec_tc3_0x  76) *(.intvec_tc3_0x76) } > .
    .inttab_tc3_077 BIND (__INTTAB_CPU3 + 0x0EE0) ALIGN(8) : { *(.intvec_tc3_119  ) *(.intvec_tc3_0x  77) *(.intvec_tc3_0x77) } > .
    .inttab_tc3_078 BIND (__INTTAB_CPU3 + 0x0F00) ALIGN(8) : { *(.intvec_tc3_120  ) *(.intvec_tc3_0x  78) *(.intvec_tc3_0x78) } > .
    .inttab_tc3_079 BIND (__INTTAB_CPU3 + 0x0F20) ALIGN(8) : { *(.intvec_tc3_121  ) *(.intvec_tc3_0x  79) *(.intvec_tc3_0x79) } > .
    .inttab_tc3_07A BIND (__INTTAB_CPU3 + 0x0F40) ALIGN(8) : { *(.intvec_tc3_122  ) *(.intvec_tc3_0x  7A) *(.intvec_tc3_0x7a) } > .
    .inttab_tc3_07B BIND (__INTTAB_CPU3 + 0x0F60) ALIGN(8) : { *(.intvec_tc3_123  ) *(.intvec_tc3_0x  7B) *(.intvec_tc3_0x7b) } > .
    .inttab_tc3_07C BIND (__INTTAB_CPU3 + 0x0F80) ALIGN(8) : { *(.intvec_tc3_124  ) *(.intvec_tc3_0x  7C) *(.intvec_tc3_0x7c) } > .
    .inttab_tc3_07D BIND (__INTTAB_CPU3 + 0x0FA0) ALIGN(8) : { *(.intvec_tc3_125  ) *(.intvec_tc3_0x  7D) *(.intvec_tc3_0x7d) } > .
    .inttab_tc3_07E BIND (__INTTAB_CPU3 + 0x0FC0) ALIGN(8) : { *(.intvec_tc3_126  ) *(.intvec_tc3_0x  7E) *(.intvec_tc3_0x7e) } > .
    .inttab_tc3_07F BIND (__INTTAB_CPU3 + 0x0FE0) ALIGN(8) : { *(.intvec_tc3_127  ) *(.intvec_tc3_0x  7F) *(.intvec_tc3_0x7f) } > .
    .inttab_tc3_080 BIND (__INTTAB_CPU3 + 0x1000) ALIGN(8) : { *(.intvec_tc3_128  ) *(.intvec_tc3_0x  80) *(.intvec_tc3_0x80) } > .
    .inttab_tc3_081 BIND (__INTTAB_CPU3 + 0x1020) ALIGN(8) : { *(.intvec_tc3_129  ) *(.intvec_tc3_0x  81) *(.intvec_tc3_0x81) } > .
    .inttab_tc3_082 BIND (__INTTAB_CPU3 + 0x1040) ALIGN(8) : { *(.intvec_tc3_130  ) *(.intvec_tc3_0x  82) *(.intvec_tc3_0x82) } > .
    .inttab_tc3_083 BIND (__INTTAB_CPU3 + 0x1060) ALIGN(8) : { *(.intvec_tc3_131  ) *(.intvec_tc3_0x  83) *(.intvec_tc3_0x83) } > .
    .inttab_tc3_084 BIND (__INTTAB_CPU3 + 0x1080) ALIGN(8) : { *(.intvec_tc3_132  ) *(.intvec_tc3_0x  84) *(.intvec_tc3_0x84) } > .
    .inttab_tc3_085 BIND (__INTTAB_CPU3 + 0x10A0) ALIGN(8) : { *(.intvec_tc3_133  ) *(.intvec_tc3_0x  85) *(.intvec_tc3_0x85) } > .
    .inttab_tc3_086 BIND (__INTTAB_CPU3 + 0x10C0) ALIGN(8) : { *(.intvec_tc3_134  ) *(.intvec_tc3_0x  86) *(.intvec_tc3_0x86) } > .
    .inttab_tc3_087 BIND (__INTTAB_CPU3 + 0x10E0) ALIGN(8) : { *(.intvec_tc3_135  ) *(.intvec_tc3_0x  87) *(.intvec_tc3_0x87) } > .
    .inttab_tc3_088 BIND (__INTTAB_CPU3 + 0x1100) ALIGN(8) : { *(.intvec_tc3_136  ) *(.intvec_tc3_0x  88) *(.intvec_tc3_0x88) } > .
    .inttab_tc3_089 BIND (__INTTAB_CPU3 + 0x1120) ALIGN(8) : { *(.intvec_tc3_137  ) *(.intvec_tc3_0x  89) *(.intvec_tc3_0x89) } > .
    .inttab_tc3_08A BIND (__INTTAB_CPU3 + 0x1140) ALIGN(8) : { *(.intvec_tc3_138  ) *(.intvec_tc3_0x  8A) *(.intvec_tc3_0x8a) } > .
    .inttab_tc3_08B BIND (__INTTAB_CPU3 + 0x1160) ALIGN(8) : { *(.intvec_tc3_139  ) *(.intvec_tc3_0x  8B) *(.intvec_tc3_0x8b) } > .
    .inttab_tc3_08C BIND (__INTTAB_CPU3 + 0x1180) ALIGN(8) : { *(.intvec_tc3_140  ) *(.intvec_tc3_0x  8C) *(.intvec_tc3_0x8c) } > .
    .inttab_tc3_08D BIND (__INTTAB_CPU3 + 0x11A0) ALIGN(8) : { *(.intvec_tc3_141  ) *(.intvec_tc3_0x  8D) *(.intvec_tc3_0x8d) } > .
    .inttab_tc3_08E BIND (__INTTAB_CPU3 + 0x11C0) ALIGN(8) : { *(.intvec_tc3_142  ) *(.intvec_tc3_0x  8E) *(.intvec_tc3_0x8e) } > .
    .inttab_tc3_08F BIND (__INTTAB_CPU3 + 0x11E0) ALIGN(8) : { *(.intvec_tc3_143  ) *(.intvec_tc3_0x  8F) *(.intvec_tc3_0x8f) } > .
    .inttab_tc3_090 BIND (__INTTAB_CPU3 + 0x1200) ALIGN(8) : { *(.intvec_tc3_144  ) *(.intvec_tc3_0x  90) *(.intvec_tc3_0x90) } > .
    .inttab_tc3_091 BIND (__INTTAB_CPU3 + 0x1220) ALIGN(8) : { *(.intvec_tc3_145  ) *(.intvec_tc3_0x  91) *(.intvec_tc3_0x91) } > .
    .inttab_tc3_092 BIND (__INTTAB_CPU3 + 0x1240) ALIGN(8) : { *(.intvec_tc3_146  ) *(.intvec_tc3_0x  92) *(.intvec_tc3_0x92) } > .
    .inttab_tc3_093 BIND (__INTTAB_CPU3 + 0x1260) ALIGN(8) : { *(.intvec_tc3_147  ) *(.intvec_tc3_0x  93) *(.intvec_tc3_0x93) } > .
    .inttab_tc3_094 BIND (__INTTAB_CPU3 + 0x1280) ALIGN(8) : { *(.intvec_tc3_148  ) *(.intvec_tc3_0x  94) *(.intvec_tc3_0x94) } > .
    .inttab_tc3_095 BIND (__INTTAB_CPU3 + 0x12A0) ALIGN(8) : { *(.intvec_tc3_149  ) *(.intvec_tc3_0x  95) *(.intvec_tc3_0x95) } > .
    .inttab_tc3_096 BIND (__INTTAB_CPU3 + 0x12C0) ALIGN(8) : { *(.intvec_tc3_150  ) *(.intvec_tc3_0x  96) *(.intvec_tc3_0x96) } > .
    .inttab_tc3_097 BIND (__INTTAB_CPU3 + 0x12E0) ALIGN(8) : { *(.intvec_tc3_151  ) *(.intvec_tc3_0x  97) *(.intvec_tc3_0x97) } > .
    .inttab_tc3_098 BIND (__INTTAB_CPU3 + 0x1300) ALIGN(8) : { *(.intvec_tc3_152  ) *(.intvec_tc3_0x  98) *(.intvec_tc3_0x98) } > .
    .inttab_tc3_099 BIND (__INTTAB_CPU3 + 0x1320) ALIGN(8) : { *(.intvec_tc3_153  ) *(.intvec_tc3_0x  99) *(.intvec_tc3_0x99) } > .
    .inttab_tc3_09A BIND (__INTTAB_CPU3 + 0x1340) ALIGN(8) : { *(.intvec_tc3_154  ) *(.intvec_tc3_0x  9A) *(.intvec_tc3_0x9a) } > .
    .inttab_tc3_09B BIND (__INTTAB_CPU3 + 0x1360) ALIGN(8) : { *(.intvec_tc3_155  ) *(.intvec_tc3_0x  9B) *(.intvec_tc3_0x9b) } > .
    .inttab_tc3_09C BIND (__INTTAB_CPU3 + 0x1380) ALIGN(8) : { *(.intvec_tc3_156  ) *(.intvec_tc3_0x  9C) *(.intvec_tc3_0x9c) } > .
    .inttab_tc3_09D BIND (__INTTAB_CPU3 + 0x13A0) ALIGN(8) : { *(.intvec_tc3_157  ) *(.intvec_tc3_0x  9D) *(.intvec_tc3_0x9d) } > .
    .inttab_tc3_09E BIND (__INTTAB_CPU3 + 0x13C0) ALIGN(8) : { *(.intvec_tc3_158  ) *(.intvec_tc3_0x  9E) *(.intvec_tc3_0x9e) } > .
    .inttab_tc3_09F BIND (__INTTAB_CPU3 + 0x13E0) ALIGN(8) : { *(.intvec_tc3_159  ) *(.intvec_tc3_0x  9F) *(.intvec_tc3_0x9f) } > .
    .inttab_tc3_0A0 BIND (__INTTAB_CPU3 + 0x1400) ALIGN(8) : { *(.intvec_tc3_160  ) *(.intvec_tc3_0x  A0) *(.intvec_tc3_0xa0) } > .
    .inttab_tc3_0A1 BIND (__INTTAB_CPU3 + 0x1420) ALIGN(8) : { *(.intvec_tc3_161  ) *(.intvec_tc3_0x  A1) *(.intvec_tc3_0xa1) } > .
    .inttab_tc3_0A2 BIND (__INTTAB_CPU3 + 0x1440) ALIGN(8) : { *(.intvec_tc3_162  ) *(.intvec_tc3_0x  A2) *(.intvec_tc3_0xa2) } > .
    .inttab_tc3_0A3 BIND (__INTTAB_CPU3 + 0x1460) ALIGN(8) : { *(.intvec_tc3_163  ) *(.intvec_tc3_0x  A3) *(.intvec_tc3_0xa3) } > .
    .inttab_tc3_0A4 BIND (__INTTAB_CPU3 + 0x1480) ALIGN(8) : { *(.intvec_tc3_164  ) *(.intvec_tc3_0x  A4) *(.intvec_tc3_0xa4) } > .
    .inttab_tc3_0A5 BIND (__INTTAB_CPU3 + 0x14A0) ALIGN(8) : { *(.intvec_tc3_165  ) *(.intvec_tc3_0x  A5) *(.intvec_tc3_0xa5) } > .
    .inttab_tc3_0A6 BIND (__INTTAB_CPU3 + 0x14C0) ALIGN(8) : { *(.intvec_tc3_166  ) *(.intvec_tc3_0x  A6) *(.intvec_tc3_0xa6) } > .
    .inttab_tc3_0A7 BIND (__INTTAB_CPU3 + 0x14E0) ALIGN(8) : { *(.intvec_tc3_167  ) *(.intvec_tc3_0x  A7) *(.intvec_tc3_0xa7) } > .
    .inttab_tc3_0A8 BIND (__INTTAB_CPU3 + 0x1500) ALIGN(8) : { *(.intvec_tc3_168  ) *(.intvec_tc3_0x  A8) *(.intvec_tc3_0xa8) } > .
    .inttab_tc3_0A9 BIND (__INTTAB_CPU3 + 0x1520) ALIGN(8) : { *(.intvec_tc3_169  ) *(.intvec_tc3_0x  A9) *(.intvec_tc3_0xa9) } > .
    .inttab_tc3_0AA BIND (__INTTAB_CPU3 + 0x1540) ALIGN(8) : { *(.intvec_tc3_170  ) *(.intvec_tc3_0x  AA) *(.intvec_tc3_0xaa) } > .
    .inttab_tc3_0AB BIND (__INTTAB_CPU3 + 0x1560) ALIGN(8) : { *(.intvec_tc3_171  ) *(.intvec_tc3_0x  AB) *(.intvec_tc3_0xab) } > .
    .inttab_tc3_0AC BIND (__INTTAB_CPU3 + 0x1580) ALIGN(8) : { *(.intvec_tc3_172  ) *(.intvec_tc3_0x  AC) *(.intvec_tc3_0xac) } > .
    .inttab_tc3_0AD BIND (__INTTAB_CPU3 + 0x15A0) ALIGN(8) : { *(.intvec_tc3_173  ) *(.intvec_tc3_0x  AD) *(.intvec_tc3_0xad) } > .
    .inttab_tc3_0AE BIND (__INTTAB_CPU3 + 0x15C0) ALIGN(8) : { *(.intvec_tc3_174  ) *(.intvec_tc3_0x  AE) *(.intvec_tc3_0xae) } > .
    .inttab_tc3_0AF BIND (__INTTAB_CPU3 + 0x15E0) ALIGN(8) : { *(.intvec_tc3_175  ) *(.intvec_tc3_0x  AF) *(.intvec_tc3_0xaf) } > .
    .inttab_tc3_0B0 BIND (__INTTAB_CPU3 + 0x1600) ALIGN(8) : { *(.intvec_tc3_176  ) *(.intvec_tc3_0x  B0) *(.intvec_tc3_0xb0) } > .
    .inttab_tc3_0B1 BIND (__INTTAB_CPU3 + 0x1620) ALIGN(8) : { *(.intvec_tc3_177  ) *(.intvec_tc3_0x  B1) *(.intvec_tc3_0xb1) } > .
    .inttab_tc3_0B2 BIND (__INTTAB_CPU3 + 0x1640) ALIGN(8) : { *(.intvec_tc3_178  ) *(.intvec_tc3_0x  B2) *(.intvec_tc3_0xb2) } > .
    .inttab_tc3_0B3 BIND (__INTTAB_CPU3 + 0x1660) ALIGN(8) : { *(.intvec_tc3_179  ) *(.intvec_tc3_0x  B3) *(.intvec_tc3_0xb3) } > .
    .inttab_tc3_0B4 BIND (__INTTAB_CPU3 + 0x1680) ALIGN(8) : { *(.intvec_tc3_180  ) *(.intvec_tc3_0x  B4) *(.intvec_tc3_0xb4) } > .
    .inttab_tc3_0B5 BIND (__INTTAB_CPU3 + 0x16A0) ALIGN(8) : { *(.intvec_tc3_181  ) *(.intvec_tc3_0x  B5) *(.intvec_tc3_0xb5) } > .
    .inttab_tc3_0B6 BIND (__INTTAB_CPU3 + 0x16C0) ALIGN(8) : { *(.intvec_tc3_182  ) *(.intvec_tc3_0x  B6) *(.intvec_tc3_0xb6) } > .
    .inttab_tc3_0B7 BIND (__INTTAB_CPU3 + 0x16E0) ALIGN(8) : { *(.intvec_tc3_183  ) *(.intvec_tc3_0x  B7) *(.intvec_tc3_0xb7) } > .
    .inttab_tc3_0B8 BIND (__INTTAB_CPU3 + 0x1700) ALIGN(8) : { *(.intvec_tc3_184  ) *(.intvec_tc3_0x  B8) *(.intvec_tc3_0xb8) } > .
    .inttab_tc3_0B9 BIND (__INTTAB_CPU3 + 0x1720) ALIGN(8) : { *(.intvec_tc3_185  ) *(.intvec_tc3_0x  B9) *(.intvec_tc3_0xb9) } > .
    .inttab_tc3_0BA BIND (__INTTAB_CPU3 + 0x1740) ALIGN(8) : { *(.intvec_tc3_186  ) *(.intvec_tc3_0x  BA) *(.intvec_tc3_0xba) } > .
    .inttab_tc3_0BB BIND (__INTTAB_CPU3 + 0x1760) ALIGN(8) : { *(.intvec_tc3_187  ) *(.intvec_tc3_0x  BB) *(.intvec_tc3_0xbb) } > .
    .inttab_tc3_0BC BIND (__INTTAB_CPU3 + 0x1780) ALIGN(8) : { *(.intvec_tc3_188  ) *(.intvec_tc3_0x  BC) *(.intvec_tc3_0xbc) } > .
    .inttab_tc3_0BD BIND (__INTTAB_CPU3 + 0x17A0) ALIGN(8) : { *(.intvec_tc3_189  ) *(.intvec_tc3_0x  BD) *(.intvec_tc3_0xbd) } > .
    .inttab_tc3_0BE BIND (__INTTAB_CPU3 + 0x17C0) ALIGN(8) : { *(.intvec_tc3_190  ) *(.intvec_tc3_0x  BE) *(.intvec_tc3_0xbe) } > .
    .inttab_tc3_0BF BIND (__INTTAB_CPU3 + 0x17E0) ALIGN(8) : { *(.intvec_tc3_191  ) *(.intvec_tc3_0x  BF) *(.intvec_tc3_0xbf) } > .
    .inttab_tc3_0C0 BIND (__INTTAB_CPU3 + 0x1800) ALIGN(8) : { *(.intvec_tc3_192  ) *(.intvec_tc3_0x  C0) *(.intvec_tc3_0xc0) } > .
    .inttab_tc3_0C1 BIND (__INTTAB_CPU3 + 0x1820) ALIGN(8) : { *(.intvec_tc3_193  ) *(.intvec_tc3_0x  C1) *(.intvec_tc3_0xc1) } > .
    .inttab_tc3_0C2 BIND (__INTTAB_CPU3 + 0x1840) ALIGN(8) : { *(.intvec_tc3_194  ) *(.intvec_tc3_0x  C2) *(.intvec_tc3_0xc2) } > .
    .inttab_tc3_0C3 BIND (__INTTAB_CPU3 + 0x1860) ALIGN(8) : { *(.intvec_tc3_195  ) *(.intvec_tc3_0x  C3) *(.intvec_tc3_0xc3) } > .
    .inttab_tc3_0C4 BIND (__INTTAB_CPU3 + 0x1880) ALIGN(8) : { *(.intvec_tc3_196  ) *(.intvec_tc3_0x  C4) *(.intvec_tc3_0xc4) } > .
    .inttab_tc3_0C5 BIND (__INTTAB_CPU3 + 0x18A0) ALIGN(8) : { *(.intvec_tc3_197  ) *(.intvec_tc3_0x  C5) *(.intvec_tc3_0xc5) } > .
    .inttab_tc3_0C6 BIND (__INTTAB_CPU3 + 0x18C0) ALIGN(8) : { *(.intvec_tc3_198  ) *(.intvec_tc3_0x  C6) *(.intvec_tc3_0xc6) } > .
    .inttab_tc3_0C7 BIND (__INTTAB_CPU3 + 0x18E0) ALIGN(8) : { *(.intvec_tc3_199  ) *(.intvec_tc3_0x  C7) *(.intvec_tc3_0xc7) } > .
    .inttab_tc3_0C8 BIND (__INTTAB_CPU3 + 0x1900) ALIGN(8) : { *(.intvec_tc3_200  ) *(.intvec_tc3_0x  C8) *(.intvec_tc3_0xc8) } > .
    .inttab_tc3_0C9 BIND (__INTTAB_CPU3 + 0x1920) ALIGN(8) : { *(.intvec_tc3_201  ) *(.intvec_tc3_0x  C9) *(.intvec_tc3_0xc9) } > .
    .inttab_tc3_0CA BIND (__INTTAB_CPU3 + 0x1940) ALIGN(8) : { *(.intvec_tc3_202  ) *(.intvec_tc3_0x  CA) *(.intvec_tc3_0xca) } > .
    .inttab_tc3_0CB BIND (__INTTAB_CPU3 + 0x1960) ALIGN(8) : { *(.intvec_tc3_203  ) *(.intvec_tc3_0x  CB) *(.intvec_tc3_0xcb) } > .
    .inttab_tc3_0CC BIND (__INTTAB_CPU3 + 0x1980) ALIGN(8) : { *(.intvec_tc3_204  ) *(.intvec_tc3_0x  CC) *(.intvec_tc3_0xcc) } > .
    .inttab_tc3_0CD BIND (__INTTAB_CPU3 + 0x19A0) ALIGN(8) : { *(.intvec_tc3_205  ) *(.intvec_tc3_0x  CD) *(.intvec_tc3_0xcd) } > .
    .inttab_tc3_0CE BIND (__INTTAB_CPU3 + 0x19C0) ALIGN(8) : { *(.intvec_tc3_206  ) *(.intvec_tc3_0x  CE) *(.intvec_tc3_0xce) } > .
    .inttab_tc3_0CF BIND (__INTTAB_CPU3 + 0x19E0) ALIGN(8) : { *(.intvec_tc3_207  ) *(.intvec_tc3_0x  CF) *(.intvec_tc3_0xcf) } > .
    .inttab_tc3_0D0 BIND (__INTTAB_CPU3 + 0x1A00) ALIGN(8) : { *(.intvec_tc3_208  ) *(.intvec_tc3_0x  D0) *(.intvec_tc3_0xd0) } > .
    .inttab_tc3_0D1 BIND (__INTTAB_CPU3 + 0x1A20) ALIGN(8) : { *(.intvec_tc3_209  ) *(.intvec_tc3_0x  D1) *(.intvec_tc3_0xd1) } > .
    .inttab_tc3_0D2 BIND (__INTTAB_CPU3 + 0x1A40) ALIGN(8) : { *(.intvec_tc3_210  ) *(.intvec_tc3_0x  D2) *(.intvec_tc3_0xd2) } > .
    .inttab_tc3_0D3 BIND (__INTTAB_CPU3 + 0x1A60) ALIGN(8) : { *(.intvec_tc3_211  ) *(.intvec_tc3_0x  D3) *(.intvec_tc3_0xd3) } > .
    .inttab_tc3_0D4 BIND (__INTTAB_CPU3 + 0x1A80) ALIGN(8) : { *(.intvec_tc3_212  ) *(.intvec_tc3_0x  D4) *(.intvec_tc3_0xd4) } > .
    .inttab_tc3_0D5 BIND (__INTTAB_CPU3 + 0x1AA0) ALIGN(8) : { *(.intvec_tc3_213  ) *(.intvec_tc3_0x  D5) *(.intvec_tc3_0xd5) } > .
    .inttab_tc3_0D6 BIND (__INTTAB_CPU3 + 0x1AC0) ALIGN(8) : { *(.intvec_tc3_214  ) *(.intvec_tc3_0x  D6) *(.intvec_tc3_0xd6) } > .
    .inttab_tc3_0D7 BIND (__INTTAB_CPU3 + 0x1AE0) ALIGN(8) : { *(.intvec_tc3_215  ) *(.intvec_tc3_0x  D7) *(.intvec_tc3_0xd7) } > .
    .inttab_tc3_0D8 BIND (__INTTAB_CPU3 + 0x1B00) ALIGN(8) : { *(.intvec_tc3_216  ) *(.intvec_tc3_0x  D8) *(.intvec_tc3_0xd8) } > .
    .inttab_tc3_0D9 BIND (__INTTAB_CPU3 + 0x1B20) ALIGN(8) : { *(.intvec_tc3_217  ) *(.intvec_tc3_0x  D9) *(.intvec_tc3_0xd9) } > .
    .inttab_tc3_0DA BIND (__INTTAB_CPU3 + 0x1B40) ALIGN(8) : { *(.intvec_tc3_218  ) *(.intvec_tc3_0x  DA) *(.intvec_tc3_0xda) } > .
    .inttab_tc3_0DB BIND (__INTTAB_CPU3 + 0x1B60) ALIGN(8) : { *(.intvec_tc3_219  ) *(.intvec_tc3_0x  DB) *(.intvec_tc3_0xdb) } > .
    .inttab_tc3_0DC BIND (__INTTAB_CPU3 + 0x1B80) ALIGN(8) : { *(.intvec_tc3_220  ) *(.intvec_tc3_0x  DC) *(.intvec_tc3_0xdc) } > .
    .inttab_tc3_0DD BIND (__INTTAB_CPU3 + 0x1BA0) ALIGN(8) : { *(.intvec_tc3_221  ) *(.intvec_tc3_0x  DD) *(.intvec_tc3_0xdd) } > .
    .inttab_tc3_0DE BIND (__INTTAB_CPU3 + 0x1BC0) ALIGN(8) : { *(.intvec_tc3_222  ) *(.intvec_tc3_0x  DE) *(.intvec_tc3_0xde) } > .
    .inttab_tc3_0DF BIND (__INTTAB_CPU3 + 0x1BE0) ALIGN(8) : { *(.intvec_tc3_223  ) *(.intvec_tc3_0x  DF) *(.intvec_tc3_0xdf) } > .
    .inttab_tc3_0E0 BIND (__INTTAB_CPU3 + 0x1C00) ALIGN(8) : { *(.intvec_tc3_224  ) *(.intvec_tc3_0x  E0) *(.intvec_tc3_0xe0) } > .
    .inttab_tc3_0E1 BIND (__INTTAB_CPU3 + 0x1C20) ALIGN(8) : { *(.intvec_tc3_225  ) *(.intvec_tc3_0x  E1) *(.intvec_tc3_0xe1) } > .
    .inttab_tc3_0E2 BIND (__INTTAB_CPU3 + 0x1C40) ALIGN(8) : { *(.intvec_tc3_226  ) *(.intvec_tc3_0x  E2) *(.intvec_tc3_0xe2) } > .
    .inttab_tc3_0E3 BIND (__INTTAB_CPU3 + 0x1C60) ALIGN(8) : { *(.intvec_tc3_227  ) *(.intvec_tc3_0x  E3) *(.intvec_tc3_0xe3) } > .
    .inttab_tc3_0E4 BIND (__INTTAB_CPU3 + 0x1C80) ALIGN(8) : { *(.intvec_tc3_228  ) *(.intvec_tc3_0x  E4) *(.intvec_tc3_0xe4) } > .
    .inttab_tc3_0E5 BIND (__INTTAB_CPU3 + 0x1CA0) ALIGN(8) : { *(.intvec_tc3_229  ) *(.intvec_tc3_0x  E5) *(.intvec_tc3_0xe5) } > .
    .inttab_tc3_0E6 BIND (__INTTAB_CPU3 + 0x1CC0) ALIGN(8) : { *(.intvec_tc3_230  ) *(.intvec_tc3_0x  E6) *(.intvec_tc3_0xe6) } > .
    .inttab_tc3_0E7 BIND (__INTTAB_CPU3 + 0x1CE0) ALIGN(8) : { *(.intvec_tc3_231  ) *(.intvec_tc3_0x  E7) *(.intvec_tc3_0xe7) } > .
    .inttab_tc3_0E8 BIND (__INTTAB_CPU3 + 0x1D00) ALIGN(8) : { *(.intvec_tc3_232  ) *(.intvec_tc3_0x  E8) *(.intvec_tc3_0xe8) } > .
    .inttab_tc3_0E9 BIND (__INTTAB_CPU3 + 0x1D20) ALIGN(8) : { *(.intvec_tc3_233  ) *(.intvec_tc3_0x  E9) *(.intvec_tc3_0xe9) } > .
    .inttab_tc3_0EA BIND (__INTTAB_CPU3 + 0x1D40) ALIGN(8) : { *(.intvec_tc3_234  ) *(.intvec_tc3_0x  EA) *(.intvec_tc3_0xea) } > .
    .inttab_tc3_0EB BIND (__INTTAB_CPU3 + 0x1D60) ALIGN(8) : { *(.intvec_tc3_235  ) *(.intvec_tc3_0x  EB) *(.intvec_tc3_0xeb) } > .
    .inttab_tc3_0EC BIND (__INTTAB_CPU3 + 0x1D80) ALIGN(8) : { *(.intvec_tc3_236  ) *(.intvec_tc3_0x  EC) *(.intvec_tc3_0xec) } > .
    .inttab_tc3_0ED BIND (__INTTAB_CPU3 + 0x1DA0) ALIGN(8) : { *(.intvec_tc3_237  ) *(.intvec_tc3_0x  ED) *(.intvec_tc3_0xed) } > .
    .inttab_tc3_0EE BIND (__INTTAB_CPU3 + 0x1DC0) ALIGN(8) : { *(.intvec_tc3_238  ) *(.intvec_tc3_0x  EE) *(.intvec_tc3_0xee) } > .
    .inttab_tc3_0EF BIND (__INTTAB_CPU3 + 0x1DE0) ALIGN(8) : { *(.intvec_tc3_239  ) *(.intvec_tc3_0x  EF) *(.intvec_tc3_0xef) } > .
    .inttab_tc3_0F0 BIND (__INTTAB_CPU3 + 0x1E00) ALIGN(8) : { *(.intvec_tc3_240  ) *(.intvec_tc3_0x  F0) *(.intvec_tc3_0xf0) } > .
    .inttab_tc3_0F1 BIND (__INTTAB_CPU3 + 0x1E20) ALIGN(8) : { *(.intvec_tc3_241  ) *(.intvec_tc3_0x  F1) *(.intvec_tc3_0xf1) } > .
    .inttab_tc3_0F2 BIND (__INTTAB_CPU3 + 0x1E40) ALIGN(8) : { *(.intvec_tc3_242  ) *(.intvec_tc3_0x  F2) *(.intvec_tc3_0xf2) } > .
    .inttab_tc3_0F3 BIND (__INTTAB_CPU3 + 0x1E60) ALIGN(8) : { *(.intvec_tc3_243  ) *(.intvec_tc3_0x  F3) *(.intvec_tc3_0xf3) } > .
    .inttab_tc3_0F4 BIND (__INTTAB_CPU3 + 0x1E80) ALIGN(8) : { *(.intvec_tc3_244  ) *(.intvec_tc3_0x  F4) *(.intvec_tc3_0xf4) } > .
    .inttab_tc3_0F5 BIND (__INTTAB_CPU3 + 0x1EA0) ALIGN(8) : { *(.intvec_tc3_245  ) *(.intvec_tc3_0x  F5) *(.intvec_tc3_0xf5) } > .
    .inttab_tc3_0F6 BIND (__INTTAB_CPU3 + 0x1EC0) ALIGN(8) : { *(.intvec_tc3_246  ) *(.intvec_tc3_0x  F6) *(.intvec_tc3_0xf6) } > .
    .inttab_tc3_0F7 BIND (__INTTAB_CPU3 + 0x1EE0) ALIGN(8) : { *(.intvec_tc3_247  ) *(.intvec_tc3_0x  F7) *(.intvec_tc3_0xf7) } > .
    .inttab_tc3_0F8 BIND (__INTTAB_CPU3 + 0x1F00) ALIGN(8) : { *(.intvec_tc3_248  ) *(.intvec_tc3_0x  F8) *(.intvec_tc3_0xf8) } > .
    .inttab_tc3_0F9 BIND (__INTTAB_CPU3 + 0x1F20) ALIGN(8) : { *(.intvec_tc3_249  ) *(.intvec_tc3_0x  F9) *(.intvec_tc3_0xf9) } > .
    .inttab_tc3_0FA BIND (__INTTAB_CPU3 + 0x1F40) ALIGN(8) : { *(.intvec_tc3_250  ) *(.intvec_tc3_0x  FA) *(.intvec_tc3_0xfa) } > .
    .inttab_tc3_0FB BIND (__INTTAB_CPU3 + 0x1F60) ALIGN(8) : { *(.intvec_tc3_251  ) *(.intvec_tc3_0x  FB) *(.intvec_tc3_0xfb) } > .
    .inttab_tc3_0FC BIND (__INTTAB_CPU3 + 0x1F80) ALIGN(8) : { *(.intvec_tc3_252  ) *(.intvec_tc3_0x  FC) *(.intvec_tc3_0xfc) } > .
    .inttab_tc3_0FD BIND (__INTTAB_CPU3 + 0x1FA0) ALIGN(8) : { *(.intvec_tc3_253  ) *(.intvec_tc3_0x  FD) *(.intvec_tc3_0xfd) } > .
    .inttab_tc3_0FE BIND (__INTTAB_CPU3 + 0x1FC0) ALIGN(8) : { *(.intvec_tc3_254  ) *(.intvec_tc3_0x  FE) *(.intvec_tc3_0xfe) } > .
    .inttab_tc3_0FF BIND (__INTTAB_CPU3 + 0x1FE0) ALIGN(8) : { *(.intvec_tc3_255  ) *(.intvec_tc3_0x  FF) *(.intvec_tc3_0xff) } > .

    .ppu_code (MEMENDADDR(pfls5) - LCF_PPU_FLASH_SIZE) : {.+= LCF_PPU_FLASH_SIZE;}
    PROVIDE(__PPU_IF_CONSTANTS = ADDR(.ppu_code));
    PROVIDE(__PPU_CODE_START   = ADDR(.ppu_code));
    PROVIDE(__PPU_CODE_END     = ENDADDR(.ppu_code));


    /* LMU memory sections */
    /* Near absolute LMURAM sections */
    .GLOBAL_lmuzdata ABS       ALIGN(4) : { *(.zlmudata) } > cpu3_dlmu
    .GLOBAL_lmuzbss  ABS CLEAR ALIGN(4) : { *(.zlmubss) } > .

    /* Far addressable LMURAM sections */
    .CPU3_lmudata       ALIGN(4) : { "*(.lmudata_cpu3)" } > cpu3_dlmu
    .CPU3_lmubss        ALIGN(4) : { "*(.lmubss_cpu3)" } > .

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
    PROVIDE(__ghs_ramstart  = MEMADDR(psram3));
    PROVIDE(__ghs_ramend    = MEMENDADDR(psram3));
    PROVIDE(__ghs_romstart  = MEMADDR(pfls3));
    PROVIDE(__ghs_romend    = MEMENDADDR(pfls3));

//
// These special symbols mark the bounds of RAM and ROM images of boot code.
// They are used by the GHS startup code (_start and __ghs_ind_crt0).
//
    PROVIDE(__ghs_rambootcodestart  = 0);
    PROVIDE(__ghs_rambootcodeend    = 0);
    PROVIDE(__ghs_rombootcodestart  = ADDR(.start_tc3));
    PROVIDE(__ghs_rombootcodeend    = ENDADDR(.secinfo));
    PROVIDE(__INTTAB_CPU3= __INTTAB_CPU3);
}
