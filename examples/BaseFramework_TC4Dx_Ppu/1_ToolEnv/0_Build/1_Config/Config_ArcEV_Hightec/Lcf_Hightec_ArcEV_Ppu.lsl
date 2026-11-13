ENTRY(_start)

LCF_ICACHE_LINESIZE = 64;
LCF_DCACHE_LINESIZE = 64;
LCF_STACKSIZE       = 0x2000;   /* 8KB */
LCF_IVTSIZE         = 400;      /* irqs=84: (84+16)*4 = 400B */
_HEAPSIZE           = 0x2000;

MEMORY
{
    LMU9_CACHED        (rw)  : ORIGIN = 0x90880000, LENGTH = 256K   /* PPU-local data (cached address) */
    LMU9_UNCACHED      (rw)  : ORIGIN = 0xB08C0000, LENGTH = 256K   /* data shared with TriCore (non-cached address) */
    PFLASH5_PPU        (rx)  : ORIGIN = 0x81300000, LENGTH = 1024K  /* PFLASH51 reserved for PPU */
    CSM                (rwx) : ORIGIN = 0x92080000, LENGTH = 512K   /* PPU-local memory, cached; TriCore must not access at runtime */
    VCCM               (rwx) : ORIGIN = 0xC0000000, LENGTH = 128K
    LMU_NOT_ALLOCATED1 (rw)  : ORIGIN = 0xB0400000, LENGTH = 2048K
    LMU_NOT_ALLOCATED2 (rw)  : ORIGIN = 0xB0780000, LENGTH = 1024K
    PER_SPACE_NO_ALOC1 (rw)  : ORIGIN = 0xF0000000, LENGTH = 256M
}

/* MPU Permission flags */
_MPU_PERMISSION_EXECUTE = 0x1;
_MPU_PERMISSION_READ    = 0x2;
_MPU_PERMISSION_WRITE   = 0x4;

_fMPU_REGION0 = ORIGIN(LMU9_CACHED);
_eMPU_REGION0 = ORIGIN(LMU9_CACHED) + LENGTH(LMU9_CACHED);
_pMPU_REGION0 = 0x7;

_fMPU_REGION1 = ORIGIN(LMU9_UNCACHED);
_eMPU_REGION1 = ORIGIN(LMU9_UNCACHED) + LENGTH(LMU9_UNCACHED);
_pMPU_REGION1 = 0x7;

_fMPU_REGION2 = ORIGIN(PFLASH5_PPU);
_eMPU_REGION2 = ORIGIN(PFLASH5_PPU) + LENGTH(PFLASH5_PPU);
_pMPU_REGION2 = 0x7;

_fMPU_REGION3 = ORIGIN(CSM);
_eMPU_REGION3 = ORIGIN(CSM) + LENGTH(CSM);
_pMPU_REGION3 = 0x7;

_fMPU_REGION4 = ORIGIN(VCCM);
_eMPU_REGION4 = ORIGIN(VCCM) + LENGTH(VCCM);
_pMPU_REGION4 = 0x6;

_fMPU_REGION5 = ORIGIN(LMU_NOT_ALLOCATED1);
_eMPU_REGION5 = ORIGIN(LMU_NOT_ALLOCATED1) + LENGTH(LMU_NOT_ALLOCATED1);
_pMPU_REGION5 = 0x6;

_fMPU_REGION6 = ORIGIN(LMU_NOT_ALLOCATED2);
_eMPU_REGION6 = ORIGIN(LMU_NOT_ALLOCATED2) + LENGTH(LMU_NOT_ALLOCATED2);
_pMPU_REGION6 = 0x6;

_fMPU_REGION7 = ORIGIN(PER_SPACE_NO_ALOC1);
_eMPU_REGION7 = ORIGIN(PER_SPACE_NO_ALOC1) + LENGTH(PER_SPACE_NO_ALOC1);
_pMPU_REGION7 = 0x6;

_fMPU_REGION8 = 0;  _eMPU_REGION8 = 0;  _pMPU_REGION8 = 0;
_fMPU_REGION9 = 0;  _eMPU_REGION9 = 0;  _pMPU_REGION9 = 0;
_fMPU_REGION10 = 0; _eMPU_REGION10 = 0; _pMPU_REGION10 = 0;
_fMPU_REGION11 = 0; _eMPU_REGION11 = 0; _pMPU_REGION11 = 0;
_fMPU_REGION12 = 0; _eMPU_REGION12 = 0; _pMPU_REGION12 = 0;
_fMPU_REGION13 = 0; _eMPU_REGION13 = 0; _pMPU_REGION13 = 0;
_fMPU_REGION14 = 0; _eMPU_REGION14 = 0; _pMPU_REGION14 = 0;
_fMPU_REGION15 = 0; _eMPU_REGION15 = 0; _pMPU_REGION15 = 0;

SECTIONS
{
    /* Vector table address as copy table information for TriCore to initialize
     * the PPU vectors during the PPU Startup Trigger procedure.
     * !!!! Please do not modify the location of this section !!!! */
    .shareddata_ppu_if_constants ORIGIN(PFLASH5_PPU) :
    {
        __PPU_IF_CONSTANTS = .;
        LONG(LOADADDR(.vectors));                            /* sourceAddress */
        LONG((ADDR(.vectors) & 0x0FFFFFFF) | 0xB0000000);     /* destinationAddress */
        LONG(SIZEOF(.vectors));                               /* size */
        LONG(ADDR(.ppu_tc_shared_memory));                     /* ppuIpcDataPtr */
    } > PFLASH5_PPU

    /* RAM vector table requires 1024 byte alignment. It has a flash load image
     * (AT > PFLASH5_PPU) used as the copy-table source, but is not initialized
     * by the PPU startup: the TriCore copies it via .shareddata_ppu_if_constants. */
    .vectors ALIGN(1024) :
    {
        __vector_table = .;
        /* j _start */
        SHORT(0x2020);
        SHORT(0x0f80);
        LONG(_start);
        /* ARC trap_s 0 is the little-endian halfword 0x781e. */
        FILL(0x1e781e78)

        . = __vector_table + LCF_IVTSIZE - 2;
        SHORT(0x781e)
    } > CSM AT > PFLASH5_PPU

    .text ALIGN(LCF_ICACHE_LINESIZE) :
    {
        _ftextarea = .;
        KEEP(*(.text.init.enter))
        KEEP(*(.data.init.enter))
        KEEP(*(.text$crt*))
        *(.text .text.* .literal .literal.*)
        *(.init .init.* .fini .fini.*)
        _etextarea = .;
        . = ALIGN(LCF_ICACHE_LINESIZE);
    } > PFLASH5_PPU

    .rodata ALIGN(LCF_DCACHE_LINESIZE) :
    {
        *(.rodata .rodata.* .srodata .srodata.* .rdata)
        *(.interface_const)
        *(.initcall_cluster .initcall_core .destructcall_core)
        KEEP(*(.preinit_array))
        KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*)))
        KEEP(*(.init_array))
        KEEP(*(SORT_BY_INIT_PRIORITY(.fini_array.*)))
        KEEP(*(.fini_array))
        . = ALIGN(LCF_DCACHE_LINESIZE);
    } > PFLASH5_PPU

    .data ALIGN(LCF_DCACHE_LINESIZE) :
    {
        __data_start = .;
        *(.data .data.* .user_ddr)
        __data_end = .;
        . = ALIGN(LCF_DCACHE_LINESIZE);
    } > LMU9_CACHED AT > PFLASH5_PPU
    __data_source = LOADADDR(.data);
    __data_size = __data_end - __data_start;

    .uncached.data ALIGN(LCF_DCACHE_LINESIZE) :
    {
        *(.ucdata .ucdata.* .uncached.data .uncached.data.*)
        . = ALIGN(LCF_DCACHE_LINESIZE);
    } > LMU9_UNCACHED AT > PFLASH5_PPU

    .sdata ALIGN(8) :
    {
        __sdata_start = .;
        *(.sdata .sdata.* .sdata$*)
        __sdata_end = .;
    } > CSM AT > PFLASH5_PPU
    __sdata_source = LOADADDR(.sdata);
    __sdata_size = SIZEOF(.sdata);

    .sbss ALIGN(16) (NOLOAD) :
    {
        __sbss_start = .;
        *(.sbss .sbss.* .sbss$*)
        . = ALIGN(8);
    } > CSM
    __sbss_size = SIZEOF(.sbss);
    _SDA_BASE_ = 0xFFFFFFF0 & (__sbss_start + (__sdata_end - __sbss_start) / 2);

    .bss ALIGN(8) (NOLOAD) :
    {
        __bss_start = .;
        *(.bss .bss.* COMMON)
        *(.tls .tls.*)
        __bss_end = .;
        . = ALIGN(8);
    } > LMU9_CACHED
    __bss_size = __bss_end - __bss_start;

    .ppu_tc_shared_memory ALIGN(8) (NOLOAD) :
    {
        *(.shared_bss_ppu_tc)
        *(.uncached.bss .uncached.bss.*)
    } > LMU9_UNCACHED

    .heap ALIGN(LCF_DCACHE_LINESIZE) (NOLOAD) :
    {
        __start_heap = .;
        . += _HEAPSIZE;
        __end_heap = .;
    } > CSM

    .csm.data ALIGN(LCF_DCACHE_LINESIZE) :
    {
        *(.csm.data .csm.data.*)
        *(.net_const2)
        . = ALIGN(LCF_DCACHE_LINESIZE);
    } > CSM AT > PFLASH5_PPU

    .csm.bss ALIGN(LCF_DCACHE_LINESIZE) (NOLOAD) :
    {
        *(.stu_descriptors .stu_descriptors.*)
        *(.csm.bss .csm.bss.*)
    } > CSM

    .vdata ALIGN(LCF_DCACHE_LINESIZE) :
    {
        __vdata_start = .;
        *(.vdata .vdata.* ._vdata ._vdata.*)
        /* Deprecated .vecmem_data section, kept until all tools migrate to ._vdata */
        *(.vecmem_data .vecmem_data.*)
        __vdata_end = .;
        . = ALIGN(LCF_DCACHE_LINESIZE);
    } > VCCM AT > PFLASH5_PPU
    __vdata_source = LOADADDR(.vdata);
    __vdata_size = __vdata_end - __vdata_start;

    .vbss ALIGN(LCF_DCACHE_LINESIZE) (NOLOAD) :
    {
        *(.vbss .vbss.* ._vbss ._vbss.*)
        . = ALIGN(LCF_DCACHE_LINESIZE);
    } > VCCM

    /* Standard stack is part of VCCM; no dedicated vector stack is needed. */
    .stack ALIGN(LCF_DCACHE_LINESIZE) (NOLOAD) :
    {
        _fvstack = .;
        _fvecstack = .;
        _evstack = .;
        _evecstack = .;
        _fstack = .;
        . += LCF_STACKSIZE;
        _estack = .;
        __stack = .;
    } > VCCM

    __vccm = ORIGIN(VCCM);
    __vccm_size = LENGTH(VCCM);
    _fstack1 = 0;
    _estack1 = 0;

    /DISCARD/ : { *(.note .note.* .eh_frame .eh_frame.*) }
}

ASSERT(SIZEOF(.shareddata_ppu_if_constants) == 16,
       "PPU interface constants must remain 16 bytes")
ASSERT(SIZEOF(.vectors) == LCF_IVTSIZE, "PPU vector table has an invalid size")
ASSERT(_estack <= ORIGIN(VCCM) + LENGTH(VCCM), "VCCM overflow")
