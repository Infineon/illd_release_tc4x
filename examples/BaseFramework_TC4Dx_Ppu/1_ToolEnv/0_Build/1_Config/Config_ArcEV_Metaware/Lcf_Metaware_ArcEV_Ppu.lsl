
LCF_ICACHE_LINESIZE    = 64;        # core_config_icache_line_size=64
LCF_DCACHE_LINESIZE    = 64;        # core_config_dcache_line_size=64
LCF_VEC_STACKSIZE      = 0x10000;   # 64KB (use 50% of total size -- revisit?)
LCF_VEC_BUFFER_SIZE    = 0;         # 
LCF_STACKSIZE          = 0x00001000;# 4KB
LCF_IVTSIZE            = 400;       # irqs=84: (84+16)*4 = 400B
_HEAPSIZE              = 0;         # crt module sets this size for USE_LIBC case

MEMORY {
    dsram_local: ORIGIN = 0xd0000000, LENGTH = 240K     # Reserved for Tricore use
    dsram5      : ORIGIN = 0x20000000, LENGTH = 240K     # Reserved for Tricore use
    psram5      : ORIGIN = 0x20100000, LENGTH = 64K      # Reserved for Tricore use
    
    
    dsram4      : ORIGIN = 0x30000000, LENGTH = 240K     # Reserved for Tricore use
    psram4      : ORIGIN = 0x30100000, LENGTH = 64K      # Reserved for Tricore use
    
    
    dsram3      : ORIGIN = 0x40000000, LENGTH = 240K     # Reserved for Tricore use
    psram3      : ORIGIN = 0x40100000, LENGTH = 64K      # Reserved for Tricore use
    
    
    dsram2      : ORIGIN = 0x50000000, LENGTH = 240K     # Reserved for Tricore use
    psram2      : ORIGIN = 0x50100000, LENGTH = 64K      # Reserved for Tricore use
    
    
    dsram1      : ORIGIN = 0x60000000, LENGTH = 240K     # Reserved for Tricore use
    psram1      : ORIGIN = 0x60100000, LENGTH = 64K      # Reserved for Tricore use
    
    
    dsram0      : ORIGIN = 0x70000000, LENGTH = 240K     # Reserved for Tricore use
    psram0      : ORIGIN = 0x70100000, LENGTH = 64K      # Reserved for Tricore use

    
    psram_local : ORIGIN = 0xc0000000, LENGTH = 64K      # Reserved for Tricore use

    pfls0       : ORIGIN = 0x80000000, LENGTH = 4M       # Reserved for Tricore use
    pfls0_nc    : ORIGIN = 0xA0000000, LENGTH = 4M       # Reserved for Tricore use

    pfls1       : ORIGIN = 0x80400000, LENGTH = 4M       # Reserved for Tricore use
    pfls1_nc    : ORIGIN = 0xA0400000, LENGTH = 4M       # Reserved for Tricore use

    pfls2       : ORIGIN = 0x80800000, LENGTH = 2M       # Reserved for Tricore use
    pfls2_nc    : ORIGIN = 0xA0800000, LENGTH = 2M       # Reserved for Tricore use

    pfls3       : ORIGIN = 0x80A00000, LENGTH = 4M       # Reserved for Tricore use
    pfls3_nc    : ORIGIN = 0xA0A00000, LENGTH = 4M       # Reserved for Tricore use

    pfls4       : ORIGIN = 0x80E00000, LENGTH = 4M       # Reserved for Tricore use
    pfls4_nc    : ORIGIN = 0xA0E00000, LENGTH = 4M       # Reserved for Tricore use

    pfls5       : ORIGIN = 0x81200000, LENGTH = 2M       # Reserved for Tricore use
    pfls5_nc    : ORIGIN = 0xA1200000, LENGTH = 2M       # Reserved for Tricore use

    ucb         : ORIGIN = 0xae400000, LENGTH = 80K      # Reserved for Tricore use

    cpu0_dlmu   : ORIGIN = 0x90000000, LENGTH = 512K     # Reserved for Tricore use
    cpu0_dlmu_nc: ORIGIN = 0xb0000000, LENGTH = 512K     # Reserved for Tricore use

    cpu1_dlmu   : ORIGIN = 0x90080000, LENGTH = 512K     # Reserved for Tricore use
    cpu1_dlmu_nc: ORIGIN = 0xb0080000, LENGTH = 512K     # Reserved for Tricore use

    cpu2_dlmu   : ORIGIN = 0x90100000, LENGTH = 512K     # Reserved for Tricore use
    cpu2_dlmu_nc: ORIGIN = 0xb0100000, LENGTH = 512K     # Reserved for Tricore use

    cpu3_dlmu   : ORIGIN = 0x90180000, LENGTH = 512K     # Reserved for Tricore use
    cpu3_dlmu_nc: ORIGIN = 0xb0180000, LENGTH = 512K     # Reserved for Tricore use

    cpu4_dlmu   : ORIGIN = 0x90200000, LENGTH = 512K     # Reserved for Tricore use
    cpu4_dlmu_nc: ORIGIN = 0xb0200000, LENGTH = 512K     # Reserved for Tricore use

    cpu5_dlmu   : ORIGIN = 0x90280000, LENGTH = 512K     # Reserved for Tricore use
    cpu5_dlmu_nc: ORIGIN = 0xb0280000, LENGTH = 512K     # Reserved for Tricore use

    lmuram      : ORIGIN = 0x90400000, LENGTH = 4608K    # Reserved for Tricore use
    lmuram_nc   : ORIGIN = 0xb0400000, LENGTH = 4608K    # Reserved for Tricore use
    
    ppu_lmuram      : ORIGIN = 0x90880000, LENGTH = 256K    # Contains the data stored by PPU applications locally (cached address)
    ppu_lmuram_nc   : ORIGIN = 0xB0880000 + 256K, LENGTH = 256K    # Contains the data shared by PPU applications and other TC applications (non cached address)

    ppu_csm         : ORIGIN = 0x92080000, LENGTH = 512K    # Local memory for PPU. Used as cached address (Tricore shall not access this memory during runtime)
    ppu_csm_nc      : ORIGIN = 0xb2080000, LENGTH = 512K     
    
    pfls5_ppu       : ORIGIN = 0x81300000, LENGTH = 1024K   # FLASH51 is reserved for PPU
    
    ppu_vccm : ORIGIN = 0xC0000000, LENGTH = 128K    
     
    lmu_not_allocated1 : ORIGIN = 0xB0400000, LENGTH = 2048K   # Define to set up MPU not allocated allocation is done by TriCore but PPU might read
    lmu_not_allocated2 : ORIGIN = 0xB0780000, LENGTH = 1024K   # Define to set up MPU not allocated allocation is done by TriCore but PPU might read
    per_space_no_aloc1 : ORIGIN = 0xF0000000, LENGTH = 256M    # Define to set up MPU not allocated allocation is done by TriCore but PPU might read
}

# MPU Permission flags
_MPU_PERMISSION_EXECUTE = 0x1;
_MPU_PERMISSION_READ    = 0x2;
_MPU_PERMISSION_WRITE   = 0x4;

_fMPU_REGION0 = ADDR(ppu_lmuram);
_eMPU_REGION0 = ADDR(ppu_lmuram) + SIZEOF(ppu_lmuram);
_pMPU_REGION0 = (_MPU_PERMISSION_READ | _MPU_PERMISSION_EXECUTE | _MPU_PERMISSION_WRITE);

_fMPU_REGION1 = ADDR(ppu_lmuram_nc);
_eMPU_REGION1 = ADDR(ppu_lmuram_nc) + SIZEOF(ppu_lmuram_nc);
_pMPU_REGION1 = (_MPU_PERMISSION_READ | _MPU_PERMISSION_EXECUTE | _MPU_PERMISSION_WRITE);

_fMPU_REGION2 = ADDR(pfls5_ppu);
_eMPU_REGION2 = ADDR(pfls5_ppu) + SIZEOF(pfls5_ppu);
_pMPU_REGION2 = (_MPU_PERMISSION_READ | _MPU_PERMISSION_EXECUTE | _MPU_PERMISSION_WRITE);

_fMPU_REGION3 = ADDR(ppu_csm);
_eMPU_REGION3 = ADDR(ppu_csm) + SIZEOF(ppu_csm);
_pMPU_REGION3 = (_MPU_PERMISSION_READ | _MPU_PERMISSION_EXECUTE | _MPU_PERMISSION_WRITE);

_fMPU_REGION4 = ADDR(ppu_vccm);
_eMPU_REGION4 = ADDR(ppu_vccm) + SIZEOF(ppu_vccm);
_pMPU_REGION4 = (_MPU_PERMISSION_READ | _MPU_PERMISSION_WRITE);

_fMPU_REGION5 = ADDR(lmu_not_allocated1);
_eMPU_REGION5 = ADDR(lmu_not_allocated1) + SIZEOF(lmu_not_allocated1);
_pMPU_REGION5 = (_MPU_PERMISSION_READ | _MPU_PERMISSION_WRITE);

_fMPU_REGION6 = ADDR(lmu_not_allocated2);
_eMPU_REGION6 = ADDR(lmu_not_allocated1) + SIZEOF(lmu_not_allocated1);
_pMPU_REGION6 = (_MPU_PERMISSION_READ | _MPU_PERMISSION_WRITE);

_fMPU_REGION7 = ADDR(per_space_no_aloc1);
_eMPU_REGION7 = ADDR(per_space_no_aloc1) + SIZEOF(per_space_no_aloc1);
_pMPU_REGION7 = (_MPU_PERMISSION_READ | _MPU_PERMISSION_WRITE);

_fMPU_REGION8 = 0;
_eMPU_REGION8 = 0;
_pMPU_REGION8 = 0;

_fMPU_REGION9 = 0;
_eMPU_REGION9 = 0;
_pMPU_REGION9 = 0;

_fMPU_REGION10 = 0;
_eMPU_REGION10 = 0;
_pMPU_REGION10 = 0;

_fMPU_REGION11 = 0;
_eMPU_REGION11 = 0;
_pMPU_REGION11 = 0;

_fMPU_REGION12 = 0;
_eMPU_REGION12 = 0;
_pMPU_REGION12 = 0;

_fMPU_REGION13 = 0;
_eMPU_REGION13 = 0;
_pMPU_REGION13 = 0;

_fMPU_REGION14 = 0;
_eMPU_REGION14 = 0;
_pMPU_REGION14 = 0;

_fMPU_REGION15 = 0;
_eMPU_REGION15 = 0;
_pMPU_REGION15 = 0;


SECTIONS 
{

    #Vector table address as copy table information for TriCore to initialize the PPU vectors
    #during PPU Startup Trigger procedure
    #!!!! Please do not modify the location of below section !!!!
    GROUP BIND(ADDR(pfls5_ppu)) :
    {
        # Structure: SharedData_PpuIfConstants
        .shareddata_ppu_if_constants (LIT):
        {
            # SharedData_PpuIfConstants.ppuCopyTable from the file SharedData.h
            LONG(LOADADDR(.vectors));                                 # sourceAddress 
            LONG((ADDR(.vectors) & 0x0FFFFFFF) | 0xB0000000);         # destinationAddress
            LONG(SIZEOF(.vectors));                                   # size
            
            # SharedData_PpuIfConstants.ppuIpcDataPtr from the file SharedData.h 
            LONG(ADDR(.ppu_tc_shared_memory));
        }
    } > pfls5_ppu
    
    # RAM vector table requires 1024 byte alignment, note: not loaded
    GROUP BIND(ADDR(ppu_csm)):
    {
        .vectors (TEXT) SIZE(DEFINED LCF_IVTSIZE ? LCF_IVTSIZE:240):
        {
            KEEP(*(.vectors));
        }
    } =0x78e0 > ppu_csm AT>pfls5_ppu

    GROUP ALIGN(LCF_ICACHE_LINESIZE) BLOCK(4) :
    {
        _ftextarea = .;
        .text? : { *('.text$crt*') }
        * (TEXT): {}
        _etextarea = .;
        .padding ALIGN(LCF_ICACHE_LINESIZE) SIZE(2): {} = FILL(0x781E) # trap_s 0
    } = FILL(0x781E) > pfls5_ppu



    GROUP ALIGN(LCF_DCACHE_LINESIZE) BLOCK(4) :
    {
        # .lit and .rodata
        * (LIT): {}
        .initcall_cluster : {}
        .initcall_core : {}
        .destructcall_core : {}
        .padding ALIGN(LCF_DCACHE_LINESIZE) SIZE(2): {} = FILL(0x781E)
    } = FILL(0x781E) > pfls5_ppu

    GROUP ALIGN(LCF_DCACHE_LINESIZE) BLOCK(4):
    {
        .data :
        {  
            *(DATA)
            *(.user_ddr)
            *(.data*)
        }
        .padding ALIGN(LCF_DCACHE_LINESIZE) SIZE(2): {} = FILL(0x781E)
    } = FILL(0x781E) > ppu_lmuram AT>pfls5_ppu
    
    GROUP ALIGN(LCF_DCACHE_LINESIZE) BLOCK(4):
    {
        .uncached.data : {
            *(.ucdata*)
            *(.uncached.data*)
        }
        .padding ALIGN(LCF_DCACHE_LINESIZE) SIZE(2): {} = FILL(0x781E)
    } > ppu_lmuram_nc AT>pfls5_ppu
    
    GROUP (NOLOAD) BLOCK(4):
    {
        *(BSS): { *(.tls*) }
    } > ppu_lmuram
    
    GROUP (NOLOAD) ALIGN(4) BLOCK(4):
    {
        .ppu_tc_shared_memory (BSS): { * (.shared_bss_ppu_tc)}
        .uncached.bss: { * (.uncached.bss)}
    } > ppu_lmuram_nc

    # for now removed, as the current version of hal (speed) does not support sdata / sbss
    #GROUP ALIGN(LCF_DCACHE_LINESIZE) BLOCK(4):
    #{
    #    .sdata?: {}
    #} > CSM AT>PFLASH5.PPU
    
    #GROUP (NOLOAD) ALIGN(LCF_DCACHE_LINESIZE) BLOCK(4):
    #{
    #    .sbss?: {}
    #} > CSM

    GROUP (NOLOAD) BLOCK(4):
    {
        .heap? ALIGN(LCF_DCACHE_LINESIZE)
            SIZE(DEFINED _HEAPSIZE?_HEAPSIZE:0): {}
    } > ppu_csm

    GROUP BLOCK(4):
    {
        _fstack = .;
        .stack0 (NOLOAD) ALIGN(LCF_DCACHE_LINESIZE)
             SIZE(DEFINED LCF_STACKSIZE?LCF_STACKSIZE:65536): {}
        _estack = .;
             //.stack SIZE(4): {}
        .local_storage0 (NOLOAD) ALIGN(LCF_DCACHE_LINESIZE): {}
    } > ppu_csm
    
    GROUP ALIGN(LCF_DCACHE_LINESIZE) BLOCK(8):
    {
        .csm.data: {* (.csm.data) }
        .padding ALIGN(LCF_DCACHE_LINESIZE) SIZE(2): {} = FILL(0x781E)
    } = FILL(0x781E) > ppu_csm AT>pfls5_ppu

    GROUP (NOLOAD) ALIGN(LCF_DCACHE_LINESIZE) BLOCK(8):
    {
        .stu_descriptors?:{}
        .csm.bss: {* (.csm.bss) }
    } > ppu_csm 

    GROUP ALIGN(LCF_DCACHE_LINESIZE) BLOCK(8):
    {
        .vdata : {}
        # Deprecated .vecmem_data section, will be removed when all tools have
        # migrated to use ._vdata instead.
        .vecmem_data : {}
        .padding ALIGN(LCF_DCACHE_LINESIZE) SIZE(2): {} = FILL(0x781E)
    } = FILL(0x781E) > ppu_vccm AT > pfls5_ppu

    GROUP BLOCK(8):
    {
        .vbss (NOLOAD): {}

        # The vector buffer section must be adjacent to the vector stack section
        .vbuffer (NOLOAD) SIZE(DEFINED LCF_VEC_BUFFER_SIZE ? LCF_VEC_BUFFER_SIZE : 0): {}
        # The vector stack must be the last section in VCCM, since we are allocating
        # all remaining VCCM here. We cannot use the SIZE() keyword for this though:
        # instead, we explicitly define the (otherwise implicitly defined) _fvstack
        # and _evstack symbols to indicate start and end of .vstack.
        # To avoid name collision with implicitly defined symbols, we call the
        # vstack section itself ._vstack.
        _fvstack = ALIGN(8);
        _fvecstack = _fvstack;
        ._vstack (NOLOAD) SIZE(DEFINED LCF_VEC_STACKSIZE ? LCF_VEC_STACKSIZE : 8192): {}
        _evstack = ALIGN(SIZEOF(ppu_vccm)) - 8;
        _evecstack = _evstack;
    } > ppu_vccm
    

    /* Reserved memory sections for TriCore use */
    GROUP : {
        .shared_mem_ppu_dsram_local :
        {
            . = ALIGN(4);
            __DSRAM_LOCAL_START = .;
            . = . + 0x3c000; # 240K reserved as per dsram_local LENGTH
            __DSRAM_LOCAL_END = .;
        }
    } > dsram_local

    GROUP : {
        .shared_mem_ppu_dsram5 :
        {
            . = ALIGN(4);
            __DSRAM5_START = .;
            . = . + 0x3c000; # 240K reserved as per dsram5 LENGTH
            __DSRAM5_END = .;
        }
    } > dsram5

    GROUP : {
        .shared_mem_ppu_psram5 :
        {
            . = ALIGN(4);
            __PSRAM5_START = .;
            . = . + 0x10000; # 64K reserved as per psram5 LENGTH
            __PSRAM5_END = .;
        }
    } > psram5



    GROUP : {
        .shared_mem_ppu_dsram4 :
        {
            . = ALIGN(4);
            __DSRAM4_START = .;
            . = . + 0x3c000; # 240K reserved as per dsram4 LENGTH
            __DSRAM4_END = .;
        }
    } > dsram4

    GROUP : {
        .shared_mem_ppu_psram4 :
        {
            . = ALIGN(4);
            __PSRAM4_START = .;
            . = . + 0x10000; # 64K reserved as per psram4 LENGTH
            __PSRAM4_END = .;
        }
    } > psram4



    GROUP : {
        .shared_mem_ppu_dsram3 :
        {
            . = ALIGN(4);
            __DSRAM3_START = .;
            . = . + 0x3c000; # 240K reserved as per dsram3 LENGTH
            __DSRAM3_END = .;
        }
    } > dsram3

    GROUP : {
        .shared_mem_ppu_psram3 :
        {
            . = ALIGN(4);
            __PSRAM3_START = .;
            . = . + 0x10000; # 64K reserved as per psram3 LENGTH
            __PSRAM3_END = .;
        }
    } > psram3



    GROUP : {
        .shared_mem_ppu_dsram2 :
        {
            . = ALIGN(4);
            __DSRAM2_START = .;
            . = . + 0x3c000; # 240K reserved as per dsram2 LENGTH
            __DSRAM2_END = .;
        }
    } > dsram2

    GROUP : {
        .shared_mem_ppu_psram2 :
        {
            . = ALIGN(4);
            __PSRAM2_START = .;
            . = . + 0x10000; # 64K reserved as per psram2 LENGTH
            __PSRAM2_END = .;
        }
    } > psram2



    GROUP : {
        .shared_mem_ppu_dsram1 :
        {
            . = ALIGN(4);
            __DSRAM1_START = .;
            . = . + 0x3c000; # 240K reserved as per dsram1 LENGTH
            __DSRAM1_END = .;
        }
    } > dsram1

    GROUP : {
        .shared_mem_ppu_psram1 :
        {
            . = ALIGN(4);
            __PSRAM1_START = .;
            . = . + 0x10000; # 64K reserved as per psram1 LENGTH
            __PSRAM1_END = .;
        }
    } > psram1

    GROUP : {
        .shared_mem_ppu_dsram0 :
        {
            . = ALIGN(4);
            __DSRAM0_START = .;
            . = . + 0x3c000; # 240K reserved as per dsram0 LENGTH
            __DSRAM0_END = .;
        }
    } > dsram0


    
    GROUP : {
        .shared_mem_ppu_psram0 :
        {
            . = ALIGN(4);
            __PSRAM0_START = .;
            . = . + 0x10000; # 64K reserved as per psram0 LENGTH
            __PSRAM0_END = .;
        }
    } > psram0

    GROUP : {
        .shared_mem_ppu_pfls0 :
        {
            . = ALIGN(4);
            __PFLS0_START = .;
            . = . + 0x400000; # 4M reserved as per pfls0 LENGTH
            __PFLS0_END = .;
        }
    } > pfls0

    GROUP : {
        .shared_mem_ppu_pfls0_nc :
        {
            . = ALIGN(4);
            __PFLS0_NC_START = .;
            . = . + 0x400000; # 4M reserved as per pfls0_nc LENGTH
            __PFLS0_NC_END = .;
        }
    } > pfls0_nc

    GROUP : {
        .shared_mem_ppu_pfls1 :
        {
            . = ALIGN(4);
            __PFLS1_START = .;
            . = . + 0x400000; # 4M reserved as per pfls1 LENGTH
            __PFLS1_END = .;
        }
    } > pfls1

    GROUP : {
        .shared_mem_ppu_pfls1_nc :
        {
            . = ALIGN(4);
            __PFLS1_NC_START = .;
            . = . + 0x400000; # 4M reserved as per pfls1_nc LENGTH
            __PFLS1_NC_END = .;
        }
    } > pfls1_nc

    GROUP : {
        .shared_mem_ppu_pfls2 :
        {
            . = ALIGN(4);
            __PFLS2_START = .;
            . = . + 0x200000; # 2M reserved as per pfls2 LENGTH
            __PFLS2_END = .;
        }
    } > pfls2

    GROUP : {
        .shared_mem_ppu_pfls2_nc :
        {
            . = ALIGN(4);
            __PFLS2_NC_START = .;
            . = . + 0x200000; # 2M reserved as per pfls2_nc LENGTH
            __PFLS2_NC_END = .;
        }
    } > pfls2_nc

    GROUP : {
        .shared_mem_ppu_pfls3 :
        {
            . = ALIGN(4);
            __PFLS3_START = .;
            . = . + 0x400000; # 4M reserved as per pfls3 LENGTH
            __PFLS3_END = .;
        }
    } > pfls3

    GROUP : {
        .shared_mem_ppu_pfls3_nc :
        {
            . = ALIGN(4);
            __PFLS3_NC_START = .;
            . = . + 0x400000; # 4M reserved as per pfls3_nc LENGTH
            __PFLS3_NC_END = .;
        }
    } > pfls3_nc

    GROUP : {
        .shared_mem_ppu_pfls4 :
        {
            . = ALIGN(4);
            __PFLS4_START = .;
            . = . + 0x400000; # 4M reserved as per pfls4 LENGTH
            __PFLS4_END = .;
        }
    } > pfls4

    GROUP : {
        .shared_mem_ppu_pfls4_nc :
        {
            . = ALIGN(4);
            __PFLS4_NC_START = .;
            . = . + 0x400000; # 4M reserved as per pfls4_nc LENGTH
            __PFLS4_NC_END = .;
        }
    } > pfls4_nc

    GROUP : {
        .shared_mem_ppu_pfls5 :
        {
            . = ALIGN(4);
            __PFLS5_START = .;
            . = . + 0x100000; # 1M reserved as per pfls5 LENGTH
            __PFLS5_END = .;
        }
    } > pfls5

    GROUP : {
        .shared_mem_ppu_pfls5_nc :
        {
            . = ALIGN(4);
            __PFLS5_NC_START = .;
            . = . + 0x200000; # 2M reserved as per pfls5_nc LENGTH
            __PFLS5_NC_END = .;
        }
    } > pfls5_nc

    GROUP : {
        .shared_mem_ppu_ucb :
        {
            . = ALIGN(4);
            __UCB_START = .;
            . = . + 0x14000; # 80K reserved as per ucb LENGTH
            __UCB_END = .;
        }
    } > ucb

    GROUP : {
        .shared_mem_ppu_cpu0_dlmu :
        {
            . = ALIGN(4);
            __CPU0_DLMU_START = .;
            . = . + 0x80000; # 512K reserved as per cpu0_dlmu LENGTH
            __CPU0_DLMU_END = .;
        }
    } > cpu0_dlmu

    GROUP : {
        .shared_mem_ppu_cpu0_dlmu_nc :
        {
            . = ALIGN(4);
            __CPU0_DLMU_NC_START = .;
            . = . + 0x80000; # 512K reserved as per cpu0_dlmu_nc LENGTH
            __CPU0_DLMU_NC_END = .;
        }
    } > cpu0_dlmu_nc

    GROUP : {
        .shared_mem_ppu_cpu1_dlmu :
        {
            . = ALIGN(4);
            __CPU1_DLMU_START = .;
            . = . + 0x80000; # 512K reserved as per cpu1_dlmu LENGTH
            __CPU1_DLMU_END = .;
        }
    } > cpu1_dlmu

    GROUP : {
        .shared_mem_ppu_cpu1_dlmu_nc :
        {
            . = ALIGN(4);
            __CPU1_DLMU_NC_START = .;
            . = . + 0x80000; # 512K reserved as per cpu1_dlmu_nc LENGTH
            __CPU1_DLMU_NC_END = .;
        }
    } > cpu1_dlmu_nc

    GROUP : {
        .shared_mem_ppu_cpu2_dlmu :
        {
            . = ALIGN(4);
            __CPU2_DLMU_START = .;
            . = . + 0x80000; # 512K reserved as per cpu2_dlmu LENGTH
            __CPU2_DLMU_END = .;
        }
    } > cpu2_dlmu

    GROUP : {
        .shared_mem_ppu_cpu2_dlmu_nc :
        {
            . = ALIGN(4);
            __CPU2_DLMU_NC_START = .;
            . = . + 0x80000; # 512K reserved as per cpu2_dlmu_nc LENGTH
            __CPU2_DLMU_NC_END = .;
        }
    } > cpu2_dlmu_nc

    GROUP : {
        .shared_mem_ppu_cpu3_dlmu :
        {
            . = ALIGN(4);
            __CPU3_DLMU_START = .;
            . = . + 0x80000; # 512K reserved as per cpu3_dlmu LENGTH
            __CPU3_DLMU_END = .;
        }
    } > cpu3_dlmu

    GROUP : {
        .shared_mem_ppu_cpu3_dlmu_nc :
        {
            . = ALIGN(4);
            __CPU3_DLMU_NC_START = .;
            . = . + 0x80000; # 512K reserved as per cpu3_dlmu_nc LENGTH
            __CPU3_DLMU_NC_END = .;
        }
    } > cpu3_dlmu_nc

    GROUP : {
        .shared_mem_ppu_cpu4_dlmu :
        {
            . = ALIGN(4);
            __CPU4_DLMU_START = .;
            . = . + 0x80000; # 512K reserved as per cpu4_dlmu LENGTH
            __CPU4_DLMU_END = .;
        }
    } > cpu4_dlmu

    GROUP : {
        .shared_mem_ppu_cpu4_dlmu_nc :
        {
            . = ALIGN(4);
            __CPU4_DLMU_NC_START = .;
            . = . + 0x80000; # 512K reserved as per cpu4_dlmu_nc LENGTH
            __CPU4_DLMU_NC_END = .;
        }
    } > cpu4_dlmu_nc

    GROUP : {
        .shared_mem_ppu_cpu5_dlmu :
        {
            . = ALIGN(4);
            __CPU5_DLMU_START = .;
            . = . + 0x80000; # 512K reserved as per cpu5_dlmu LENGTH
            __CPU5_DLMU_END = .;
        }
    } > cpu5_dlmu

    GROUP : {
        .shared_mem_ppu_cpu5_dlmu_nc :
        {
            . = ALIGN(4);
            __CPU5_DLMU_NC_START = .;
            . = . + 0x80000; # 512K reserved as per cpu5_dlmu_nc LENGTH
            __CPU5_DLMU_NC_END = .;
        }
    } > cpu5_dlmu_nc

    GROUP : {
        .shared_mem_ppu_lmuram :
        {
            . = ALIGN(4);
            __LMURAM_START = .;
            . = . + 0x480000; # 4608K reserved as per lmuram LENGTH
            __LMURAM_END = .;
        }
    } > lmuram

    GROUP : {
        .shared_mem_ppu_lmuram_nc :
        {
            . = ALIGN(4);
            __LMURAM_NC_START = .;
            . = . + 0x480000; # 4608K reserved as per lmuram_nc LENGTH
            __LMURAM_NC_END = .;
        }
    } > lmuram_nc



}

#
# INITDATA
# The ARC does ROM-to-RAM copies.
# The INITDATA keyword is used to list the sections for ROM-to-RAM copy.
# NOTE: Do not list .vectors as it is handled by drivers/hal.
#
INITDATA  .data, .uncached.data, .vdata, .csm.data, .vecmem_data

_fstack1 = 0;
_estack1 = 0;