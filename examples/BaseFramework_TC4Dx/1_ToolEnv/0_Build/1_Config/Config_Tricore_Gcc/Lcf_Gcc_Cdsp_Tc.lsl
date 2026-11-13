/* cdsp_overlay.ld — CDSP memory and sections overlay for TC4Dx
 *
 * Usage: Pass after the main linker script on the link line (the main script must define default_ram):
 *
 *          -T Lcf_Gcc_Tricore_Tc.lsl -T Lcf_Gcc_Cdsp_Tc.lsl
 */

/* CDSP sizing symbols */
/* ------------------------------------------------------------------------------------------------------------------ */
CDSP_BREAK_SIZE = 0x400;
CDSP_CODE_SIZE  = 0x1800 * 2;   /* 2 × 6 KiB program slots */
CDSP_FLASH_BASE = 0xA03E0000;    /* Non-cached base of the CDSP image area in PFLASH */
CDSP_SECTOR_SIZE = 16K;          /* PFLASH erase granularity */

/* CDSP sections */
/* ------------------------------------------------------------------------------------------------------------------ */
SECTIONS
{
  /* CDSP software breakpoint table; not in the startup clear table, so it is not zeroed at boot. */
  .cdsp_break (NOLOAD) :
  {
    . = ALIGN(8);
    PROVIDE(__CDSP_BREAK = .);
    . += CDSP_BREAK_SIZE;
    PROVIDE(__CDSP_BREAK_END = .);
  } > default_ram

  /*
   * Shared CDSP memory section — code/data placed by the CDSP loader or linked directly by the CDSP toolchain.
   */

  /*
   * Fill-level guards: placed without an address, so they land at the current end of each PFLASH0 alias.
   * That end covers both sections linked there and load images of initialized data (AT> pfls0).
   * They must stay before .shared_cdsp_mem, which moves the pfls0 location past the reserved area.
   */
  .cdsp_guard_pfls0 (NOLOAD) : { __cdsp_pfls0_used_end = .; } > pfls0
  .cdsp_guard_pfls0_nc (NOLOAD) : { __cdsp_pfls0_nc_used_end = .; } > pfls0_nc

  /* Reserve the same physical PFLASH range used by pfls0 at its cached alias. */
  .shared_cdsp_mem (CDSP_FLASH_BASE & ~0x20000000) (NOLOAD) :
  {
    . += ALIGN(CDSP_CODE_SIZE, CDSP_SECTOR_SIZE);
  } > pfls0
}

PROVIDE(_fshared_cdsp_mem = CDSP_FLASH_BASE);
PROVIDE(_eshared_cdsp_mem = CDSP_FLASH_BASE + CDSP_CODE_SIZE);

ASSERT((CDSP_FLASH_BASE % CDSP_SECTOR_SIZE) == 0, "CDSP image area must start on a PFLASH sector boundary")
ASSERT(__cdsp_pfls0_used_end <= (CDSP_FLASH_BASE & ~0x20000000),
       "pfls0 (cached) code/const/init-data image overlaps the reserved CDSP image area")
ASSERT(__cdsp_pfls0_nc_used_end <= CDSP_FLASH_BASE,
       "pfls0_nc (non-cached) content overlaps the reserved CDSP image area")
