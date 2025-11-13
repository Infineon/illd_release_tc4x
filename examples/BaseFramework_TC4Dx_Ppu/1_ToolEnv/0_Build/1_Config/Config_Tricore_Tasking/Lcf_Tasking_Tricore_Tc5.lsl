#define LCF_CSA5_SIZE     8k
#define LCF_USTACK5_SIZE  2k
#define LCF_ISTACK5_SIZE  1k

#define LCF_HEAP_SIZE  4k

#define LCF_PPU_FLASH_SIZE    1M
#define LCF_PPU_LMURAM_SIZE   512k
#define LCF_PPU_CSM_SIZE      512k

#define LCF_CPU0 0
#define LCF_CPU1 1
#define LCF_CPU2 2
#define LCF_CPU3 3
#define LCF_CPU4 4
#define LCF_CPU5 5

#define LCF_DEFAULT_HOST LCF_CPU5

#define LCF_DSPR5_START  0x20000000
#define LCF_DSPR5_SIZE   240K

#define LCF_CSA5_OFFSET     (LCF_DSPR5_SIZE - 1k - LCF_CSA5_SIZE)
#define LCF_ISTACK5_OFFSET  (LCF_CSA5_OFFSET - 256 - LCF_ISTACK5_SIZE)
#define LCF_USTACK5_OFFSET  (LCF_ISTACK5_OFFSET - 256 - LCF_USTACK5_SIZE)

#define LCF_HEAP5_OFFSET    (LCF_USTACK5_OFFSET - LCF_HEAP_SIZE)

#define LCF_INTVEC5_START 0x813FE000 - LCF_PPU_FLASH_SIZE

#define LCF_TRAPVEC5_START 0x81200100

#define LCF_STARTPTR_CPU0 0x80000000
#define LCF_STARTPTR_CPU1 0x80400000
#define LCF_STARTPTR_CPU2 0x80800000
#define LCF_STARTPTR_CPU3 0x80A00000
#define LCF_STARTPTR_CPU4 0x80E00000
#define LCF_STARTPTR_CPU5 0x81200000

#define LCF_STARTPTR_NC_CPU0 0xA0000000
#define LCF_STARTPTR_NC_CPU1 0xA0400000
#define LCF_STARTPTR_NC_CPU2 0xA0800000
#define LCF_STARTPTR_NC_CPU3 0xA0A00000
#define LCF_STARTPTR_NC_CPU4 0xA0E00000
#define LCF_STARTPTR_NC_CPU5 0xA1200000

#define INTTAB5     (LCF_INTVEC5_START)
#define TRAPTAB5    (LCF_TRAPVEC5_START)

#define RESET LCF_STARTPTR_NC_CPU5

#include "tc1v1_8.lsl"

// Specify a multi-core processor environment (mpe)

processor mpe
{
    derivative = tc4D;
}

derivative tc4D
{
    core tc5 
    {
        architecture = TC1V1.8;
        space_id_offset = 600;           // add 600 to all space IDs in the architecture definition
        copytable_space = vtc:linear;    // use the copy table in the virtual core for 'bss' and initialized data sections
    }

    core vtc
    {
        architecture = TC1V1.8;
        import tc5;                     // add all address spaces of core tc5 to core vtc for linking and locating
    }

    bus sri
    {
        mau = 8;
        width = 32;

        // map shared addresses one-to-one to real cores and virtual cores
        map (dest=bus:tc5:fpi_bus, src_offset=0, dest_offset=0, size=0xc0000000);
        map (dest=bus:vtc:fpi_bus, src_offset=0, dest_offset=0, size=0xc0000000);
    }

    memory dsram5 // Data Scratch Pad Ram
    {
        mau = 8;
        size = 240K;
        type = ram;
        map (dest=bus:tc5:fpi_bus, dest_offset=0xD0000000, size=240K, priority=8);
        map (dest=bus:sri, dest_offset=0x20000000, size=240K);
    }
    
    memory psram5 // Program Scratch Pad Ram
    {
        mau = 8;
        size = 64K;
        type = ram;
        map (dest=bus:tc5:fpi_bus, dest_offset=0xC0000000, size=64K, priority=8);
        map (dest=bus:sri, dest_offset=0x20100000, size=64K);
    }

    memory pfls5
    {
        mau = 8;
        size = 2M;
        type = rom;
        map     cached (dest=bus:sri, dest_offset=0x81200000,           size=2M);
        map not_cached (dest=bus:sri, dest_offset=0xa1200000, reserved, size=2M);
    }

    memory cpu5_dlmu
    {
        mau = 8;
        size = 512K;
        type = ram;
        map     cached (dest=bus:sri, dest_offset=0x90280000,           size=512K);
        map not_cached (dest=bus:sri, dest_offset=0xB0280000, reserved, size=512K);
    }

    memory lmuram
    {
        mau = 8;
        size = 5M;
        type = ram;
        map     cached (dest=bus:sri, dest_offset= 0x90400000,           size=5M);
        map not_cached (dest=bus:sri, dest_offset= 0xb0400000, reserved, size=5M);
    }

    memory ppu_csm
    {
        mau = 8;
        size = 512k;
        type = ram;
        map     cached (dest=bus:sri, dest_offset=0x92080000,           size=512k);
        map not_cached (dest=bus:sri, dest_offset=0xb2080000, reserved, size=512k);
    }

    section_setup :vtc:linear
    {
        heap "heap" (min_size = (1k), fixed, align = 8);
    }    
    
    section_setup :vtc:linear
    {
        start_address
        (
            symbol = "_START5"
        );
    }
    
    section_setup :vtc:linear
    {
        stack "ustack_tc5" (min_size = 1k, fixed, align = 8);
        stack "istack_tc5" (min_size = 1k, fixed, align = 8);

    }

    /*Section setup for the copy table*/
    section_setup :vtc:linear
    {
        copytable
        (
            align = 4,
            dest = linear,
            table
            {
                symbol = "_lc_ub_table_tc5";
                space = :tc5:linear, :tc5:abs24, :tc5:abs18, :tc5:csa;
            }
        );
    }

    /*Sections located at absolute fixed address*/

    section_layout :vtc:linear
    {
        /*Fixed memory Allocations for stack memory and CSA*/
        group (ordered)
        {
            group ustack5(align = 8, run_addr = mem:dsram5[LCF_USTACK5_OFFSET])
            {
                stack "ustack_tc5" (size = LCF_USTACK5_SIZE);
            }
            "__USTACK5":= sizeof(group:ustack5) > 0  ? "_lc_ue_ustack_tc5" : 0;
            "__USTACK5_END"="_lc_gb_ustack5";
            
            group istack5(align = 8, run_addr = mem:dsram5[LCF_ISTACK5_OFFSET])
            {
                stack "istack_tc5" (size = LCF_ISTACK5_SIZE);
            }
            "__ISTACK5":= sizeof(group:istack5) > 0  ? "_lc_ue_istack_tc5" : 0;
            "__ISTACK5_END"="_lc_gb_istack5";
            
            group (align = 64, attributes=rw, run_addr=mem:dsram5[LCF_CSA5_OFFSET]) 
                reserved "csa_tc5" (size = LCF_CSA5_SIZE);
            "__CSA5":=        "_lc_ub_csa_tc5";
            "__CSA5_END":=    "_lc_ue_csa_tc5";        
        }

        /*Fixed memory Allocations for _START*/
        group (ordered)
        {
			group  reset (run_addr=RESET)
			{
				section "reset" ( size = 0x20, attributes = rx, fill = 0x0800 )
                {
                    select ".text.start_cpu5";
                }
            }
            "__IF_CONST" := 0x80000020;
            "__START0" := LCF_STARTPTR_NC_CPU0;
            "__START1" := LCF_STARTPTR_NC_CPU1;
            "__START2" := LCF_STARTPTR_NC_CPU2;
            "__START3" := LCF_STARTPTR_NC_CPU3;
            "__START4" := LCF_STARTPTR_NC_CPU4;
            "__START5" := LCF_STARTPTR_NC_CPU5;
        }

        /*Fixed memory Allocations for Trap Vector Table*/
        group (ordered)
        {
            group trapvec_tc5 (align = 8, run_addr=LCF_TRAPVEC5_START)
            {
                section "trapvec_tc5" (size=0x100, attributes=rx, fill=0)
                {
                    select "(.text.traptab_cpu5*)";
                }
            }
            "__TRAPTAB_CPU5" := TRAPTAB5;
        }

        /*Fixed memory Allocations for Start up code*/
        group (ordered, attributes=rx)
        {
            group start_tc5 (run_addr=LCF_STARTPTR_NC_CPU5)
            {
                select "(.text.start_cpu5*)";
            }

            "__ENABLE_INDIVIDUAL_C_INIT_CPU5" := 1;
        }

        /*Fixed memory Allocations for Interrupt Vector Table*/
        group (ordered, attributes=rx)
        {
            group int_tab_tc5 (ordered)
            {
        group (run_addr=(INTTAB5)+0x0000) select ".text.inttab5.intvec.000";
        group (run_addr=(INTTAB5)+0x0020) select ".text.inttab5.intvec.001";
        group (run_addr=(INTTAB5)+0x0040) select ".text.inttab5.intvec.002";
        group (run_addr=(INTTAB5)+0x0060) select ".text.inttab5.intvec.003";
        group (run_addr=(INTTAB5)+0x0080) select ".text.inttab5.intvec.004";
        group (run_addr=(INTTAB5)+0x00A0) select ".text.inttab5.intvec.005";
        group (run_addr=(INTTAB5)+0x00C0) select ".text.inttab5.intvec.006";
        group (run_addr=(INTTAB5)+0x00E0) select ".text.inttab5.intvec.007";
        group (run_addr=(INTTAB5)+0x0100) select ".text.inttab5.intvec.008";
        group (run_addr=(INTTAB5)+0x0120) select ".text.inttab5.intvec.009";
        group (run_addr=(INTTAB5)+0x0140) select ".text.inttab5.intvec.00A";
        group (run_addr=(INTTAB5)+0x0160) select ".text.inttab5.intvec.00B";
        group (run_addr=(INTTAB5)+0x0180) select ".text.inttab5.intvec.00C";
        group (run_addr=(INTTAB5)+0x01A0) select ".text.inttab5.intvec.00D";
        group (run_addr=(INTTAB5)+0x01C0) select ".text.inttab5.intvec.00E";
        group (run_addr=(INTTAB5)+0x01E0) select ".text.inttab5.intvec.00F";
        group (run_addr=(INTTAB5)+0x0200) select ".text.inttab5.intvec.010";
        group (run_addr=(INTTAB5)+0x0220) select ".text.inttab5.intvec.011";
        group (run_addr=(INTTAB5)+0x0240) select ".text.inttab5.intvec.012";
        group (run_addr=(INTTAB5)+0x0260) select ".text.inttab5.intvec.013";
        group (run_addr=(INTTAB5)+0x0280) select ".text.inttab5.intvec.014";
        group (run_addr=(INTTAB5)+0x02A0) select ".text.inttab5.intvec.015";
        group (run_addr=(INTTAB5)+0x02C0) select ".text.inttab5.intvec.016";
        group (run_addr=(INTTAB5)+0x02E0) select ".text.inttab5.intvec.017";
        group (run_addr=(INTTAB5)+0x0300) select ".text.inttab5.intvec.018";
        group (run_addr=(INTTAB5)+0x0320) select ".text.inttab5.intvec.019";
        group (run_addr=(INTTAB5)+0x0340) select ".text.inttab5.intvec.01A";
        group (run_addr=(INTTAB5)+0x0360) select ".text.inttab5.intvec.01B";
        group (run_addr=(INTTAB5)+0x0380) select ".text.inttab5.intvec.01C";
        group (run_addr=(INTTAB5)+0x03A0) select ".text.inttab5.intvec.01D";
        group (run_addr=(INTTAB5)+0x03C0) select ".text.inttab5.intvec.01E";
        group (run_addr=(INTTAB5)+0x03E0) select ".text.inttab5.intvec.01F";
        group (run_addr=(INTTAB5)+0x0400) select ".text.inttab5.intvec.020";
        group (run_addr=(INTTAB5)+0x0420) select ".text.inttab5.intvec.021";
        group (run_addr=(INTTAB5)+0x0440) select ".text.inttab5.intvec.022";
        group (run_addr=(INTTAB5)+0x0460) select ".text.inttab5.intvec.023";
        group (run_addr=(INTTAB5)+0x0480) select ".text.inttab5.intvec.024";
        group (run_addr=(INTTAB5)+0x04A0) select ".text.inttab5.intvec.025";
        group (run_addr=(INTTAB5)+0x04C0) select ".text.inttab5.intvec.026";
        group (run_addr=(INTTAB5)+0x04E0) select ".text.inttab5.intvec.027";
        group (run_addr=(INTTAB5)+0x0500) select ".text.inttab5.intvec.028";
        group (run_addr=(INTTAB5)+0x0520) select ".text.inttab5.intvec.029";
        group (run_addr=(INTTAB5)+0x0540) select ".text.inttab5.intvec.02A";
        group (run_addr=(INTTAB5)+0x0560) select ".text.inttab5.intvec.02B";
        group (run_addr=(INTTAB5)+0x0580) select ".text.inttab5.intvec.02C";
        group (run_addr=(INTTAB5)+0x05A0) select ".text.inttab5.intvec.02D";
        group (run_addr=(INTTAB5)+0x05C0) select ".text.inttab5.intvec.02E";
        group (run_addr=(INTTAB5)+0x05E0) select ".text.inttab5.intvec.02F";
        group (run_addr=(INTTAB5)+0x0600) select ".text.inttab5.intvec.030";
        group (run_addr=(INTTAB5)+0x0620) select ".text.inttab5.intvec.031";
        group (run_addr=(INTTAB5)+0x0640) select ".text.inttab5.intvec.032";
        group (run_addr=(INTTAB5)+0x0660) select ".text.inttab5.intvec.033";
        group (run_addr=(INTTAB5)+0x0680) select ".text.inttab5.intvec.034";
        group (run_addr=(INTTAB5)+0x06A0) select ".text.inttab5.intvec.035";
        group (run_addr=(INTTAB5)+0x06C0) select ".text.inttab5.intvec.036";
        group (run_addr=(INTTAB5)+0x06E0) select ".text.inttab5.intvec.037";
        group (run_addr=(INTTAB5)+0x0700) select ".text.inttab5.intvec.038";
        group (run_addr=(INTTAB5)+0x0720) select ".text.inttab5.intvec.039";
        group (run_addr=(INTTAB5)+0x0740) select ".text.inttab5.intvec.03A";
        group (run_addr=(INTTAB5)+0x0760) select ".text.inttab5.intvec.03B";
        group (run_addr=(INTTAB5)+0x0780) select ".text.inttab5.intvec.03C";
        group (run_addr=(INTTAB5)+0x07A0) select ".text.inttab5.intvec.03D";
        group (run_addr=(INTTAB5)+0x07C0) select ".text.inttab5.intvec.03E";
        group (run_addr=(INTTAB5)+0x07E0) select ".text.inttab5.intvec.03F";
        group (run_addr=(INTTAB5)+0x0800) select ".text.inttab5.intvec.040";
        group (run_addr=(INTTAB5)+0x0820) select ".text.inttab5.intvec.041";
        group (run_addr=(INTTAB5)+0x0840) select ".text.inttab5.intvec.042";
        group (run_addr=(INTTAB5)+0x0860) select ".text.inttab5.intvec.043";
        group (run_addr=(INTTAB5)+0x0880) select ".text.inttab5.intvec.044";
        group (run_addr=(INTTAB5)+0x08A0) select ".text.inttab5.intvec.045";
        group (run_addr=(INTTAB5)+0x08C0) select ".text.inttab5.intvec.046";
        group (run_addr=(INTTAB5)+0x08E0) select ".text.inttab5.intvec.047";
        group (run_addr=(INTTAB5)+0x0900) select ".text.inttab5.intvec.048";
        group (run_addr=(INTTAB5)+0x0920) select ".text.inttab5.intvec.049";
        group (run_addr=(INTTAB5)+0x0940) select ".text.inttab5.intvec.04A";
        group (run_addr=(INTTAB5)+0x0960) select ".text.inttab5.intvec.04B";
        group (run_addr=(INTTAB5)+0x0980) select ".text.inttab5.intvec.04C";
        group (run_addr=(INTTAB5)+0x09A0) select ".text.inttab5.intvec.04D";
        group (run_addr=(INTTAB5)+0x09C0) select ".text.inttab5.intvec.04E";
        group (run_addr=(INTTAB5)+0x09E0) select ".text.inttab5.intvec.04F";
        group (run_addr=(INTTAB5)+0x0A00) select ".text.inttab5.intvec.050";
        group (run_addr=(INTTAB5)+0x0A20) select ".text.inttab5.intvec.051";
        group (run_addr=(INTTAB5)+0x0A40) select ".text.inttab5.intvec.052";
        group (run_addr=(INTTAB5)+0x0A60) select ".text.inttab5.intvec.053";
        group (run_addr=(INTTAB5)+0x0A80) select ".text.inttab5.intvec.054";
        group (run_addr=(INTTAB5)+0x0AA0) select ".text.inttab5.intvec.055";
        group (run_addr=(INTTAB5)+0x0AC0) select ".text.inttab5.intvec.056";
        group (run_addr=(INTTAB5)+0x0AE0) select ".text.inttab5.intvec.057";
        group (run_addr=(INTTAB5)+0x0B00) select ".text.inttab5.intvec.058";
        group (run_addr=(INTTAB5)+0x0B20) select ".text.inttab5.intvec.059";
        group (run_addr=(INTTAB5)+0x0B40) select ".text.inttab5.intvec.05A";
        group (run_addr=(INTTAB5)+0x0B60) select ".text.inttab5.intvec.05B";
        group (run_addr=(INTTAB5)+0x0B80) select ".text.inttab5.intvec.05C";
        group (run_addr=(INTTAB5)+0x0BA0) select ".text.inttab5.intvec.05D";
        group (run_addr=(INTTAB5)+0x0BC0) select ".text.inttab5.intvec.05E";
        group (run_addr=(INTTAB5)+0x0BE0) select ".text.inttab5.intvec.05F";
        group (run_addr=(INTTAB5)+0x0C00) select ".text.inttab5.intvec.060";
        group (run_addr=(INTTAB5)+0x0C20) select ".text.inttab5.intvec.061";
        group (run_addr=(INTTAB5)+0x0C40) select ".text.inttab5.intvec.062";
        group (run_addr=(INTTAB5)+0x0C60) select ".text.inttab5.intvec.063";
        group (run_addr=(INTTAB5)+0x0C80) select ".text.inttab5.intvec.064";
        group (run_addr=(INTTAB5)+0x0CA0) select ".text.inttab5.intvec.065";
        group (run_addr=(INTTAB5)+0x0CC0) select ".text.inttab5.intvec.066";
        group (run_addr=(INTTAB5)+0x0CE0) select ".text.inttab5.intvec.067";
        group (run_addr=(INTTAB5)+0x0D00) select ".text.inttab5.intvec.068";
        group (run_addr=(INTTAB5)+0x0D20) select ".text.inttab5.intvec.069";
        group (run_addr=(INTTAB5)+0x0D40) select ".text.inttab5.intvec.06A";
        group (run_addr=(INTTAB5)+0x0D60) select ".text.inttab5.intvec.06B";
        group (run_addr=(INTTAB5)+0x0D80) select ".text.inttab5.intvec.06C";
        group (run_addr=(INTTAB5)+0x0DA0) select ".text.inttab5.intvec.06D";
        group (run_addr=(INTTAB5)+0x0DC0) select ".text.inttab5.intvec.06E";
        group (run_addr=(INTTAB5)+0x0DE0) select ".text.inttab5.intvec.06F";
        group (run_addr=(INTTAB5)+0x0E00) select ".text.inttab5.intvec.070";
        group (run_addr=(INTTAB5)+0x0E20) select ".text.inttab5.intvec.071";
        group (run_addr=(INTTAB5)+0x0E40) select ".text.inttab5.intvec.072";
        group (run_addr=(INTTAB5)+0x0E60) select ".text.inttab5.intvec.073";
        group (run_addr=(INTTAB5)+0x0E80) select ".text.inttab5.intvec.074";
        group (run_addr=(INTTAB5)+0x0EA0) select ".text.inttab5.intvec.075";
        group (run_addr=(INTTAB5)+0x0EC0) select ".text.inttab5.intvec.076";
        group (run_addr=(INTTAB5)+0x0EE0) select ".text.inttab5.intvec.077";
        group (run_addr=(INTTAB5)+0x0F00) select ".text.inttab5.intvec.078";
        group (run_addr=(INTTAB5)+0x0F20) select ".text.inttab5.intvec.079";
        group (run_addr=(INTTAB5)+0x0F40) select ".text.inttab5.intvec.07A";
        group (run_addr=(INTTAB5)+0x0F60) select ".text.inttab5.intvec.07B";
        group (run_addr=(INTTAB5)+0x0F80) select ".text.inttab5.intvec.07C";
        group (run_addr=(INTTAB5)+0x0FA0) select ".text.inttab5.intvec.07D";
        group (run_addr=(INTTAB5)+0x0FC0) select ".text.inttab5.intvec.07E";
        group (run_addr=(INTTAB5)+0x0FE0) select ".text.inttab5.intvec.07F";
        group (run_addr=(INTTAB5)+0x1000) select ".text.inttab5.intvec.080";
        group (run_addr=(INTTAB5)+0x1020) select ".text.inttab5.intvec.081";
        group (run_addr=(INTTAB5)+0x1040) select ".text.inttab5.intvec.082";
        group (run_addr=(INTTAB5)+0x1060) select ".text.inttab5.intvec.083";
        group (run_addr=(INTTAB5)+0x1080) select ".text.inttab5.intvec.084";
        group (run_addr=(INTTAB5)+0x10A0) select ".text.inttab5.intvec.085";
        group (run_addr=(INTTAB5)+0x10C0) select ".text.inttab5.intvec.086";
        group (run_addr=(INTTAB5)+0x10E0) select ".text.inttab5.intvec.087";
        group (run_addr=(INTTAB5)+0x1100) select ".text.inttab5.intvec.088";
        group (run_addr=(INTTAB5)+0x1120) select ".text.inttab5.intvec.089";
        group (run_addr=(INTTAB5)+0x1140) select ".text.inttab5.intvec.08A";
        group (run_addr=(INTTAB5)+0x1160) select ".text.inttab5.intvec.08B";
        group (run_addr=(INTTAB5)+0x1180) select ".text.inttab5.intvec.08C";
        group (run_addr=(INTTAB5)+0x11A0) select ".text.inttab5.intvec.08D";
        group (run_addr=(INTTAB5)+0x11C0) select ".text.inttab5.intvec.08E";
        group (run_addr=(INTTAB5)+0x11E0) select ".text.inttab5.intvec.08F";
        group (run_addr=(INTTAB5)+0x1200) select ".text.inttab5.intvec.090";
        group (run_addr=(INTTAB5)+0x1220) select ".text.inttab5.intvec.091";
        group (run_addr=(INTTAB5)+0x1240) select ".text.inttab5.intvec.092";
        group (run_addr=(INTTAB5)+0x1260) select ".text.inttab5.intvec.093";
        group (run_addr=(INTTAB5)+0x1280) select ".text.inttab5.intvec.094";
        group (run_addr=(INTTAB5)+0x12A0) select ".text.inttab5.intvec.095";
        group (run_addr=(INTTAB5)+0x12C0) select ".text.inttab5.intvec.096";
        group (run_addr=(INTTAB5)+0x12E0) select ".text.inttab5.intvec.097";
        group (run_addr=(INTTAB5)+0x1300) select ".text.inttab5.intvec.098";
        group (run_addr=(INTTAB5)+0x1320) select ".text.inttab5.intvec.099";
        group (run_addr=(INTTAB5)+0x1340) select ".text.inttab5.intvec.09A";
        group (run_addr=(INTTAB5)+0x1360) select ".text.inttab5.intvec.09B";
        group (run_addr=(INTTAB5)+0x1380) select ".text.inttab5.intvec.09C";
        group (run_addr=(INTTAB5)+0x13A0) select ".text.inttab5.intvec.09D";
        group (run_addr=(INTTAB5)+0x13C0) select ".text.inttab5.intvec.09E";
        group (run_addr=(INTTAB5)+0x13E0) select ".text.inttab5.intvec.09F";
        group (run_addr=(INTTAB5)+0x1400) select ".text.inttab5.intvec.0A0";
        group (run_addr=(INTTAB5)+0x1420) select ".text.inttab5.intvec.0A1";
        group (run_addr=(INTTAB5)+0x1440) select ".text.inttab5.intvec.0A2";
        group (run_addr=(INTTAB5)+0x1460) select ".text.inttab5.intvec.0A3";
        group (run_addr=(INTTAB5)+0x1480) select ".text.inttab5.intvec.0A4";
        group (run_addr=(INTTAB5)+0x14A0) select ".text.inttab5.intvec.0A5";
        group (run_addr=(INTTAB5)+0x14C0) select ".text.inttab5.intvec.0A6";
        group (run_addr=(INTTAB5)+0x14E0) select ".text.inttab5.intvec.0A7";
        group (run_addr=(INTTAB5)+0x1500) select ".text.inttab5.intvec.0A8";
        group (run_addr=(INTTAB5)+0x1520) select ".text.inttab5.intvec.0A9";
        group (run_addr=(INTTAB5)+0x1540) select ".text.inttab5.intvec.0AA";
        group (run_addr=(INTTAB5)+0x1560) select ".text.inttab5.intvec.0AB";
        group (run_addr=(INTTAB5)+0x1580) select ".text.inttab5.intvec.0AC";
        group (run_addr=(INTTAB5)+0x15A0) select ".text.inttab5.intvec.0AD";
        group (run_addr=(INTTAB5)+0x15C0) select ".text.inttab5.intvec.0AE";
        group (run_addr=(INTTAB5)+0x15E0) select ".text.inttab5.intvec.0AF";
        group (run_addr=(INTTAB5)+0x1600) select ".text.inttab5.intvec.0B0";
        group (run_addr=(INTTAB5)+0x1620) select ".text.inttab5.intvec.0B1";
        group (run_addr=(INTTAB5)+0x1640) select ".text.inttab5.intvec.0B2";
        group (run_addr=(INTTAB5)+0x1660) select ".text.inttab5.intvec.0B3";
        group (run_addr=(INTTAB5)+0x1680) select ".text.inttab5.intvec.0B4";
        group (run_addr=(INTTAB5)+0x16A0) select ".text.inttab5.intvec.0B5";
        group (run_addr=(INTTAB5)+0x16C0) select ".text.inttab5.intvec.0B6";
        group (run_addr=(INTTAB5)+0x16E0) select ".text.inttab5.intvec.0B7";
        group (run_addr=(INTTAB5)+0x1700) select ".text.inttab5.intvec.0B8";
        group (run_addr=(INTTAB5)+0x1720) select ".text.inttab5.intvec.0B9";
        group (run_addr=(INTTAB5)+0x1740) select ".text.inttab5.intvec.0BA";
        group (run_addr=(INTTAB5)+0x1760) select ".text.inttab5.intvec.0BB";
        group (run_addr=(INTTAB5)+0x1780) select ".text.inttab5.intvec.0BC";
        group (run_addr=(INTTAB5)+0x17A0) select ".text.inttab5.intvec.0BD";
        group (run_addr=(INTTAB5)+0x17C0) select ".text.inttab5.intvec.0BE";
        group (run_addr=(INTTAB5)+0x17E0) select ".text.inttab5.intvec.0BF";
        group (run_addr=(INTTAB5)+0x1800) select ".text.inttab5.intvec.0C0";
        group (run_addr=(INTTAB5)+0x1820) select ".text.inttab5.intvec.0C1";
        group (run_addr=(INTTAB5)+0x1840) select ".text.inttab5.intvec.0C2";
        group (run_addr=(INTTAB5)+0x1860) select ".text.inttab5.intvec.0C3";
        group (run_addr=(INTTAB5)+0x1880) select ".text.inttab5.intvec.0C4";
        group (run_addr=(INTTAB5)+0x18A0) select ".text.inttab5.intvec.0C5";
        group (run_addr=(INTTAB5)+0x18C0) select ".text.inttab5.intvec.0C6";
        group (run_addr=(INTTAB5)+0x18E0) select ".text.inttab5.intvec.0C7";
        group (run_addr=(INTTAB5)+0x1900) select ".text.inttab5.intvec.0C8";
        group (run_addr=(INTTAB5)+0x1920) select ".text.inttab5.intvec.0C9";
        group (run_addr=(INTTAB5)+0x1940) select ".text.inttab5.intvec.0CA";
        group (run_addr=(INTTAB5)+0x1960) select ".text.inttab5.intvec.0CB";
        group (run_addr=(INTTAB5)+0x1980) select ".text.inttab5.intvec.0CC";
        group (run_addr=(INTTAB5)+0x19A0) select ".text.inttab5.intvec.0CD";
        group (run_addr=(INTTAB5)+0x19C0) select ".text.inttab5.intvec.0CE";
        group (run_addr=(INTTAB5)+0x19E0) select ".text.inttab5.intvec.0CF";
        group (run_addr=(INTTAB5)+0x1A00) select ".text.inttab5.intvec.0D0";
        group (run_addr=(INTTAB5)+0x1A20) select ".text.inttab5.intvec.0D1";
        group (run_addr=(INTTAB5)+0x1A40) select ".text.inttab5.intvec.0D2";
        group (run_addr=(INTTAB5)+0x1A60) select ".text.inttab5.intvec.0D3";
        group (run_addr=(INTTAB5)+0x1A80) select ".text.inttab5.intvec.0D4";
        group (run_addr=(INTTAB5)+0x1AA0) select ".text.inttab5.intvec.0D5";
        group (run_addr=(INTTAB5)+0x1AC0) select ".text.inttab5.intvec.0D6";
        group (run_addr=(INTTAB5)+0x1AE0) select ".text.inttab5.intvec.0D7";
        group (run_addr=(INTTAB5)+0x1B00) select ".text.inttab5.intvec.0D8";
        group (run_addr=(INTTAB5)+0x1B20) select ".text.inttab5.intvec.0D9";
        group (run_addr=(INTTAB5)+0x1B40) select ".text.inttab5.intvec.0DA";
        group (run_addr=(INTTAB5)+0x1B60) select ".text.inttab5.intvec.0DB";
        group (run_addr=(INTTAB5)+0x1B80) select ".text.inttab5.intvec.0DC";
        group (run_addr=(INTTAB5)+0x1BA0) select ".text.inttab5.intvec.0DD";
        group (run_addr=(INTTAB5)+0x1BC0) select ".text.inttab5.intvec.0DE";
        group (run_addr=(INTTAB5)+0x1BE0) select ".text.inttab5.intvec.0DF";
        group (run_addr=(INTTAB5)+0x1C00) select ".text.inttab5.intvec.0E0";
        group (run_addr=(INTTAB5)+0x1C20) select ".text.inttab5.intvec.0E1";
        group (run_addr=(INTTAB5)+0x1C40) select ".text.inttab5.intvec.0E2";
        group (run_addr=(INTTAB5)+0x1C60) select ".text.inttab5.intvec.0E3";
        group (run_addr=(INTTAB5)+0x1C80) select ".text.inttab5.intvec.0E4";
        group (run_addr=(INTTAB5)+0x1CA0) select ".text.inttab5.intvec.0E5";
        group (run_addr=(INTTAB5)+0x1CC0) select ".text.inttab5.intvec.0E6";
        group (run_addr=(INTTAB5)+0x1CE0) select ".text.inttab5.intvec.0E7";
        group (run_addr=(INTTAB5)+0x1D00) select ".text.inttab5.intvec.0E8";
        group (run_addr=(INTTAB5)+0x1D20) select ".text.inttab5.intvec.0E9";
        group (run_addr=(INTTAB5)+0x1D40) select ".text.inttab5.intvec.0EA";
        group (run_addr=(INTTAB5)+0x1D60) select ".text.inttab5.intvec.0EB";
        group (run_addr=(INTTAB5)+0x1D80) select ".text.inttab5.intvec.0EC";
        group (run_addr=(INTTAB5)+0x1DA0) select ".text.inttab5.intvec.0ED";
        group (run_addr=(INTTAB5)+0x1DC0) select ".text.inttab5.intvec.0EE";
        group (run_addr=(INTTAB5)+0x1DE0) select ".text.inttab5.intvec.0EF";
        group (run_addr=(INTTAB5)+0x1E00) select ".text.inttab5.intvec.0F0";
        group (run_addr=(INTTAB5)+0x1E20) select ".text.inttab5.intvec.0F1";
        group (run_addr=(INTTAB5)+0x1E40) select ".text.inttab5.intvec.0F2";
        group (run_addr=(INTTAB5)+0x1E60) select ".text.inttab5.intvec.0F3";
        group (run_addr=(INTTAB5)+0x1E80) select ".text.inttab5.intvec.0F4";
        group (run_addr=(INTTAB5)+0x1EA0) select ".text.inttab5.intvec.0F5";
        group (run_addr=(INTTAB5)+0x1EC0) select ".text.inttab5.intvec.0F6";
        group (run_addr=(INTTAB5)+0x1EE0) select ".text.inttab5.intvec.0F7";
        group (run_addr=(INTTAB5)+0x1F00) select ".text.inttab5.intvec.0F8";
        group (run_addr=(INTTAB5)+0x1F20) select ".text.inttab5.intvec.0F9";
        group (run_addr=(INTTAB5)+0x1F40) select ".text.inttab5.intvec.0FA";
        group (run_addr=(INTTAB5)+0x1F60) select ".text.inttab5.intvec.0FB";
        group (run_addr=(INTTAB5)+0x1F80) select ".text.inttab5.intvec.0FC";
        group (run_addr=(INTTAB5)+0x1FA0) select ".text.inttab5.intvec.0FD";
        group (run_addr=(INTTAB5)+0x1FC0) select ".text.inttab5.intvec.0FE";
        group (run_addr=(INTTAB5)+0x1FE0) select ".text.inttab5.intvec.0FF";
        group (run_addr=(INTTAB5)+0x0000) select ".text.inttab5.intvec8.000";
        group (run_addr=(INTTAB5)+0x0008) select ".text.inttab5.intvec8.001";
        group (run_addr=(INTTAB5)+0x0010) select ".text.inttab5.intvec8.002";
        group (run_addr=(INTTAB5)+0x0018) select ".text.inttab5.intvec8.003";
        group (run_addr=(INTTAB5)+0x0020) select ".text.inttab5.intvec8.004";
        group (run_addr=(INTTAB5)+0x0028) select ".text.inttab5.intvec8.005";
        group (run_addr=(INTTAB5)+0x0030) select ".text.inttab5.intvec8.006";
        group (run_addr=(INTTAB5)+0x0038) select ".text.inttab5.intvec8.007";
        group (run_addr=(INTTAB5)+0x0040) select ".text.inttab5.intvec8.008";
        group (run_addr=(INTTAB5)+0x0048) select ".text.inttab5.intvec8.009";
        group (run_addr=(INTTAB5)+0x0050) select ".text.inttab5.intvec8.00A";
        group (run_addr=(INTTAB5)+0x0058) select ".text.inttab5.intvec8.00B";
        group (run_addr=(INTTAB5)+0x0060) select ".text.inttab5.intvec8.00C";
        group (run_addr=(INTTAB5)+0x0068) select ".text.inttab5.intvec8.00D";
        group (run_addr=(INTTAB5)+0x0070) select ".text.inttab5.intvec8.00E";
        group (run_addr=(INTTAB5)+0x0078) select ".text.inttab5.intvec8.00F";
        group (run_addr=(INTTAB5)+0x0080) select ".text.inttab5.intvec8.010";
        group (run_addr=(INTTAB5)+0x0088) select ".text.inttab5.intvec8.011";
        group (run_addr=(INTTAB5)+0x0090) select ".text.inttab5.intvec8.012";
        group (run_addr=(INTTAB5)+0x0098) select ".text.inttab5.intvec8.013";
        group (run_addr=(INTTAB5)+0x00A0) select ".text.inttab5.intvec8.014";
        group (run_addr=(INTTAB5)+0x00A8) select ".text.inttab5.intvec8.015";
        group (run_addr=(INTTAB5)+0x00B0) select ".text.inttab5.intvec8.016";
        group (run_addr=(INTTAB5)+0x00B8) select ".text.inttab5.intvec8.017";
        group (run_addr=(INTTAB5)+0x00C0) select ".text.inttab5.intvec8.018";
        group (run_addr=(INTTAB5)+0x00C8) select ".text.inttab5.intvec8.019";
        group (run_addr=(INTTAB5)+0x00D0) select ".text.inttab5.intvec8.01A";
        group (run_addr=(INTTAB5)+0x00D8) select ".text.inttab5.intvec8.01B";
        group (run_addr=(INTTAB5)+0x00E0) select ".text.inttab5.intvec8.01C";
        group (run_addr=(INTTAB5)+0x00E8) select ".text.inttab5.intvec8.01D";
        group (run_addr=(INTTAB5)+0x00F0) select ".text.inttab5.intvec8.01E";
        group (run_addr=(INTTAB5)+0x00F8) select ".text.inttab5.intvec8.01F";
        group (run_addr=(INTTAB5)+0x0100) select ".text.inttab5.intvec8.020";
        group (run_addr=(INTTAB5)+0x0108) select ".text.inttab5.intvec8.021";
        group (run_addr=(INTTAB5)+0x0110) select ".text.inttab5.intvec8.022";
        group (run_addr=(INTTAB5)+0x0118) select ".text.inttab5.intvec8.023";
        group (run_addr=(INTTAB5)+0x0120) select ".text.inttab5.intvec8.024";
        group (run_addr=(INTTAB5)+0x0128) select ".text.inttab5.intvec8.025";
        group (run_addr=(INTTAB5)+0x0130) select ".text.inttab5.intvec8.026";
        group (run_addr=(INTTAB5)+0x0138) select ".text.inttab5.intvec8.027";
        group (run_addr=(INTTAB5)+0x0140) select ".text.inttab5.intvec8.028";
        group (run_addr=(INTTAB5)+0x0148) select ".text.inttab5.intvec8.029";
        group (run_addr=(INTTAB5)+0x0150) select ".text.inttab5.intvec8.02A";
        group (run_addr=(INTTAB5)+0x0158) select ".text.inttab5.intvec8.02B";
        group (run_addr=(INTTAB5)+0x0160) select ".text.inttab5.intvec8.02C";
        group (run_addr=(INTTAB5)+0x0168) select ".text.inttab5.intvec8.02D";
        group (run_addr=(INTTAB5)+0x0170) select ".text.inttab5.intvec8.02E";
        group (run_addr=(INTTAB5)+0x0178) select ".text.inttab5.intvec8.02F";
        group (run_addr=(INTTAB5)+0x0180) select ".text.inttab5.intvec8.030";
        group (run_addr=(INTTAB5)+0x0188) select ".text.inttab5.intvec8.031";
        group (run_addr=(INTTAB5)+0x0190) select ".text.inttab5.intvec8.032";
        group (run_addr=(INTTAB5)+0x0198) select ".text.inttab5.intvec8.033";
        group (run_addr=(INTTAB5)+0x01A0) select ".text.inttab5.intvec8.034";
        group (run_addr=(INTTAB5)+0x01A8) select ".text.inttab5.intvec8.035";
        group (run_addr=(INTTAB5)+0x01B0) select ".text.inttab5.intvec8.036";
        group (run_addr=(INTTAB5)+0x01B8) select ".text.inttab5.intvec8.037";
        group (run_addr=(INTTAB5)+0x01C0) select ".text.inttab5.intvec8.038";
        group (run_addr=(INTTAB5)+0x01C8) select ".text.inttab5.intvec8.039";
        group (run_addr=(INTTAB5)+0x01D0) select ".text.inttab5.intvec8.03A";
        group (run_addr=(INTTAB5)+0x01D8) select ".text.inttab5.intvec8.03B";
        group (run_addr=(INTTAB5)+0x01E0) select ".text.inttab5.intvec8.03C";
        group (run_addr=(INTTAB5)+0x01E8) select ".text.inttab5.intvec8.03D";
        group (run_addr=(INTTAB5)+0x01F0) select ".text.inttab5.intvec8.03E";
        group (run_addr=(INTTAB5)+0x01F8) select ".text.inttab5.intvec8.03F";
        group (run_addr=(INTTAB5)+0x0200) select ".text.inttab5.intvec8.040";
        group (run_addr=(INTTAB5)+0x0208) select ".text.inttab5.intvec8.041";
        group (run_addr=(INTTAB5)+0x0210) select ".text.inttab5.intvec8.042";
        group (run_addr=(INTTAB5)+0x0218) select ".text.inttab5.intvec8.043";
        group (run_addr=(INTTAB5)+0x0220) select ".text.inttab5.intvec8.044";
        group (run_addr=(INTTAB5)+0x0228) select ".text.inttab5.intvec8.045";
        group (run_addr=(INTTAB5)+0x0230) select ".text.inttab5.intvec8.046";
        group (run_addr=(INTTAB5)+0x0238) select ".text.inttab5.intvec8.047";
        group (run_addr=(INTTAB5)+0x0240) select ".text.inttab5.intvec8.048";
        group (run_addr=(INTTAB5)+0x0248) select ".text.inttab5.intvec8.049";
        group (run_addr=(INTTAB5)+0x0250) select ".text.inttab5.intvec8.04A";
        group (run_addr=(INTTAB5)+0x0258) select ".text.inttab5.intvec8.04B";
        group (run_addr=(INTTAB5)+0x0260) select ".text.inttab5.intvec8.04C";
        group (run_addr=(INTTAB5)+0x0268) select ".text.inttab5.intvec8.04D";
        group (run_addr=(INTTAB5)+0x0270) select ".text.inttab5.intvec8.04E";
        group (run_addr=(INTTAB5)+0x0278) select ".text.inttab5.intvec8.04F";
        group (run_addr=(INTTAB5)+0x0280) select ".text.inttab5.intvec8.050";
        group (run_addr=(INTTAB5)+0x0288) select ".text.inttab5.intvec8.051";
        group (run_addr=(INTTAB5)+0x0290) select ".text.inttab5.intvec8.052";
        group (run_addr=(INTTAB5)+0x0298) select ".text.inttab5.intvec8.053";
        group (run_addr=(INTTAB5)+0x02A0) select ".text.inttab5.intvec8.054";
        group (run_addr=(INTTAB5)+0x02A8) select ".text.inttab5.intvec8.055";
        group (run_addr=(INTTAB5)+0x02B0) select ".text.inttab5.intvec8.056";
        group (run_addr=(INTTAB5)+0x02B8) select ".text.inttab5.intvec8.057";
        group (run_addr=(INTTAB5)+0x02C0) select ".text.inttab5.intvec8.058";
        group (run_addr=(INTTAB5)+0x02C8) select ".text.inttab5.intvec8.059";
        group (run_addr=(INTTAB5)+0x02D0) select ".text.inttab5.intvec8.05A";
        group (run_addr=(INTTAB5)+0x02D8) select ".text.inttab5.intvec8.05B";
        group (run_addr=(INTTAB5)+0x02E0) select ".text.inttab5.intvec8.05C";
        group (run_addr=(INTTAB5)+0x02E8) select ".text.inttab5.intvec8.05D";
        group (run_addr=(INTTAB5)+0x02F0) select ".text.inttab5.intvec8.05E";
        group (run_addr=(INTTAB5)+0x02F8) select ".text.inttab5.intvec8.05F";
        group (run_addr=(INTTAB5)+0x0300) select ".text.inttab5.intvec8.060";
        group (run_addr=(INTTAB5)+0x0308) select ".text.inttab5.intvec8.061";
        group (run_addr=(INTTAB5)+0x0310) select ".text.inttab5.intvec8.062";
        group (run_addr=(INTTAB5)+0x0318) select ".text.inttab5.intvec8.063";
        group (run_addr=(INTTAB5)+0x0320) select ".text.inttab5.intvec8.064";
        group (run_addr=(INTTAB5)+0x0328) select ".text.inttab5.intvec8.065";
        group (run_addr=(INTTAB5)+0x0330) select ".text.inttab5.intvec8.066";
        group (run_addr=(INTTAB5)+0x0338) select ".text.inttab5.intvec8.067";
        group (run_addr=(INTTAB5)+0x0340) select ".text.inttab5.intvec8.068";
        group (run_addr=(INTTAB5)+0x0348) select ".text.inttab5.intvec8.069";
        group (run_addr=(INTTAB5)+0x0350) select ".text.inttab5.intvec8.06A";
        group (run_addr=(INTTAB5)+0x0358) select ".text.inttab5.intvec8.06B";
        group (run_addr=(INTTAB5)+0x0360) select ".text.inttab5.intvec8.06C";
        group (run_addr=(INTTAB5)+0x0368) select ".text.inttab5.intvec8.06D";
        group (run_addr=(INTTAB5)+0x0370) select ".text.inttab5.intvec8.06E";
        group (run_addr=(INTTAB5)+0x0378) select ".text.inttab5.intvec8.06F";
        group (run_addr=(INTTAB5)+0x0380) select ".text.inttab5.intvec8.070";
        group (run_addr=(INTTAB5)+0x0388) select ".text.inttab5.intvec8.071";
        group (run_addr=(INTTAB5)+0x0390) select ".text.inttab5.intvec8.072";
        group (run_addr=(INTTAB5)+0x0398) select ".text.inttab5.intvec8.073";
        group (run_addr=(INTTAB5)+0x03A0) select ".text.inttab5.intvec8.074";
        group (run_addr=(INTTAB5)+0x03A8) select ".text.inttab5.intvec8.075";
        group (run_addr=(INTTAB5)+0x03B0) select ".text.inttab5.intvec8.076";
        group (run_addr=(INTTAB5)+0x03B8) select ".text.inttab5.intvec8.077";
        group (run_addr=(INTTAB5)+0x03C0) select ".text.inttab5.intvec8.078";
        group (run_addr=(INTTAB5)+0x03C8) select ".text.inttab5.intvec8.079";
        group (run_addr=(INTTAB5)+0x03D0) select ".text.inttab5.intvec8.07A";
        group (run_addr=(INTTAB5)+0x03D8) select ".text.inttab5.intvec8.07B";
        group (run_addr=(INTTAB5)+0x03E0) select ".text.inttab5.intvec8.07C";
        group (run_addr=(INTTAB5)+0x03E8) select ".text.inttab5.intvec8.07D";
        group (run_addr=(INTTAB5)+0x03F0) select ".text.inttab5.intvec8.07E";
        group (run_addr=(INTTAB5)+0x03F8) select ".text.inttab5.intvec8.07F";
        group (run_addr=(INTTAB5)+0x0400) select ".text.inttab5.intvec8.080";
        group (run_addr=(INTTAB5)+0x0408) select ".text.inttab5.intvec8.081";
        group (run_addr=(INTTAB5)+0x0410) select ".text.inttab5.intvec8.082";
        group (run_addr=(INTTAB5)+0x0418) select ".text.inttab5.intvec8.083";
        group (run_addr=(INTTAB5)+0x0420) select ".text.inttab5.intvec8.084";
        group (run_addr=(INTTAB5)+0x0428) select ".text.inttab5.intvec8.085";
        group (run_addr=(INTTAB5)+0x0430) select ".text.inttab5.intvec8.086";
        group (run_addr=(INTTAB5)+0x0438) select ".text.inttab5.intvec8.087";
        group (run_addr=(INTTAB5)+0x0440) select ".text.inttab5.intvec8.088";
        group (run_addr=(INTTAB5)+0x0448) select ".text.inttab5.intvec8.089";
        group (run_addr=(INTTAB5)+0x0450) select ".text.inttab5.intvec8.08A";
        group (run_addr=(INTTAB5)+0x0458) select ".text.inttab5.intvec8.08B";
        group (run_addr=(INTTAB5)+0x0460) select ".text.inttab5.intvec8.08C";
        group (run_addr=(INTTAB5)+0x0468) select ".text.inttab5.intvec8.08D";
        group (run_addr=(INTTAB5)+0x0470) select ".text.inttab5.intvec8.08E";
        group (run_addr=(INTTAB5)+0x0478) select ".text.inttab5.intvec8.08F";
        group (run_addr=(INTTAB5)+0x0480) select ".text.inttab5.intvec8.090";
        group (run_addr=(INTTAB5)+0x0488) select ".text.inttab5.intvec8.091";
        group (run_addr=(INTTAB5)+0x0490) select ".text.inttab5.intvec8.092";
        group (run_addr=(INTTAB5)+0x0498) select ".text.inttab5.intvec8.093";
        group (run_addr=(INTTAB5)+0x04A0) select ".text.inttab5.intvec8.094";
        group (run_addr=(INTTAB5)+0x04A8) select ".text.inttab5.intvec8.095";
        group (run_addr=(INTTAB5)+0x04B0) select ".text.inttab5.intvec8.096";
        group (run_addr=(INTTAB5)+0x04B8) select ".text.inttab5.intvec8.097";
        group (run_addr=(INTTAB5)+0x04C0) select ".text.inttab5.intvec8.098";
        group (run_addr=(INTTAB5)+0x04C8) select ".text.inttab5.intvec8.099";
        group (run_addr=(INTTAB5)+0x04D0) select ".text.inttab5.intvec8.09A";
        group (run_addr=(INTTAB5)+0x04D8) select ".text.inttab5.intvec8.09B";
        group (run_addr=(INTTAB5)+0x04E0) select ".text.inttab5.intvec8.09C";
        group (run_addr=(INTTAB5)+0x04E8) select ".text.inttab5.intvec8.09D";
        group (run_addr=(INTTAB5)+0x04F0) select ".text.inttab5.intvec8.09E";
        group (run_addr=(INTTAB5)+0x04F8) select ".text.inttab5.intvec8.09F";
        group (run_addr=(INTTAB5)+0x0500) select ".text.inttab5.intvec8.0A0";
        group (run_addr=(INTTAB5)+0x0508) select ".text.inttab5.intvec8.0A1";
        group (run_addr=(INTTAB5)+0x0510) select ".text.inttab5.intvec8.0A2";
        group (run_addr=(INTTAB5)+0x0518) select ".text.inttab5.intvec8.0A3";
        group (run_addr=(INTTAB5)+0x0520) select ".text.inttab5.intvec8.0A4";
        group (run_addr=(INTTAB5)+0x0528) select ".text.inttab5.intvec8.0A5";
        group (run_addr=(INTTAB5)+0x0530) select ".text.inttab5.intvec8.0A6";
        group (run_addr=(INTTAB5)+0x0538) select ".text.inttab5.intvec8.0A7";
        group (run_addr=(INTTAB5)+0x0540) select ".text.inttab5.intvec8.0A8";
        group (run_addr=(INTTAB5)+0x0548) select ".text.inttab5.intvec8.0A9";
        group (run_addr=(INTTAB5)+0x0550) select ".text.inttab5.intvec8.0AA";
        group (run_addr=(INTTAB5)+0x0558) select ".text.inttab5.intvec8.0AB";
        group (run_addr=(INTTAB5)+0x0560) select ".text.inttab5.intvec8.0AC";
        group (run_addr=(INTTAB5)+0x0568) select ".text.inttab5.intvec8.0AD";
        group (run_addr=(INTTAB5)+0x0570) select ".text.inttab5.intvec8.0AE";
        group (run_addr=(INTTAB5)+0x0578) select ".text.inttab5.intvec8.0AF";
        group (run_addr=(INTTAB5)+0x0580) select ".text.inttab5.intvec8.0B0";
        group (run_addr=(INTTAB5)+0x0588) select ".text.inttab5.intvec8.0B1";
        group (run_addr=(INTTAB5)+0x0590) select ".text.inttab5.intvec8.0B2";
        group (run_addr=(INTTAB5)+0x0598) select ".text.inttab5.intvec8.0B3";
        group (run_addr=(INTTAB5)+0x05A0) select ".text.inttab5.intvec8.0B4";
        group (run_addr=(INTTAB5)+0x05A8) select ".text.inttab5.intvec8.0B5";
        group (run_addr=(INTTAB5)+0x05B0) select ".text.inttab5.intvec8.0B6";
        group (run_addr=(INTTAB5)+0x05B8) select ".text.inttab5.intvec8.0B7";
        group (run_addr=(INTTAB5)+0x05C0) select ".text.inttab5.intvec8.0B8";
        group (run_addr=(INTTAB5)+0x05C8) select ".text.inttab5.intvec8.0B9";
        group (run_addr=(INTTAB5)+0x05D0) select ".text.inttab5.intvec8.0BA";
        group (run_addr=(INTTAB5)+0x05D8) select ".text.inttab5.intvec8.0BB";
        group (run_addr=(INTTAB5)+0x05E0) select ".text.inttab5.intvec8.0BC";
        group (run_addr=(INTTAB5)+0x05E8) select ".text.inttab5.intvec8.0BD";
        group (run_addr=(INTTAB5)+0x05F0) select ".text.inttab5.intvec8.0BE";
        group (run_addr=(INTTAB5)+0x05F8) select ".text.inttab5.intvec8.0BF";
        group (run_addr=(INTTAB5)+0x0600) select ".text.inttab5.intvec8.0C0";
        group (run_addr=(INTTAB5)+0x0608) select ".text.inttab5.intvec8.0C1";
        group (run_addr=(INTTAB5)+0x0610) select ".text.inttab5.intvec8.0C2";
        group (run_addr=(INTTAB5)+0x0618) select ".text.inttab5.intvec8.0C3";
        group (run_addr=(INTTAB5)+0x0620) select ".text.inttab5.intvec8.0C4";
        group (run_addr=(INTTAB5)+0x0628) select ".text.inttab5.intvec8.0C5";
        group (run_addr=(INTTAB5)+0x0630) select ".text.inttab5.intvec8.0C6";
        group (run_addr=(INTTAB5)+0x0638) select ".text.inttab5.intvec8.0C7";
        group (run_addr=(INTTAB5)+0x0640) select ".text.inttab5.intvec8.0C8";
        group (run_addr=(INTTAB5)+0x0648) select ".text.inttab5.intvec8.0C9";
        group (run_addr=(INTTAB5)+0x0650) select ".text.inttab5.intvec8.0CA";
        group (run_addr=(INTTAB5)+0x0658) select ".text.inttab5.intvec8.0CB";
        group (run_addr=(INTTAB5)+0x0660) select ".text.inttab5.intvec8.0CC";
        group (run_addr=(INTTAB5)+0x0668) select ".text.inttab5.intvec8.0CD";
        group (run_addr=(INTTAB5)+0x0670) select ".text.inttab5.intvec8.0CE";
        group (run_addr=(INTTAB5)+0x0678) select ".text.inttab5.intvec8.0CF";
        group (run_addr=(INTTAB5)+0x0680) select ".text.inttab5.intvec8.0D0";
        group (run_addr=(INTTAB5)+0x0688) select ".text.inttab5.intvec8.0D1";
        group (run_addr=(INTTAB5)+0x0690) select ".text.inttab5.intvec8.0D2";
        group (run_addr=(INTTAB5)+0x0698) select ".text.inttab5.intvec8.0D3";
        group (run_addr=(INTTAB5)+0x06A0) select ".text.inttab5.intvec8.0D4";
        group (run_addr=(INTTAB5)+0x06A8) select ".text.inttab5.intvec8.0D5";
        group (run_addr=(INTTAB5)+0x06B0) select ".text.inttab5.intvec8.0D6";
        group (run_addr=(INTTAB5)+0x06B8) select ".text.inttab5.intvec8.0D7";
        group (run_addr=(INTTAB5)+0x06C0) select ".text.inttab5.intvec8.0D8";
        group (run_addr=(INTTAB5)+0x06C8) select ".text.inttab5.intvec8.0D9";
        group (run_addr=(INTTAB5)+0x06D0) select ".text.inttab5.intvec8.0DA";
        group (run_addr=(INTTAB5)+0x06D8) select ".text.inttab5.intvec8.0DB";
        group (run_addr=(INTTAB5)+0x06E0) select ".text.inttab5.intvec8.0DC";
        group (run_addr=(INTTAB5)+0x06E8) select ".text.inttab5.intvec8.0DD";
        group (run_addr=(INTTAB5)+0x06F0) select ".text.inttab5.intvec8.0DE";
        group (run_addr=(INTTAB5)+0x06F8) select ".text.inttab5.intvec8.0DF";
        group (run_addr=(INTTAB5)+0x0700) select ".text.inttab5.intvec8.0E0";
        group (run_addr=(INTTAB5)+0x0708) select ".text.inttab5.intvec8.0E1";
        group (run_addr=(INTTAB5)+0x0710) select ".text.inttab5.intvec8.0E2";
        group (run_addr=(INTTAB5)+0x0718) select ".text.inttab5.intvec8.0E3";
        group (run_addr=(INTTAB5)+0x0720) select ".text.inttab5.intvec8.0E4";
        group (run_addr=(INTTAB5)+0x0728) select ".text.inttab5.intvec8.0E5";
        group (run_addr=(INTTAB5)+0x0730) select ".text.inttab5.intvec8.0E6";
        group (run_addr=(INTTAB5)+0x0738) select ".text.inttab5.intvec8.0E7";
        group (run_addr=(INTTAB5)+0x0740) select ".text.inttab5.intvec8.0E8";
        group (run_addr=(INTTAB5)+0x0748) select ".text.inttab5.intvec8.0E9";
        group (run_addr=(INTTAB5)+0x0750) select ".text.inttab5.intvec8.0EA";
        group (run_addr=(INTTAB5)+0x0758) select ".text.inttab5.intvec8.0EB";
        group (run_addr=(INTTAB5)+0x0760) select ".text.inttab5.intvec8.0EC";
        group (run_addr=(INTTAB5)+0x0768) select ".text.inttab5.intvec8.0ED";
        group (run_addr=(INTTAB5)+0x0770) select ".text.inttab5.intvec8.0EE";
        group (run_addr=(INTTAB5)+0x0778) select ".text.inttab5.intvec8.0EF";
        group (run_addr=(INTTAB5)+0x0780) select ".text.inttab5.intvec8.0F0";
        group (run_addr=(INTTAB5)+0x0788) select ".text.inttab5.intvec8.0F1";
        group (run_addr=(INTTAB5)+0x0790) select ".text.inttab5.intvec8.0F2";
        group (run_addr=(INTTAB5)+0x0798) select ".text.inttab5.intvec8.0F3";
        group (run_addr=(INTTAB5)+0x07A0) select ".text.inttab5.intvec8.0F4";
        group (run_addr=(INTTAB5)+0x07A8) select ".text.inttab5.intvec8.0F5";
        group (run_addr=(INTTAB5)+0x07B0) select ".text.inttab5.intvec8.0F6";
        group (run_addr=(INTTAB5)+0x07B8) select ".text.inttab5.intvec8.0F7";
        group (run_addr=(INTTAB5)+0x07C0) select ".text.inttab5.intvec8.0F8";
        group (run_addr=(INTTAB5)+0x07C8) select ".text.inttab5.intvec8.0F9";
        group (run_addr=(INTTAB5)+0x07D0) select ".text.inttab5.intvec8.0FA";
        group (run_addr=(INTTAB5)+0x07D8) select ".text.inttab5.intvec8.0FB";
        group (run_addr=(INTTAB5)+0x07E0) select ".text.inttab5.intvec8.0FC";
        group (run_addr=(INTTAB5)+0x07E8) select ".text.inttab5.intvec8.0FD";
        group (run_addr=(INTTAB5)+0x07F0) select ".text.inttab5.intvec8.0FE";
        group (run_addr=(INTTAB5)+0x07F8) select ".text.inttab5.intvec8.0FF";
            }
            "__INTTAB_CPU5" = (LCF_INTVEC5_START);
        }

    }

    /*Near Abbsolute Addressable Data Sections*/
    section_layout :vtc:abs18
    {
        /*Near Absolute Data, selectable with patterns and user defined sections*/
        group
        {
            group (ordered, contiguous, align = 4, attributes=rw, run_addr = mem:dsram5)
            {
                select "(.zdata.zdata_cpu5|.zdata.zdata_cpu5.*)";
                select "(.zbss.zbss_cpu5|.zbss.zbss_cpu5.*)";
            }

        }

        /*Near Absolute Data, selectable by toolchain*/
#        if LCF_DEFAULT_HOST == LCF_CPU5
        group (ordered, contiguous, align = 4, attributes=rw, run_addr = mem:dsram5)
#        endif
        {
            group zdata_mcal(attributes=rw)
            {
                select ".zdata.dsprInit.cpu5.32bit";
                select ".zdata.dsprInit.cpu5.16bit";
                select ".zdata.dsprInit.cpu5.8bit";
            }
            
            group zdata_powerOn(attributes=rw)
            {
                select ".zdata.dsprPowerOnInit.cpu5.32bit";
                select ".zdata.dsprPowerOnInit.cpu5.16bit";
                select ".zdata.dsprPowerOnInit.cpu5.8bit";
            }
            
            group zbss_mcal(attributes=rw)
            {
                select ".zbss.dsprClearOnInit.cpu5.32bit";
                select ".zbss.dsprClearOnInit.cpu5.16bit";
                select ".zbss.dsprClearOnInit.cpu5.8bit";
            }
            
            group zbss_noClear(attributes=rw)
            {
                select ".zbss.dsprNoInit.cpu5.32bit";
                select ".zbss.dsprNoInit.cpu5.16bit";
                select ".zbss.dsprNoInit.cpu5.8bit";
            }
            
            group zbss_powerOn(attributes=rw)
            {
                select ".zbss.dsprPowerOnClear.cpu5.32bit";
                select ".zbss.dsprPowerOnClear.cpu5.16bit";
                select ".zbss.dsprPowerOnClear.cpu5.8bit";
            }
            
            group zdata(attributes=rw)
            {
                select "(.zdata|.zdata.*)";
                select "(.zbss|.zbss.*)";
            }
        }
        
        /*Near Absolute Const, selectable with patterns and user defined sections*/
        group
        {
            group (ordered, contiguous, align = 4, attributes=r, run_addr=mem:pfls5)
            {
                select ".zrodata.Ifx_Ssw_Tc5.*";
                select ".zrodata.Cpu5_Main.*";

                /*Near Absolute Const, selectable by toolchain*/
                select ".zrodata.const.cpu5.32bit";
                select ".zrodata.const.cpu5.16bit";
                select ".zrodata.const.cpu5.8bit";
                select ".zrodata.config.cpu5.32bit";
                select ".zrodata.config.cpu5.16bit";
                select ".zrodata.config.cpu5.8bit";
                select "(.zrodata|.zrodata.*)";
            }
        }
    }

    /*Relative A0/A1/A8/A9 Addressable Sections*/
    section_layout :vtc:linear
    {
        /*Relative A0 Addressable Data, selectable by toolchain*/
#        if LCF_DEFAULT_HOST == LCF_CPU5
        group a0 (ordered, contiguous, align = 4, attributes=rw, run_addr = mem:dsram5)
#        endif
        {
            select "(.sdata|.sdata.*)";
			select "(.data_a0|.data_a0.*)";
            select "(.sbss|.sbss.*)";
            select "(.bss_a0|.bss_a0.*)";
        }
        "_SMALL_DATA_" := sizeof(group:a0) > 0 ? addressof(group:a0) : addressof(group:a0) & 0xF0000000 + 32k;
        "__A0_MEM" = "_SMALL_DATA_";
        
        /*Relative A1 Addressable Const, selectable by toolchain*/
        /*Small constant sections, No option given for CPU specific user sections to make generated code portable across Cpus*/
#        if LCF_DEFAULT_HOST == LCF_CPU5
        group  a1 (ordered, align = 4, attributes=r, run_addr=mem:pfls5)
#        endif
        {
			select "(.srodata|.srodata.*)";
            select "(.ldata|.ldata.*)";
			select "(.rodata_a1|.rodata_a1.*)";
        }
        "_LITERAL_DATA_" := sizeof(group:a1) > 0 ? addressof(group:a1) : addressof(group:a1) & 0xF0000000 + 32k;
        "__A1_MEM" = "_LITERAL_DATA_";
        
        /*Relative A9 Addressable Data, selectable with patterns and user defined sections*/
        group a9 (ordered, align = 4, run_addr=mem:cpu5_dlmu)
        {
            select "(.a9sdata|.a9sdata.*)";
            select "(.data_a9|.data_a9.*)";
            select "(.a9sbss|.a9sbss.*)";
            select "(.bss_a9|.bss_a9.*)";
        }
        "_A9_DATA_" := sizeof(group:a9) > 0 ? addressof(group:a9) : addressof(group:a9) & 0xF0000000 + 32k;
        "__A9_MEM" = "_A9_DATA_";

        /*Relative A8 Addressable Const, selectable with patterns and user defined sections*/
#        if LCF_DEFAULT_HOST == LCF_CPU5
        group  a8 (ordered, align = 4, run_addr=mem:pfls5)
#        endif
        {
			select "(.a8srodata|.a8srodata.*)";
            select "(.rodata_a8|.rodata_a8.*)";
        }
        "_A8_DATA_" := sizeof(group:a8) > 0 ? addressof(group:a8) : addressof(group:a8) & 0xF0000000 + 32k;
        "__A8_MEM" = "_A8_DATA_";
    }

    /*Far Data / Far Const Sections, selectable with patterns and user defined sections*/
    section_layout :vtc:linear
    {
        /*Far Data Sections, selectable with patterns and user defined sections*/

            /*DSRAM sections*/
            group
            {
                group (ordered, attributes=rw, run_addr=mem:dsram5)
                {
                    select ".data.Ifx_Ssw_Tc5.*";
                    select ".data.Cpu5_Main.*";
                    select "(.data.data_cpu5|.data.data_cpu5.*)";
                    select ".bss.Ifx_Ssw_Tc5.*";
                    select ".bss.Cpu5_Main.*";
                    select "(.bss.bss_cpu5|.bss.bss_cpu5.*)";
                }
            }

            /*LMU Data sections*/
            group
            {
                group (ordered, attributes=rw, run_addr = mem:cpu5_dlmu)
                {
                    select "(.data.lmudata_cpu5|.data.lmudata_cpu5.*)";
                    select "(.bss.lmubss_cpu5|.bss.lmubss_cpu5.*)";
                }
	    }
        group
        {
            /*LMU Shared variable for TriCore CPUs*/
            group shared_lmuram (ordered, align = 4, attributes=rwu, run_addr=mem:cpu5_dlmu)
            {
                select "(.data.uncached.lmudata|.data.uncached.lmudata.*)";
                select "(.bss.uncached.lmubss|.bss.uncached.lmubss.*)";
                select "(.bss.sharedvar|.bss.sharedvar.*)";
            }
            "__SHARED_DATA"= "_lc_gb_shared_lmuram";

            /*LMU reserved sections for exclusive PPU usage*/
            group ppu_lmuram (ordered, attributes=rwu, run_addr=mem:lmuram/not_cached[sizeof(mem:lmuram) - LCF_PPU_LMURAM_SIZE])
            {
                reserved "ppu_lmuram" (size = LCF_PPU_LMURAM_SIZE);
            }
            "__PPU_LMURAM_START"= "_lc_gb_ppu_lmuram";
            "__PPU_LMURAM_END"= "_lc_ge_ppu_lmuram";

            /*Fixed memory Allocations for PPU Local data in CSM*/
            group ppu_csm (ordered, attributes=rwxu, run_addr= mem:ppu_csm/not_cached)
            {
                reserved "ppu_csm" (size = sizeof(mem:ppu_csm));
            }
            "__PPU_CSM_START"= "_lc_gb_ppu_csm";
            "__PPU_CSM_END"= "_lc_ge_ppu_csm";
        }

        /*Far Data Sections, selectable by toolchain*/
#        if LCF_DEFAULT_HOST == LCF_CPU5
        group (ordered, contiguous, align = 4, attributes=rw, run_addr = mem:dsram5)
#        endif
        {
            group data_mcal(attributes=rw)
            {
                select ".data.farDsprInit.cpu5.32bit";
                select ".data.farDsprInit.cpu5.16bit";
                select ".data.farDsprInit.cpu5.8bit";
            }
            
            group bss_mcal(attributes=rw)
            {
                select ".bss.farDsprClearOnInit.cpu5.32bit";
                select ".bss.farDsprClearOnInit.cpu5.16bit";
                select ".bss.farDsprClearOnInit.cpu5.8bit";
            }
            
            group bss_noInit(attributes=rw)
            {
                select ".bss.farDsprNoInit.cpu5.32bit";
                select ".bss.farDsprNoInit.cpu5.16bit";
                select ".bss.farDsprNoInit.cpu5.8bit";                
            }
            
            group data(attributes=rw)
            {
                select "(.data|.data.*)";
                select "(.bss|.bss.*)";
            }
        }

        /*Heap allocation*/
#        if LCF_DEFAULT_HOST == LCF_CPU5
        group (ordered, align = 4, run_addr = mem:dsram5[LCF_HEAP5_OFFSET])
#        endif
        {
            heap "heap" (size = LCF_HEAP_SIZE);
        }

        /*Far Const Sections, selectable with patterns and user defined sections*/
        group
        {
            group (ordered, align = 4, attributes=r, run_addr=mem:pfls5)
            {
		select ".rodata.Ifx_Ssw_Tc5.*";
                select ".rodata.Cpu5_Main.*";
                select "(.rodata.rodata_cpu5|.rodata.rodata_cpu5.*)";
            }
        }

        /*Far Const Sections, selectable by toolchain*/
#        if LCF_DEFAULT_HOST == LCF_CPU5
        group (ordered, align = 4, run_addr=mem:pfls5)
#        endif
        {
            select ".rodata.farConst.cpu5.32bit";
            select ".rodata.farConst.cpu5.16bit";
            select ".rodata.farConst.cpu5.8bit";
            select "(.rodata|.rodata.*)";
        }
    }

    /* PSRAM Code selections*/
    section_layout :vtc:linear
    {
        /*Code Sections, selectable with patterns and user defined sections*/
        group
        {
            /*Program Scratchpad Sections*/
            group
            {
                group code_psram5 (ordered, attributes=rwx, copy, run_addr=mem:psram5)
                {
                    select "(.text.cpu5_psram|.text.cpu5_psram.*)";
                    select "(.text.psram_text_cpu5|.text.psram_text_cpu5.*)";
                }

            }
        }
    }

    /* FLS Code selections*/
    section_layout :vtc:linear
    {
        /*Code Sections, selectable with patterns and user defined sections*/
        group
        {    
            /*Cpu specific PFLASH Sections*/
            group
            {
                group (ordered, align = 4, run_addr=mem:pfls5)
                {
                    select ".text.Ifx_Ssw_Tc5.*";
                    select ".text.Cpu5_Main.*";
                    select ".text.CompilerTasking.Ifx_C_Init";
                    select "(.text.text_cpu5|.text.text_cpu5.*)";
                }
            }
        }

        /*Code Sections, selectable by toolchain*/
#        if LCF_DEFAULT_HOST == LCF_CPU5
        group (ordered, run_addr=mem:pfls5)
#        endif
        {
            select ".text.fast.pfls.cpu5";
            select ".text.slow.pfls.cpu5";
            select ".text.5ms.pfls.cpu5";
            select ".text.10ms.pfls.cpu5";
            select ".text.callout.pfls.cpu5";
            select "(.text|.text.*)";
        }

        group
        {
            /* Fixed memory Allocations for PPU code placement in PFLS5 */
            group ppu_code (ordered, run_addr= mem:pfls5[sizeof(mem:pfls5)-LCF_PPU_FLASH_SIZE])
            {
                reserved "ppu_code" (size = LCF_PPU_FLASH_SIZE);
            }
            "__PPU_IF_CONSTANTS"= addressof(group:ppu_code);
            "__PPU_CODE_START"= "_lc_gb_ppu_code";
            "__PPU_CODE_END"= "_lc_ge_ppu_code";
        }
    }
}
