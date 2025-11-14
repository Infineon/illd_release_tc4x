/* Default linker script, for normal executables */
OUTPUT_FORMAT("elf32-tricore")
OUTPUT_ARCH(tricore)
ENTRY(_START4)

__TRICORE_DERIVATE_MEMORY_MAP__ = 0x4D0;

LCF_CSA4_SIZE = 8k;
LCF_USTACK4_SIZE = 2k;
LCF_ISTACK4_SIZE = 1k;

LCF_HEAP_SIZE = 4k;

LCF_PPU_FLASH_SIZE  = 1M;
LCF_PPU_LMURAM_SIZE = 512k;
LCF_PPU_CSM_SIZE    = 512k;

LCF_DSPR4_START = 0x30000000;
LCF_DSPR4_SIZE  = 240K;

LCF_CSA4_OFFSET =    (LCF_DSPR4_SIZE - 1k - LCF_CSA4_SIZE);
LCF_ISTACK4_OFFSET = (LCF_CSA4_OFFSET - 256 - LCF_ISTACK4_SIZE);
LCF_USTACK4_OFFSET = (LCF_ISTACK4_OFFSET - 256 - LCF_USTACK4_SIZE);

LCF_HEAP4_OFFSET =   (LCF_USTACK4_OFFSET - LCF_HEAP_SIZE);

LCF_INTVEC4_START = 0x811FE000;

__INTTAB_CPU4 = LCF_INTVEC4_START;

LCF_TRAPVEC4_START = 0x80E00100;

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

RESET = LCF_STARTPTR_NC_CPU4;

MEMORY
{
    dsram4_local (w!xp): org = 0xd0000000, len = 240K
    dsram4 (w!xp): org = 0x30000000, len = 240K
    psram4 (w!xp): org = 0x30100000, len = 64K
    
    psram_local (w!xp): org = 0xc0000000, len = 64K
    
    pfls4 (rx!p): org = 0x80E00000, len = 4M
    pfls4_nc (rx!p): org = 0xA0E00000, len = 4M
    
    pfls5 (rx!p): org = 0x81200000, len = 2M
    pfls5_nc (rx!p): org = 0xA1200000, len = 2M
    
    cpu4_dlmu (w!xp): org = 0x90200000, len = 512K
    cpu4_dlmu_nc (w!xp): org = 0xb0200000, len = 512K
    
    ppu_lmuram (w!xp): org = 0x90880000, len = 512k
    ppu_lmuram_nc (w!xp): org = 0xb0880000, len = 512k  
    
    ppu_csm (w!xp): org = 0x92080000, len = 512k
    ppu_csm_nc (w!xp): org = 0xb2080000, len = 512k

}


/* map local memory address to a global address */
REGION_MAP( CPU4 , ORIGIN(dsram4_local), LENGTH(dsram4_local), ORIGIN(dsram4))

/* map cached and non cached addresses */
REGION_MIRROR("pfls4", "pfls4_nc")
REGION_MIRROR("pfls5", "pfls5_nc")
REGION_MIRROR("cpu4_dlmu", "cpu4_dlmu_nc")
REGION_MIRROR("ppu_csm", "ppu_csm_nc")

/*Un comment one of the below statement groups to enable CpuX DMI RAM to hold global variables*/

REGION_ALIAS( default_ram , dsram4)
REGION_ALIAS( default_rom , pfls4)

/*Sections located at absolute fixed address*/
    /*Fixed memory Allocations for stack memory and CSA*/    
    CORE_ID = CPU4;
    SECTIONS
    {
        CORE_SEC(.ustack) (LCF_DSPR4_START + LCF_USTACK4_OFFSET):
        { PROVIDE(__USTACK4_END = .);    . = . + LCF_USTACK4_SIZE;    PROVIDE(__USTACK4 = .); }
        
        CORE_SEC(.istack) (LCF_DSPR4_START + LCF_ISTACK4_OFFSET):
        { PROVIDE(__ISTACK4_END = .);    . = . + LCF_ISTACK4_SIZE;    PROVIDE(__ISTACK4 = .); }
        
        CORE_SEC(.csa) (LCF_DSPR4_START + LCF_CSA4_OFFSET):
        { PROVIDE(__CSA4 = .);    . = . + LCF_CSA4_SIZE;    PROVIDE(__CSA4_END = .); }
    }
    
    /*Fixed memory Allocations for _START*/
    CORE_ID = GLOBAL ;
    SECTIONS
    {
        PROVIDE(__START0 = LCF_STARTPTR_NC_CPU0);
        PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU0 = 0); /* Not used */
        PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU1 = 0);
        PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU2 = 0);
        PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU3 = 0);
        PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU4 = 1);
        PROVIDE(__ENABLE_INDIVIDUAL_C_INIT_CPU5 = 0);
    }
    
    /*Fixed memory Allocations for Trap Vector Table*/
    CORE_ID = GLOBAL;
    SECTIONS
    {
        .traptab_tc4 (LCF_TRAPVEC4_START) : { PROVIDE(__TRAPTAB_CPU4 = .); KEEP (*(.traptab_cpu4)); } > pfls4
    }
    
    /*Fixed memory Allocations for _START1 to 4 */
    CORE_ID = GLOBAL ;
    SECTIONS
    {
        .start_tc4 (LCF_STARTPTR_NC_CPU4) : FLAGS(rxl) { KEEP (*(.start_cpu4)); } > pfls4_nc
        PROVIDE(__START1 = LCF_STARTPTR_NC_CPU1);
        PROVIDE(__START2 = LCF_STARTPTR_NC_CPU2);
        PROVIDE(__START3 = LCF_STARTPTR_NC_CPU3);
        PROVIDE(__START4 = LCF_STARTPTR_NC_CPU4);
        PROVIDE(__START5 = LCF_STARTPTR_NC_CPU5);
    }
    
    /*Fixed memory Allocations for Interrupt Vector Table*/
    SECTIONS
    {
        /*CPU4 Interrupt Vector Table*/
        .inttab_tc4_000 (__INTTAB_CPU4 + 0x0000) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_0  )); }
        .inttab_tc4_001 (__INTTAB_CPU4 + 0x0020) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_1  )); }
        .inttab_tc4_002 (__INTTAB_CPU4 + 0x0040) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_2  )); }
        .inttab_tc4_003 (__INTTAB_CPU4 + 0x0060) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_3  )); }
        .inttab_tc4_004 (__INTTAB_CPU4 + 0x0080) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_4  )); }
        .inttab_tc4_005 (__INTTAB_CPU4 + 0x00A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_5  )); }
        .inttab_tc4_006 (__INTTAB_CPU4 + 0x00C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_6  )); }
        .inttab_tc4_007 (__INTTAB_CPU4 + 0x00E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_7  )); }
        .inttab_tc4_008 (__INTTAB_CPU4 + 0x0100) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_8  )); }
        .inttab_tc4_009 (__INTTAB_CPU4 + 0x0120) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_9  )); }
        .inttab_tc4_00A (__INTTAB_CPU4 + 0x0140) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_10 )); }
        .inttab_tc4_00B (__INTTAB_CPU4 + 0x0160) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_11 )); }
        .inttab_tc4_00C (__INTTAB_CPU4 + 0x0180) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_12 )); }
        .inttab_tc4_00D (__INTTAB_CPU4 + 0x01A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_13 )); }
        .inttab_tc4_00E (__INTTAB_CPU4 + 0x01C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_14 )); }
        .inttab_tc4_00F (__INTTAB_CPU4 + 0x01E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_15 )); }
        .inttab_tc4_010 (__INTTAB_CPU4 + 0x0200) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_16 )); }
        .inttab_tc4_011 (__INTTAB_CPU4 + 0x0220) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_17 )); }
        .inttab_tc4_012 (__INTTAB_CPU4 + 0x0240) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_18 )); }
        .inttab_tc4_013 (__INTTAB_CPU4 + 0x0260) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_19 )); }
        .inttab_tc4_014 (__INTTAB_CPU4 + 0x0280) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_20 )); }
        .inttab_tc4_015 (__INTTAB_CPU4 + 0x02A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_21 )); }
        .inttab_tc4_016 (__INTTAB_CPU4 + 0x02C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_22 )); }
        .inttab_tc4_017 (__INTTAB_CPU4 + 0x02E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_23 )); }
        .inttab_tc4_018 (__INTTAB_CPU4 + 0x0300) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_24 )); }
        .inttab_tc4_019 (__INTTAB_CPU4 + 0x0320) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_25 )); }
        .inttab_tc4_01A (__INTTAB_CPU4 + 0x0340) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_26 )); }
        .inttab_tc4_01B (__INTTAB_CPU4 + 0x0360) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_27 )); }
        .inttab_tc4_01C (__INTTAB_CPU4 + 0x0380) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_28 )); }
        .inttab_tc4_01D (__INTTAB_CPU4 + 0x03A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_29 )); }
        .inttab_tc4_01E (__INTTAB_CPU4 + 0x03C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_30 )); }
        .inttab_tc4_01F (__INTTAB_CPU4 + 0x03E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_31 )); }
        .inttab_tc4_020 (__INTTAB_CPU4 + 0x0400) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_32 )); }
        .inttab_tc4_021 (__INTTAB_CPU4 + 0x0420) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_33 )); }
        .inttab_tc4_022 (__INTTAB_CPU4 + 0x0440) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_34 )); }
        .inttab_tc4_023 (__INTTAB_CPU4 + 0x0460) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_35 )); }
        .inttab_tc4_024 (__INTTAB_CPU4 + 0x0480) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_36 )); }
        .inttab_tc4_025 (__INTTAB_CPU4 + 0x04A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_37 )); }
        .inttab_tc4_026 (__INTTAB_CPU4 + 0x04C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_38 )); }
        .inttab_tc4_027 (__INTTAB_CPU4 + 0x04E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_39 )); }
        .inttab_tc4_028 (__INTTAB_CPU4 + 0x0500) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_40 )); }
        .inttab_tc4_029 (__INTTAB_CPU4 + 0x0520) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_41 )); }
        .inttab_tc4_02A (__INTTAB_CPU4 + 0x0540) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_42 )); }
        .inttab_tc4_02B (__INTTAB_CPU4 + 0x0560) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_43 )); }
        .inttab_tc4_02C (__INTTAB_CPU4 + 0x0580) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_44 )); }
        .inttab_tc4_02D (__INTTAB_CPU4 + 0x05A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_45 )); }
        .inttab_tc4_02E (__INTTAB_CPU4 + 0x05C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_46 )); }
        .inttab_tc4_02F (__INTTAB_CPU4 + 0x05E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_47 )); }
        .inttab_tc4_030 (__INTTAB_CPU4 + 0x0600) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_48 )); }
        .inttab_tc4_031 (__INTTAB_CPU4 + 0x0620) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_49 )); }
        .inttab_tc4_032 (__INTTAB_CPU4 + 0x0640) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_50 )); }
        .inttab_tc4_033 (__INTTAB_CPU4 + 0x0660) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_51 )); }
        .inttab_tc4_034 (__INTTAB_CPU4 + 0x0680) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_52 )); }
        .inttab_tc4_035 (__INTTAB_CPU4 + 0x06A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_53 )); }
        .inttab_tc4_036 (__INTTAB_CPU4 + 0x06C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_54 )); }
        .inttab_tc4_037 (__INTTAB_CPU4 + 0x06E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_55 )); }
        .inttab_tc4_038 (__INTTAB_CPU4 + 0x0700) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_56 )); }
        .inttab_tc4_039 (__INTTAB_CPU4 + 0x0720) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_57 )); }
        .inttab_tc4_03A (__INTTAB_CPU4 + 0x0740) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_58 )); }
        .inttab_tc4_03B (__INTTAB_CPU4 + 0x0760) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_59 )); }
        .inttab_tc4_03C (__INTTAB_CPU4 + 0x0780) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_60 )); }
        .inttab_tc4_03D (__INTTAB_CPU4 + 0x07A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_61 )); }
        .inttab_tc4_03E (__INTTAB_CPU4 + 0x07C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_62 )); }
        .inttab_tc4_03F (__INTTAB_CPU4 + 0x07E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_63 )); }
        .inttab_tc4_040 (__INTTAB_CPU4 + 0x0800) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_64 )); }
        .inttab_tc4_041 (__INTTAB_CPU4 + 0x0820) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_65 )); }
        .inttab_tc4_042 (__INTTAB_CPU4 + 0x0840) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_66 )); }
        .inttab_tc4_043 (__INTTAB_CPU4 + 0x0860) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_67 )); }
        .inttab_tc4_044 (__INTTAB_CPU4 + 0x0880) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_68 )); }
        .inttab_tc4_045 (__INTTAB_CPU4 + 0x08A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_69 )); }
        .inttab_tc4_046 (__INTTAB_CPU4 + 0x08C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_70 )); }
        .inttab_tc4_047 (__INTTAB_CPU4 + 0x08E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_71 )); }
        .inttab_tc4_048 (__INTTAB_CPU4 + 0x0900) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_72 )); }
        .inttab_tc4_049 (__INTTAB_CPU4 + 0x0920) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_73 )); }
        .inttab_tc4_04A (__INTTAB_CPU4 + 0x0940) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_74 )); }
        .inttab_tc4_04B (__INTTAB_CPU4 + 0x0960) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_75 )); }
        .inttab_tc4_04C (__INTTAB_CPU4 + 0x0980) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_76 )); }
        .inttab_tc4_04D (__INTTAB_CPU4 + 0x09A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_77 )); }
        .inttab_tc4_04E (__INTTAB_CPU4 + 0x09C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_78 )); }
        .inttab_tc4_04F (__INTTAB_CPU4 + 0x09E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_79 )); }
        .inttab_tc4_050 (__INTTAB_CPU4 + 0x0A00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_80 )); }
        .inttab_tc4_051 (__INTTAB_CPU4 + 0x0A20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_81 )); }
        .inttab_tc4_052 (__INTTAB_CPU4 + 0x0A40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_82 )); }
        .inttab_tc4_053 (__INTTAB_CPU4 + 0x0A60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_83 )); }
        .inttab_tc4_054 (__INTTAB_CPU4 + 0x0A80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_84 )); }
        .inttab_tc4_055 (__INTTAB_CPU4 + 0x0AA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_85 )); }
        .inttab_tc4_056 (__INTTAB_CPU4 + 0x0AC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_86 )); }
        .inttab_tc4_057 (__INTTAB_CPU4 + 0x0AE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_87 )); }
        .inttab_tc4_058 (__INTTAB_CPU4 + 0x0B00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_88 )); }
        .inttab_tc4_059 (__INTTAB_CPU4 + 0x0B20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_89 )); }
        .inttab_tc4_05A (__INTTAB_CPU4 + 0x0B40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_90 )); }
        .inttab_tc4_05B (__INTTAB_CPU4 + 0x0B60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_91 )); }
        .inttab_tc4_05C (__INTTAB_CPU4 + 0x0B80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_92 )); }
        .inttab_tc4_05D (__INTTAB_CPU4 + 0x0BA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_93 )); }
        .inttab_tc4_05E (__INTTAB_CPU4 + 0x0BC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_94 )); }
        .inttab_tc4_05F (__INTTAB_CPU4 + 0x0BE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_95 )); }
        .inttab_tc4_060 (__INTTAB_CPU4 + 0x0C00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_96 )); }
        .inttab_tc4_061 (__INTTAB_CPU4 + 0x0C20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_97 )); }
        .inttab_tc4_062 (__INTTAB_CPU4 + 0x0C40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_98 )); }
        .inttab_tc4_063 (__INTTAB_CPU4 + 0x0C60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_99 )); }
        .inttab_tc4_064 (__INTTAB_CPU4 + 0x0C80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_100)); }
        .inttab_tc4_065 (__INTTAB_CPU4 + 0x0CA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_101)); }
        .inttab_tc4_066 (__INTTAB_CPU4 + 0x0CC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_102)); }
        .inttab_tc4_067 (__INTTAB_CPU4 + 0x0CE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_103)); }
        .inttab_tc4_068 (__INTTAB_CPU4 + 0x0D00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_104)); }
        .inttab_tc4_069 (__INTTAB_CPU4 + 0x0D20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_105)); }
        .inttab_tc4_06A (__INTTAB_CPU4 + 0x0D40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_106)); }
        .inttab_tc4_06B (__INTTAB_CPU4 + 0x0D60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_107)); }
        .inttab_tc4_06C (__INTTAB_CPU4 + 0x0D80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_108)); }
        .inttab_tc4_06D (__INTTAB_CPU4 + 0x0DA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_109)); }
        .inttab_tc4_06E (__INTTAB_CPU4 + 0x0DC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_110)); }
        .inttab_tc4_06F (__INTTAB_CPU4 + 0x0DE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_111)); }
        .inttab_tc4_070 (__INTTAB_CPU4 + 0x0E00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_112)); }
        .inttab_tc4_071 (__INTTAB_CPU4 + 0x0E20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_113)); }
        .inttab_tc4_072 (__INTTAB_CPU4 + 0x0E40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_114)); }
        .inttab_tc4_073 (__INTTAB_CPU4 + 0x0E60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_115)); }
        .inttab_tc4_074 (__INTTAB_CPU4 + 0x0E80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_116)); }
        .inttab_tc4_075 (__INTTAB_CPU4 + 0x0EA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_117)); }
        .inttab_tc4_076 (__INTTAB_CPU4 + 0x0EC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_118)); }
        .inttab_tc4_077 (__INTTAB_CPU4 + 0x0EE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_119)); }
        .inttab_tc4_078 (__INTTAB_CPU4 + 0x0F00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_120)); }
        .inttab_tc4_079 (__INTTAB_CPU4 + 0x0F20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_121)); }
        .inttab_tc4_07A (__INTTAB_CPU4 + 0x0F40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_122)); }
        .inttab_tc4_07B (__INTTAB_CPU4 + 0x0F60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_123)); }
        .inttab_tc4_07C (__INTTAB_CPU4 + 0x0F80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_124)); }
        .inttab_tc4_07D (__INTTAB_CPU4 + 0x0FA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_125)); }
        .inttab_tc4_07E (__INTTAB_CPU4 + 0x0FC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_126)); }
        .inttab_tc4_07F (__INTTAB_CPU4 + 0x0FE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_127)); }
        .inttab_tc4_080 (__INTTAB_CPU4 + 0x1000) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_128)); }
        .inttab_tc4_081 (__INTTAB_CPU4 + 0x1020) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_129)); }
        .inttab_tc4_082 (__INTTAB_CPU4 + 0x1040) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_130)); }
        .inttab_tc4_083 (__INTTAB_CPU4 + 0x1060) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_131)); }
        .inttab_tc4_084 (__INTTAB_CPU4 + 0x1080) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_132)); }
        .inttab_tc4_085 (__INTTAB_CPU4 + 0x10A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_133)); }
        .inttab_tc4_086 (__INTTAB_CPU4 + 0x10C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_134)); }
        .inttab_tc4_087 (__INTTAB_CPU4 + 0x10E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_135)); }
        .inttab_tc4_088 (__INTTAB_CPU4 + 0x1100) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_136)); }
        .inttab_tc4_089 (__INTTAB_CPU4 + 0x1120) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_137)); }
        .inttab_tc4_08A (__INTTAB_CPU4 + 0x1140) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_138)); }
        .inttab_tc4_08B (__INTTAB_CPU4 + 0x1160) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_139)); }
        .inttab_tc4_08C (__INTTAB_CPU4 + 0x1180) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_140)); }
        .inttab_tc4_08D (__INTTAB_CPU4 + 0x11A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_141)); }
        .inttab_tc4_08E (__INTTAB_CPU4 + 0x11C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_142)); }
        .inttab_tc4_08F (__INTTAB_CPU4 + 0x11E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_143)); }
        .inttab_tc4_090 (__INTTAB_CPU4 + 0x1200) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_144)); }
        .inttab_tc4_091 (__INTTAB_CPU4 + 0x1220) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_145)); }
        .inttab_tc4_092 (__INTTAB_CPU4 + 0x1240) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_146)); }
        .inttab_tc4_093 (__INTTAB_CPU4 + 0x1260) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_147)); }
        .inttab_tc4_094 (__INTTAB_CPU4 + 0x1280) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_148)); }
        .inttab_tc4_095 (__INTTAB_CPU4 + 0x12A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_149)); }
        .inttab_tc4_096 (__INTTAB_CPU4 + 0x12C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_150)); }
        .inttab_tc4_097 (__INTTAB_CPU4 + 0x12E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_151)); }
        .inttab_tc4_098 (__INTTAB_CPU4 + 0x1300) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_152)); }
        .inttab_tc4_099 (__INTTAB_CPU4 + 0x1320) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_153)); }
        .inttab_tc4_09A (__INTTAB_CPU4 + 0x1340) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_154)); }
        .inttab_tc4_09B (__INTTAB_CPU4 + 0x1360) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_155)); }
        .inttab_tc4_09C (__INTTAB_CPU4 + 0x1380) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_156)); }
        .inttab_tc4_09D (__INTTAB_CPU4 + 0x13A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_157)); }
        .inttab_tc4_09E (__INTTAB_CPU4 + 0x13C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_158)); }
        .inttab_tc4_09F (__INTTAB_CPU4 + 0x13E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_159)); }
        .inttab_tc4_0A0 (__INTTAB_CPU4 + 0x1400) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_160)); }
        .inttab_tc4_0A1 (__INTTAB_CPU4 + 0x1420) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_161)); }
        .inttab_tc4_0A2 (__INTTAB_CPU4 + 0x1440) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_162)); }
        .inttab_tc4_0A3 (__INTTAB_CPU4 + 0x1460) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_163)); }
        .inttab_tc4_0A4 (__INTTAB_CPU4 + 0x1480) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_164)); }
        .inttab_tc4_0A5 (__INTTAB_CPU4 + 0x14A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_165)); }
        .inttab_tc4_0A6 (__INTTAB_CPU4 + 0x14C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_166)); }
        .inttab_tc4_0A7 (__INTTAB_CPU4 + 0x14E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_167)); }
        .inttab_tc4_0A8 (__INTTAB_CPU4 + 0x1500) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_168)); }
        .inttab_tc4_0A9 (__INTTAB_CPU4 + 0x1520) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_169)); }
        .inttab_tc4_0AA (__INTTAB_CPU4 + 0x1540) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_170)); }
        .inttab_tc4_0AB (__INTTAB_CPU4 + 0x1560) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_171)); }
        .inttab_tc4_0AC (__INTTAB_CPU4 + 0x1580) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_172)); }
        .inttab_tc4_0AD (__INTTAB_CPU4 + 0x15A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_173)); }
        .inttab_tc4_0AE (__INTTAB_CPU4 + 0x15C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_174)); }
        .inttab_tc4_0AF (__INTTAB_CPU4 + 0x15E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_175)); }
        .inttab_tc4_0B0 (__INTTAB_CPU4 + 0x1600) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_176)); }
        .inttab_tc4_0B1 (__INTTAB_CPU4 + 0x1620) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_177)); }
        .inttab_tc4_0B2 (__INTTAB_CPU4 + 0x1640) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_178)); }
        .inttab_tc4_0B3 (__INTTAB_CPU4 + 0x1660) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_179)); }
        .inttab_tc4_0B4 (__INTTAB_CPU4 + 0x1680) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_180)); }
        .inttab_tc4_0B5 (__INTTAB_CPU4 + 0x16A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_181)); }
        .inttab_tc4_0B6 (__INTTAB_CPU4 + 0x16C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_182)); }
        .inttab_tc4_0B7 (__INTTAB_CPU4 + 0x16E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_183)); }
        .inttab_tc4_0B8 (__INTTAB_CPU4 + 0x1700) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_184)); }
        .inttab_tc4_0B9 (__INTTAB_CPU4 + 0x1720) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_185)); }
        .inttab_tc4_0BA (__INTTAB_CPU4 + 0x1740) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_186)); }
        .inttab_tc4_0BB (__INTTAB_CPU4 + 0x1760) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_187)); }
        .inttab_tc4_0BC (__INTTAB_CPU4 + 0x1780) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_188)); }
        .inttab_tc4_0BD (__INTTAB_CPU4 + 0x17A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_189)); }
        .inttab_tc4_0BE (__INTTAB_CPU4 + 0x17C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_190)); }
        .inttab_tc4_0BF (__INTTAB_CPU4 + 0x17E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_191)); }
        .inttab_tc4_0C0 (__INTTAB_CPU4 + 0x1800) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_192)); }
        .inttab_tc4_0C1 (__INTTAB_CPU4 + 0x1820) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_193)); }
        .inttab_tc4_0C2 (__INTTAB_CPU4 + 0x1840) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_194)); }
        .inttab_tc4_0C3 (__INTTAB_CPU4 + 0x1860) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_195)); }
        .inttab_tc4_0C4 (__INTTAB_CPU4 + 0x1880) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_196)); }
        .inttab_tc4_0C5 (__INTTAB_CPU4 + 0x18A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_197)); }
        .inttab_tc4_0C6 (__INTTAB_CPU4 + 0x18C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_198)); }
        .inttab_tc4_0C7 (__INTTAB_CPU4 + 0x18E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_199)); }
        .inttab_tc4_0C8 (__INTTAB_CPU4 + 0x1900) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_200)); }
        .inttab_tc4_0C9 (__INTTAB_CPU4 + 0x1920) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_201)); }
        .inttab_tc4_0CA (__INTTAB_CPU4 + 0x1940) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_202)); }
        .inttab_tc4_0CB (__INTTAB_CPU4 + 0x1960) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_203)); }
        .inttab_tc4_0CC (__INTTAB_CPU4 + 0x1980) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_204)); }
        .inttab_tc4_0CD (__INTTAB_CPU4 + 0x19A0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_205)); }
        .inttab_tc4_0CE (__INTTAB_CPU4 + 0x19C0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_206)); }
        .inttab_tc4_0CF (__INTTAB_CPU4 + 0x19E0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_207)); }
        .inttab_tc4_0D0 (__INTTAB_CPU4 + 0x1A00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_208)); }
        .inttab_tc4_0D1 (__INTTAB_CPU4 + 0x1A20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_209)); }
        .inttab_tc4_0D2 (__INTTAB_CPU4 + 0x1A40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_210)); }
        .inttab_tc4_0D3 (__INTTAB_CPU4 + 0x1A60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_211)); }
        .inttab_tc4_0D4 (__INTTAB_CPU4 + 0x1A80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_212)); }
        .inttab_tc4_0D5 (__INTTAB_CPU4 + 0x1AA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_213)); }
        .inttab_tc4_0D6 (__INTTAB_CPU4 + 0x1AC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_214)); }
        .inttab_tc4_0D7 (__INTTAB_CPU4 + 0x1AE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_215)); }
        .inttab_tc4_0D8 (__INTTAB_CPU4 + 0x1B00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_216)); }
        .inttab_tc4_0D9 (__INTTAB_CPU4 + 0x1B20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_217)); }
        .inttab_tc4_0DA (__INTTAB_CPU4 + 0x1B40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_218)); }
        .inttab_tc4_0DB (__INTTAB_CPU4 + 0x1B60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_219)); }
        .inttab_tc4_0DC (__INTTAB_CPU4 + 0x1B80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_220)); }
        .inttab_tc4_0DD (__INTTAB_CPU4 + 0x1BA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_221)); }
        .inttab_tc4_0DE (__INTTAB_CPU4 + 0x1BC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_222)); }
        .inttab_tc4_0DF (__INTTAB_CPU4 + 0x1BE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_223)); }
        .inttab_tc4_0E0 (__INTTAB_CPU4 + 0x1C00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_224)); }
        .inttab_tc4_0E1 (__INTTAB_CPU4 + 0x1C20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_225)); }
        .inttab_tc4_0E2 (__INTTAB_CPU4 + 0x1C40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_226)); }
        .inttab_tc4_0E3 (__INTTAB_CPU4 + 0x1C60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_227)); }
        .inttab_tc4_0E4 (__INTTAB_CPU4 + 0x1C80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_228)); }
        .inttab_tc4_0E5 (__INTTAB_CPU4 + 0x1CA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_229)); }
        .inttab_tc4_0E6 (__INTTAB_CPU4 + 0x1CC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_230)); }
        .inttab_tc4_0E7 (__INTTAB_CPU4 + 0x1CE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_231)); }
        .inttab_tc4_0E8 (__INTTAB_CPU4 + 0x1D00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_232)); }
        .inttab_tc4_0E9 (__INTTAB_CPU4 + 0x1D20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_233)); }
        .inttab_tc4_0EA (__INTTAB_CPU4 + 0x1D40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_234)); }
        .inttab_tc4_0EB (__INTTAB_CPU4 + 0x1D60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_235)); }
        .inttab_tc4_0EC (__INTTAB_CPU4 + 0x1D80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_236)); }
        .inttab_tc4_0ED (__INTTAB_CPU4 + 0x1DA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_237)); }
        .inttab_tc4_0EE (__INTTAB_CPU4 + 0x1DC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_238)); }
        .inttab_tc4_0EF (__INTTAB_CPU4 + 0x1DE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_239)); }
        .inttab_tc4_0F0 (__INTTAB_CPU4 + 0x1E00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_240)); }
        .inttab_tc4_0F1 (__INTTAB_CPU4 + 0x1E20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_241)); }
        .inttab_tc4_0F2 (__INTTAB_CPU4 + 0x1E40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_242)); }
        .inttab_tc4_0F3 (__INTTAB_CPU4 + 0x1E60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_243)); }
        .inttab_tc4_0F4 (__INTTAB_CPU4 + 0x1E80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_244)); }
        .inttab_tc4_0F5 (__INTTAB_CPU4 + 0x1EA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_245)); }
        .inttab_tc4_0F6 (__INTTAB_CPU4 + 0x1EC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_246)); }
        .inttab_tc4_0F7 (__INTTAB_CPU4 + 0x1EE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_247)); }
        .inttab_tc4_0F8 (__INTTAB_CPU4 + 0x1F00) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_248)); }
        .inttab_tc4_0F9 (__INTTAB_CPU4 + 0x1F20) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_249)); }
        .inttab_tc4_0FA (__INTTAB_CPU4 + 0x1F40) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_250)); }
        .inttab_tc4_0FB (__INTTAB_CPU4 + 0x1F60) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_251)); }
        .inttab_tc4_0FC (__INTTAB_CPU4 + 0x1F80) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_252)); }
        .inttab_tc4_0FD (__INTTAB_CPU4 + 0x1FA0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_253)); }
        .inttab_tc4_0FE (__INTTAB_CPU4 + 0x1FC0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_254)); }
        .inttab_tc4_0FF (__INTTAB_CPU4 + 0x1FE0) : { . = ALIGN(8) ;  KEEP (*(.intvec_tc4_255)); }
    }   
    
    /*Near Absolute Addressable Data Sections*/
    /*Near Absolute Data, selectable with patterns and user defined sections*/
    CORE_ID = CPU4;
    SECTIONS
    {
        CORE_SEC(.zdata) (LCF_DSPR4_START): FLAGS(awzl)
        {
            *Ifx_Ssw_Tc4.* (.zdata)
            *Cpu4_Main.* (.zdata)
            *(.zdata_cpu4)
            *(.zdata_cpu4.*)
            . = ALIGN(2);
        } > dsram4 AT> pfls4
        
        CORE_SEC(.zbss) (NOLOAD): FLAGS(awz)
        {
            *Ifx_Ssw_Tc4.* (.zbss)
            *Cpu4_Main.* (.zbss)
            *(.zbss_cpu4)
            *(.zbss_cpu4.*)
        } > dsram4
    }
    
    /*Near Absolute Data, selectable by toolchain*/
    CORE_ID = GLOBAL;
    SECTIONS
    {    
        CORE_SEC(.zdata_powerOn) : FLAGS(awzl)
        {
            *(.zdata.dsprPowerOnInit.cpu4.32bit)
            *(.zdata.dsprPowerOnInit.cpu4.16bit)
            *(.zdata.dsprPowerOnInit.cpu4.8bit)
            . = ALIGN(2);
        } > default_ram AT> pfls4
        
        CORE_SEC(.zdata) : FLAGS(awzl)
        {
            *(.zdata.dsprInit.cpu4.32bit)
            *(.zdata.dsprInit.cpu4.16bit)
            *(.zdata.dsprInit.cpu4.8bit)
            *(.zdata)
            *(.zdata.*)
            *(.gnu.linkonce.z.*)
            . = ALIGN(2);
        } > default_ram AT> pfls4
        
        CORE_SEC(.zbss_powerOn) (NOLOAD) : FLAGS(awz)
        {
            *(.zbss.dsprPowerOnClear.cpu4.32bit)
            *(.zbss.dsprPowerOnClear.cpu4.16bit)
            *(.zbss.dsprPowerOnClear.cpu4.8bit)
        } > default_ram
        
        CORE_SEC(.zbss_noClear) (NOLOAD) : FLAGS(awz)
        {
            *(.zbss.dsprNoInit.cpu4.32bit)
            *(.zbss.dsprNoInit.cpu4.16bit)
            *(.zbss.dsprNoInit.cpu4.8bit)
        } > default_ram
        
        CORE_SEC(.zbss) (NOLOAD) : FLAGS(awz)
        {
            *(.zbss.dsprClearOnInit.cpu4.32bit)
            *(.zbss.dsprClearOnInit.cpu4.16bit)
            *(.zbss.dsprClearOnInit.cpu4.8bit)
            *(.zbss)
            *(.zbss.*)
            *(.bbss)
            *(.bbss.*)
            *(.gnu.linkonce.zb.*)
        } > default_ram
    }

    CORE_ID = GLOBAL;
    SECTIONS
    {
        /*Cpu4_dlmu also is the segment start, all the near lmu data shll be located here*/
        CORE_SEC(.lmuzdata) : FLAGS(awzl)
        {
            *(.zlmudata)
            *(.zlmudata.*)
            . = ALIGN(2);
        } > cpu4_dlmu AT> pfls4
        
        CORE_SEC(.zbss) (NOLOAD) : FLAGS(awz)
        {
            *(.zlmubss)
            *(.zlmubss.*)
        } > cpu4_dlmu
    }
    
    /*Near Absolute Const, selectable with patterns and user defined sections*/
    CORE_ID = GLOBAL;
    SECTIONS
    {
        CORE_SEC(.zrodata) : FLAGS(arzl)
        {
            *Ifx_Ssw_Tc?.* (.zrodata)
            *Cpu?_Main.* (.zrodata)
            *(.zrodata_cpu?)
        } > pfls4
    }
    
    /*Near Absolute Const, selectable by toolchain*/
    CORE_ID = GLOBAL;
    SECTIONS
    {
        CORE_SEC(.zrodata) : FLAGS(arzl)
        {
            *(.zrodata.const.cpu4.32bit)
            *(.zrodata.const.cpu4.16bit)
            *(.zrodata.const.cpu4.8bit)
            *(.zrodata.config.cpu4.32bit)
            *(.zrodata.config.cpu4.16bit)
            *(.zrodata.config.cpu4.8bit)
            *(.zrodata)
            *(.zrodata.*)
        } > pfls4
    }

/*Relative A0/A1/A8/A9 Addressable Sections*/
CORE_ID = GLOBAL;
SECTIONS
{
    /*Relative A0 Addressable Data, selectable with patterns and user defined sections*/
        /*Note: A0 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A0 Addressable Data, selectable by toolchain*/
    CORE_SEC(.sdata) : FLAGS(awsl)
    {
        *(.sdata)
        *(.sdata.*)
        . = ALIGN(2);
    } > default_ram AT> pfls4
    CORE_SEC(.sbss) (NOLOAD): FLAGS(aws)
    {
        *(.sbss)
        *(.sbss.*)
    } > default_ram
    _SMALL_DATA_ = SIZEOF(CORE_SEC(.sdata)) ? ADDR(CORE_SEC(.sdata)) : (ADDR(CORE_SEC(.sdata)) & 0xF0000000) + 32k ;
    __A0_MEM = _SMALL_DATA_;
}

CORE_ID = GLOBAL;
SECTIONS
{
    /*Relative A1 Addressable Const, selectable with patterns and user defined sections*/
        /*Note: A1 addressable area is common, to make the functions callable in any CPU*/
    /*Relative A1 Addressable Const, selectable by toolchain*/
    CORE_SEC(.sdata2) : FLAGS(arsl)
    {
        *(.srodata)
        *(.srodata.*)
    } > default_rom
    _SMALL_DATA2_ = SIZEOF(CORE_SEC(.sdata2)) ? ADDR(CORE_SEC(.sdata2)) : (ADDR(CORE_SEC(.sdata2)) & 0xF0000000) + 32k ;
    __A1_MEM = _SMALL_DATA2_;
}

CORE_ID = GLOBAL;
SECTIONS
{
    /*Relative A9 Addressable Data, selectable with patterns and user defined sections*/
    CORE_SEC(.sdata4) :
    {
        *(.a9sdata)
        *(.a9sdata.*)
        . = ALIGN(2);
    } > cpu4_dlmu AT> pfls4
    
    CORE_SEC(.sbss4) :
    {
        *(.a9sbss)
        *(.a9sbss.*)    
    } > cpu4_dlmu
    
    _SMALL_DATA4_ = SIZEOF(CORE_SEC(.sdata4)) ? ADDR(CORE_SEC(.sdata4)) : (ADDR(CORE_SEC(.sdata4)) & 0xF0000000) + 32k ;
    __A9_MEM = _SMALL_DATA4_;

    /*Relative A8 Addressable Const, selectable with patterns and user defined sections*/
    CORE_SEC(.sdata3) : FLAGS(arsl)
    {
        *(.rodata_a8)
        *(.rodata_a8.*)
    } > default_rom
    
    _SMALL_DATA3_ = SIZEOF(CORE_SEC(.sdata3)) ? ADDR(CORE_SEC(.sdata3)) : (ADDR(CORE_SEC(.sdata3)) & 0xF0000000) + 32k ;
    __A8_MEM = _SMALL_DATA3_;
}

/*Far Data / Far Const Sections, selectable with patterns and user defined sections*/
/*Far Data Sections, selectable with patterns and user defined sections*/
CORE_ID = CPU4 ;
SECTIONS
{
    /*DSRAM4 Sections*/
    CORE_SEC(.data) : FLAGS(awl)
    {
        *Ifx_Ssw_Tc4.* (.data)
        *Cpu4_Main.* (.data)
        *(.data_cpu4)
        *(.data_cpu4.*)
        . = ALIGN(2);
    } > dsram4 AT> pfls4
    
    CORE_SEC(.bss) (NOLOAD): FLAGS(aw)
    {
        *Ifx_Ssw_Tc4.* (.bss)
        *Cpu4_Main.* (.bss)
        *Cpu4_Main.* (.bss.*)
        *(.bss_cpu4)
        *(.bss_cpu4.*)
    } > dsram4
    
    /*DLMU4 Sections*/
    CORE_SEC(.lmudata) : FLAGS(awl)
    {
        *(.lmudata_cpu4)
        *(.lmudata_cpu4.*)
        . = ALIGN(2);
    } > cpu4_dlmu AT> pfls4
    
    CORE_SEC(.lmubss) : FLAGS(aw)
    {
        *(.lmubss_cpu4)
        *(.lmubss_cpu4.*)
    } > cpu4_dlmu
}

/*Far Data Sections, selectable by toolchain*/
CORE_ID = GLOBAL;
SECTIONS
{
    CORE_SEC(.bss_noClear) (NOLOAD) : FLAGS(aw)
    {
        *(.bss.farDsprNoInit.cpu4.32bit)
        *(.bss.farDsprNoInit.cpu4.16bit)
        *(.bss.farDsprNoInit.cpu4.8bit)
    } > default_ram
    
    CORE_SEC(.data) : FLAGS(awl)
    {
        *(.data.farDsprInit.cpu4.32bit)
        *(.data.farDsprInit.cpu4.16bit)
        *(.data.farDsprInit.cpu4.8bit)
        *(.data)
        *(.data.*)
        *(.gnu.linkonce.d.*)
        . = ALIGN(2);
    } > default_ram AT> pfls4
    
    CORE_SEC(.bss) (NOLOAD) : FLAGS(aw)
    {
        *(.bss.farDsprClearOnInit.cpu4.32bit)
        *(.bss.farDsprClearOnInit.cpu4.16bit)
        *(.bss.farDsprClearOnInit.cpu4.8bit)
        *(.bss)
        *(.bss.*)
        *(.gnu.linkonce.b.*)
    } > default_ram
    
    .heap  : FLAGS(aw)
    {
    . = ALIGN(4);
    __HEAP = .;
    . += LCF_HEAP_SIZE;
    __HEAP_END = .;
    } > default_ram
    
    CORE_SEC(.lmudata) : FLAGS(awl)
    {
        *(.lmudata)
        *(.lmudata.*)
        . = ALIGN(2);
    } > cpu4_dlmu AT> pfls4
    
    CORE_SEC(.lmubss) : FLAGS(aw)
    {
        *(.lmubss)
        *(.lmubss.*)
    } > cpu4_dlmu
    
    .shared_data : FLAGS(awl)
    {
       *(.uncached.lmudata)
       *(.uncached.lmudata.*)
    } > cpu4_dlmu_nc
    
    .shared_bss : FLAGS(aw)
    {
       *(.uncached.lmubss)
       *(.uncached.lmubss.*)
       *(.sharedvar)
       *(.sharedvar.*)
    } > cpu4_dlmu_nc
    
    .ppu_lmuram  : FLAGS(aw)
    {
    . = ALIGN(4);
    __PPU_LMURAM_START = .;
    . += LCF_PPU_LMURAM_SIZE;
    __PPU_LMURAM_END = .;
    } > ppu_lmuram_nc
    
    .ppu_csm  : FLAGS(aw)
    {
    . = ALIGN(4);
    __PPU_CSM_START = .;
    . += LCF_PPU_CSM_SIZE;
    __PPU_CSM_END = .;
    } > ppu_csm_nc
    
}
/*Far Const Sections, selectable with patterns and user defined sections*/
CORE_ID = CPU4;
SECTIONS
{
    CORE_SEC(.rodata) : FLAGS(arl)
    {
        *Ifx_Ssw_Tc4.* (.rodata)
        *Cpu4_Main.* (.rodata)
        *(.rodata_cpu4)
        *(.rodata_cpu4.*)
    } > pfls4
}

/*Far Const Sections, selectable by toolchain*/
CORE_ID = GLOBAL;
SECTIONS
{
    CORE_SEC(.rodata) : FLAGS(arl)
    {
        *(.rodata.farConst.cpu4.32bit)
        *(.rodata.farConst.cpu4.16bit)
        *(.rodata.farConst.cpu4.8bit)
        *(.rodata)
        *(.rodata.*)
    *(.gnu.linkonce.r.*)
    /*
     * Create the clear and copy tables that tell the startup code
     * which memory areas to clear and to copy, respectively.
     */
    . = ALIGN(4) ;
    PROVIDE(__clear_table = .);
    LONG(0 + ADDR(.CPU4.zbss));       LONG(SIZEOF(.CPU4.zbss));
    LONG(0 + ADDR(.CPU4.bss));        LONG(SIZEOF(.CPU4.bss));
    LONG(0 + ADDR(.CPU4.lmubss));     LONG(SIZEOF(.CPU4.lmubss));
    LONG(0 + ADDR(.zbss));            LONG(SIZEOF(.zbss));
    LONG(0 + ADDR(.sbss));            LONG(SIZEOF(.sbss));
    LONG(0 + ADDR(.bss));             LONG(SIZEOF(.bss));
    LONG(0 + ADDR(.lmubss));          LONG(SIZEOF(.lmubss));
    LONG(0 + ADDR(.sbss4));           LONG(SIZEOF(.sbss4));
    LONG(0 + ADDR(.shared_bss));      LONG(SIZEOF(.shared_bss));
    LONG(-1);                         LONG(-1);
    PROVIDE(__clear_table_powerOn = .);
    LONG(0 + ADDR(.zbss_powerOn));    LONG(SIZEOF(.zbss_powerOn));
    LONG(-1);                         LONG(-1);
    PROVIDE(__copy_table = .);
    LONG(LOADADDR(.CPU4.zdata));      LONG(0 + ADDR(.CPU4.zdata));      LONG(SIZEOF(.CPU4.zdata));
    LONG(LOADADDR(.CPU4.data));       LONG(0 + ADDR(.CPU4.data));       LONG(SIZEOF(.CPU4.data));
    LONG(LOADADDR(.CPU4.lmudata));    LONG(0 + ADDR(.CPU4.lmudata));    LONG(SIZEOF(.CPU4.lmudata));
    LONG(LOADADDR(.zdata));           LONG(0 + ADDR(.zdata));           LONG(SIZEOF(.zdata));
    LONG(LOADADDR(.sdata));           LONG(0 + ADDR(.sdata));           LONG(SIZEOF(.sdata));
    LONG(LOADADDR(.data));            LONG(0 + ADDR(.data));            LONG(SIZEOF(.data));
    LONG(LOADADDR(.lmudata));         LONG(0 + ADDR(.lmudata));         LONG(SIZEOF(.lmudata));
    LONG(LOADADDR(.sdata4));          LONG(0 + ADDR(.sdata4));          LONG(SIZEOF(.sdata4));
    LONG(LOADADDR(.shared_data));     LONG(0 + ADDR(.shared_data));     LONG(SIZEOF(.shared_data));
    LONG(LOADADDR(.CPU4.psram_text)); LONG(0 + ADDR(.CPU4.psram_text)); LONG(SIZEOF(.CPU4.psram_text));
    LONG(-1);                         LONG(-1);                         LONG(-1);
    PROVIDE(__copy_table_powerOn = .) ;
    LONG(LOADADDR(.zdata_powerOn));   LONG(0 + ADDR(.zdata_powerOn));   LONG(SIZEOF(.zdata_powerOn));
    LONG(-1);                         LONG(-1);                         LONG(-1);
    . = ALIGN(8);
    } > default_rom
}

/*Code selections*/
/*Code Sections, selectable with patterns and user defined sections*/
CORE_ID = CPU4;
SECTIONS
{
	/* VDK TSPI Functions */
    .tspi :
     {
        *(.tspi)
        . = ALIGN(8);
    } > pfls4
	
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
    
    } > pfls4
    
    .fini :
    {
        PROVIDE(__fini_start = .);
        KEEP(*(.fini))
        KEEP(*(.fini*))
        PROVIDE(__fini_end = .);
        . = ALIGN(8);
    } > pfls4
    
    /*
     * Code executed before calling main extra section for C++ constructor init
     *  -------------------------End-----------------------------------------
     */
}

CORE_ID = CPU4;
SECTIONS
{
    CORE_SEC(.text) : FLAGS(axl)
    {
        . = ALIGN(4);
        *Ifx_Ssw_Tc4.*(.text)
        *Cpu4_Main.*(.text)
        *Ifx_Ssw_Tc4.*(.text.*)
        *Cpu4_Main.*(.text.*)
        *(.text_cpu4)
        *(.text_cpu4.*)
	. = ALIGN(4);
		
    } > pfls4

    CORE_SEC(.psram_text)  : FLAGS(awx)
    {
        . = ALIGN(4);
        *(.psram_text_cpu4)
        *(.psram_text_cpu4.*)
        *(.cpu4_psram)
        *(.cpu4_psram.*)
        . = ALIGN(4);
    } > psram4 AT> pfls4
}

/*Code Sections, selectable by toolchain*/
CORE_ID = GLOBAL;
SECTIONS
{
    CORE_SEC(.text) : FLAGS(axl)
    {
        *(.text.fast.pfls.cpu4)
        *(.text.slow.pfls.cpu4)
        *(.text.5ms.pfls.cpu4)
        *(.text.10ms.pfls.cpu4)
        *(.text.callout.pfls.cpu4)
        *(.text)
        *(.text.*)
        *(.gnu.linkonce.t.*)
        *(.gnu.warning)        /* .gnu.warning sections are handled specially by elf32.em. */
        . = ALIGN(4);
    } > default_rom
    
    CORE_SEC(.ppu_code) (ORIGIN(pfls5) + LENGTH(pfls5) - LCF_PPU_FLASH_SIZE) (NOLOAD) : FLAGS(axl)
    {
    __PPU_IF_CONSTANTS = .;
    __PPU_CODE_START = .;
    . += LCF_PPU_FLASH_SIZE;
    __PPU_CODE_END = .;
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

    /*
     * Constructors and destructors.
     */
    .ctors : FLAGS(ar)
    {
        __CTOR_LIST__ = . ;
        LONG((__CTOR_END__ - __CTOR_LIST__) / 4 - 2);
        /*
         * Code executed before calling main extra section for C++ constructor init
         *  -------------------------Start-----------------------------------------
         */
        KEEP (*crtbegin.o(.ctors))
        KEEP (*(EXCLUDE_FILE (*crtend.o ) .ctors))
        KEEP (*(SORT(.ctors.*)))
        KEEP (*(.ctors))
        /*
         * Code executed before calling main extra section for C++ constructor init
         *  -------------------------End-----------------------------------------
         */
        LONG(0) ;
        __CTOR_END__ = . ;
        . = ALIGN(8);
    } > default_rom
    .dtors : FLAGS(ar)
    {
        __DTOR_LIST__ = . ;
        LONG((__DTOR_END__ - __DTOR_LIST__) / 4 - 2);
        /*
         * Code executed before calling main extra section for C++ distructor init
         *  -------------------------Start-----------------------------------------
         */
        KEEP (*crtbegin.o(.dtors))
        KEEP (*(EXCLUDE_FILE (*crtend.o ) .dtors))
        KEEP (*(SORT(.dtors.*)))
        KEEP (*(.dtors))
        /*
         * Code executed before calling main extra section for C++ distructor init
         *  -------------------------End-----------------------------------------
         */
        LONG(0) ;
        __DTOR_END__ = . ;
        . = ALIGN(8);
    } > default_rom
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

