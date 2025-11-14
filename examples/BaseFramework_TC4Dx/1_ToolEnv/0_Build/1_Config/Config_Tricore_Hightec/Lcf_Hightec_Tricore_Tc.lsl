/* Default linker script, for normal executables */
OUTPUT_FORMAT("elf32-tricore")
OUTPUT_ARCH(tricore)
ENTRY(_START)

__TRICORE_DERIVATE_MEMORY_MAP__ = 0x4D0;

LCF_CSA0_SIZE    = 8k;
LCF_USTACK0_SIZE = 2k;
LCF_ISTACK0_SIZE = 1k;

LCF_CSA1_SIZE    = 8k;
LCF_USTACK1_SIZE = 2k;
LCF_ISTACK1_SIZE = 1k;

LCF_CSA2_SIZE    = 8k;
LCF_USTACK2_SIZE = 2k;
LCF_ISTACK2_SIZE = 1k;

LCF_CSA3_SIZE    = 8k;
LCF_USTACK3_SIZE = 2k;
LCF_ISTACK3_SIZE = 1k;

LCF_CSA4_SIZE    = 8k;
LCF_USTACK4_SIZE = 2k;
LCF_ISTACK4_SIZE = 1k;

LCF_CSA5_SIZE    = 8k;
LCF_USTACK5_SIZE = 2k;
LCF_ISTACK5_SIZE = 1k;

LCF_HEAP_SIZE = 4k;

LCF_DSPR5_START = 0x20000000;
LCF_DSPR5_SIZE  = 240K;

LCF_DSPR4_START = 0x30000000;
LCF_DSPR4_SIZE  = 240K;

LCF_DSPR3_START = 0x40000000;
LCF_DSPR3_SIZE  = 240K;

LCF_DSPR2_START = 0x50000000;
LCF_DSPR2_SIZE  = 240K;

LCF_DSPR1_START = 0x60000000;
LCF_DSPR1_SIZE  = 240K;

LCF_DSPR0_START = 0x70000000;
LCF_DSPR0_SIZE  = 240K;

LCF_CSA5_OFFSET    = (LCF_DSPR5_SIZE - 1k - LCF_CSA5_SIZE);
LCF_ISTACK5_OFFSET = (LCF_CSA5_OFFSET - 256 - LCF_ISTACK5_SIZE);
LCF_USTACK5_OFFSET = (LCF_ISTACK5_OFFSET - 256 - LCF_USTACK5_SIZE);

LCF_CSA4_OFFSET    = (LCF_DSPR4_SIZE - 1k - LCF_CSA4_SIZE);
LCF_ISTACK4_OFFSET = (LCF_CSA4_OFFSET - 256 - LCF_ISTACK4_SIZE);
LCF_USTACK4_OFFSET = (LCF_ISTACK4_OFFSET - 256 - LCF_USTACK4_SIZE);

LCF_CSA3_OFFSET    = (LCF_DSPR3_SIZE - 1k - LCF_CSA3_SIZE);
LCF_ISTACK3_OFFSET = (LCF_CSA3_OFFSET - 256 - LCF_ISTACK3_SIZE);
LCF_USTACK3_OFFSET = (LCF_ISTACK3_OFFSET - 256 - LCF_USTACK3_SIZE);

LCF_CSA2_OFFSET    = (LCF_DSPR2_SIZE - 1k - LCF_CSA2_SIZE);
LCF_ISTACK2_OFFSET = (LCF_CSA2_OFFSET - 256 - LCF_ISTACK2_SIZE);
LCF_USTACK2_OFFSET = (LCF_ISTACK2_OFFSET - 256 - LCF_USTACK2_SIZE);

LCF_CSA1_OFFSET    = (LCF_DSPR1_SIZE - 1k - LCF_CSA1_SIZE);
LCF_ISTACK1_OFFSET = (LCF_CSA1_OFFSET - 256 - LCF_ISTACK1_SIZE);
LCF_USTACK1_OFFSET = (LCF_ISTACK1_OFFSET - 256 - LCF_USTACK1_SIZE);

LCF_CSA0_OFFSET    = (LCF_DSPR0_SIZE - 1k - LCF_CSA0_SIZE);
LCF_ISTACK0_OFFSET = (LCF_CSA0_OFFSET - 256 - LCF_ISTACK0_SIZE);
LCF_USTACK0_OFFSET = (LCF_ISTACK0_OFFSET - 256 - LCF_USTACK0_SIZE);

LCF_HEAP0_OFFSET = (LCF_USTACK0_OFFSET - LCF_HEAP_SIZE);
LCF_HEAP1_OFFSET = (LCF_USTACK1_OFFSET - LCF_HEAP_SIZE);
LCF_HEAP2_OFFSET = (LCF_USTACK2_OFFSET - LCF_HEAP_SIZE);
LCF_HEAP3_OFFSET = (LCF_USTACK3_OFFSET - LCF_HEAP_SIZE);
LCF_HEAP4_OFFSET = (LCF_USTACK4_OFFSET - LCF_HEAP_SIZE);
LCF_HEAP5_OFFSET = (LCF_USTACK5_OFFSET - LCF_HEAP_SIZE);
LCF_INTVEC0_START = 0x803FE000;
LCF_INTVEC1_START = 0x807FE000;
LCF_INTVEC2_START = 0x809FE000;
LCF_INTVEC3_START = 0x80DFE000;
LCF_INTVEC4_START = 0x811FE000;
LCF_INTVEC5_START = 0x813FE000;

LCF_TRAPVEC0_START = 0x80000100;
LCF_TRAPVEC1_START = 0x80400100;
LCF_TRAPVEC2_START = 0x80800100;
LCF_TRAPVEC3_START = 0x80A00100;
LCF_TRAPVEC4_START = 0x80E00100;
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
__INTTAB_CPU0 = LCF_INTVEC0_START;
__INTTAB_CPU1 = LCF_INTVEC1_START;
__INTTAB_CPU2 = LCF_INTVEC2_START;
__INTTAB_CPU3 = LCF_INTVEC3_START;
__INTTAB_CPU4 = LCF_INTVEC4_START;
__INTTAB_CPU5 = LCF_INTVEC5_START;


RESET = LCF_STARTPTR_NC_CPU0;

MEMORY
{
    dsram5 (w!x): org = 0x20000000, len = 240K
    psram5 (w!x): org = 0x20100000, len = 64K

    dsram4 (w!x): org = 0x30000000, len = 240K
    psram4 (w!x): org = 0x30100000, len = 64K

    dsram3 (w!x): org = 0x40000000, len = 240K
    psram3 (w!x): org = 0x40100000, len = 64K

    dsram2 (w!x): org = 0x50000000, len = 240K
    psram2 (w!x): org = 0x50100000, len = 64K

    dsram1 (w!x): org = 0x60000000, len = 240K
    psram1 (w!x): org = 0x60100000, len = 64K

    dsram0 (w!x): org = 0x70000000, len = 240K
    psram0 (w!x): org = 0x70100000, len = 64K

    psram_local (w!x): org = 0xc0000000, len = 64K
	dsram_local (w!x): org = 0xd0000000, len = 240K

    pfls0 (rx): org = 0x80000000, len = 4M
    pfls0_nc (rx): org = 0xA0000000, len = 4M

    pfls1 (rx): org = 0x80400000, len = 4M
    pfls1_nc (rx): org = 0xA0400000, len = 4M

    pfls2 (rx): org = 0x80800000, len = 2M
    pfls2_nc (rx): org = 0xA0800000, len = 2M

    pfls3 (rx): org = 0x80A00000, len = 4M
    pfls3_nc (rx): org = 0xA0A00000, len = 4M

    pfls4 (rx): org = 0x80E00000, len = 4M
    pfls4_nc (rx): org = 0xA0E00000, len = 4M

    pfls5 (rx): org = 0x81200000, len = 2M
    pfls5_nc (rx): org = 0xA1200000, len = 2M


    /*ucb (rx): org = 0xae400000, len = 80K*/
	ucb_bmhd0 (rx): org = 0xae404800, len = 2K
	ucb_bmhd1 (rx): org = 0xae405000, len = 2K
	ucb_bmhd2 (rx): org = 0xae405800, len = 2K
	ucb_bmhd3 (rx): org = 0xae406000, len = 2K
	ucb_usercfg_org (rx): org = 0xae408800, len = 2K
	ucb_usercfg_cpy (rx): org = 0xae409000, len = 2K

    cpu0_dlmu (w!x): org = 0x90000000, len = 512K
    cpu0_dlmu_nc (w!x): org = 0xb0000000, len = 512K

    cpu1_dlmu (w!x): org = 0x90080000, len = 512K
    cpu1_dlmu_nc (w!x): org = 0xb0080000, len = 512K

    cpu2_dlmu (w!x): org = 0x90100000, len = 512K
    cpu2_dlmu_nc (w!x): org = 0xb0100000, len = 512K

    cpu3_dlmu (w!x): org = 0x90180000, len = 512K
    cpu3_dlmu_nc (w!x): org = 0xb0180000, len = 512K

    cpu4_dlmu (w!x): org = 0x90200000, len = 512K
    cpu4_dlmu_nc (w!x): org = 0xb0200000, len = 512K

    cpu5_dlmu (w!x): org = 0x90280000, len = 512K
    cpu5_dlmu_nc (w!x): org = 0xb0280000, len = 512K

    lmuram (w!x): org = 0x90400000, len = 5M
    lmuram_nc (w!x): org = 0xb0400000, len = 5M

}

/* map cached and non cached addresses */
REGION_MIRROR("pfls0", "pfls0_nc")
REGION_MIRROR("pfls1", "pfls1_nc")
REGION_MIRROR("pfls2", "pfls2_nc")
REGION_MIRROR("pfls3", "pfls3_nc")
REGION_MIRROR("pfls4", "pfls4_nc")
REGION_MIRROR("pfls5", "pfls5_nc")
REGION_MIRROR("cpu0_dlmu", "cpu0_dlmu_nc")
REGION_MIRROR("cpu1_dlmu", "cpu1_dlmu_nc")
REGION_MIRROR("cpu2_dlmu", "cpu2_dlmu_nc")
REGION_MIRROR("cpu3_dlmu", "cpu3_dlmu_nc")
REGION_MIRROR("cpu4_dlmu", "cpu4_dlmu_nc")
REGION_MIRROR("cpu5_dlmu", "cpu5_dlmu_nc")
REGION_MIRROR("lmuram", "lmuram_nc")

/*Un comment one of the below statement groups to enable CpuX DMI RAM to hold global variables*/

REGION_ALIAS( default_ram , dsram0)
REGION_ALIAS( default_rom , pfls0)

/*
REGION_ALIAS( default_ram , dsram1)
REGION_ALIAS( default_rom , pfls1)
*/
/*
REGION_ALIAS( default_ram , dsram2)
REGION_ALIAS( default_rom , pfls2)
*/
/*
REGION_ALIAS( default_ram , dsram3)
REGION_ALIAS( default_rom , pfls3)
*/
/*
REGION_ALIAS( default_ram , dsram4)
REGION_ALIAS( default_rom , pfls4)
*/
/*
REGION_ALIAS( default_ram , dsram5)
REGION_ALIAS( default_rom , pfls5)
*/


    /* Fixed memory Allocations for _START */
    SECTIONS
    {
		.start_tc0 (LCF_STARTPTR_NC_CPU0) : { KEEP (*(.start)); } > pfls0_nc
		.interface_const (0x80000020) : { __IF_CONST = .; KEEP (*(.interface_const)); } > pfls0
		.traptab_tc0 (LCF_TRAPVEC0_START) : { PROVIDE(__TRAPTAB_CPU0 = .); KEEP (*(.traptab_cpu0)); } > pfls0
		PROVIDE(__IF_CONST = 0x80000020);
		PROVIDE(__START0 = LCF_STARTPTR_NC_CPU0);
	


    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU0 = 0); /* Not used */
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU1 = 0);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU2 = 0);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU3 = 0);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU4 = 0);
    PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU5 = 0);
    }                     



    SECTIONS
    {
		.start_tc1 (LCF_STARTPTR_NC_CPU1) :  { KEEP (*(.start_cpu1)); } > pfls1_nc
        .traptab_tc1 (LCF_TRAPVEC1_START) : { PROVIDE(__TRAPTAB_CPU1 = .); KEEP (*(.traptab_cpu1)); } > pfls1
		 PROVIDE(__START1 = LCF_STARTPTR_NC_CPU1);
	}
    SECTIONS
    {
		.start_tc2 (LCF_STARTPTR_NC_CPU2) :  { KEEP (*(.start_cpu2)); } > pfls2_nc
        .traptab_tc2 (LCF_TRAPVEC2_START) : { PROVIDE(__TRAPTAB_CPU2 = .); KEEP (*(.traptab_cpu2)); } > pfls2
		 PROVIDE(__START2 = LCF_STARTPTR_NC_CPU2);
	}
    SECTIONS
    {
		.start_tc3 (LCF_STARTPTR_NC_CPU3) :  { KEEP (*(.start_cpu3)); } > pfls3_nc
        .traptab_tc3 (LCF_TRAPVEC3_START) : { PROVIDE(__TRAPTAB_CPU3 = .); KEEP (*(.traptab_cpu3)); } > pfls3
		 PROVIDE(__START3 = LCF_STARTPTR_NC_CPU3);
	}
    SECTIONS
    {
		.start_tc4 (LCF_STARTPTR_NC_CPU4) :  { KEEP (*(.start_cpu4)); } > pfls4_nc
        .traptab_tc4 (LCF_TRAPVEC4_START) : { PROVIDE(__TRAPTAB_CPU4 = .); KEEP (*(.traptab_cpu4)); } > pfls4
		 PROVIDE(__START4 = LCF_STARTPTR_NC_CPU4);
	}
    SECTIONS
    {
		.start_tc5 (LCF_STARTPTR_NC_CPU5) :  { KEEP (*(.start_cpu5)); } > pfls5_nc
        .traptab_tc5 (LCF_TRAPVEC5_START) : { PROVIDE(__TRAPTAB_CPU5 = .); KEEP (*(.traptab_cpu5)); } > pfls5
		 PROVIDE(__START5 = LCF_STARTPTR_NC_CPU5);
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
    SECTIONS
    {
        .CPU4.zdata (LCF_DSPR4_START):
        {
            *Ifx_Ssw_Tc4.* (.zdata) *Ifx_Ssw_Tc4.* (.zdata.*)
            *Cpu4_Main.* (.zdata) *Cpu4_Main.* (.zdata.*)
            *(.zdata_cpu4) *(.zdata_cpu4.*)
            . = ALIGN(2);
        } > dsram4 AT> default_rom
        
        .CPU4.zbss (NOLOAD): ALIGN(4)
        {
            *Ifx_Ssw_Tc4.* (.zbss) *Ifx_Ssw_Tc4.* (.zbss.*)
            *Cpu4_Main.* (.zbss) *Cpu4_Main.* (.zbss.*)
            *(.zbss_cpu4)*(.zbss_cpu4.*)

        } > dsram4
    }
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
    SECTIONS
    {
        .CPU2.zdata (LCF_DSPR2_START):
        {
            *Ifx_Ssw_Tc2.* (.zdata) *Ifx_Ssw_Tc2.* (.zdata.*)
            *Cpu2_Main.* (.zdata) *Cpu2_Main.* (.zdata.*)
            *(.zdata_cpu2) *(.zdata_cpu2.*)
            . = ALIGN(2);
        } > dsram2 AT> default_rom
        
        .CPU2.zbss (NOLOAD): ALIGN(4)
        {
            *Ifx_Ssw_Tc2.* (.zbss) *Ifx_Ssw_Tc2.* (.zbss.*)
            *Cpu2_Main.* (.zbss) *Cpu2_Main.* (.zbss.*)
            *(.zbss_cpu2)*(.zbss_cpu2.*)

        } > dsram2
    }
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
SECTIONS
{
    /*DSRAM4 Sections*/
    .CPU4.data : ALIGN(4)
    {
        *Ifx_Ssw_Tc4.* (.data) *Ifx_Ssw_Tc4.* (.data.*)
        *Cpu4_Main.* (.data) *Cpu4_Main.* (.data.*)
        *(.data_cpu4) *(.data_cpu4.*)
        . = ALIGN(2);
    } > dsram4 AT> default_rom
    
    .CPU4.bss (NOLOAD): ALIGN(4)
    {
        *Ifx_Ssw_Tc4.* (.bss) *Ifx_Ssw_Tc4.* (.bss.*)
        *Cpu4_Main.* (.bss) *Cpu4_Main.* (.bss.*)
        *(.bss_cpu4) *(.bss_cpu4.*)

    } > dsram4
    
    /*DLMU4 Sections*/
    .CPU4.lmudata : ALIGN(4) 
    {
         *(.lmudata_cpu4) *(.lmudata_cpu4.*)
        . = ALIGN(2);
    } > cpu4_dlmu AT> default_rom
    
    .CPU4.lmubss (NOLOAD) : ALIGN(4) 
    {
        *(.lmubss_cpu4) *(.lmubss_cpu4.*)   
    } > cpu4_dlmu
}
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
SECTIONS
{
    /*DSRAM2 Sections*/
    .CPU2.data : ALIGN(4)
    {
        *Ifx_Ssw_Tc2.* (.data) *Ifx_Ssw_Tc2.* (.data.*)
        *Cpu2_Main.* (.data) *Cpu2_Main.* (.data.*)
        *(.data_cpu2) *(.data_cpu2.*)
        . = ALIGN(2);
    } > dsram2 AT> default_rom
    
    .CPU2.bss (NOLOAD): ALIGN(4)
    {
        *Ifx_Ssw_Tc2.* (.bss) *Ifx_Ssw_Tc2.* (.bss.*)
        *Cpu2_Main.* (.bss) *Cpu2_Main.* (.bss.*)
        *(.bss_cpu2) *(.bss_cpu2.*)

    } > dsram2
    
    /*DLMU2 Sections*/
    .CPU2.lmudata : ALIGN(4) 
    {
         *(.lmudata_cpu2) *(.lmudata_cpu2.*)
        . = ALIGN(2);
    } > cpu2_dlmu AT> default_rom
    
    .CPU2.lmubss (NOLOAD) : ALIGN(4) 
    {
        *(.lmubss_cpu2) *(.lmubss_cpu2.*)   
    } > cpu2_dlmu
}
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
    } > lmuram_nc AT> default_rom
    
    .lmubss : ALIGN(4) 
    {
        *(.lmubss) *(.lmubss.*)
        *(.uncached.lmubss) *(.uncached.lmubss.*)
    } > lmuram_nc
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

    SECTIONS
    {
        .CPU4.ustack (LCF_DSPR4_START + LCF_USTACK4_OFFSET)(NOLOAD):
        { PROVIDE(__USTACK4_END = .);    . = . + LCF_USTACK4_SIZE;    PROVIDE(__USTACK4 = .); } > dsram4
        
        .CPU4.istack (LCF_DSPR4_START + LCF_ISTACK4_OFFSET)(NOLOAD):
        { PROVIDE(__ISTACK4_END = .);    . = . + LCF_ISTACK4_SIZE;    PROVIDE(__ISTACK4 = .); } > dsram4
        
        .CPU4.csa (LCF_DSPR4_START + LCF_CSA4_OFFSET)(NOLOAD):
        { PROVIDE(__CSA4 = .);    . = . + LCF_CSA4_SIZE;    PROVIDE(__CSA4_END = .); } > dsram4
    }

    SECTIONS
    {
        .CPU3.ustack (LCF_DSPR3_START + LCF_USTACK3_OFFSET)(NOLOAD):
        { PROVIDE(__USTACK3_END = .);    . = . + LCF_USTACK3_SIZE;    PROVIDE(__USTACK3 = .); } > dsram3
        
        .CPU3.istack (LCF_DSPR3_START + LCF_ISTACK3_OFFSET)(NOLOAD):
        { PROVIDE(__ISTACK3_END = .);    . = . + LCF_ISTACK3_SIZE;    PROVIDE(__ISTACK3 = .); } > dsram3
        
        .CPU3.csa (LCF_DSPR3_START + LCF_CSA3_OFFSET)(NOLOAD):
        { PROVIDE(__CSA3 = .);    . = . + LCF_CSA3_SIZE;    PROVIDE(__CSA3_END = .); } > dsram3
    }

    SECTIONS
    {
        .CPU2.ustack (LCF_DSPR2_START + LCF_USTACK2_OFFSET)(NOLOAD):
        { PROVIDE(__USTACK2_END = .);    . = . + LCF_USTACK2_SIZE;    PROVIDE(__USTACK2 = .); } > dsram2
        
        .CPU2.istack (LCF_DSPR2_START + LCF_ISTACK2_OFFSET)(NOLOAD):
        { PROVIDE(__ISTACK2_END = .);    . = . + LCF_ISTACK2_SIZE;    PROVIDE(__ISTACK2 = .); } > dsram2
        
        .CPU2.csa (LCF_DSPR2_START + LCF_CSA2_OFFSET)(NOLOAD):
        { PROVIDE(__CSA2 = .);    . = . + LCF_CSA2_SIZE;    PROVIDE(__CSA2_END = .); } > dsram2
    }

    SECTIONS
    {
        .CPU1.ustack (LCF_DSPR1_START + LCF_USTACK1_OFFSET)(NOLOAD):
        { PROVIDE(__USTACK1_END = .);    . = . + LCF_USTACK1_SIZE;    PROVIDE(__USTACK1 = .); } > dsram1
        
        .CPU1.istack (LCF_DSPR1_START + LCF_ISTACK1_OFFSET)(NOLOAD):
        { PROVIDE(__ISTACK1_END = .);    . = . + LCF_ISTACK1_SIZE;    PROVIDE(__ISTACK1 = .); } > dsram1
        
        .CPU1.csa (LCF_DSPR1_START + LCF_CSA1_OFFSET)(NOLOAD):
        { PROVIDE(__CSA1 = .);    . = . + LCF_CSA1_SIZE;    PROVIDE(__CSA1_END = .); } > dsram1
    }

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

SECTIONS
{
    .CPU1.rodata : ALIGN(4) 
    {
        *Ifx_Ssw_Tc1.* (.rodata) *Ifx_Ssw_Tc1.* (.rodata.*)
        *Cpu1_Main.* (.rodata) *Cpu1_Main.* (.rodata.*)
		*(.rodata_cpu1) *(.rodata_cpu1.*)
    } > pfls1
}

SECTIONS
{
    .CPU2.rodata : ALIGN(4) 
    {
        *Ifx_Ssw_Tc2.* (.rodata) *Ifx_Ssw_Tc2.* (.rodata.*)
        *Cpu2_Main.* (.rodata) *Cpu2_Main.* (.rodata.*)
		*(.rodata_cpu2) *(.rodata_cpu2.*)
    } > pfls2
}

SECTIONS
{
    .CPU3.rodata : ALIGN(4) 
    {
        *Ifx_Ssw_Tc3.* (.rodata) *Ifx_Ssw_Tc3.* (.rodata.*)
        *Cpu3_Main.* (.rodata) *Cpu3_Main.* (.rodata.*)
		*(.rodata_cpu3) *(.rodata_cpu3.*)
    } > pfls3
}

SECTIONS
{
    .CPU4.rodata : ALIGN(4) 
    {
        *Ifx_Ssw_Tc4.* (.rodata) *Ifx_Ssw_Tc4.* (.rodata.*)
        *Cpu4_Main.* (.rodata) *Cpu4_Main.* (.rodata.*)
		*(.rodata_cpu4) *(.rodata_cpu4.*)
    } > pfls4
}

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
    LONG(0 + ADDR(.CPU5.zbss));       LONG(SIZEOF(.CPU5.zbss));
    LONG(0 + ADDR(.CPU5.bss));        LONG(SIZEOF(.CPU5.bss));
    LONG(0 + ADDR(.CPU5.lmubss));     LONG(SIZEOF(.CPU5.lmubss));
    LONG(0 + ADDR(.CPU4.zbss));       LONG(SIZEOF(.CPU4.zbss));
    LONG(0 + ADDR(.CPU4.bss));        LONG(SIZEOF(.CPU4.bss));
    LONG(0 + ADDR(.CPU4.lmubss));     LONG(SIZEOF(.CPU4.lmubss));
    LONG(0 + ADDR(.CPU3.zbss));       LONG(SIZEOF(.CPU3.zbss));
    LONG(0 + ADDR(.CPU3.bss));        LONG(SIZEOF(.CPU3.bss));
    LONG(0 + ADDR(.CPU3.lmubss));     LONG(SIZEOF(.CPU3.lmubss));
    LONG(0 + ADDR(.CPU2.zbss));       LONG(SIZEOF(.CPU2.zbss));
    LONG(0 + ADDR(.CPU2.bss));        LONG(SIZEOF(.CPU2.bss));
    LONG(0 + ADDR(.CPU2.lmubss));     LONG(SIZEOF(.CPU2.lmubss));
    LONG(0 + ADDR(.CPU1.zbss));       LONG(SIZEOF(.CPU1.zbss));
    LONG(0 + ADDR(.CPU1.bss));        LONG(SIZEOF(.CPU1.bss));
    LONG(0 + ADDR(.CPU1.lmubss));     LONG(SIZEOF(.CPU1.lmubss));
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
    LONG(LOADADDR(.CPU5.zdata));      LONG(0 + ADDR(.CPU5.zdata));      LONG(SIZEOF(.CPU5.zdata));
    LONG(LOADADDR(.CPU5.data));       LONG(0 + ADDR(.CPU5.data));       LONG(SIZEOF(.CPU5.data));
    LONG(LOADADDR(.CPU5.lmudata));    LONG(0 + ADDR(.CPU5.lmudata));    LONG(SIZEOF(.CPU5.lmudata));
    LONG(LOADADDR(.CPU4.zdata));      LONG(0 + ADDR(.CPU4.zdata));      LONG(SIZEOF(.CPU4.zdata));
    LONG(LOADADDR(.CPU4.data));       LONG(0 + ADDR(.CPU4.data));       LONG(SIZEOF(.CPU4.data));
    LONG(LOADADDR(.CPU4.lmudata));    LONG(0 + ADDR(.CPU4.lmudata));    LONG(SIZEOF(.CPU4.lmudata));
    LONG(LOADADDR(.CPU3.zdata));      LONG(0 + ADDR(.CPU3.zdata));      LONG(SIZEOF(.CPU3.zdata));
    LONG(LOADADDR(.CPU3.data));       LONG(0 + ADDR(.CPU3.data));       LONG(SIZEOF(.CPU3.data));
    LONG(LOADADDR(.CPU3.lmudata));    LONG(0 + ADDR(.CPU3.lmudata));    LONG(SIZEOF(.CPU3.lmudata));
    LONG(LOADADDR(.CPU2.zdata));      LONG(0 + ADDR(.CPU2.zdata));      LONG(SIZEOF(.CPU2.zdata));
    LONG(LOADADDR(.CPU2.data));       LONG(0 + ADDR(.CPU2.data));       LONG(SIZEOF(.CPU2.data));
    LONG(LOADADDR(.CPU2.lmudata));    LONG(0 + ADDR(.CPU2.lmudata));    LONG(SIZEOF(.CPU2.lmudata));
    LONG(LOADADDR(.CPU1.zdata));      LONG(0 + ADDR(.CPU1.zdata));      LONG(SIZEOF(.CPU1.zdata));
    LONG(LOADADDR(.CPU1.data));       LONG(0 + ADDR(.CPU1.data));       LONG(SIZEOF(.CPU1.data));
    LONG(LOADADDR(.CPU1.lmudata));    LONG(0 + ADDR(.CPU1.lmudata));    LONG(SIZEOF(.CPU1.lmudata));
    LONG(LOADADDR(.CPU0.zdata));      LONG(0 + ADDR(.CPU0.zdata));      LONG(SIZEOF(.CPU0.zdata));
    LONG(LOADADDR(.CPU0.data));       LONG(0 + ADDR(.CPU0.data));       LONG(SIZEOF(.CPU0.data));
    LONG(LOADADDR(.CPU0.lmudata));    LONG(0 + ADDR(.CPU0.lmudata));    LONG(SIZEOF(.CPU0.lmudata));
    LONG(LOADADDR(.zdata));           LONG(0 + ADDR(.zdata));           LONG(SIZEOF(.zdata));
    LONG(LOADADDR(.sdata));           LONG(0 + ADDR(.sdata));           LONG(SIZEOF(.sdata));
    LONG(LOADADDR(.data));            LONG(0 + ADDR(.data));            LONG(SIZEOF(.data));
    LONG(LOADADDR(.lmudata));         LONG(0 + ADDR(.lmudata));         LONG(SIZEOF(.lmudata));
    LONG(LOADADDR(.sdata4));          LONG(0 + ADDR(.sdata4));          LONG(SIZEOF(.sdata4));
    LONG(LOADADDR(.CPU0.psram_text)); LONG(0 + ADDR(.CPU0.psram_text)); LONG(SIZEOF(.CPU0.psram_text));
    LONG(LOADADDR(.CPU1.psram_text)); LONG(0 + ADDR(.CPU1.psram_text)); LONG(SIZEOF(.CPU1.psram_text));
    LONG(LOADADDR(.CPU2.psram_text)); LONG(0 + ADDR(.CPU2.psram_text)); LONG(SIZEOF(.CPU2.psram_text));
    LONG(LOADADDR(.CPU3.psram_text)); LONG(0 + ADDR(.CPU3.psram_text)); LONG(SIZEOF(.CPU3.psram_text));
    LONG(LOADADDR(.CPU4.psram_text)); LONG(0 + ADDR(.CPU4.psram_text)); LONG(SIZEOF(.CPU4.psram_text));
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

SECTIONS
{
    .CPU1.text : ALIGN(4) 
    {
        *Ifx_Ssw_Tc1.*(.text) *Ifx_Ssw_Tc1.*(.text.*)
        *Cpu1_Main.*(.text) *Cpu1_Main.*(.text.*)
        *(.text_cpu1) *(.text_cpu1.*)
        . = ALIGN(4);
    } > pfls1
	
    .CPU1.psram_text  : ALIGN(4) 
    {
        *(.psram_text_cpu1) *(.psram_text_cpu1.*)
        *(.cpu1_psram) *(.cpu1_psram.*)
        . = ALIGN(4);
    } > psram1 AT> pfls1
}

SECTIONS
{
    .CPU2.text : ALIGN(4) 
    {
        *Ifx_Ssw_Tc2.*(.text) *Ifx_Ssw_Tc2.*(.text.*)
        *Cpu2_Main.*(.text) *Cpu2_Main.*(.text.*)
        *(.text_cpu2) *(.text_cpu2.*)
        . = ALIGN(4);
    } > pfls2
	
    .CPU2.psram_text  : ALIGN(4) 
    {
        *(.psram_text_cpu2) *(.psram_text_cpu2.*)
        *(.cpu2_psram) *(.cpu2_psram.*)
        . = ALIGN(4);
    } > psram2 AT> pfls2
}

SECTIONS
{
    .CPU3.text : ALIGN(4) 
    {
        *Ifx_Ssw_Tc3.*(.text) *Ifx_Ssw_Tc3.*(.text.*)
        *Cpu3_Main.*(.text) *Cpu3_Main.*(.text.*)
        *(.text_cpu3) *(.text_cpu3.*)
        . = ALIGN(4);
    } > pfls3
	
    .CPU3.psram_text  : ALIGN(4) 
    {
        *(.psram_text_cpu3) *(.psram_text_cpu3.*)
        *(.cpu3_psram) *(.cpu3_psram.*)
        . = ALIGN(4);
    } > psram3 AT> pfls3
}

SECTIONS
{
    .CPU4.text : ALIGN(4) 
    {
        *Ifx_Ssw_Tc4.*(.text) *Ifx_Ssw_Tc4.*(.text.*)
        *Cpu4_Main.*(.text) *Cpu4_Main.*(.text.*)
        *(.text_cpu4) *(.text_cpu4.*)
        . = ALIGN(4);
    } > pfls4
	
    .CPU4.psram_text  : ALIGN(4) 
    {
        *(.psram_text_cpu4) *(.psram_text_cpu4.*)
        *(.cpu4_psram) *(.cpu4_psram.*)
        . = ALIGN(4);
    } > psram4 AT> pfls4
}

SECTIONS
{
    .CPU5.text : ALIGN(4) 
    {
        *Ifx_Ssw_Tc5.*(.text) *Ifx_Ssw_Tc5.*(.text.*)
        *Cpu5_Main.*(.text) *Cpu5_Main.*(.text.*)
        *(.text_cpu5) *(.text_cpu5.*)
        . = ALIGN(4);
    } > pfls5
	
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
    SECTIONS
    {
        /*CPU2 Interrupt Vector Table*/
        .inttab_tc2_000 (__INTTAB_CPU2 + 0x0000) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_0  )); } > pfls2
        .inttab_tc2_001 (__INTTAB_CPU2 + 0x0020) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_1  )); } > pfls2
        .inttab_tc2_002 (__INTTAB_CPU2 + 0x0040) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_2  )); } > pfls2
        .inttab_tc2_003 (__INTTAB_CPU2 + 0x0060) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_3  )); } > pfls2
        .inttab_tc2_004 (__INTTAB_CPU2 + 0x0080) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_4  )); } > pfls2
        .inttab_tc2_005 (__INTTAB_CPU2 + 0x00A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_5  )); } > pfls2
        .inttab_tc2_006 (__INTTAB_CPU2 + 0x00C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_6  )); } > pfls2
        .inttab_tc2_007 (__INTTAB_CPU2 + 0x00E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_7  )); } > pfls2
        .inttab_tc2_008 (__INTTAB_CPU2 + 0x0100) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_8  )); } > pfls2
        .inttab_tc2_009 (__INTTAB_CPU2 + 0x0120) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_9  )); } > pfls2
        .inttab_tc2_00A (__INTTAB_CPU2 + 0x0140) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_10 )); } > pfls2
        .inttab_tc2_00B (__INTTAB_CPU2 + 0x0160) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_11 )); } > pfls2
        .inttab_tc2_00C (__INTTAB_CPU2 + 0x0180) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_12 )); } > pfls2
        .inttab_tc2_00D (__INTTAB_CPU2 + 0x01A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_13 )); } > pfls2
        .inttab_tc2_00E (__INTTAB_CPU2 + 0x01C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_14 )); } > pfls2
        .inttab_tc2_00F (__INTTAB_CPU2 + 0x01E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_15 )); } > pfls2
        .inttab_tc2_010 (__INTTAB_CPU2 + 0x0200) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_16 )); } > pfls2
        .inttab_tc2_011 (__INTTAB_CPU2 + 0x0220) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_17 )); } > pfls2
        .inttab_tc2_012 (__INTTAB_CPU2 + 0x0240) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_18 )); } > pfls2
        .inttab_tc2_013 (__INTTAB_CPU2 + 0x0260) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_19 )); } > pfls2
        .inttab_tc2_014 (__INTTAB_CPU2 + 0x0280) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_20 )); } > pfls2
        .inttab_tc2_015 (__INTTAB_CPU2 + 0x02A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_21 )); } > pfls2
        .inttab_tc2_016 (__INTTAB_CPU2 + 0x02C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_22 )); } > pfls2
        .inttab_tc2_017 (__INTTAB_CPU2 + 0x02E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_23 )); } > pfls2
        .inttab_tc2_018 (__INTTAB_CPU2 + 0x0300) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_24 )); } > pfls2
        .inttab_tc2_019 (__INTTAB_CPU2 + 0x0320) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_25 )); } > pfls2
        .inttab_tc2_01A (__INTTAB_CPU2 + 0x0340) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_26 )); } > pfls2
        .inttab_tc2_01B (__INTTAB_CPU2 + 0x0360) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_27 )); } > pfls2
        .inttab_tc2_01C (__INTTAB_CPU2 + 0x0380) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_28 )); } > pfls2
        .inttab_tc2_01D (__INTTAB_CPU2 + 0x03A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_29 )); } > pfls2
        .inttab_tc2_01E (__INTTAB_CPU2 + 0x03C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_30 )); } > pfls2
        .inttab_tc2_01F (__INTTAB_CPU2 + 0x03E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_31 )); } > pfls2
        .inttab_tc2_020 (__INTTAB_CPU2 + 0x0400) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_32 )); } > pfls2
        .inttab_tc2_021 (__INTTAB_CPU2 + 0x0420) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_33 )); } > pfls2
        .inttab_tc2_022 (__INTTAB_CPU2 + 0x0440) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_34 )); } > pfls2
        .inttab_tc2_023 (__INTTAB_CPU2 + 0x0460) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_35 )); } > pfls2
        .inttab_tc2_024 (__INTTAB_CPU2 + 0x0480) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_36 )); } > pfls2
        .inttab_tc2_025 (__INTTAB_CPU2 + 0x04A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_37 )); } > pfls2
        .inttab_tc2_026 (__INTTAB_CPU2 + 0x04C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_38 )); } > pfls2
        .inttab_tc2_027 (__INTTAB_CPU2 + 0x04E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_39 )); } > pfls2
        .inttab_tc2_028 (__INTTAB_CPU2 + 0x0500) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_40 )); } > pfls2
        .inttab_tc2_029 (__INTTAB_CPU2 + 0x0520) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_41 )); } > pfls2
        .inttab_tc2_02A (__INTTAB_CPU2 + 0x0540) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_42 )); } > pfls2
        .inttab_tc2_02B (__INTTAB_CPU2 + 0x0560) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_43 )); } > pfls2
        .inttab_tc2_02C (__INTTAB_CPU2 + 0x0580) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_44 )); } > pfls2
        .inttab_tc2_02D (__INTTAB_CPU2 + 0x05A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_45 )); } > pfls2
        .inttab_tc2_02E (__INTTAB_CPU2 + 0x05C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_46 )); } > pfls2
        .inttab_tc2_02F (__INTTAB_CPU2 + 0x05E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_47 )); } > pfls2
        .inttab_tc2_030 (__INTTAB_CPU2 + 0x0600) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_48 )); } > pfls2
        .inttab_tc2_031 (__INTTAB_CPU2 + 0x0620) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_49 )); } > pfls2
        .inttab_tc2_032 (__INTTAB_CPU2 + 0x0640) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_50 )); } > pfls2
        .inttab_tc2_033 (__INTTAB_CPU2 + 0x0660) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_51 )); } > pfls2
        .inttab_tc2_034 (__INTTAB_CPU2 + 0x0680) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_52 )); } > pfls2
        .inttab_tc2_035 (__INTTAB_CPU2 + 0x06A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_53 )); } > pfls2
        .inttab_tc2_036 (__INTTAB_CPU2 + 0x06C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_54 )); } > pfls2
        .inttab_tc2_037 (__INTTAB_CPU2 + 0x06E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_55 )); } > pfls2
        .inttab_tc2_038 (__INTTAB_CPU2 + 0x0700) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_56 )); } > pfls2
        .inttab_tc2_039 (__INTTAB_CPU2 + 0x0720) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_57 )); } > pfls2
        .inttab_tc2_03A (__INTTAB_CPU2 + 0x0740) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_58 )); } > pfls2
        .inttab_tc2_03B (__INTTAB_CPU2 + 0x0760) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_59 )); } > pfls2
        .inttab_tc2_03C (__INTTAB_CPU2 + 0x0780) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_60 )); } > pfls2
        .inttab_tc2_03D (__INTTAB_CPU2 + 0x07A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_61 )); } > pfls2
        .inttab_tc2_03E (__INTTAB_CPU2 + 0x07C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_62 )); } > pfls2
        .inttab_tc2_03F (__INTTAB_CPU2 + 0x07E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_63 )); } > pfls2
        .inttab_tc2_040 (__INTTAB_CPU2 + 0x0800) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_64 )); } > pfls2
        .inttab_tc2_041 (__INTTAB_CPU2 + 0x0820) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_65 )); } > pfls2
        .inttab_tc2_042 (__INTTAB_CPU2 + 0x0840) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_66 )); } > pfls2
        .inttab_tc2_043 (__INTTAB_CPU2 + 0x0860) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_67 )); } > pfls2
        .inttab_tc2_044 (__INTTAB_CPU2 + 0x0880) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_68 )); } > pfls2
        .inttab_tc2_045 (__INTTAB_CPU2 + 0x08A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_69 )); } > pfls2
        .inttab_tc2_046 (__INTTAB_CPU2 + 0x08C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_70 )); } > pfls2
        .inttab_tc2_047 (__INTTAB_CPU2 + 0x08E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_71 )); } > pfls2
        .inttab_tc2_048 (__INTTAB_CPU2 + 0x0900) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_72 )); } > pfls2
        .inttab_tc2_049 (__INTTAB_CPU2 + 0x0920) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_73 )); } > pfls2
        .inttab_tc2_04A (__INTTAB_CPU2 + 0x0940) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_74 )); } > pfls2
        .inttab_tc2_04B (__INTTAB_CPU2 + 0x0960) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_75 )); } > pfls2
        .inttab_tc2_04C (__INTTAB_CPU2 + 0x0980) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_76 )); } > pfls2
        .inttab_tc2_04D (__INTTAB_CPU2 + 0x09A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_77 )); } > pfls2
        .inttab_tc2_04E (__INTTAB_CPU2 + 0x09C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_78 )); } > pfls2
        .inttab_tc2_04F (__INTTAB_CPU2 + 0x09E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_79 )); } > pfls2
        .inttab_tc2_050 (__INTTAB_CPU2 + 0x0A00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_80 )); } > pfls2
        .inttab_tc2_051 (__INTTAB_CPU2 + 0x0A20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_81 )); } > pfls2
        .inttab_tc2_052 (__INTTAB_CPU2 + 0x0A40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_82 )); } > pfls2
        .inttab_tc2_053 (__INTTAB_CPU2 + 0x0A60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_83 )); } > pfls2
        .inttab_tc2_054 (__INTTAB_CPU2 + 0x0A80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_84 )); } > pfls2
        .inttab_tc2_055 (__INTTAB_CPU2 + 0x0AA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_85 )); } > pfls2
        .inttab_tc2_056 (__INTTAB_CPU2 + 0x0AC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_86 )); } > pfls2
        .inttab_tc2_057 (__INTTAB_CPU2 + 0x0AE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_87 )); } > pfls2
        .inttab_tc2_058 (__INTTAB_CPU2 + 0x0B00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_88 )); } > pfls2
        .inttab_tc2_059 (__INTTAB_CPU2 + 0x0B20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_89 )); } > pfls2
        .inttab_tc2_05A (__INTTAB_CPU2 + 0x0B40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_90 )); } > pfls2
        .inttab_tc2_05B (__INTTAB_CPU2 + 0x0B60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_91 )); } > pfls2
        .inttab_tc2_05C (__INTTAB_CPU2 + 0x0B80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_92 )); } > pfls2
        .inttab_tc2_05D (__INTTAB_CPU2 + 0x0BA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_93 )); } > pfls2
        .inttab_tc2_05E (__INTTAB_CPU2 + 0x0BC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_94 )); } > pfls2
        .inttab_tc2_05F (__INTTAB_CPU2 + 0x0BE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_95 )); } > pfls2
        .inttab_tc2_060 (__INTTAB_CPU2 + 0x0C00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_96 )); } > pfls2
        .inttab_tc2_061 (__INTTAB_CPU2 + 0x0C20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_97 )); } > pfls2
        .inttab_tc2_062 (__INTTAB_CPU2 + 0x0C40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_98 )); } > pfls2
        .inttab_tc2_063 (__INTTAB_CPU2 + 0x0C60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_99 )); } > pfls2
        .inttab_tc2_064 (__INTTAB_CPU2 + 0x0C80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_100)); } > pfls2
        .inttab_tc2_065 (__INTTAB_CPU2 + 0x0CA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_101)); } > pfls2
        .inttab_tc2_066 (__INTTAB_CPU2 + 0x0CC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_102)); } > pfls2
        .inttab_tc2_067 (__INTTAB_CPU2 + 0x0CE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_103)); } > pfls2
        .inttab_tc2_068 (__INTTAB_CPU2 + 0x0D00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_104)); } > pfls2
        .inttab_tc2_069 (__INTTAB_CPU2 + 0x0D20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_105)); } > pfls2
        .inttab_tc2_06A (__INTTAB_CPU2 + 0x0D40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_106)); } > pfls2
        .inttab_tc2_06B (__INTTAB_CPU2 + 0x0D60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_107)); } > pfls2
        .inttab_tc2_06C (__INTTAB_CPU2 + 0x0D80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_108)); } > pfls2
        .inttab_tc2_06D (__INTTAB_CPU2 + 0x0DA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_109)); } > pfls2
        .inttab_tc2_06E (__INTTAB_CPU2 + 0x0DC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_110)); } > pfls2
        .inttab_tc2_06F (__INTTAB_CPU2 + 0x0DE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_111)); } > pfls2
        .inttab_tc2_070 (__INTTAB_CPU2 + 0x0E00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_112)); } > pfls2
        .inttab_tc2_071 (__INTTAB_CPU2 + 0x0E20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_113)); } > pfls2
        .inttab_tc2_072 (__INTTAB_CPU2 + 0x0E40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_114)); } > pfls2
        .inttab_tc2_073 (__INTTAB_CPU2 + 0x0E60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_115)); } > pfls2
        .inttab_tc2_074 (__INTTAB_CPU2 + 0x0E80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_116)); } > pfls2
        .inttab_tc2_075 (__INTTAB_CPU2 + 0x0EA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_117)); } > pfls2
        .inttab_tc2_076 (__INTTAB_CPU2 + 0x0EC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_118)); } > pfls2
        .inttab_tc2_077 (__INTTAB_CPU2 + 0x0EE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_119)); } > pfls2
        .inttab_tc2_078 (__INTTAB_CPU2 + 0x0F00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_120)); } > pfls2
        .inttab_tc2_079 (__INTTAB_CPU2 + 0x0F20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_121)); } > pfls2
        .inttab_tc2_07A (__INTTAB_CPU2 + 0x0F40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_122)); } > pfls2
        .inttab_tc2_07B (__INTTAB_CPU2 + 0x0F60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_123)); } > pfls2
        .inttab_tc2_07C (__INTTAB_CPU2 + 0x0F80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_124)); } > pfls2
        .inttab_tc2_07D (__INTTAB_CPU2 + 0x0FA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_125)); } > pfls2
        .inttab_tc2_07E (__INTTAB_CPU2 + 0x0FC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_126)); } > pfls2
        .inttab_tc2_07F (__INTTAB_CPU2 + 0x0FE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_127)); } > pfls2
        .inttab_tc2_080 (__INTTAB_CPU2 + 0x1000) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_128)); } > pfls2
        .inttab_tc2_081 (__INTTAB_CPU2 + 0x1020) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_129)); } > pfls2
        .inttab_tc2_082 (__INTTAB_CPU2 + 0x1040) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_130)); } > pfls2
        .inttab_tc2_083 (__INTTAB_CPU2 + 0x1060) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_131)); } > pfls2
        .inttab_tc2_084 (__INTTAB_CPU2 + 0x1080) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_132)); } > pfls2
        .inttab_tc2_085 (__INTTAB_CPU2 + 0x10A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_133)); } > pfls2
        .inttab_tc2_086 (__INTTAB_CPU2 + 0x10C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_134)); } > pfls2
        .inttab_tc2_087 (__INTTAB_CPU2 + 0x10E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_135)); } > pfls2
        .inttab_tc2_088 (__INTTAB_CPU2 + 0x1100) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_136)); } > pfls2
        .inttab_tc2_089 (__INTTAB_CPU2 + 0x1120) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_137)); } > pfls2
        .inttab_tc2_08A (__INTTAB_CPU2 + 0x1140) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_138)); } > pfls2
        .inttab_tc2_08B (__INTTAB_CPU2 + 0x1160) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_139)); } > pfls2
        .inttab_tc2_08C (__INTTAB_CPU2 + 0x1180) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_140)); } > pfls2
        .inttab_tc2_08D (__INTTAB_CPU2 + 0x11A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_141)); } > pfls2
        .inttab_tc2_08E (__INTTAB_CPU2 + 0x11C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_142)); } > pfls2
        .inttab_tc2_08F (__INTTAB_CPU2 + 0x11E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_143)); } > pfls2
        .inttab_tc2_090 (__INTTAB_CPU2 + 0x1200) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_144)); } > pfls2
        .inttab_tc2_091 (__INTTAB_CPU2 + 0x1220) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_145)); } > pfls2
        .inttab_tc2_092 (__INTTAB_CPU2 + 0x1240) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_146)); } > pfls2
        .inttab_tc2_093 (__INTTAB_CPU2 + 0x1260) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_147)); } > pfls2
        .inttab_tc2_094 (__INTTAB_CPU2 + 0x1280) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_148)); } > pfls2
        .inttab_tc2_095 (__INTTAB_CPU2 + 0x12A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_149)); } > pfls2
        .inttab_tc2_096 (__INTTAB_CPU2 + 0x12C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_150)); } > pfls2
        .inttab_tc2_097 (__INTTAB_CPU2 + 0x12E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_151)); } > pfls2
        .inttab_tc2_098 (__INTTAB_CPU2 + 0x1300) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_152)); } > pfls2
        .inttab_tc2_099 (__INTTAB_CPU2 + 0x1320) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_153)); } > pfls2
        .inttab_tc2_09A (__INTTAB_CPU2 + 0x1340) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_154)); } > pfls2
        .inttab_tc2_09B (__INTTAB_CPU2 + 0x1360) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_155)); } > pfls2
        .inttab_tc2_09C (__INTTAB_CPU2 + 0x1380) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_156)); } > pfls2
        .inttab_tc2_09D (__INTTAB_CPU2 + 0x13A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_157)); } > pfls2
        .inttab_tc2_09E (__INTTAB_CPU2 + 0x13C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_158)); } > pfls2
        .inttab_tc2_09F (__INTTAB_CPU2 + 0x13E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_159)); } > pfls2
        .inttab_tc2_0A0 (__INTTAB_CPU2 + 0x1400) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_160)); } > pfls2
        .inttab_tc2_0A1 (__INTTAB_CPU2 + 0x1420) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_161)); } > pfls2
        .inttab_tc2_0A2 (__INTTAB_CPU2 + 0x1440) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_162)); } > pfls2
        .inttab_tc2_0A3 (__INTTAB_CPU2 + 0x1460) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_163)); } > pfls2
        .inttab_tc2_0A4 (__INTTAB_CPU2 + 0x1480) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_164)); } > pfls2
        .inttab_tc2_0A5 (__INTTAB_CPU2 + 0x14A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_165)); } > pfls2
        .inttab_tc2_0A6 (__INTTAB_CPU2 + 0x14C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_166)); } > pfls2
        .inttab_tc2_0A7 (__INTTAB_CPU2 + 0x14E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_167)); } > pfls2
        .inttab_tc2_0A8 (__INTTAB_CPU2 + 0x1500) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_168)); } > pfls2
        .inttab_tc2_0A9 (__INTTAB_CPU2 + 0x1520) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_169)); } > pfls2
        .inttab_tc2_0AA (__INTTAB_CPU2 + 0x1540) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_170)); } > pfls2
        .inttab_tc2_0AB (__INTTAB_CPU2 + 0x1560) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_171)); } > pfls2
        .inttab_tc2_0AC (__INTTAB_CPU2 + 0x1580) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_172)); } > pfls2
        .inttab_tc2_0AD (__INTTAB_CPU2 + 0x15A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_173)); } > pfls2
        .inttab_tc2_0AE (__INTTAB_CPU2 + 0x15C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_174)); } > pfls2
        .inttab_tc2_0AF (__INTTAB_CPU2 + 0x15E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_175)); } > pfls2
        .inttab_tc2_0B0 (__INTTAB_CPU2 + 0x1600) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_176)); } > pfls2
        .inttab_tc2_0B1 (__INTTAB_CPU2 + 0x1620) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_177)); } > pfls2
        .inttab_tc2_0B2 (__INTTAB_CPU2 + 0x1640) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_178)); } > pfls2
        .inttab_tc2_0B3 (__INTTAB_CPU2 + 0x1660) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_179)); } > pfls2
        .inttab_tc2_0B4 (__INTTAB_CPU2 + 0x1680) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_180)); } > pfls2
        .inttab_tc2_0B5 (__INTTAB_CPU2 + 0x16A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_181)); } > pfls2
        .inttab_tc2_0B6 (__INTTAB_CPU2 + 0x16C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_182)); } > pfls2
        .inttab_tc2_0B7 (__INTTAB_CPU2 + 0x16E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_183)); } > pfls2
        .inttab_tc2_0B8 (__INTTAB_CPU2 + 0x1700) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_184)); } > pfls2
        .inttab_tc2_0B9 (__INTTAB_CPU2 + 0x1720) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_185)); } > pfls2
        .inttab_tc2_0BA (__INTTAB_CPU2 + 0x1740) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_186)); } > pfls2
        .inttab_tc2_0BB (__INTTAB_CPU2 + 0x1760) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_187)); } > pfls2
        .inttab_tc2_0BC (__INTTAB_CPU2 + 0x1780) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_188)); } > pfls2
        .inttab_tc2_0BD (__INTTAB_CPU2 + 0x17A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_189)); } > pfls2
        .inttab_tc2_0BE (__INTTAB_CPU2 + 0x17C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_190)); } > pfls2
        .inttab_tc2_0BF (__INTTAB_CPU2 + 0x17E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_191)); } > pfls2
        .inttab_tc2_0C0 (__INTTAB_CPU2 + 0x1800) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_192)); } > pfls2
        .inttab_tc2_0C1 (__INTTAB_CPU2 + 0x1820) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_193)); } > pfls2
        .inttab_tc2_0C2 (__INTTAB_CPU2 + 0x1840) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_194)); } > pfls2
        .inttab_tc2_0C3 (__INTTAB_CPU2 + 0x1860) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_195)); } > pfls2
        .inttab_tc2_0C4 (__INTTAB_CPU2 + 0x1880) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_196)); } > pfls2
        .inttab_tc2_0C5 (__INTTAB_CPU2 + 0x18A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_197)); } > pfls2
        .inttab_tc2_0C6 (__INTTAB_CPU2 + 0x18C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_198)); } > pfls2
        .inttab_tc2_0C7 (__INTTAB_CPU2 + 0x18E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_199)); } > pfls2
        .inttab_tc2_0C8 (__INTTAB_CPU2 + 0x1900) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_200)); } > pfls2
        .inttab_tc2_0C9 (__INTTAB_CPU2 + 0x1920) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_201)); } > pfls2
        .inttab_tc2_0CA (__INTTAB_CPU2 + 0x1940) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_202)); } > pfls2
        .inttab_tc2_0CB (__INTTAB_CPU2 + 0x1960) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_203)); } > pfls2
        .inttab_tc2_0CC (__INTTAB_CPU2 + 0x1980) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_204)); } > pfls2
        .inttab_tc2_0CD (__INTTAB_CPU2 + 0x19A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_205)); } > pfls2
        .inttab_tc2_0CE (__INTTAB_CPU2 + 0x19C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_206)); } > pfls2
        .inttab_tc2_0CF (__INTTAB_CPU2 + 0x19E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_207)); } > pfls2
        .inttab_tc2_0D0 (__INTTAB_CPU2 + 0x1A00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_208)); } > pfls2
        .inttab_tc2_0D1 (__INTTAB_CPU2 + 0x1A20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_209)); } > pfls2
        .inttab_tc2_0D2 (__INTTAB_CPU2 + 0x1A40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_210)); } > pfls2
        .inttab_tc2_0D3 (__INTTAB_CPU2 + 0x1A60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_211)); } > pfls2
        .inttab_tc2_0D4 (__INTTAB_CPU2 + 0x1A80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_212)); } > pfls2
        .inttab_tc2_0D5 (__INTTAB_CPU2 + 0x1AA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_213)); } > pfls2
        .inttab_tc2_0D6 (__INTTAB_CPU2 + 0x1AC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_214)); } > pfls2
        .inttab_tc2_0D7 (__INTTAB_CPU2 + 0x1AE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_215)); } > pfls2
        .inttab_tc2_0D8 (__INTTAB_CPU2 + 0x1B00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_216)); } > pfls2
        .inttab_tc2_0D9 (__INTTAB_CPU2 + 0x1B20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_217)); } > pfls2
        .inttab_tc2_0DA (__INTTAB_CPU2 + 0x1B40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_218)); } > pfls2
        .inttab_tc2_0DB (__INTTAB_CPU2 + 0x1B60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_219)); } > pfls2
        .inttab_tc2_0DC (__INTTAB_CPU2 + 0x1B80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_220)); } > pfls2
        .inttab_tc2_0DD (__INTTAB_CPU2 + 0x1BA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_221)); } > pfls2
        .inttab_tc2_0DE (__INTTAB_CPU2 + 0x1BC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_222)); } > pfls2
        .inttab_tc2_0DF (__INTTAB_CPU2 + 0x1BE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_223)); } > pfls2
        .inttab_tc2_0E0 (__INTTAB_CPU2 + 0x1C00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_224)); } > pfls2
        .inttab_tc2_0E1 (__INTTAB_CPU2 + 0x1C20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_225)); } > pfls2
        .inttab_tc2_0E2 (__INTTAB_CPU2 + 0x1C40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_226)); } > pfls2
        .inttab_tc2_0E3 (__INTTAB_CPU2 + 0x1C60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_227)); } > pfls2
        .inttab_tc2_0E4 (__INTTAB_CPU2 + 0x1C80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_228)); } > pfls2
        .inttab_tc2_0E5 (__INTTAB_CPU2 + 0x1CA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_229)); } > pfls2
        .inttab_tc2_0E6 (__INTTAB_CPU2 + 0x1CC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_230)); } > pfls2
        .inttab_tc2_0E7 (__INTTAB_CPU2 + 0x1CE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_231)); } > pfls2
        .inttab_tc2_0E8 (__INTTAB_CPU2 + 0x1D00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_232)); } > pfls2
        .inttab_tc2_0E9 (__INTTAB_CPU2 + 0x1D20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_233)); } > pfls2
        .inttab_tc2_0EA (__INTTAB_CPU2 + 0x1D40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_234)); } > pfls2
        .inttab_tc2_0EB (__INTTAB_CPU2 + 0x1D60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_235)); } > pfls2
        .inttab_tc2_0EC (__INTTAB_CPU2 + 0x1D80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_236)); } > pfls2
        .inttab_tc2_0ED (__INTTAB_CPU2 + 0x1DA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_237)); } > pfls2
        .inttab_tc2_0EE (__INTTAB_CPU2 + 0x1DC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_238)); } > pfls2
        .inttab_tc2_0EF (__INTTAB_CPU2 + 0x1DE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_239)); } > pfls2
        .inttab_tc2_0F0 (__INTTAB_CPU2 + 0x1E00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_240)); } > pfls2
        .inttab_tc2_0F1 (__INTTAB_CPU2 + 0x1E20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_241)); } > pfls2
        .inttab_tc2_0F2 (__INTTAB_CPU2 + 0x1E40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_242)); } > pfls2
        .inttab_tc2_0F3 (__INTTAB_CPU2 + 0x1E60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_243)); } > pfls2
        .inttab_tc2_0F4 (__INTTAB_CPU2 + 0x1E80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_244)); } > pfls2
        .inttab_tc2_0F5 (__INTTAB_CPU2 + 0x1EA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_245)); } > pfls2
        .inttab_tc2_0F6 (__INTTAB_CPU2 + 0x1EC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_246)); } > pfls2
        .inttab_tc2_0F7 (__INTTAB_CPU2 + 0x1EE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_247)); } > pfls2
        .inttab_tc2_0F8 (__INTTAB_CPU2 + 0x1F00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_248)); } > pfls2
        .inttab_tc2_0F9 (__INTTAB_CPU2 + 0x1F20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_249)); } > pfls2
        .inttab_tc2_0FA (__INTTAB_CPU2 + 0x1F40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_250)); } > pfls2
        .inttab_tc2_0FB (__INTTAB_CPU2 + 0x1F60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_251)); } > pfls2
        .inttab_tc2_0FC (__INTTAB_CPU2 + 0x1F80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_252)); } > pfls2
        .inttab_tc2_0FD (__INTTAB_CPU2 + 0x1FA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_253)); } > pfls2
        .inttab_tc2_0FE (__INTTAB_CPU2 + 0x1FC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_254)); } > pfls2
        .inttab_tc2_0FF (__INTTAB_CPU2 + 0x1FE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc2_255)); } > pfls2
    }
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
    SECTIONS
    {
        /*CPU4 Interrupt Vector Table*/
        .inttab_tc4_000 (__INTTAB_CPU4 + 0x0000) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_0  )); } > pfls4
        .inttab_tc4_001 (__INTTAB_CPU4 + 0x0020) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_1  )); } > pfls4
        .inttab_tc4_002 (__INTTAB_CPU4 + 0x0040) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_2  )); } > pfls4
        .inttab_tc4_003 (__INTTAB_CPU4 + 0x0060) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_3  )); } > pfls4
        .inttab_tc4_004 (__INTTAB_CPU4 + 0x0080) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_4  )); } > pfls4
        .inttab_tc4_005 (__INTTAB_CPU4 + 0x00A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_5  )); } > pfls4
        .inttab_tc4_006 (__INTTAB_CPU4 + 0x00C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_6  )); } > pfls4
        .inttab_tc4_007 (__INTTAB_CPU4 + 0x00E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_7  )); } > pfls4
        .inttab_tc4_008 (__INTTAB_CPU4 + 0x0100) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_8  )); } > pfls4
        .inttab_tc4_009 (__INTTAB_CPU4 + 0x0120) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_9  )); } > pfls4
        .inttab_tc4_00A (__INTTAB_CPU4 + 0x0140) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_10 )); } > pfls4
        .inttab_tc4_00B (__INTTAB_CPU4 + 0x0160) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_11 )); } > pfls4
        .inttab_tc4_00C (__INTTAB_CPU4 + 0x0180) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_12 )); } > pfls4
        .inttab_tc4_00D (__INTTAB_CPU4 + 0x01A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_13 )); } > pfls4
        .inttab_tc4_00E (__INTTAB_CPU4 + 0x01C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_14 )); } > pfls4
        .inttab_tc4_00F (__INTTAB_CPU4 + 0x01E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_15 )); } > pfls4
        .inttab_tc4_010 (__INTTAB_CPU4 + 0x0200) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_16 )); } > pfls4
        .inttab_tc4_011 (__INTTAB_CPU4 + 0x0220) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_17 )); } > pfls4
        .inttab_tc4_012 (__INTTAB_CPU4 + 0x0240) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_18 )); } > pfls4
        .inttab_tc4_013 (__INTTAB_CPU4 + 0x0260) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_19 )); } > pfls4
        .inttab_tc4_014 (__INTTAB_CPU4 + 0x0280) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_20 )); } > pfls4
        .inttab_tc4_015 (__INTTAB_CPU4 + 0x02A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_21 )); } > pfls4
        .inttab_tc4_016 (__INTTAB_CPU4 + 0x02C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_22 )); } > pfls4
        .inttab_tc4_017 (__INTTAB_CPU4 + 0x02E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_23 )); } > pfls4
        .inttab_tc4_018 (__INTTAB_CPU4 + 0x0300) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_24 )); } > pfls4
        .inttab_tc4_019 (__INTTAB_CPU4 + 0x0320) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_25 )); } > pfls4
        .inttab_tc4_01A (__INTTAB_CPU4 + 0x0340) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_26 )); } > pfls4
        .inttab_tc4_01B (__INTTAB_CPU4 + 0x0360) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_27 )); } > pfls4
        .inttab_tc4_01C (__INTTAB_CPU4 + 0x0380) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_28 )); } > pfls4
        .inttab_tc4_01D (__INTTAB_CPU4 + 0x03A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_29 )); } > pfls4
        .inttab_tc4_01E (__INTTAB_CPU4 + 0x03C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_30 )); } > pfls4
        .inttab_tc4_01F (__INTTAB_CPU4 + 0x03E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_31 )); } > pfls4
        .inttab_tc4_020 (__INTTAB_CPU4 + 0x0400) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_32 )); } > pfls4
        .inttab_tc4_021 (__INTTAB_CPU4 + 0x0420) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_33 )); } > pfls4
        .inttab_tc4_022 (__INTTAB_CPU4 + 0x0440) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_34 )); } > pfls4
        .inttab_tc4_023 (__INTTAB_CPU4 + 0x0460) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_35 )); } > pfls4
        .inttab_tc4_024 (__INTTAB_CPU4 + 0x0480) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_36 )); } > pfls4
        .inttab_tc4_025 (__INTTAB_CPU4 + 0x04A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_37 )); } > pfls4
        .inttab_tc4_026 (__INTTAB_CPU4 + 0x04C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_38 )); } > pfls4
        .inttab_tc4_027 (__INTTAB_CPU4 + 0x04E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_39 )); } > pfls4
        .inttab_tc4_028 (__INTTAB_CPU4 + 0x0500) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_40 )); } > pfls4
        .inttab_tc4_029 (__INTTAB_CPU4 + 0x0520) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_41 )); } > pfls4
        .inttab_tc4_02A (__INTTAB_CPU4 + 0x0540) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_42 )); } > pfls4
        .inttab_tc4_02B (__INTTAB_CPU4 + 0x0560) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_43 )); } > pfls4
        .inttab_tc4_02C (__INTTAB_CPU4 + 0x0580) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_44 )); } > pfls4
        .inttab_tc4_02D (__INTTAB_CPU4 + 0x05A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_45 )); } > pfls4
        .inttab_tc4_02E (__INTTAB_CPU4 + 0x05C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_46 )); } > pfls4
        .inttab_tc4_02F (__INTTAB_CPU4 + 0x05E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_47 )); } > pfls4
        .inttab_tc4_030 (__INTTAB_CPU4 + 0x0600) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_48 )); } > pfls4
        .inttab_tc4_031 (__INTTAB_CPU4 + 0x0620) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_49 )); } > pfls4
        .inttab_tc4_032 (__INTTAB_CPU4 + 0x0640) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_50 )); } > pfls4
        .inttab_tc4_033 (__INTTAB_CPU4 + 0x0660) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_51 )); } > pfls4
        .inttab_tc4_034 (__INTTAB_CPU4 + 0x0680) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_52 )); } > pfls4
        .inttab_tc4_035 (__INTTAB_CPU4 + 0x06A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_53 )); } > pfls4
        .inttab_tc4_036 (__INTTAB_CPU4 + 0x06C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_54 )); } > pfls4
        .inttab_tc4_037 (__INTTAB_CPU4 + 0x06E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_55 )); } > pfls4
        .inttab_tc4_038 (__INTTAB_CPU4 + 0x0700) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_56 )); } > pfls4
        .inttab_tc4_039 (__INTTAB_CPU4 + 0x0720) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_57 )); } > pfls4
        .inttab_tc4_03A (__INTTAB_CPU4 + 0x0740) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_58 )); } > pfls4
        .inttab_tc4_03B (__INTTAB_CPU4 + 0x0760) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_59 )); } > pfls4
        .inttab_tc4_03C (__INTTAB_CPU4 + 0x0780) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_60 )); } > pfls4
        .inttab_tc4_03D (__INTTAB_CPU4 + 0x07A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_61 )); } > pfls4
        .inttab_tc4_03E (__INTTAB_CPU4 + 0x07C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_62 )); } > pfls4
        .inttab_tc4_03F (__INTTAB_CPU4 + 0x07E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_63 )); } > pfls4
        .inttab_tc4_040 (__INTTAB_CPU4 + 0x0800) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_64 )); } > pfls4
        .inttab_tc4_041 (__INTTAB_CPU4 + 0x0820) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_65 )); } > pfls4
        .inttab_tc4_042 (__INTTAB_CPU4 + 0x0840) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_66 )); } > pfls4
        .inttab_tc4_043 (__INTTAB_CPU4 + 0x0860) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_67 )); } > pfls4
        .inttab_tc4_044 (__INTTAB_CPU4 + 0x0880) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_68 )); } > pfls4
        .inttab_tc4_045 (__INTTAB_CPU4 + 0x08A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_69 )); } > pfls4
        .inttab_tc4_046 (__INTTAB_CPU4 + 0x08C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_70 )); } > pfls4
        .inttab_tc4_047 (__INTTAB_CPU4 + 0x08E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_71 )); } > pfls4
        .inttab_tc4_048 (__INTTAB_CPU4 + 0x0900) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_72 )); } > pfls4
        .inttab_tc4_049 (__INTTAB_CPU4 + 0x0920) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_73 )); } > pfls4
        .inttab_tc4_04A (__INTTAB_CPU4 + 0x0940) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_74 )); } > pfls4
        .inttab_tc4_04B (__INTTAB_CPU4 + 0x0960) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_75 )); } > pfls4
        .inttab_tc4_04C (__INTTAB_CPU4 + 0x0980) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_76 )); } > pfls4
        .inttab_tc4_04D (__INTTAB_CPU4 + 0x09A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_77 )); } > pfls4
        .inttab_tc4_04E (__INTTAB_CPU4 + 0x09C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_78 )); } > pfls4
        .inttab_tc4_04F (__INTTAB_CPU4 + 0x09E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_79 )); } > pfls4
        .inttab_tc4_050 (__INTTAB_CPU4 + 0x0A00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_80 )); } > pfls4
        .inttab_tc4_051 (__INTTAB_CPU4 + 0x0A20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_81 )); } > pfls4
        .inttab_tc4_052 (__INTTAB_CPU4 + 0x0A40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_82 )); } > pfls4
        .inttab_tc4_053 (__INTTAB_CPU4 + 0x0A60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_83 )); } > pfls4
        .inttab_tc4_054 (__INTTAB_CPU4 + 0x0A80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_84 )); } > pfls4
        .inttab_tc4_055 (__INTTAB_CPU4 + 0x0AA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_85 )); } > pfls4
        .inttab_tc4_056 (__INTTAB_CPU4 + 0x0AC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_86 )); } > pfls4
        .inttab_tc4_057 (__INTTAB_CPU4 + 0x0AE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_87 )); } > pfls4
        .inttab_tc4_058 (__INTTAB_CPU4 + 0x0B00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_88 )); } > pfls4
        .inttab_tc4_059 (__INTTAB_CPU4 + 0x0B20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_89 )); } > pfls4
        .inttab_tc4_05A (__INTTAB_CPU4 + 0x0B40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_90 )); } > pfls4
        .inttab_tc4_05B (__INTTAB_CPU4 + 0x0B60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_91 )); } > pfls4
        .inttab_tc4_05C (__INTTAB_CPU4 + 0x0B80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_92 )); } > pfls4
        .inttab_tc4_05D (__INTTAB_CPU4 + 0x0BA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_93 )); } > pfls4
        .inttab_tc4_05E (__INTTAB_CPU4 + 0x0BC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_94 )); } > pfls4
        .inttab_tc4_05F (__INTTAB_CPU4 + 0x0BE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_95 )); } > pfls4
        .inttab_tc4_060 (__INTTAB_CPU4 + 0x0C00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_96 )); } > pfls4
        .inttab_tc4_061 (__INTTAB_CPU4 + 0x0C20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_97 )); } > pfls4
        .inttab_tc4_062 (__INTTAB_CPU4 + 0x0C40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_98 )); } > pfls4
        .inttab_tc4_063 (__INTTAB_CPU4 + 0x0C60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_99 )); } > pfls4
        .inttab_tc4_064 (__INTTAB_CPU4 + 0x0C80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_100)); } > pfls4
        .inttab_tc4_065 (__INTTAB_CPU4 + 0x0CA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_101)); } > pfls4
        .inttab_tc4_066 (__INTTAB_CPU4 + 0x0CC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_102)); } > pfls4
        .inttab_tc4_067 (__INTTAB_CPU4 + 0x0CE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_103)); } > pfls4
        .inttab_tc4_068 (__INTTAB_CPU4 + 0x0D00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_104)); } > pfls4
        .inttab_tc4_069 (__INTTAB_CPU4 + 0x0D20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_105)); } > pfls4
        .inttab_tc4_06A (__INTTAB_CPU4 + 0x0D40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_106)); } > pfls4
        .inttab_tc4_06B (__INTTAB_CPU4 + 0x0D60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_107)); } > pfls4
        .inttab_tc4_06C (__INTTAB_CPU4 + 0x0D80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_108)); } > pfls4
        .inttab_tc4_06D (__INTTAB_CPU4 + 0x0DA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_109)); } > pfls4
        .inttab_tc4_06E (__INTTAB_CPU4 + 0x0DC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_110)); } > pfls4
        .inttab_tc4_06F (__INTTAB_CPU4 + 0x0DE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_111)); } > pfls4
        .inttab_tc4_070 (__INTTAB_CPU4 + 0x0E00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_112)); } > pfls4
        .inttab_tc4_071 (__INTTAB_CPU4 + 0x0E20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_113)); } > pfls4
        .inttab_tc4_072 (__INTTAB_CPU4 + 0x0E40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_114)); } > pfls4
        .inttab_tc4_073 (__INTTAB_CPU4 + 0x0E60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_115)); } > pfls4
        .inttab_tc4_074 (__INTTAB_CPU4 + 0x0E80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_116)); } > pfls4
        .inttab_tc4_075 (__INTTAB_CPU4 + 0x0EA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_117)); } > pfls4
        .inttab_tc4_076 (__INTTAB_CPU4 + 0x0EC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_118)); } > pfls4
        .inttab_tc4_077 (__INTTAB_CPU4 + 0x0EE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_119)); } > pfls4
        .inttab_tc4_078 (__INTTAB_CPU4 + 0x0F00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_120)); } > pfls4
        .inttab_tc4_079 (__INTTAB_CPU4 + 0x0F20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_121)); } > pfls4
        .inttab_tc4_07A (__INTTAB_CPU4 + 0x0F40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_122)); } > pfls4
        .inttab_tc4_07B (__INTTAB_CPU4 + 0x0F60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_123)); } > pfls4
        .inttab_tc4_07C (__INTTAB_CPU4 + 0x0F80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_124)); } > pfls4
        .inttab_tc4_07D (__INTTAB_CPU4 + 0x0FA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_125)); } > pfls4
        .inttab_tc4_07E (__INTTAB_CPU4 + 0x0FC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_126)); } > pfls4
        .inttab_tc4_07F (__INTTAB_CPU4 + 0x0FE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_127)); } > pfls4
        .inttab_tc4_080 (__INTTAB_CPU4 + 0x1000) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_128)); } > pfls4
        .inttab_tc4_081 (__INTTAB_CPU4 + 0x1020) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_129)); } > pfls4
        .inttab_tc4_082 (__INTTAB_CPU4 + 0x1040) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_130)); } > pfls4
        .inttab_tc4_083 (__INTTAB_CPU4 + 0x1060) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_131)); } > pfls4
        .inttab_tc4_084 (__INTTAB_CPU4 + 0x1080) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_132)); } > pfls4
        .inttab_tc4_085 (__INTTAB_CPU4 + 0x10A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_133)); } > pfls4
        .inttab_tc4_086 (__INTTAB_CPU4 + 0x10C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_134)); } > pfls4
        .inttab_tc4_087 (__INTTAB_CPU4 + 0x10E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_135)); } > pfls4
        .inttab_tc4_088 (__INTTAB_CPU4 + 0x1100) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_136)); } > pfls4
        .inttab_tc4_089 (__INTTAB_CPU4 + 0x1120) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_137)); } > pfls4
        .inttab_tc4_08A (__INTTAB_CPU4 + 0x1140) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_138)); } > pfls4
        .inttab_tc4_08B (__INTTAB_CPU4 + 0x1160) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_139)); } > pfls4
        .inttab_tc4_08C (__INTTAB_CPU4 + 0x1180) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_140)); } > pfls4
        .inttab_tc4_08D (__INTTAB_CPU4 + 0x11A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_141)); } > pfls4
        .inttab_tc4_08E (__INTTAB_CPU4 + 0x11C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_142)); } > pfls4
        .inttab_tc4_08F (__INTTAB_CPU4 + 0x11E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_143)); } > pfls4
        .inttab_tc4_090 (__INTTAB_CPU4 + 0x1200) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_144)); } > pfls4
        .inttab_tc4_091 (__INTTAB_CPU4 + 0x1220) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_145)); } > pfls4
        .inttab_tc4_092 (__INTTAB_CPU4 + 0x1240) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_146)); } > pfls4
        .inttab_tc4_093 (__INTTAB_CPU4 + 0x1260) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_147)); } > pfls4
        .inttab_tc4_094 (__INTTAB_CPU4 + 0x1280) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_148)); } > pfls4
        .inttab_tc4_095 (__INTTAB_CPU4 + 0x12A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_149)); } > pfls4
        .inttab_tc4_096 (__INTTAB_CPU4 + 0x12C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_150)); } > pfls4
        .inttab_tc4_097 (__INTTAB_CPU4 + 0x12E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_151)); } > pfls4
        .inttab_tc4_098 (__INTTAB_CPU4 + 0x1300) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_152)); } > pfls4
        .inttab_tc4_099 (__INTTAB_CPU4 + 0x1320) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_153)); } > pfls4
        .inttab_tc4_09A (__INTTAB_CPU4 + 0x1340) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_154)); } > pfls4
        .inttab_tc4_09B (__INTTAB_CPU4 + 0x1360) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_155)); } > pfls4
        .inttab_tc4_09C (__INTTAB_CPU4 + 0x1380) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_156)); } > pfls4
        .inttab_tc4_09D (__INTTAB_CPU4 + 0x13A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_157)); } > pfls4
        .inttab_tc4_09E (__INTTAB_CPU4 + 0x13C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_158)); } > pfls4
        .inttab_tc4_09F (__INTTAB_CPU4 + 0x13E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_159)); } > pfls4
        .inttab_tc4_0A0 (__INTTAB_CPU4 + 0x1400) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_160)); } > pfls4
        .inttab_tc4_0A1 (__INTTAB_CPU4 + 0x1420) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_161)); } > pfls4
        .inttab_tc4_0A2 (__INTTAB_CPU4 + 0x1440) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_162)); } > pfls4
        .inttab_tc4_0A3 (__INTTAB_CPU4 + 0x1460) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_163)); } > pfls4
        .inttab_tc4_0A4 (__INTTAB_CPU4 + 0x1480) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_164)); } > pfls4
        .inttab_tc4_0A5 (__INTTAB_CPU4 + 0x14A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_165)); } > pfls4
        .inttab_tc4_0A6 (__INTTAB_CPU4 + 0x14C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_166)); } > pfls4
        .inttab_tc4_0A7 (__INTTAB_CPU4 + 0x14E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_167)); } > pfls4
        .inttab_tc4_0A8 (__INTTAB_CPU4 + 0x1500) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_168)); } > pfls4
        .inttab_tc4_0A9 (__INTTAB_CPU4 + 0x1520) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_169)); } > pfls4
        .inttab_tc4_0AA (__INTTAB_CPU4 + 0x1540) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_170)); } > pfls4
        .inttab_tc4_0AB (__INTTAB_CPU4 + 0x1560) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_171)); } > pfls4
        .inttab_tc4_0AC (__INTTAB_CPU4 + 0x1580) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_172)); } > pfls4
        .inttab_tc4_0AD (__INTTAB_CPU4 + 0x15A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_173)); } > pfls4
        .inttab_tc4_0AE (__INTTAB_CPU4 + 0x15C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_174)); } > pfls4
        .inttab_tc4_0AF (__INTTAB_CPU4 + 0x15E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_175)); } > pfls4
        .inttab_tc4_0B0 (__INTTAB_CPU4 + 0x1600) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_176)); } > pfls4
        .inttab_tc4_0B1 (__INTTAB_CPU4 + 0x1620) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_177)); } > pfls4
        .inttab_tc4_0B2 (__INTTAB_CPU4 + 0x1640) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_178)); } > pfls4
        .inttab_tc4_0B3 (__INTTAB_CPU4 + 0x1660) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_179)); } > pfls4
        .inttab_tc4_0B4 (__INTTAB_CPU4 + 0x1680) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_180)); } > pfls4
        .inttab_tc4_0B5 (__INTTAB_CPU4 + 0x16A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_181)); } > pfls4
        .inttab_tc4_0B6 (__INTTAB_CPU4 + 0x16C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_182)); } > pfls4
        .inttab_tc4_0B7 (__INTTAB_CPU4 + 0x16E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_183)); } > pfls4
        .inttab_tc4_0B8 (__INTTAB_CPU4 + 0x1700) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_184)); } > pfls4
        .inttab_tc4_0B9 (__INTTAB_CPU4 + 0x1720) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_185)); } > pfls4
        .inttab_tc4_0BA (__INTTAB_CPU4 + 0x1740) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_186)); } > pfls4
        .inttab_tc4_0BB (__INTTAB_CPU4 + 0x1760) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_187)); } > pfls4
        .inttab_tc4_0BC (__INTTAB_CPU4 + 0x1780) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_188)); } > pfls4
        .inttab_tc4_0BD (__INTTAB_CPU4 + 0x17A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_189)); } > pfls4
        .inttab_tc4_0BE (__INTTAB_CPU4 + 0x17C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_190)); } > pfls4
        .inttab_tc4_0BF (__INTTAB_CPU4 + 0x17E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_191)); } > pfls4
        .inttab_tc4_0C0 (__INTTAB_CPU4 + 0x1800) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_192)); } > pfls4
        .inttab_tc4_0C1 (__INTTAB_CPU4 + 0x1820) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_193)); } > pfls4
        .inttab_tc4_0C2 (__INTTAB_CPU4 + 0x1840) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_194)); } > pfls4
        .inttab_tc4_0C3 (__INTTAB_CPU4 + 0x1860) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_195)); } > pfls4
        .inttab_tc4_0C4 (__INTTAB_CPU4 + 0x1880) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_196)); } > pfls4
        .inttab_tc4_0C5 (__INTTAB_CPU4 + 0x18A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_197)); } > pfls4
        .inttab_tc4_0C6 (__INTTAB_CPU4 + 0x18C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_198)); } > pfls4
        .inttab_tc4_0C7 (__INTTAB_CPU4 + 0x18E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_199)); } > pfls4
        .inttab_tc4_0C8 (__INTTAB_CPU4 + 0x1900) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_200)); } > pfls4
        .inttab_tc4_0C9 (__INTTAB_CPU4 + 0x1920) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_201)); } > pfls4
        .inttab_tc4_0CA (__INTTAB_CPU4 + 0x1940) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_202)); } > pfls4
        .inttab_tc4_0CB (__INTTAB_CPU4 + 0x1960) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_203)); } > pfls4
        .inttab_tc4_0CC (__INTTAB_CPU4 + 0x1980) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_204)); } > pfls4
        .inttab_tc4_0CD (__INTTAB_CPU4 + 0x19A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_205)); } > pfls4
        .inttab_tc4_0CE (__INTTAB_CPU4 + 0x19C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_206)); } > pfls4
        .inttab_tc4_0CF (__INTTAB_CPU4 + 0x19E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_207)); } > pfls4
        .inttab_tc4_0D0 (__INTTAB_CPU4 + 0x1A00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_208)); } > pfls4
        .inttab_tc4_0D1 (__INTTAB_CPU4 + 0x1A20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_209)); } > pfls4
        .inttab_tc4_0D2 (__INTTAB_CPU4 + 0x1A40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_210)); } > pfls4
        .inttab_tc4_0D3 (__INTTAB_CPU4 + 0x1A60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_211)); } > pfls4
        .inttab_tc4_0D4 (__INTTAB_CPU4 + 0x1A80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_212)); } > pfls4
        .inttab_tc4_0D5 (__INTTAB_CPU4 + 0x1AA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_213)); } > pfls4
        .inttab_tc4_0D6 (__INTTAB_CPU4 + 0x1AC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_214)); } > pfls4
        .inttab_tc4_0D7 (__INTTAB_CPU4 + 0x1AE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_215)); } > pfls4
        .inttab_tc4_0D8 (__INTTAB_CPU4 + 0x1B00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_216)); } > pfls4
        .inttab_tc4_0D9 (__INTTAB_CPU4 + 0x1B20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_217)); } > pfls4
        .inttab_tc4_0DA (__INTTAB_CPU4 + 0x1B40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_218)); } > pfls4
        .inttab_tc4_0DB (__INTTAB_CPU4 + 0x1B60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_219)); } > pfls4
        .inttab_tc4_0DC (__INTTAB_CPU4 + 0x1B80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_220)); } > pfls4
        .inttab_tc4_0DD (__INTTAB_CPU4 + 0x1BA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_221)); } > pfls4
        .inttab_tc4_0DE (__INTTAB_CPU4 + 0x1BC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_222)); } > pfls4
        .inttab_tc4_0DF (__INTTAB_CPU4 + 0x1BE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_223)); } > pfls4
        .inttab_tc4_0E0 (__INTTAB_CPU4 + 0x1C00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_224)); } > pfls4
        .inttab_tc4_0E1 (__INTTAB_CPU4 + 0x1C20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_225)); } > pfls4
        .inttab_tc4_0E2 (__INTTAB_CPU4 + 0x1C40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_226)); } > pfls4
        .inttab_tc4_0E3 (__INTTAB_CPU4 + 0x1C60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_227)); } > pfls4
        .inttab_tc4_0E4 (__INTTAB_CPU4 + 0x1C80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_228)); } > pfls4
        .inttab_tc4_0E5 (__INTTAB_CPU4 + 0x1CA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_229)); } > pfls4
        .inttab_tc4_0E6 (__INTTAB_CPU4 + 0x1CC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_230)); } > pfls4
        .inttab_tc4_0E7 (__INTTAB_CPU4 + 0x1CE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_231)); } > pfls4
        .inttab_tc4_0E8 (__INTTAB_CPU4 + 0x1D00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_232)); } > pfls4
        .inttab_tc4_0E9 (__INTTAB_CPU4 + 0x1D20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_233)); } > pfls4
        .inttab_tc4_0EA (__INTTAB_CPU4 + 0x1D40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_234)); } > pfls4
        .inttab_tc4_0EB (__INTTAB_CPU4 + 0x1D60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_235)); } > pfls4
        .inttab_tc4_0EC (__INTTAB_CPU4 + 0x1D80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_236)); } > pfls4
        .inttab_tc4_0ED (__INTTAB_CPU4 + 0x1DA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_237)); } > pfls4
        .inttab_tc4_0EE (__INTTAB_CPU4 + 0x1DC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_238)); } > pfls4
        .inttab_tc4_0EF (__INTTAB_CPU4 + 0x1DE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_239)); } > pfls4
        .inttab_tc4_0F0 (__INTTAB_CPU4 + 0x1E00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_240)); } > pfls4
        .inttab_tc4_0F1 (__INTTAB_CPU4 + 0x1E20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_241)); } > pfls4
        .inttab_tc4_0F2 (__INTTAB_CPU4 + 0x1E40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_242)); } > pfls4
        .inttab_tc4_0F3 (__INTTAB_CPU4 + 0x1E60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_243)); } > pfls4
        .inttab_tc4_0F4 (__INTTAB_CPU4 + 0x1E80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_244)); } > pfls4
        .inttab_tc4_0F5 (__INTTAB_CPU4 + 0x1EA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_245)); } > pfls4
        .inttab_tc4_0F6 (__INTTAB_CPU4 + 0x1EC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_246)); } > pfls4
        .inttab_tc4_0F7 (__INTTAB_CPU4 + 0x1EE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_247)); } > pfls4
        .inttab_tc4_0F8 (__INTTAB_CPU4 + 0x1F00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_248)); } > pfls4
        .inttab_tc4_0F9 (__INTTAB_CPU4 + 0x1F20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_249)); } > pfls4
        .inttab_tc4_0FA (__INTTAB_CPU4 + 0x1F40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_250)); } > pfls4
        .inttab_tc4_0FB (__INTTAB_CPU4 + 0x1F60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_251)); } > pfls4
        .inttab_tc4_0FC (__INTTAB_CPU4 + 0x1F80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_252)); } > pfls4
        .inttab_tc4_0FD (__INTTAB_CPU4 + 0x1FA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_253)); } > pfls4
        .inttab_tc4_0FE (__INTTAB_CPU4 + 0x1FC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_254)); } > pfls4
        .inttab_tc4_0FF (__INTTAB_CPU4 + 0x1FE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc4_255)); } > pfls4
    }
    SECTIONS
    {
        /*CPU5 Interrupt Vector Table*/
        .inttab_tc5_000 (__INTTAB_CPU5 + 0x0000) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_0  )); } > pfls5
        .inttab_tc5_001 (__INTTAB_CPU5 + 0x0020) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_1  )); } > pfls5
        .inttab_tc5_002 (__INTTAB_CPU5 + 0x0040) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_2  )); } > pfls5
        .inttab_tc5_003 (__INTTAB_CPU5 + 0x0060) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_3  )); } > pfls5
        .inttab_tc5_004 (__INTTAB_CPU5 + 0x0080) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_4  )); } > pfls5
        .inttab_tc5_005 (__INTTAB_CPU5 + 0x00A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_5  )); } > pfls5
        .inttab_tc5_006 (__INTTAB_CPU5 + 0x00C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_6  )); } > pfls5
        .inttab_tc5_007 (__INTTAB_CPU5 + 0x00E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_7  )); } > pfls5
        .inttab_tc5_008 (__INTTAB_CPU5 + 0x0100) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_8  )); } > pfls5
        .inttab_tc5_009 (__INTTAB_CPU5 + 0x0120) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_9  )); } > pfls5
        .inttab_tc5_00A (__INTTAB_CPU5 + 0x0140) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_10 )); } > pfls5
        .inttab_tc5_00B (__INTTAB_CPU5 + 0x0160) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_11 )); } > pfls5
        .inttab_tc5_00C (__INTTAB_CPU5 + 0x0180) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_12 )); } > pfls5
        .inttab_tc5_00D (__INTTAB_CPU5 + 0x01A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_13 )); } > pfls5
        .inttab_tc5_00E (__INTTAB_CPU5 + 0x01C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_14 )); } > pfls5
        .inttab_tc5_00F (__INTTAB_CPU5 + 0x01E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_15 )); } > pfls5
        .inttab_tc5_010 (__INTTAB_CPU5 + 0x0200) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_16 )); } > pfls5
        .inttab_tc5_011 (__INTTAB_CPU5 + 0x0220) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_17 )); } > pfls5
        .inttab_tc5_012 (__INTTAB_CPU5 + 0x0240) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_18 )); } > pfls5
        .inttab_tc5_013 (__INTTAB_CPU5 + 0x0260) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_19 )); } > pfls5
        .inttab_tc5_014 (__INTTAB_CPU5 + 0x0280) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_20 )); } > pfls5
        .inttab_tc5_015 (__INTTAB_CPU5 + 0x02A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_21 )); } > pfls5
        .inttab_tc5_016 (__INTTAB_CPU5 + 0x02C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_22 )); } > pfls5
        .inttab_tc5_017 (__INTTAB_CPU5 + 0x02E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_23 )); } > pfls5
        .inttab_tc5_018 (__INTTAB_CPU5 + 0x0300) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_24 )); } > pfls5
        .inttab_tc5_019 (__INTTAB_CPU5 + 0x0320) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_25 )); } > pfls5
        .inttab_tc5_01A (__INTTAB_CPU5 + 0x0340) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_26 )); } > pfls5
        .inttab_tc5_01B (__INTTAB_CPU5 + 0x0360) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_27 )); } > pfls5
        .inttab_tc5_01C (__INTTAB_CPU5 + 0x0380) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_28 )); } > pfls5
        .inttab_tc5_01D (__INTTAB_CPU5 + 0x03A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_29 )); } > pfls5
        .inttab_tc5_01E (__INTTAB_CPU5 + 0x03C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_30 )); } > pfls5
        .inttab_tc5_01F (__INTTAB_CPU5 + 0x03E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_31 )); } > pfls5
        .inttab_tc5_020 (__INTTAB_CPU5 + 0x0400) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_32 )); } > pfls5
        .inttab_tc5_021 (__INTTAB_CPU5 + 0x0420) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_33 )); } > pfls5
        .inttab_tc5_022 (__INTTAB_CPU5 + 0x0440) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_34 )); } > pfls5
        .inttab_tc5_023 (__INTTAB_CPU5 + 0x0460) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_35 )); } > pfls5
        .inttab_tc5_024 (__INTTAB_CPU5 + 0x0480) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_36 )); } > pfls5
        .inttab_tc5_025 (__INTTAB_CPU5 + 0x04A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_37 )); } > pfls5
        .inttab_tc5_026 (__INTTAB_CPU5 + 0x04C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_38 )); } > pfls5
        .inttab_tc5_027 (__INTTAB_CPU5 + 0x04E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_39 )); } > pfls5
        .inttab_tc5_028 (__INTTAB_CPU5 + 0x0500) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_40 )); } > pfls5
        .inttab_tc5_029 (__INTTAB_CPU5 + 0x0520) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_41 )); } > pfls5
        .inttab_tc5_02A (__INTTAB_CPU5 + 0x0540) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_42 )); } > pfls5
        .inttab_tc5_02B (__INTTAB_CPU5 + 0x0560) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_43 )); } > pfls5
        .inttab_tc5_02C (__INTTAB_CPU5 + 0x0580) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_44 )); } > pfls5
        .inttab_tc5_02D (__INTTAB_CPU5 + 0x05A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_45 )); } > pfls5
        .inttab_tc5_02E (__INTTAB_CPU5 + 0x05C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_46 )); } > pfls5
        .inttab_tc5_02F (__INTTAB_CPU5 + 0x05E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_47 )); } > pfls5
        .inttab_tc5_030 (__INTTAB_CPU5 + 0x0600) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_48 )); } > pfls5
        .inttab_tc5_031 (__INTTAB_CPU5 + 0x0620) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_49 )); } > pfls5
        .inttab_tc5_032 (__INTTAB_CPU5 + 0x0640) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_50 )); } > pfls5
        .inttab_tc5_033 (__INTTAB_CPU5 + 0x0660) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_51 )); } > pfls5
        .inttab_tc5_034 (__INTTAB_CPU5 + 0x0680) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_52 )); } > pfls5
        .inttab_tc5_035 (__INTTAB_CPU5 + 0x06A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_53 )); } > pfls5
        .inttab_tc5_036 (__INTTAB_CPU5 + 0x06C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_54 )); } > pfls5
        .inttab_tc5_037 (__INTTAB_CPU5 + 0x06E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_55 )); } > pfls5
        .inttab_tc5_038 (__INTTAB_CPU5 + 0x0700) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_56 )); } > pfls5
        .inttab_tc5_039 (__INTTAB_CPU5 + 0x0720) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_57 )); } > pfls5
        .inttab_tc5_03A (__INTTAB_CPU5 + 0x0740) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_58 )); } > pfls5
        .inttab_tc5_03B (__INTTAB_CPU5 + 0x0760) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_59 )); } > pfls5
        .inttab_tc5_03C (__INTTAB_CPU5 + 0x0780) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_60 )); } > pfls5
        .inttab_tc5_03D (__INTTAB_CPU5 + 0x07A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_61 )); } > pfls5
        .inttab_tc5_03E (__INTTAB_CPU5 + 0x07C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_62 )); } > pfls5
        .inttab_tc5_03F (__INTTAB_CPU5 + 0x07E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_63 )); } > pfls5
        .inttab_tc5_040 (__INTTAB_CPU5 + 0x0800) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_64 )); } > pfls5
        .inttab_tc5_041 (__INTTAB_CPU5 + 0x0820) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_65 )); } > pfls5
        .inttab_tc5_042 (__INTTAB_CPU5 + 0x0840) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_66 )); } > pfls5
        .inttab_tc5_043 (__INTTAB_CPU5 + 0x0860) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_67 )); } > pfls5
        .inttab_tc5_044 (__INTTAB_CPU5 + 0x0880) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_68 )); } > pfls5
        .inttab_tc5_045 (__INTTAB_CPU5 + 0x08A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_69 )); } > pfls5
        .inttab_tc5_046 (__INTTAB_CPU5 + 0x08C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_70 )); } > pfls5
        .inttab_tc5_047 (__INTTAB_CPU5 + 0x08E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_71 )); } > pfls5
        .inttab_tc5_048 (__INTTAB_CPU5 + 0x0900) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_72 )); } > pfls5
        .inttab_tc5_049 (__INTTAB_CPU5 + 0x0920) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_73 )); } > pfls5
        .inttab_tc5_04A (__INTTAB_CPU5 + 0x0940) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_74 )); } > pfls5
        .inttab_tc5_04B (__INTTAB_CPU5 + 0x0960) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_75 )); } > pfls5
        .inttab_tc5_04C (__INTTAB_CPU5 + 0x0980) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_76 )); } > pfls5
        .inttab_tc5_04D (__INTTAB_CPU5 + 0x09A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_77 )); } > pfls5
        .inttab_tc5_04E (__INTTAB_CPU5 + 0x09C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_78 )); } > pfls5
        .inttab_tc5_04F (__INTTAB_CPU5 + 0x09E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_79 )); } > pfls5
        .inttab_tc5_050 (__INTTAB_CPU5 + 0x0A00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_80 )); } > pfls5
        .inttab_tc5_051 (__INTTAB_CPU5 + 0x0A20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_81 )); } > pfls5
        .inttab_tc5_052 (__INTTAB_CPU5 + 0x0A40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_82 )); } > pfls5
        .inttab_tc5_053 (__INTTAB_CPU5 + 0x0A60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_83 )); } > pfls5
        .inttab_tc5_054 (__INTTAB_CPU5 + 0x0A80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_84 )); } > pfls5
        .inttab_tc5_055 (__INTTAB_CPU5 + 0x0AA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_85 )); } > pfls5
        .inttab_tc5_056 (__INTTAB_CPU5 + 0x0AC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_86 )); } > pfls5
        .inttab_tc5_057 (__INTTAB_CPU5 + 0x0AE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_87 )); } > pfls5
        .inttab_tc5_058 (__INTTAB_CPU5 + 0x0B00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_88 )); } > pfls5
        .inttab_tc5_059 (__INTTAB_CPU5 + 0x0B20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_89 )); } > pfls5
        .inttab_tc5_05A (__INTTAB_CPU5 + 0x0B40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_90 )); } > pfls5
        .inttab_tc5_05B (__INTTAB_CPU5 + 0x0B60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_91 )); } > pfls5
        .inttab_tc5_05C (__INTTAB_CPU5 + 0x0B80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_92 )); } > pfls5
        .inttab_tc5_05D (__INTTAB_CPU5 + 0x0BA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_93 )); } > pfls5
        .inttab_tc5_05E (__INTTAB_CPU5 + 0x0BC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_94 )); } > pfls5
        .inttab_tc5_05F (__INTTAB_CPU5 + 0x0BE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_95 )); } > pfls5
        .inttab_tc5_060 (__INTTAB_CPU5 + 0x0C00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_96 )); } > pfls5
        .inttab_tc5_061 (__INTTAB_CPU5 + 0x0C20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_97 )); } > pfls5
        .inttab_tc5_062 (__INTTAB_CPU5 + 0x0C40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_98 )); } > pfls5
        .inttab_tc5_063 (__INTTAB_CPU5 + 0x0C60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_99 )); } > pfls5
        .inttab_tc5_064 (__INTTAB_CPU5 + 0x0C80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_100)); } > pfls5
        .inttab_tc5_065 (__INTTAB_CPU5 + 0x0CA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_101)); } > pfls5
        .inttab_tc5_066 (__INTTAB_CPU5 + 0x0CC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_102)); } > pfls5
        .inttab_tc5_067 (__INTTAB_CPU5 + 0x0CE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_103)); } > pfls5
        .inttab_tc5_068 (__INTTAB_CPU5 + 0x0D00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_104)); } > pfls5
        .inttab_tc5_069 (__INTTAB_CPU5 + 0x0D20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_105)); } > pfls5
        .inttab_tc5_06A (__INTTAB_CPU5 + 0x0D40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_106)); } > pfls5
        .inttab_tc5_06B (__INTTAB_CPU5 + 0x0D60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_107)); } > pfls5
        .inttab_tc5_06C (__INTTAB_CPU5 + 0x0D80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_108)); } > pfls5
        .inttab_tc5_06D (__INTTAB_CPU5 + 0x0DA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_109)); } > pfls5
        .inttab_tc5_06E (__INTTAB_CPU5 + 0x0DC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_110)); } > pfls5
        .inttab_tc5_06F (__INTTAB_CPU5 + 0x0DE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_111)); } > pfls5
        .inttab_tc5_070 (__INTTAB_CPU5 + 0x0E00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_112)); } > pfls5
        .inttab_tc5_071 (__INTTAB_CPU5 + 0x0E20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_113)); } > pfls5
        .inttab_tc5_072 (__INTTAB_CPU5 + 0x0E40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_114)); } > pfls5
        .inttab_tc5_073 (__INTTAB_CPU5 + 0x0E60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_115)); } > pfls5
        .inttab_tc5_074 (__INTTAB_CPU5 + 0x0E80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_116)); } > pfls5
        .inttab_tc5_075 (__INTTAB_CPU5 + 0x0EA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_117)); } > pfls5
        .inttab_tc5_076 (__INTTAB_CPU5 + 0x0EC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_118)); } > pfls5
        .inttab_tc5_077 (__INTTAB_CPU5 + 0x0EE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_119)); } > pfls5
        .inttab_tc5_078 (__INTTAB_CPU5 + 0x0F00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_120)); } > pfls5
        .inttab_tc5_079 (__INTTAB_CPU5 + 0x0F20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_121)); } > pfls5
        .inttab_tc5_07A (__INTTAB_CPU5 + 0x0F40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_122)); } > pfls5
        .inttab_tc5_07B (__INTTAB_CPU5 + 0x0F60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_123)); } > pfls5
        .inttab_tc5_07C (__INTTAB_CPU5 + 0x0F80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_124)); } > pfls5
        .inttab_tc5_07D (__INTTAB_CPU5 + 0x0FA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_125)); } > pfls5
        .inttab_tc5_07E (__INTTAB_CPU5 + 0x0FC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_126)); } > pfls5
        .inttab_tc5_07F (__INTTAB_CPU5 + 0x0FE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_127)); } > pfls5
        .inttab_tc5_080 (__INTTAB_CPU5 + 0x1000) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_128)); } > pfls5
        .inttab_tc5_081 (__INTTAB_CPU5 + 0x1020) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_129)); } > pfls5
        .inttab_tc5_082 (__INTTAB_CPU5 + 0x1040) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_130)); } > pfls5
        .inttab_tc5_083 (__INTTAB_CPU5 + 0x1060) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_131)); } > pfls5
        .inttab_tc5_084 (__INTTAB_CPU5 + 0x1080) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_132)); } > pfls5
        .inttab_tc5_085 (__INTTAB_CPU5 + 0x10A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_133)); } > pfls5
        .inttab_tc5_086 (__INTTAB_CPU5 + 0x10C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_134)); } > pfls5
        .inttab_tc5_087 (__INTTAB_CPU5 + 0x10E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_135)); } > pfls5
        .inttab_tc5_088 (__INTTAB_CPU5 + 0x1100) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_136)); } > pfls5
        .inttab_tc5_089 (__INTTAB_CPU5 + 0x1120) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_137)); } > pfls5
        .inttab_tc5_08A (__INTTAB_CPU5 + 0x1140) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_138)); } > pfls5
        .inttab_tc5_08B (__INTTAB_CPU5 + 0x1160) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_139)); } > pfls5
        .inttab_tc5_08C (__INTTAB_CPU5 + 0x1180) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_140)); } > pfls5
        .inttab_tc5_08D (__INTTAB_CPU5 + 0x11A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_141)); } > pfls5
        .inttab_tc5_08E (__INTTAB_CPU5 + 0x11C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_142)); } > pfls5
        .inttab_tc5_08F (__INTTAB_CPU5 + 0x11E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_143)); } > pfls5
        .inttab_tc5_090 (__INTTAB_CPU5 + 0x1200) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_144)); } > pfls5
        .inttab_tc5_091 (__INTTAB_CPU5 + 0x1220) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_145)); } > pfls5
        .inttab_tc5_092 (__INTTAB_CPU5 + 0x1240) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_146)); } > pfls5
        .inttab_tc5_093 (__INTTAB_CPU5 + 0x1260) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_147)); } > pfls5
        .inttab_tc5_094 (__INTTAB_CPU5 + 0x1280) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_148)); } > pfls5
        .inttab_tc5_095 (__INTTAB_CPU5 + 0x12A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_149)); } > pfls5
        .inttab_tc5_096 (__INTTAB_CPU5 + 0x12C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_150)); } > pfls5
        .inttab_tc5_097 (__INTTAB_CPU5 + 0x12E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_151)); } > pfls5
        .inttab_tc5_098 (__INTTAB_CPU5 + 0x1300) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_152)); } > pfls5
        .inttab_tc5_099 (__INTTAB_CPU5 + 0x1320) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_153)); } > pfls5
        .inttab_tc5_09A (__INTTAB_CPU5 + 0x1340) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_154)); } > pfls5
        .inttab_tc5_09B (__INTTAB_CPU5 + 0x1360) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_155)); } > pfls5
        .inttab_tc5_09C (__INTTAB_CPU5 + 0x1380) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_156)); } > pfls5
        .inttab_tc5_09D (__INTTAB_CPU5 + 0x13A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_157)); } > pfls5
        .inttab_tc5_09E (__INTTAB_CPU5 + 0x13C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_158)); } > pfls5
        .inttab_tc5_09F (__INTTAB_CPU5 + 0x13E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_159)); } > pfls5
        .inttab_tc5_0A0 (__INTTAB_CPU5 + 0x1400) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_160)); } > pfls5
        .inttab_tc5_0A1 (__INTTAB_CPU5 + 0x1420) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_161)); } > pfls5
        .inttab_tc5_0A2 (__INTTAB_CPU5 + 0x1440) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_162)); } > pfls5
        .inttab_tc5_0A3 (__INTTAB_CPU5 + 0x1460) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_163)); } > pfls5
        .inttab_tc5_0A4 (__INTTAB_CPU5 + 0x1480) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_164)); } > pfls5
        .inttab_tc5_0A5 (__INTTAB_CPU5 + 0x14A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_165)); } > pfls5
        .inttab_tc5_0A6 (__INTTAB_CPU5 + 0x14C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_166)); } > pfls5
        .inttab_tc5_0A7 (__INTTAB_CPU5 + 0x14E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_167)); } > pfls5
        .inttab_tc5_0A8 (__INTTAB_CPU5 + 0x1500) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_168)); } > pfls5
        .inttab_tc5_0A9 (__INTTAB_CPU5 + 0x1520) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_169)); } > pfls5
        .inttab_tc5_0AA (__INTTAB_CPU5 + 0x1540) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_170)); } > pfls5
        .inttab_tc5_0AB (__INTTAB_CPU5 + 0x1560) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_171)); } > pfls5
        .inttab_tc5_0AC (__INTTAB_CPU5 + 0x1580) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_172)); } > pfls5
        .inttab_tc5_0AD (__INTTAB_CPU5 + 0x15A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_173)); } > pfls5
        .inttab_tc5_0AE (__INTTAB_CPU5 + 0x15C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_174)); } > pfls5
        .inttab_tc5_0AF (__INTTAB_CPU5 + 0x15E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_175)); } > pfls5
        .inttab_tc5_0B0 (__INTTAB_CPU5 + 0x1600) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_176)); } > pfls5
        .inttab_tc5_0B1 (__INTTAB_CPU5 + 0x1620) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_177)); } > pfls5
        .inttab_tc5_0B2 (__INTTAB_CPU5 + 0x1640) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_178)); } > pfls5
        .inttab_tc5_0B3 (__INTTAB_CPU5 + 0x1660) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_179)); } > pfls5
        .inttab_tc5_0B4 (__INTTAB_CPU5 + 0x1680) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_180)); } > pfls5
        .inttab_tc5_0B5 (__INTTAB_CPU5 + 0x16A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_181)); } > pfls5
        .inttab_tc5_0B6 (__INTTAB_CPU5 + 0x16C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_182)); } > pfls5
        .inttab_tc5_0B7 (__INTTAB_CPU5 + 0x16E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_183)); } > pfls5
        .inttab_tc5_0B8 (__INTTAB_CPU5 + 0x1700) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_184)); } > pfls5
        .inttab_tc5_0B9 (__INTTAB_CPU5 + 0x1720) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_185)); } > pfls5
        .inttab_tc5_0BA (__INTTAB_CPU5 + 0x1740) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_186)); } > pfls5
        .inttab_tc5_0BB (__INTTAB_CPU5 + 0x1760) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_187)); } > pfls5
        .inttab_tc5_0BC (__INTTAB_CPU5 + 0x1780) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_188)); } > pfls5
        .inttab_tc5_0BD (__INTTAB_CPU5 + 0x17A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_189)); } > pfls5
        .inttab_tc5_0BE (__INTTAB_CPU5 + 0x17C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_190)); } > pfls5
        .inttab_tc5_0BF (__INTTAB_CPU5 + 0x17E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_191)); } > pfls5
        .inttab_tc5_0C0 (__INTTAB_CPU5 + 0x1800) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_192)); } > pfls5
        .inttab_tc5_0C1 (__INTTAB_CPU5 + 0x1820) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_193)); } > pfls5
        .inttab_tc5_0C2 (__INTTAB_CPU5 + 0x1840) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_194)); } > pfls5
        .inttab_tc5_0C3 (__INTTAB_CPU5 + 0x1860) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_195)); } > pfls5
        .inttab_tc5_0C4 (__INTTAB_CPU5 + 0x1880) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_196)); } > pfls5
        .inttab_tc5_0C5 (__INTTAB_CPU5 + 0x18A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_197)); } > pfls5
        .inttab_tc5_0C6 (__INTTAB_CPU5 + 0x18C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_198)); } > pfls5
        .inttab_tc5_0C7 (__INTTAB_CPU5 + 0x18E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_199)); } > pfls5
        .inttab_tc5_0C8 (__INTTAB_CPU5 + 0x1900) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_200)); } > pfls5
        .inttab_tc5_0C9 (__INTTAB_CPU5 + 0x1920) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_201)); } > pfls5
        .inttab_tc5_0CA (__INTTAB_CPU5 + 0x1940) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_202)); } > pfls5
        .inttab_tc5_0CB (__INTTAB_CPU5 + 0x1960) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_203)); } > pfls5
        .inttab_tc5_0CC (__INTTAB_CPU5 + 0x1980) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_204)); } > pfls5
        .inttab_tc5_0CD (__INTTAB_CPU5 + 0x19A0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_205)); } > pfls5
        .inttab_tc5_0CE (__INTTAB_CPU5 + 0x19C0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_206)); } > pfls5
        .inttab_tc5_0CF (__INTTAB_CPU5 + 0x19E0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_207)); } > pfls5
        .inttab_tc5_0D0 (__INTTAB_CPU5 + 0x1A00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_208)); } > pfls5
        .inttab_tc5_0D1 (__INTTAB_CPU5 + 0x1A20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_209)); } > pfls5
        .inttab_tc5_0D2 (__INTTAB_CPU5 + 0x1A40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_210)); } > pfls5
        .inttab_tc5_0D3 (__INTTAB_CPU5 + 0x1A60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_211)); } > pfls5
        .inttab_tc5_0D4 (__INTTAB_CPU5 + 0x1A80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_212)); } > pfls5
        .inttab_tc5_0D5 (__INTTAB_CPU5 + 0x1AA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_213)); } > pfls5
        .inttab_tc5_0D6 (__INTTAB_CPU5 + 0x1AC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_214)); } > pfls5
        .inttab_tc5_0D7 (__INTTAB_CPU5 + 0x1AE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_215)); } > pfls5
        .inttab_tc5_0D8 (__INTTAB_CPU5 + 0x1B00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_216)); } > pfls5
        .inttab_tc5_0D9 (__INTTAB_CPU5 + 0x1B20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_217)); } > pfls5
        .inttab_tc5_0DA (__INTTAB_CPU5 + 0x1B40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_218)); } > pfls5
        .inttab_tc5_0DB (__INTTAB_CPU5 + 0x1B60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_219)); } > pfls5
        .inttab_tc5_0DC (__INTTAB_CPU5 + 0x1B80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_220)); } > pfls5
        .inttab_tc5_0DD (__INTTAB_CPU5 + 0x1BA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_221)); } > pfls5
        .inttab_tc5_0DE (__INTTAB_CPU5 + 0x1BC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_222)); } > pfls5
        .inttab_tc5_0DF (__INTTAB_CPU5 + 0x1BE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_223)); } > pfls5
        .inttab_tc5_0E0 (__INTTAB_CPU5 + 0x1C00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_224)); } > pfls5
        .inttab_tc5_0E1 (__INTTAB_CPU5 + 0x1C20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_225)); } > pfls5
        .inttab_tc5_0E2 (__INTTAB_CPU5 + 0x1C40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_226)); } > pfls5
        .inttab_tc5_0E3 (__INTTAB_CPU5 + 0x1C60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_227)); } > pfls5
        .inttab_tc5_0E4 (__INTTAB_CPU5 + 0x1C80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_228)); } > pfls5
        .inttab_tc5_0E5 (__INTTAB_CPU5 + 0x1CA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_229)); } > pfls5
        .inttab_tc5_0E6 (__INTTAB_CPU5 + 0x1CC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_230)); } > pfls5
        .inttab_tc5_0E7 (__INTTAB_CPU5 + 0x1CE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_231)); } > pfls5
        .inttab_tc5_0E8 (__INTTAB_CPU5 + 0x1D00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_232)); } > pfls5
        .inttab_tc5_0E9 (__INTTAB_CPU5 + 0x1D20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_233)); } > pfls5
        .inttab_tc5_0EA (__INTTAB_CPU5 + 0x1D40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_234)); } > pfls5
        .inttab_tc5_0EB (__INTTAB_CPU5 + 0x1D60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_235)); } > pfls5
        .inttab_tc5_0EC (__INTTAB_CPU5 + 0x1D80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_236)); } > pfls5
        .inttab_tc5_0ED (__INTTAB_CPU5 + 0x1DA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_237)); } > pfls5
        .inttab_tc5_0EE (__INTTAB_CPU5 + 0x1DC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_238)); } > pfls5
        .inttab_tc5_0EF (__INTTAB_CPU5 + 0x1DE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_239)); } > pfls5
        .inttab_tc5_0F0 (__INTTAB_CPU5 + 0x1E00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_240)); } > pfls5
        .inttab_tc5_0F1 (__INTTAB_CPU5 + 0x1E20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_241)); } > pfls5
        .inttab_tc5_0F2 (__INTTAB_CPU5 + 0x1E40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_242)); } > pfls5
        .inttab_tc5_0F3 (__INTTAB_CPU5 + 0x1E60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_243)); } > pfls5
        .inttab_tc5_0F4 (__INTTAB_CPU5 + 0x1E80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_244)); } > pfls5
        .inttab_tc5_0F5 (__INTTAB_CPU5 + 0x1EA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_245)); } > pfls5
        .inttab_tc5_0F6 (__INTTAB_CPU5 + 0x1EC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_246)); } > pfls5
        .inttab_tc5_0F7 (__INTTAB_CPU5 + 0x1EE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_247)); } > pfls5
        .inttab_tc5_0F8 (__INTTAB_CPU5 + 0x1F00) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_248)); } > pfls5
        .inttab_tc5_0F9 (__INTTAB_CPU5 + 0x1F20) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_249)); } > pfls5
        .inttab_tc5_0FA (__INTTAB_CPU5 + 0x1F40) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_250)); } > pfls5
        .inttab_tc5_0FB (__INTTAB_CPU5 + 0x1F60) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_251)); } > pfls5
        .inttab_tc5_0FC (__INTTAB_CPU5 + 0x1F80) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_252)); } > pfls5
        .inttab_tc5_0FD (__INTTAB_CPU5 + 0x1FA0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_253)); } > pfls5
        .inttab_tc5_0FE (__INTTAB_CPU5 + 0x1FC0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_254)); } > pfls5
        .inttab_tc5_0FF (__INTTAB_CPU5 + 0x1FE0) : { . = ALIGN(8) ; KEEP (*(.intvec_tc5_255)); } > pfls5
    }


