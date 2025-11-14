#define LCF_CSA1_SIZE     8k
#define LCF_USTACK1_SIZE  2k
#define LCF_ISTACK1_SIZE  1k

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

#define LCF_DEFAULT_HOST LCF_CPU1

#define LCF_DSPR1_START  0x60000000
#define LCF_DSPR1_SIZE   240K

#define LCF_CSA1_OFFSET     (LCF_DSPR1_SIZE - 1k - LCF_CSA1_SIZE)
#define LCF_ISTACK1_OFFSET  (LCF_CSA1_OFFSET - 256 - LCF_ISTACK1_SIZE)
#define LCF_USTACK1_OFFSET  (LCF_ISTACK1_OFFSET - 256 - LCF_USTACK1_SIZE)

#define LCF_HEAP1_OFFSET    (LCF_USTACK1_OFFSET - LCF_HEAP_SIZE)

#define LCF_INTVEC1_START 0x807FE000

#define LCF_TRAPVEC1_START 0x80400100

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

#define INTTAB1     (LCF_INTVEC1_START)
#define TRAPTAB1    (LCF_TRAPVEC1_START)

#define RESET LCF_STARTPTR_NC_CPU1

#include "tc1v1_8.lsl"

// Specify a multi-core processor environment (mpe)

processor mpe
{
    derivative = tc4D;
}

derivative tc4D
{

    core tc1 
    {
        architecture = TC1V1.8;
        space_id_offset = 200;           // add 200 to all space IDs in the architecture definition
        copytable_space = vtc:linear;    // use the copy table in the virtual core for 'bss' and initialized data sections
    }

    core vtc
    {
        architecture = TC1V1.8;
        import tc1;                     // add all address spaces of core tc1 to core vtc for linking and locating
    }

    bus sri
    {
        mau = 8;
        width = 32;

        // map shared addresses one-to-one to real cores and virtual cores
        map (dest=bus:tc1:fpi_bus, src_offset=0, dest_offset=0, size=0xc0000000);
        map (dest=bus:vtc:fpi_bus, src_offset=0, dest_offset=0, size=0xc0000000);
    }

    memory dsram1 // Data Scratch Pad Ram
    {
        mau = 8;
        size = 240K;
        type = ram;
        map (dest=bus:tc1:fpi_bus, dest_offset=0xD0000000, size=240K, priority=8);
        map (dest=bus:sri, dest_offset=0x60000000, size=240K);
    }
    
    memory psram1 // Program Scratch Pad Ram
    {
        mau = 8;
        size = 64K;
        type = ram;
        map (dest=bus:tc1:fpi_bus, dest_offset=0xC0000000, size=64K, priority=8);
        map (dest=bus:sri, dest_offset=0x60100000, size=64K);
    }

    memory pfls1
    {
        mau = 8;
        size = 4M;
        type = rom;
        map     cached (dest=bus:sri, dest_offset=0x80400000,           size=4M);
        map not_cached (dest=bus:sri, dest_offset=0xa0400000, reserved, size=4M);
    }

    memory pfls5
    {
        mau = 8;
        size = 2M;
        type = rom;
        map     cached (dest=bus:sri, dest_offset=0x81200000,           size=2M);
        map not_cached (dest=bus:sri, dest_offset=0xa1200000, reserved, size=2M);
    }

    memory cpu1_dlmu
    {
        mau = 8;
        size = 512K;
        type = ram;
        map     cached (dest=bus:sri, dest_offset=0x90080000,           size=512K);
        map not_cached (dest=bus:sri, dest_offset=0xB0080000, reserved, size=512K);
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
            symbol = "_START1"
        );
    }
    
    section_setup :vtc:linear
    {
        stack "ustack_tc1" (min_size = 1k, fixed, align = 8);
        stack "istack_tc1" (min_size = 1k, fixed, align = 8);

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
                symbol = "_lc_ub_table_tc1";
                space = :tc1:linear, :tc1:abs24, :tc1:abs18, :tc1:csa;
            }
        );
    }

    /*Sections located at absolute fixed address*/

    section_layout :vtc:linear
    {
        /*Fixed memory Allocations for stack memory and CSA*/
        group (ordered)
        {
            group ustack1(align = 8, run_addr = mem:dsram1[LCF_USTACK1_OFFSET])
            {
                stack "ustack_tc1" (size = LCF_USTACK1_SIZE);
            }
            "__USTACK1":= sizeof(group:ustack1) > 0  ? "_lc_ue_ustack_tc1" : 0;
            "__USTACK1_END"="_lc_gb_ustack1";

            group istack1(align = 8, run_addr = mem:dsram1[LCF_ISTACK1_OFFSET])
            {
                stack "istack_tc1" (size = LCF_ISTACK1_SIZE);
            }
            "__ISTACK1":= sizeof(group:istack1) > 0  ? "_lc_ue_istack_tc1" : 0;
            "__ISTACK1_END"="_lc_gb_istack1";

            group (align = 64, attributes=rw, run_addr=mem:dsram1[LCF_CSA1_OFFSET]) 
                reserved "csa_tc1" (size = LCF_CSA1_SIZE);
            "__CSA1":=        "_lc_ub_csa_tc1";
            "__CSA1_END":=    "_lc_ue_csa_tc1";        
        }

        /*Fixed memory Allocations for _START*/
        group (ordered)
		{
			group  reset (run_addr=RESET)
			{
				section "reset" ( size = 0x20, attributes = rx, fill = 0x0800 )
				{
					select ".text.start_cpu1";
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
            group trapvec_tc1 (align = 8, run_addr=LCF_TRAPVEC1_START)
            {
                section "trapvec_tc1" (size=0x100, attributes=rx, fill=0)
                {
                    select "(.text.traptab_cpu1*)";
                }
            }
            "__TRAPTAB_CPU1" := TRAPTAB1;
        }

        /*Fixed memory Allocations for Start up code*/
        group (ordered, attributes=rx)
        {
            group start_tc1 (run_addr=LCF_STARTPTR_NC_CPU1)
            {
                select "(.text.start_cpu1*)";
            }
            "__ENABLE_INDIVIDUAL_C_INIT_CPU1" := 1;
        }

        /*Fixed memory Allocations for Interrupt Vector Table*/
        group (ordered, attributes=rx)
        {
            group int_tab_tc1 (ordered)
            {
                group (run_addr=(INTTAB1)+0x0000) select ".text.inttab1.intvec.000";
                group (run_addr=(INTTAB1)+0x0020) select ".text.inttab1.intvec.001";
                group (run_addr=(INTTAB1)+0x0040) select ".text.inttab1.intvec.002";
                group (run_addr=(INTTAB1)+0x0060) select ".text.inttab1.intvec.003";
                group (run_addr=(INTTAB1)+0x0080) select ".text.inttab1.intvec.004";
                group (run_addr=(INTTAB1)+0x00a0) select ".text.inttab1.intvec.005";
                group (run_addr=(INTTAB1)+0x00c0) select ".text.inttab1.intvec.006";
                group (run_addr=(INTTAB1)+0x00e0) select ".text.inttab1.intvec.007";
                group (run_addr=(INTTAB1)+0x0100) select ".text.inttab1.intvec.008";
                group (run_addr=(INTTAB1)+0x0120) select ".text.inttab1.intvec.009";
                group (run_addr=(INTTAB1)+0x0140) select ".text.inttab1.intvec.00a";
                group (run_addr=(INTTAB1)+0x0160) select ".text.inttab1.intvec.00b";
                group (run_addr=(INTTAB1)+0x0180) select ".text.inttab1.intvec.00c";
                group (run_addr=(INTTAB1)+0x01a0) select ".text.inttab1.intvec.00d";
                group (run_addr=(INTTAB1)+0x01c0) select ".text.inttab1.intvec.00e";
                group (run_addr=(INTTAB1)+0x01e0) select ".text.inttab1.intvec.00f";
                group (run_addr=(INTTAB1)+0x0200) select ".text.inttab1.intvec.010";
                group (run_addr=(INTTAB1)+0x0220) select ".text.inttab1.intvec.011";
                group (run_addr=(INTTAB1)+0x0240) select ".text.inttab1.intvec.012";
                group (run_addr=(INTTAB1)+0x0260) select ".text.inttab1.intvec.013";
                group (run_addr=(INTTAB1)+0x0280) select ".text.inttab1.intvec.014";
                group (run_addr=(INTTAB1)+0x02a0) select ".text.inttab1.intvec.015";
                group (run_addr=(INTTAB1)+0x02c0) select ".text.inttab1.intvec.016";
                group (run_addr=(INTTAB1)+0x02e0) select ".text.inttab1.intvec.017";
                group (run_addr=(INTTAB1)+0x0300) select ".text.inttab1.intvec.018";
                group (run_addr=(INTTAB1)+0x0320) select ".text.inttab1.intvec.019";
                group (run_addr=(INTTAB1)+0x0340) select ".text.inttab1.intvec.01a";
                group (run_addr=(INTTAB1)+0x0360) select ".text.inttab1.intvec.01b";
                group (run_addr=(INTTAB1)+0x0380) select ".text.inttab1.intvec.01c";
                group (run_addr=(INTTAB1)+0x03a0) select ".text.inttab1.intvec.01d";
                group (run_addr=(INTTAB1)+0x03c0) select ".text.inttab1.intvec.01e";
                group (run_addr=(INTTAB1)+0x03e0) select ".text.inttab1.intvec.01f";
                group (run_addr=(INTTAB1)+0x0400) select ".text.inttab1.intvec.020";
                group (run_addr=(INTTAB1)+0x0420) select ".text.inttab1.intvec.021";
                group (run_addr=(INTTAB1)+0x0440) select ".text.inttab1.intvec.022";
                group (run_addr=(INTTAB1)+0x0460) select ".text.inttab1.intvec.023";
                group (run_addr=(INTTAB1)+0x0480) select ".text.inttab1.intvec.024";
                group (run_addr=(INTTAB1)+0x04a0) select ".text.inttab1.intvec.025";
                group (run_addr=(INTTAB1)+0x04c0) select ".text.inttab1.intvec.026";
                group (run_addr=(INTTAB1)+0x04e0) select ".text.inttab1.intvec.027";
                group (run_addr=(INTTAB1)+0x0500) select ".text.inttab1.intvec.028";
                group (run_addr=(INTTAB1)+0x0520) select ".text.inttab1.intvec.029";
                group (run_addr=(INTTAB1)+0x0540) select ".text.inttab1.intvec.02a";
                group (run_addr=(INTTAB1)+0x0560) select ".text.inttab1.intvec.02b";
                group (run_addr=(INTTAB1)+0x0580) select ".text.inttab1.intvec.02c";
                group (run_addr=(INTTAB1)+0x05a0) select ".text.inttab1.intvec.02d";
                group (run_addr=(INTTAB1)+0x05c0) select ".text.inttab1.intvec.02e";
                group (run_addr=(INTTAB1)+0x05e0) select ".text.inttab1.intvec.02f";
                group (run_addr=(INTTAB1)+0x0600) select ".text.inttab1.intvec.030";
                group (run_addr=(INTTAB1)+0x0620) select ".text.inttab1.intvec.031";
                group (run_addr=(INTTAB1)+0x0640) select ".text.inttab1.intvec.032";
                group (run_addr=(INTTAB1)+0x0660) select ".text.inttab1.intvec.033";
                group (run_addr=(INTTAB1)+0x0680) select ".text.inttab1.intvec.034";
                group (run_addr=(INTTAB1)+0x06a0) select ".text.inttab1.intvec.035";
                group (run_addr=(INTTAB1)+0x06c0) select ".text.inttab1.intvec.036";
                group (run_addr=(INTTAB1)+0x06e0) select ".text.inttab1.intvec.037";
                group (run_addr=(INTTAB1)+0x0700) select ".text.inttab1.intvec.038";
                group (run_addr=(INTTAB1)+0x0720) select ".text.inttab1.intvec.039";
                group (run_addr=(INTTAB1)+0x0740) select ".text.inttab1.intvec.03a";
                group (run_addr=(INTTAB1)+0x0760) select ".text.inttab1.intvec.03b";
                group (run_addr=(INTTAB1)+0x0780) select ".text.inttab1.intvec.03c";
                group (run_addr=(INTTAB1)+0x07a0) select ".text.inttab1.intvec.03d";
                group (run_addr=(INTTAB1)+0x07c0) select ".text.inttab1.intvec.03e";
                group (run_addr=(INTTAB1)+0x07e0) select ".text.inttab1.intvec.03f";
                group (run_addr=(INTTAB1)+0x0800) select ".text.inttab1.intvec.040";
                group (run_addr=(INTTAB1)+0x0820) select ".text.inttab1.intvec.041";
                group (run_addr=(INTTAB1)+0x0840) select ".text.inttab1.intvec.042";
                group (run_addr=(INTTAB1)+0x0860) select ".text.inttab1.intvec.043";
                group (run_addr=(INTTAB1)+0x0880) select ".text.inttab1.intvec.044";
                group (run_addr=(INTTAB1)+0x08a0) select ".text.inttab1.intvec.045";
                group (run_addr=(INTTAB1)+0x08c0) select ".text.inttab1.intvec.046";
                group (run_addr=(INTTAB1)+0x08e0) select ".text.inttab1.intvec.047";
                group (run_addr=(INTTAB1)+0x0900) select ".text.inttab1.intvec.048";
                group (run_addr=(INTTAB1)+0x0920) select ".text.inttab1.intvec.049";
                group (run_addr=(INTTAB1)+0x0940) select ".text.inttab1.intvec.04a";
                group (run_addr=(INTTAB1)+0x0960) select ".text.inttab1.intvec.04b";
                group (run_addr=(INTTAB1)+0x0980) select ".text.inttab1.intvec.04c";
                group (run_addr=(INTTAB1)+0x09a0) select ".text.inttab1.intvec.04d";
                group (run_addr=(INTTAB1)+0x09c0) select ".text.inttab1.intvec.04e";
                group (run_addr=(INTTAB1)+0x09e0) select ".text.inttab1.intvec.04f";
                group (run_addr=(INTTAB1)+0x0a00) select ".text.inttab1.intvec.050";
                group (run_addr=(INTTAB1)+0x0a20) select ".text.inttab1.intvec.051";
                group (run_addr=(INTTAB1)+0x0a40) select ".text.inttab1.intvec.052";
                group (run_addr=(INTTAB1)+0x0a60) select ".text.inttab1.intvec.053";
                group (run_addr=(INTTAB1)+0x0a80) select ".text.inttab1.intvec.054";
                group (run_addr=(INTTAB1)+0x0aa0) select ".text.inttab1.intvec.055";
                group (run_addr=(INTTAB1)+0x0ac0) select ".text.inttab1.intvec.056";
                group (run_addr=(INTTAB1)+0x0ae0) select ".text.inttab1.intvec.057";
                group (run_addr=(INTTAB1)+0x0b00) select ".text.inttab1.intvec.058";
                group (run_addr=(INTTAB1)+0x0b20) select ".text.inttab1.intvec.059";
                group (run_addr=(INTTAB1)+0x0b40) select ".text.inttab1.intvec.05a";
                group (run_addr=(INTTAB1)+0x0b60) select ".text.inttab1.intvec.05b";
                group (run_addr=(INTTAB1)+0x0b80) select ".text.inttab1.intvec.05c";
                group (run_addr=(INTTAB1)+0x0ba0) select ".text.inttab1.intvec.05d";
                group (run_addr=(INTTAB1)+0x0bc0) select ".text.inttab1.intvec.05e";
                group (run_addr=(INTTAB1)+0x0be0) select ".text.inttab1.intvec.05f";
                group (run_addr=(INTTAB1)+0x0c00) select ".text.inttab1.intvec.060";
                group (run_addr=(INTTAB1)+0x0c20) select ".text.inttab1.intvec.061";
                group (run_addr=(INTTAB1)+0x0c40) select ".text.inttab1.intvec.062";
                group (run_addr=(INTTAB1)+0x0c60) select ".text.inttab1.intvec.063";
                group (run_addr=(INTTAB1)+0x0c80) select ".text.inttab1.intvec.064";
                group (run_addr=(INTTAB1)+0x0ca0) select ".text.inttab1.intvec.065";
                group (run_addr=(INTTAB1)+0x0cc0) select ".text.inttab1.intvec.066";
                group (run_addr=(INTTAB1)+0x0ce0) select ".text.inttab1.intvec.067";
                group (run_addr=(INTTAB1)+0x0d00) select ".text.inttab1.intvec.068";
                group (run_addr=(INTTAB1)+0x0d20) select ".text.inttab1.intvec.069";
                group (run_addr=(INTTAB1)+0x0d40) select ".text.inttab1.intvec.06a";
                group (run_addr=(INTTAB1)+0x0d60) select ".text.inttab1.intvec.06b";
                group (run_addr=(INTTAB1)+0x0d80) select ".text.inttab1.intvec.06c";
                group (run_addr=(INTTAB1)+0x0da0) select ".text.inttab1.intvec.06d";
                group (run_addr=(INTTAB1)+0x0dc0) select ".text.inttab1.intvec.06e";
                group (run_addr=(INTTAB1)+0x0de0) select ".text.inttab1.intvec.06f";
                group (run_addr=(INTTAB1)+0x0e00) select ".text.inttab1.intvec.070";
                group (run_addr=(INTTAB1)+0x0e20) select ".text.inttab1.intvec.071";
                group (run_addr=(INTTAB1)+0x0e40) select ".text.inttab1.intvec.072";
                group (run_addr=(INTTAB1)+0x0e60) select ".text.inttab1.intvec.073";
                group (run_addr=(INTTAB1)+0x0e80) select ".text.inttab1.intvec.074";
                group (run_addr=(INTTAB1)+0x0ea0) select ".text.inttab1.intvec.075";
                group (run_addr=(INTTAB1)+0x0ec0) select ".text.inttab1.intvec.076";
                group (run_addr=(INTTAB1)+0x0ee0) select ".text.inttab1.intvec.077";
                group (run_addr=(INTTAB1)+0x0f00) select ".text.inttab1.intvec.078";
                group (run_addr=(INTTAB1)+0x0f20) select ".text.inttab1.intvec.079";
                group (run_addr=(INTTAB1)+0x0f40) select ".text.inttab1.intvec.07a";
                group (run_addr=(INTTAB1)+0x0f60) select ".text.inttab1.intvec.07b";
                group (run_addr=(INTTAB1)+0x0f80) select ".text.inttab1.intvec.07c";
                group (run_addr=(INTTAB1)+0x0fa0) select ".text.inttab1.intvec.07d";
                group (run_addr=(INTTAB1)+0x0fc0) select ".text.inttab1.intvec.07e";
                group (run_addr=(INTTAB1)+0x0fe0) select ".text.inttab1.intvec.07f";
                group (run_addr=(INTTAB1)+0x1000) select ".text.inttab1.intvec.080";
                group (run_addr=(INTTAB1)+0x1020) select ".text.inttab1.intvec.081";
                group (run_addr=(INTTAB1)+0x1040) select ".text.inttab1.intvec.082";
                group (run_addr=(INTTAB1)+0x1060) select ".text.inttab1.intvec.083";
                group (run_addr=(INTTAB1)+0x1080) select ".text.inttab1.intvec.084";
                group (run_addr=(INTTAB1)+0x10a0) select ".text.inttab1.intvec.085";
                group (run_addr=(INTTAB1)+0x10c0) select ".text.inttab1.intvec.086";
                group (run_addr=(INTTAB1)+0x10e0) select ".text.inttab1.intvec.087";
                group (run_addr=(INTTAB1)+0x1100) select ".text.inttab1.intvec.088";
                group (run_addr=(INTTAB1)+0x1120) select ".text.inttab1.intvec.089";
                group (run_addr=(INTTAB1)+0x1140) select ".text.inttab1.intvec.08a";
                group (run_addr=(INTTAB1)+0x1160) select ".text.inttab1.intvec.08b";
                group (run_addr=(INTTAB1)+0x1180) select ".text.inttab1.intvec.08c";
                group (run_addr=(INTTAB1)+0x11a0) select ".text.inttab1.intvec.08d";
                group (run_addr=(INTTAB1)+0x11c0) select ".text.inttab1.intvec.08e";
                group (run_addr=(INTTAB1)+0x11e0) select ".text.inttab1.intvec.08f";
                group (run_addr=(INTTAB1)+0x1200) select ".text.inttab1.intvec.090";
                group (run_addr=(INTTAB1)+0x1220) select ".text.inttab1.intvec.091";
                group (run_addr=(INTTAB1)+0x1240) select ".text.inttab1.intvec.092";
                group (run_addr=(INTTAB1)+0x1260) select ".text.inttab1.intvec.093";
                group (run_addr=(INTTAB1)+0x1280) select ".text.inttab1.intvec.094";
                group (run_addr=(INTTAB1)+0x12a0) select ".text.inttab1.intvec.095";
                group (run_addr=(INTTAB1)+0x12c0) select ".text.inttab1.intvec.096";
                group (run_addr=(INTTAB1)+0x12e0) select ".text.inttab1.intvec.097";
                group (run_addr=(INTTAB1)+0x1300) select ".text.inttab1.intvec.098";
                group (run_addr=(INTTAB1)+0x1320) select ".text.inttab1.intvec.099";
                group (run_addr=(INTTAB1)+0x1340) select ".text.inttab1.intvec.09a";
                group (run_addr=(INTTAB1)+0x1360) select ".text.inttab1.intvec.09b";
                group (run_addr=(INTTAB1)+0x1380) select ".text.inttab1.intvec.09c";
                group (run_addr=(INTTAB1)+0x13a0) select ".text.inttab1.intvec.09d";
                group (run_addr=(INTTAB1)+0x13c0) select ".text.inttab1.intvec.09e";
                group (run_addr=(INTTAB1)+0x13e0) select ".text.inttab1.intvec.09f";
                group (run_addr=(INTTAB1)+0x1400) select ".text.inttab1.intvec.0a0";
                group (run_addr=(INTTAB1)+0x1420) select ".text.inttab1.intvec.0a1";
                group (run_addr=(INTTAB1)+0x1440) select ".text.inttab1.intvec.0a2";
                group (run_addr=(INTTAB1)+0x1460) select ".text.inttab1.intvec.0a3";
                group (run_addr=(INTTAB1)+0x1480) select ".text.inttab1.intvec.0a4";
                group (run_addr=(INTTAB1)+0x14a0) select ".text.inttab1.intvec.0a5";
                group (run_addr=(INTTAB1)+0x14c0) select ".text.inttab1.intvec.0a6";
                group (run_addr=(INTTAB1)+0x14e0) select ".text.inttab1.intvec.0a7";
                group (run_addr=(INTTAB1)+0x1500) select ".text.inttab1.intvec.0a8";
                group (run_addr=(INTTAB1)+0x1520) select ".text.inttab1.intvec.0a9";
                group (run_addr=(INTTAB1)+0x1540) select ".text.inttab1.intvec.0aa";
                group (run_addr=(INTTAB1)+0x1560) select ".text.inttab1.intvec.0ab";
                group (run_addr=(INTTAB1)+0x1580) select ".text.inttab1.intvec.0ac";
                group (run_addr=(INTTAB1)+0x15a0) select ".text.inttab1.intvec.0ad";
                group (run_addr=(INTTAB1)+0x15c0) select ".text.inttab1.intvec.0ae";
                group (run_addr=(INTTAB1)+0x15e0) select ".text.inttab1.intvec.0af";
                group (run_addr=(INTTAB1)+0x1600) select ".text.inttab1.intvec.0b0";
                group (run_addr=(INTTAB1)+0x1620) select ".text.inttab1.intvec.0b1";
                group (run_addr=(INTTAB1)+0x1640) select ".text.inttab1.intvec.0b2";
                group (run_addr=(INTTAB1)+0x1660) select ".text.inttab1.intvec.0b3";
                group (run_addr=(INTTAB1)+0x1680) select ".text.inttab1.intvec.0b4";
                group (run_addr=(INTTAB1)+0x16a0) select ".text.inttab1.intvec.0b5";
                group (run_addr=(INTTAB1)+0x16c0) select ".text.inttab1.intvec.0b6";
                group (run_addr=(INTTAB1)+0x16e0) select ".text.inttab1.intvec.0b7";
                group (run_addr=(INTTAB1)+0x1700) select ".text.inttab1.intvec.0b8";
                group (run_addr=(INTTAB1)+0x1720) select ".text.inttab1.intvec.0b9";
                group (run_addr=(INTTAB1)+0x1740) select ".text.inttab1.intvec.0ba";
                group (run_addr=(INTTAB1)+0x1760) select ".text.inttab1.intvec.0bb";
                group (run_addr=(INTTAB1)+0x1780) select ".text.inttab1.intvec.0bc";
                group (run_addr=(INTTAB1)+0x17a0) select ".text.inttab1.intvec.0bd";
                group (run_addr=(INTTAB1)+0x17c0) select ".text.inttab1.intvec.0be";
                group (run_addr=(INTTAB1)+0x17e0) select ".text.inttab1.intvec.0bf";
                group (run_addr=(INTTAB1)+0x1800) select ".text.inttab1.intvec.0c0";
                group (run_addr=(INTTAB1)+0x1820) select ".text.inttab1.intvec.0c1";
                group (run_addr=(INTTAB1)+0x1840) select ".text.inttab1.intvec.0c2";
                group (run_addr=(INTTAB1)+0x1860) select ".text.inttab1.intvec.0c3";
                group (run_addr=(INTTAB1)+0x1880) select ".text.inttab1.intvec.0c4";
                group (run_addr=(INTTAB1)+0x18a0) select ".text.inttab1.intvec.0c5";
                group (run_addr=(INTTAB1)+0x18c0) select ".text.inttab1.intvec.0c6";
                group (run_addr=(INTTAB1)+0x18e0) select ".text.inttab1.intvec.0c7";
                group (run_addr=(INTTAB1)+0x1900) select ".text.inttab1.intvec.0c8";
                group (run_addr=(INTTAB1)+0x1920) select ".text.inttab1.intvec.0c9";
                group (run_addr=(INTTAB1)+0x1940) select ".text.inttab1.intvec.0ca";
                group (run_addr=(INTTAB1)+0x1960) select ".text.inttab1.intvec.0cb";
                group (run_addr=(INTTAB1)+0x1980) select ".text.inttab1.intvec.0cc";
                group (run_addr=(INTTAB1)+0x19a0) select ".text.inttab1.intvec.0cd";
                group (run_addr=(INTTAB1)+0x19c0) select ".text.inttab1.intvec.0ce";
                group (run_addr=(INTTAB1)+0x19e0) select ".text.inttab1.intvec.0cf";
                group (run_addr=(INTTAB1)+0x1a00) select ".text.inttab1.intvec.0d0";
                group (run_addr=(INTTAB1)+0x1a20) select ".text.inttab1.intvec.0d1";
                group (run_addr=(INTTAB1)+0x1a40) select ".text.inttab1.intvec.0d2";
                group (run_addr=(INTTAB1)+0x1a60) select ".text.inttab1.intvec.0d3";
                group (run_addr=(INTTAB1)+0x1a80) select ".text.inttab1.intvec.0d4";
                group (run_addr=(INTTAB1)+0x1aa0) select ".text.inttab1.intvec.0d5";
                group (run_addr=(INTTAB1)+0x1ac0) select ".text.inttab1.intvec.0d6";
                group (run_addr=(INTTAB1)+0x1ae0) select ".text.inttab1.intvec.0d7";
                group (run_addr=(INTTAB1)+0x1b00) select ".text.inttab1.intvec.0d8";
                group (run_addr=(INTTAB1)+0x1b20) select ".text.inttab1.intvec.0d9";
                group (run_addr=(INTTAB1)+0x1b40) select ".text.inttab1.intvec.0da";
                group (run_addr=(INTTAB1)+0x1b60) select ".text.inttab1.intvec.0db";
                group (run_addr=(INTTAB1)+0x1b80) select ".text.inttab1.intvec.0dc";
                group (run_addr=(INTTAB1)+0x1ba0) select ".text.inttab1.intvec.0dd";
                group (run_addr=(INTTAB1)+0x1bc0) select ".text.inttab1.intvec.0de";
                group (run_addr=(INTTAB1)+0x1be0) select ".text.inttab1.intvec.0df";
                group (run_addr=(INTTAB1)+0x1c00) select ".text.inttab1.intvec.0e0";
                group (run_addr=(INTTAB1)+0x1c20) select ".text.inttab1.intvec.0e1";
                group (run_addr=(INTTAB1)+0x1c40) select ".text.inttab1.intvec.0e2";
                group (run_addr=(INTTAB1)+0x1c60) select ".text.inttab1.intvec.0e3";
                group (run_addr=(INTTAB1)+0x1c80) select ".text.inttab1.intvec.0e4";
                group (run_addr=(INTTAB1)+0x1ca0) select ".text.inttab1.intvec.0e5";
                group (run_addr=(INTTAB1)+0x1cc0) select ".text.inttab1.intvec.0e6";
                group (run_addr=(INTTAB1)+0x1ce0) select ".text.inttab1.intvec.0e7";
                group (run_addr=(INTTAB1)+0x1d00) select ".text.inttab1.intvec.0e8";
                group (run_addr=(INTTAB1)+0x1d20) select ".text.inttab1.intvec.0e9";
                group (run_addr=(INTTAB1)+0x1d40) select ".text.inttab1.intvec.0ea";
                group (run_addr=(INTTAB1)+0x1d60) select ".text.inttab1.intvec.0eb";
                group (run_addr=(INTTAB1)+0x1d80) select ".text.inttab1.intvec.0ec";
                group (run_addr=(INTTAB1)+0x1da0) select ".text.inttab1.intvec.0ed";
                group (run_addr=(INTTAB1)+0x1dc0) select ".text.inttab1.intvec.0ee";
                group (run_addr=(INTTAB1)+0x1de0) select ".text.inttab1.intvec.0ef";
                group (run_addr=(INTTAB1)+0x1e00) select ".text.inttab1.intvec.0f0";
                group (run_addr=(INTTAB1)+0x1e20) select ".text.inttab1.intvec.0f1";
                group (run_addr=(INTTAB1)+0x1e40) select ".text.inttab1.intvec.0f2";
                group (run_addr=(INTTAB1)+0x1e60) select ".text.inttab1.intvec.0f3";
                group (run_addr=(INTTAB1)+0x1e80) select ".text.inttab1.intvec.0f4";
                group (run_addr=(INTTAB1)+0x1ea0) select ".text.inttab1.intvec.0f5";
                group (run_addr=(INTTAB1)+0x1ec0) select ".text.inttab1.intvec.0f6";
                group (run_addr=(INTTAB1)+0x1ee0) select ".text.inttab1.intvec.0f7";
                group (run_addr=(INTTAB1)+0x1f00) select ".text.inttab1.intvec.0f8";
                group (run_addr=(INTTAB1)+0x1f20) select ".text.inttab1.intvec.0f9";
                group (run_addr=(INTTAB1)+0x1f40) select ".text.inttab1.intvec.0fa";
                group (run_addr=(INTTAB1)+0x1f60) select ".text.inttab1.intvec.0fb";
                group (run_addr=(INTTAB1)+0x1f80) select ".text.inttab1.intvec.0fc";
                group (run_addr=(INTTAB1)+0x1fa0) select ".text.inttab1.intvec.0fd";
                group (run_addr=(INTTAB1)+0x1fc0) select ".text.inttab1.intvec.0fe";
                group (run_addr=(INTTAB1)+0x1fe0) select ".text.inttab1.intvec.0ff";
                group (run_addr=(INTTAB1)+0x0000) select ".text.inttab1.intvec8.000";
                group (run_addr=(INTTAB1)+0x0008) select ".text.inttab1.intvec8.001";
                group (run_addr=(INTTAB1)+0x0010) select ".text.inttab1.intvec8.002";
                group (run_addr=(INTTAB1)+0x0018) select ".text.inttab1.intvec8.003";
                group (run_addr=(INTTAB1)+0x0020) select ".text.inttab1.intvec8.004";
                group (run_addr=(INTTAB1)+0x0028) select ".text.inttab1.intvec8.005";
                group (run_addr=(INTTAB1)+0x0030) select ".text.inttab1.intvec8.006";
                group (run_addr=(INTTAB1)+0x0038) select ".text.inttab1.intvec8.007";
                group (run_addr=(INTTAB1)+0x0040) select ".text.inttab1.intvec8.008";
                group (run_addr=(INTTAB1)+0x0048) select ".text.inttab1.intvec8.009";
                group (run_addr=(INTTAB1)+0x0050) select ".text.inttab1.intvec8.00a";
                group (run_addr=(INTTAB1)+0x0058) select ".text.inttab1.intvec8.00b";
                group (run_addr=(INTTAB1)+0x0060) select ".text.inttab1.intvec8.00c";
                group (run_addr=(INTTAB1)+0x0068) select ".text.inttab1.intvec8.00d";
                group (run_addr=(INTTAB1)+0x0070) select ".text.inttab1.intvec8.00e";
                group (run_addr=(INTTAB1)+0x0078) select ".text.inttab1.intvec8.00f";
                group (run_addr=(INTTAB1)+0x0080) select ".text.inttab1.intvec8.010";
                group (run_addr=(INTTAB1)+0x0088) select ".text.inttab1.intvec8.011";
                group (run_addr=(INTTAB1)+0x0090) select ".text.inttab1.intvec8.012";
                group (run_addr=(INTTAB1)+0x0098) select ".text.inttab1.intvec8.013";
                group (run_addr=(INTTAB1)+0x00a0) select ".text.inttab1.intvec8.014";
                group (run_addr=(INTTAB1)+0x00a8) select ".text.inttab1.intvec8.015";
                group (run_addr=(INTTAB1)+0x00b0) select ".text.inttab1.intvec8.016";
                group (run_addr=(INTTAB1)+0x00b8) select ".text.inttab1.intvec8.017";
                group (run_addr=(INTTAB1)+0x00c0) select ".text.inttab1.intvec8.018";
                group (run_addr=(INTTAB1)+0x00c8) select ".text.inttab1.intvec8.019";
                group (run_addr=(INTTAB1)+0x00d0) select ".text.inttab1.intvec8.01a";
                group (run_addr=(INTTAB1)+0x00d8) select ".text.inttab1.intvec8.01b";
                group (run_addr=(INTTAB1)+0x00e0) select ".text.inttab1.intvec8.01c";
                group (run_addr=(INTTAB1)+0x00e8) select ".text.inttab1.intvec8.01d";
                group (run_addr=(INTTAB1)+0x00f0) select ".text.inttab1.intvec8.01e";
                group (run_addr=(INTTAB1)+0x00f8) select ".text.inttab1.intvec8.01f";
                group (run_addr=(INTTAB1)+0x0100) select ".text.inttab1.intvec8.020";
                group (run_addr=(INTTAB1)+0x0108) select ".text.inttab1.intvec8.021";
                group (run_addr=(INTTAB1)+0x0110) select ".text.inttab1.intvec8.022";
                group (run_addr=(INTTAB1)+0x0118) select ".text.inttab1.intvec8.023";
                group (run_addr=(INTTAB1)+0x0120) select ".text.inttab1.intvec8.024";
                group (run_addr=(INTTAB1)+0x0128) select ".text.inttab1.intvec8.025";
                group (run_addr=(INTTAB1)+0x0130) select ".text.inttab1.intvec8.026";
                group (run_addr=(INTTAB1)+0x0138) select ".text.inttab1.intvec8.027";
                group (run_addr=(INTTAB1)+0x0140) select ".text.inttab1.intvec8.028";
                group (run_addr=(INTTAB1)+0x0148) select ".text.inttab1.intvec8.029";
                group (run_addr=(INTTAB1)+0x0150) select ".text.inttab1.intvec8.02a";
                group (run_addr=(INTTAB1)+0x0158) select ".text.inttab1.intvec8.02b";
                group (run_addr=(INTTAB1)+0x0160) select ".text.inttab1.intvec8.02c";
                group (run_addr=(INTTAB1)+0x0168) select ".text.inttab1.intvec8.02d";
                group (run_addr=(INTTAB1)+0x0170) select ".text.inttab1.intvec8.02e";
                group (run_addr=(INTTAB1)+0x0178) select ".text.inttab1.intvec8.02f";
                group (run_addr=(INTTAB1)+0x0180) select ".text.inttab1.intvec8.030";
                group (run_addr=(INTTAB1)+0x0188) select ".text.inttab1.intvec8.031";
                group (run_addr=(INTTAB1)+0x0190) select ".text.inttab1.intvec8.032";
                group (run_addr=(INTTAB1)+0x0198) select ".text.inttab1.intvec8.033";
                group (run_addr=(INTTAB1)+0x01a0) select ".text.inttab1.intvec8.034";
                group (run_addr=(INTTAB1)+0x01a8) select ".text.inttab1.intvec8.035";
                group (run_addr=(INTTAB1)+0x01b0) select ".text.inttab1.intvec8.036";
                group (run_addr=(INTTAB1)+0x01b8) select ".text.inttab1.intvec8.037";
                group (run_addr=(INTTAB1)+0x01c0) select ".text.inttab1.intvec8.038";
                group (run_addr=(INTTAB1)+0x01c8) select ".text.inttab1.intvec8.039";
                group (run_addr=(INTTAB1)+0x01d0) select ".text.inttab1.intvec8.03a";
                group (run_addr=(INTTAB1)+0x01d8) select ".text.inttab1.intvec8.03b";
                group (run_addr=(INTTAB1)+0x01e0) select ".text.inttab1.intvec8.03c";
                group (run_addr=(INTTAB1)+0x01e8) select ".text.inttab1.intvec8.03d";
                group (run_addr=(INTTAB1)+0x01f0) select ".text.inttab1.intvec8.03e";
                group (run_addr=(INTTAB1)+0x01f8) select ".text.inttab1.intvec8.03f";
                group (run_addr=(INTTAB1)+0x0200) select ".text.inttab1.intvec8.040";
                group (run_addr=(INTTAB1)+0x0208) select ".text.inttab1.intvec8.041";
                group (run_addr=(INTTAB1)+0x0210) select ".text.inttab1.intvec8.042";
                group (run_addr=(INTTAB1)+0x0218) select ".text.inttab1.intvec8.043";
                group (run_addr=(INTTAB1)+0x0220) select ".text.inttab1.intvec8.044";
                group (run_addr=(INTTAB1)+0x0228) select ".text.inttab1.intvec8.045";
                group (run_addr=(INTTAB1)+0x0230) select ".text.inttab1.intvec8.046";
                group (run_addr=(INTTAB1)+0x0238) select ".text.inttab1.intvec8.047";
                group (run_addr=(INTTAB1)+0x0240) select ".text.inttab1.intvec8.048";
                group (run_addr=(INTTAB1)+0x0248) select ".text.inttab1.intvec8.049";
                group (run_addr=(INTTAB1)+0x0250) select ".text.inttab1.intvec8.04a";
                group (run_addr=(INTTAB1)+0x0258) select ".text.inttab1.intvec8.04b";
                group (run_addr=(INTTAB1)+0x0260) select ".text.inttab1.intvec8.04c";
                group (run_addr=(INTTAB1)+0x0268) select ".text.inttab1.intvec8.04d";
                group (run_addr=(INTTAB1)+0x0270) select ".text.inttab1.intvec8.04e";
                group (run_addr=(INTTAB1)+0x0278) select ".text.inttab1.intvec8.04f";
                group (run_addr=(INTTAB1)+0x0280) select ".text.inttab1.intvec8.050";
                group (run_addr=(INTTAB1)+0x0288) select ".text.inttab1.intvec8.051";
                group (run_addr=(INTTAB1)+0x0290) select ".text.inttab1.intvec8.052";
                group (run_addr=(INTTAB1)+0x0298) select ".text.inttab1.intvec8.053";
                group (run_addr=(INTTAB1)+0x02a0) select ".text.inttab1.intvec8.054";
                group (run_addr=(INTTAB1)+0x02a8) select ".text.inttab1.intvec8.055";
                group (run_addr=(INTTAB1)+0x02b0) select ".text.inttab1.intvec8.056";
                group (run_addr=(INTTAB1)+0x02b8) select ".text.inttab1.intvec8.057";
                group (run_addr=(INTTAB1)+0x02c0) select ".text.inttab1.intvec8.058";
                group (run_addr=(INTTAB1)+0x02c8) select ".text.inttab1.intvec8.059";
                group (run_addr=(INTTAB1)+0x02d0) select ".text.inttab1.intvec8.05a";
                group (run_addr=(INTTAB1)+0x02d8) select ".text.inttab1.intvec8.05b";
                group (run_addr=(INTTAB1)+0x02e0) select ".text.inttab1.intvec8.05c";
                group (run_addr=(INTTAB1)+0x02e8) select ".text.inttab1.intvec8.05d";
                group (run_addr=(INTTAB1)+0x02f0) select ".text.inttab1.intvec8.05e";
                group (run_addr=(INTTAB1)+0x02f8) select ".text.inttab1.intvec8.05f";
                group (run_addr=(INTTAB1)+0x0300) select ".text.inttab1.intvec8.060";
                group (run_addr=(INTTAB1)+0x0308) select ".text.inttab1.intvec8.061";
                group (run_addr=(INTTAB1)+0x0310) select ".text.inttab1.intvec8.062";
                group (run_addr=(INTTAB1)+0x0318) select ".text.inttab1.intvec8.063";
                group (run_addr=(INTTAB1)+0x0320) select ".text.inttab1.intvec8.064";
                group (run_addr=(INTTAB1)+0x0328) select ".text.inttab1.intvec8.065";
                group (run_addr=(INTTAB1)+0x0330) select ".text.inttab1.intvec8.066";
                group (run_addr=(INTTAB1)+0x0338) select ".text.inttab1.intvec8.067";
                group (run_addr=(INTTAB1)+0x0340) select ".text.inttab1.intvec8.068";
                group (run_addr=(INTTAB1)+0x0348) select ".text.inttab1.intvec8.069";
                group (run_addr=(INTTAB1)+0x0350) select ".text.inttab1.intvec8.06a";
                group (run_addr=(INTTAB1)+0x0358) select ".text.inttab1.intvec8.06b";
                group (run_addr=(INTTAB1)+0x0360) select ".text.inttab1.intvec8.06c";
                group (run_addr=(INTTAB1)+0x0368) select ".text.inttab1.intvec8.06d";
                group (run_addr=(INTTAB1)+0x0370) select ".text.inttab1.intvec8.06e";
                group (run_addr=(INTTAB1)+0x0378) select ".text.inttab1.intvec8.06f";
                group (run_addr=(INTTAB1)+0x0380) select ".text.inttab1.intvec8.070";
                group (run_addr=(INTTAB1)+0x0388) select ".text.inttab1.intvec8.071";
                group (run_addr=(INTTAB1)+0x0390) select ".text.inttab1.intvec8.072";
                group (run_addr=(INTTAB1)+0x0398) select ".text.inttab1.intvec8.073";
                group (run_addr=(INTTAB1)+0x03a0) select ".text.inttab1.intvec8.074";
                group (run_addr=(INTTAB1)+0x03a8) select ".text.inttab1.intvec8.075";
                group (run_addr=(INTTAB1)+0x03b0) select ".text.inttab1.intvec8.076";
                group (run_addr=(INTTAB1)+0x03b8) select ".text.inttab1.intvec8.077";
                group (run_addr=(INTTAB1)+0x03c0) select ".text.inttab1.intvec8.078";
                group (run_addr=(INTTAB1)+0x03c8) select ".text.inttab1.intvec8.079";
                group (run_addr=(INTTAB1)+0x03d0) select ".text.inttab1.intvec8.07a";
                group (run_addr=(INTTAB1)+0x03d8) select ".text.inttab1.intvec8.07b";
                group (run_addr=(INTTAB1)+0x03e0) select ".text.inttab1.intvec8.07c";
                group (run_addr=(INTTAB1)+0x03e8) select ".text.inttab1.intvec8.07d";
                group (run_addr=(INTTAB1)+0x03f0) select ".text.inttab1.intvec8.07e";
                group (run_addr=(INTTAB1)+0x03f8) select ".text.inttab1.intvec8.07f";
                group (run_addr=(INTTAB1)+0x0400) select ".text.inttab1.intvec8.080";
                group (run_addr=(INTTAB1)+0x0408) select ".text.inttab1.intvec8.081";
                group (run_addr=(INTTAB1)+0x0410) select ".text.inttab1.intvec8.082";
                group (run_addr=(INTTAB1)+0x0418) select ".text.inttab1.intvec8.083";
                group (run_addr=(INTTAB1)+0x0420) select ".text.inttab1.intvec8.084";
                group (run_addr=(INTTAB1)+0x0428) select ".text.inttab1.intvec8.085";
                group (run_addr=(INTTAB1)+0x0430) select ".text.inttab1.intvec8.086";
                group (run_addr=(INTTAB1)+0x0438) select ".text.inttab1.intvec8.087";
                group (run_addr=(INTTAB1)+0x0440) select ".text.inttab1.intvec8.088";
                group (run_addr=(INTTAB1)+0x0448) select ".text.inttab1.intvec8.089";
                group (run_addr=(INTTAB1)+0x0450) select ".text.inttab1.intvec8.08a";
                group (run_addr=(INTTAB1)+0x0458) select ".text.inttab1.intvec8.08b";
                group (run_addr=(INTTAB1)+0x0460) select ".text.inttab1.intvec8.08c";
                group (run_addr=(INTTAB1)+0x0468) select ".text.inttab1.intvec8.08d";
                group (run_addr=(INTTAB1)+0x0470) select ".text.inttab1.intvec8.08e";
                group (run_addr=(INTTAB1)+0x0478) select ".text.inttab1.intvec8.08f";
                group (run_addr=(INTTAB1)+0x0480) select ".text.inttab1.intvec8.090";
                group (run_addr=(INTTAB1)+0x0488) select ".text.inttab1.intvec8.091";
                group (run_addr=(INTTAB1)+0x0490) select ".text.inttab1.intvec8.092";
                group (run_addr=(INTTAB1)+0x0498) select ".text.inttab1.intvec8.093";
                group (run_addr=(INTTAB1)+0x04a0) select ".text.inttab1.intvec8.094";
                group (run_addr=(INTTAB1)+0x04a8) select ".text.inttab1.intvec8.095";
                group (run_addr=(INTTAB1)+0x04b0) select ".text.inttab1.intvec8.096";
                group (run_addr=(INTTAB1)+0x04b8) select ".text.inttab1.intvec8.097";
                group (run_addr=(INTTAB1)+0x04c0) select ".text.inttab1.intvec8.098";
                group (run_addr=(INTTAB1)+0x04c8) select ".text.inttab1.intvec8.099";
                group (run_addr=(INTTAB1)+0x04d0) select ".text.inttab1.intvec8.09a";
                group (run_addr=(INTTAB1)+0x04d8) select ".text.inttab1.intvec8.09b";
                group (run_addr=(INTTAB1)+0x04e0) select ".text.inttab1.intvec8.09c";
                group (run_addr=(INTTAB1)+0x04e8) select ".text.inttab1.intvec8.09d";
                group (run_addr=(INTTAB1)+0x04f0) select ".text.inttab1.intvec8.09e";
                group (run_addr=(INTTAB1)+0x04f8) select ".text.inttab1.intvec8.09f";
                group (run_addr=(INTTAB1)+0x0500) select ".text.inttab1.intvec8.0a0";
                group (run_addr=(INTTAB1)+0x0508) select ".text.inttab1.intvec8.0a1";
                group (run_addr=(INTTAB1)+0x0510) select ".text.inttab1.intvec8.0a2";
                group (run_addr=(INTTAB1)+0x0518) select ".text.inttab1.intvec8.0a3";
                group (run_addr=(INTTAB1)+0x0520) select ".text.inttab1.intvec8.0a4";
                group (run_addr=(INTTAB1)+0x0528) select ".text.inttab1.intvec8.0a5";
                group (run_addr=(INTTAB1)+0x0530) select ".text.inttab1.intvec8.0a6";
                group (run_addr=(INTTAB1)+0x0538) select ".text.inttab1.intvec8.0a7";
                group (run_addr=(INTTAB1)+0x0540) select ".text.inttab1.intvec8.0a8";
                group (run_addr=(INTTAB1)+0x0548) select ".text.inttab1.intvec8.0a9";
                group (run_addr=(INTTAB1)+0x0550) select ".text.inttab1.intvec8.0aa";
                group (run_addr=(INTTAB1)+0x0558) select ".text.inttab1.intvec8.0ab";
                group (run_addr=(INTTAB1)+0x0560) select ".text.inttab1.intvec8.0ac";
                group (run_addr=(INTTAB1)+0x0568) select ".text.inttab1.intvec8.0ad";
                group (run_addr=(INTTAB1)+0x0570) select ".text.inttab1.intvec8.0ae";
                group (run_addr=(INTTAB1)+0x0578) select ".text.inttab1.intvec8.0af";
                group (run_addr=(INTTAB1)+0x0580) select ".text.inttab1.intvec8.0b0";
                group (run_addr=(INTTAB1)+0x0588) select ".text.inttab1.intvec8.0b1";
                group (run_addr=(INTTAB1)+0x0590) select ".text.inttab1.intvec8.0b2";
                group (run_addr=(INTTAB1)+0x0598) select ".text.inttab1.intvec8.0b3";
                group (run_addr=(INTTAB1)+0x05a0) select ".text.inttab1.intvec8.0b4";
                group (run_addr=(INTTAB1)+0x05a8) select ".text.inttab1.intvec8.0b5";
                group (run_addr=(INTTAB1)+0x05b0) select ".text.inttab1.intvec8.0b6";
                group (run_addr=(INTTAB1)+0x05b8) select ".text.inttab1.intvec8.0b7";
                group (run_addr=(INTTAB1)+0x05c0) select ".text.inttab1.intvec8.0b8";
                group (run_addr=(INTTAB1)+0x05c8) select ".text.inttab1.intvec8.0b9";
                group (run_addr=(INTTAB1)+0x05d0) select ".text.inttab1.intvec8.0ba";
                group (run_addr=(INTTAB1)+0x05d8) select ".text.inttab1.intvec8.0bb";
                group (run_addr=(INTTAB1)+0x05e0) select ".text.inttab1.intvec8.0bc";
                group (run_addr=(INTTAB1)+0x05e8) select ".text.inttab1.intvec8.0bd";
                group (run_addr=(INTTAB1)+0x05f0) select ".text.inttab1.intvec8.0be";
                group (run_addr=(INTTAB1)+0x05f8) select ".text.inttab1.intvec8.0bf";
                group (run_addr=(INTTAB1)+0x0600) select ".text.inttab1.intvec8.0c0";
                group (run_addr=(INTTAB1)+0x0608) select ".text.inttab1.intvec8.0c1";
                group (run_addr=(INTTAB1)+0x0610) select ".text.inttab1.intvec8.0c2";
                group (run_addr=(INTTAB1)+0x0618) select ".text.inttab1.intvec8.0c3";
                group (run_addr=(INTTAB1)+0x0620) select ".text.inttab1.intvec8.0c4";
                group (run_addr=(INTTAB1)+0x0628) select ".text.inttab1.intvec8.0c5";
                group (run_addr=(INTTAB1)+0x0630) select ".text.inttab1.intvec8.0c6";
                group (run_addr=(INTTAB1)+0x0638) select ".text.inttab1.intvec8.0c7";
                group (run_addr=(INTTAB1)+0x0640) select ".text.inttab1.intvec8.0c8";
                group (run_addr=(INTTAB1)+0x0648) select ".text.inttab1.intvec8.0c9";
                group (run_addr=(INTTAB1)+0x0650) select ".text.inttab1.intvec8.0ca";
                group (run_addr=(INTTAB1)+0x0658) select ".text.inttab1.intvec8.0cb";
                group (run_addr=(INTTAB1)+0x0660) select ".text.inttab1.intvec8.0cc";
                group (run_addr=(INTTAB1)+0x0668) select ".text.inttab1.intvec8.0cd";
                group (run_addr=(INTTAB1)+0x0670) select ".text.inttab1.intvec8.0ce";
                group (run_addr=(INTTAB1)+0x0678) select ".text.inttab1.intvec8.0cf";
                group (run_addr=(INTTAB1)+0x0680) select ".text.inttab1.intvec8.0d0";
                group (run_addr=(INTTAB1)+0x0688) select ".text.inttab1.intvec8.0d1";
                group (run_addr=(INTTAB1)+0x0690) select ".text.inttab1.intvec8.0d2";
                group (run_addr=(INTTAB1)+0x0698) select ".text.inttab1.intvec8.0d3";
                group (run_addr=(INTTAB1)+0x06a0) select ".text.inttab1.intvec8.0d4";
                group (run_addr=(INTTAB1)+0x06a8) select ".text.inttab1.intvec8.0d5";
                group (run_addr=(INTTAB1)+0x06b0) select ".text.inttab1.intvec8.0d6";
                group (run_addr=(INTTAB1)+0x06b8) select ".text.inttab1.intvec8.0d7";
                group (run_addr=(INTTAB1)+0x06c0) select ".text.inttab1.intvec8.0d8";
                group (run_addr=(INTTAB1)+0x06c8) select ".text.inttab1.intvec8.0d9";
                group (run_addr=(INTTAB1)+0x06d0) select ".text.inttab1.intvec8.0da";
                group (run_addr=(INTTAB1)+0x06d8) select ".text.inttab1.intvec8.0db";
                group (run_addr=(INTTAB1)+0x06e0) select ".text.inttab1.intvec8.0dc";
                group (run_addr=(INTTAB1)+0x06e8) select ".text.inttab1.intvec8.0dd";
                group (run_addr=(INTTAB1)+0x06f0) select ".text.inttab1.intvec8.0de";
                group (run_addr=(INTTAB1)+0x06f8) select ".text.inttab1.intvec8.0df";
                group (run_addr=(INTTAB1)+0x0700) select ".text.inttab1.intvec8.0e0";
                group (run_addr=(INTTAB1)+0x0708) select ".text.inttab1.intvec8.0e1";
                group (run_addr=(INTTAB1)+0x0710) select ".text.inttab1.intvec8.0e2";
                group (run_addr=(INTTAB1)+0x0718) select ".text.inttab1.intvec8.0e3";
                group (run_addr=(INTTAB1)+0x0720) select ".text.inttab1.intvec8.0e4";
                group (run_addr=(INTTAB1)+0x0728) select ".text.inttab1.intvec8.0e5";
                group (run_addr=(INTTAB1)+0x0730) select ".text.inttab1.intvec8.0e6";
                group (run_addr=(INTTAB1)+0x0738) select ".text.inttab1.intvec8.0e7";
                group (run_addr=(INTTAB1)+0x0740) select ".text.inttab1.intvec8.0e8";
                group (run_addr=(INTTAB1)+0x0748) select ".text.inttab1.intvec8.0e9";
                group (run_addr=(INTTAB1)+0x0750) select ".text.inttab1.intvec8.0ea";
                group (run_addr=(INTTAB1)+0x0758) select ".text.inttab1.intvec8.0eb";
                group (run_addr=(INTTAB1)+0x0760) select ".text.inttab1.intvec8.0ec";
                group (run_addr=(INTTAB1)+0x0768) select ".text.inttab1.intvec8.0ed";
                group (run_addr=(INTTAB1)+0x0770) select ".text.inttab1.intvec8.0ee";
                group (run_addr=(INTTAB1)+0x0778) select ".text.inttab1.intvec8.0ef";
                group (run_addr=(INTTAB1)+0x0780) select ".text.inttab1.intvec8.0f0";
                group (run_addr=(INTTAB1)+0x0788) select ".text.inttab1.intvec8.0f1";
                group (run_addr=(INTTAB1)+0x0790) select ".text.inttab1.intvec8.0f2";
                group (run_addr=(INTTAB1)+0x0798) select ".text.inttab1.intvec8.0f3";
                group (run_addr=(INTTAB1)+0x07a0) select ".text.inttab1.intvec8.0f4";
                group (run_addr=(INTTAB1)+0x07a8) select ".text.inttab1.intvec8.0f5";
                group (run_addr=(INTTAB1)+0x07b0) select ".text.inttab1.intvec8.0f6";
                group (run_addr=(INTTAB1)+0x07b8) select ".text.inttab1.intvec8.0f7";
                group (run_addr=(INTTAB1)+0x07c0) select ".text.inttab1.intvec8.0f8";
                group (run_addr=(INTTAB1)+0x07c8) select ".text.inttab1.intvec8.0f9";
                group (run_addr=(INTTAB1)+0x07d0) select ".text.inttab1.intvec8.0fa";
                group (run_addr=(INTTAB1)+0x07d8) select ".text.inttab1.intvec8.0fb";
                group (run_addr=(INTTAB1)+0x07e0) select ".text.inttab1.intvec8.0fc";
                group (run_addr=(INTTAB1)+0x07e8) select ".text.inttab1.intvec8.0fd";
                group (run_addr=(INTTAB1)+0x07f0) select ".text.inttab1.intvec8.0fe";
                group (run_addr=(INTTAB1)+0x07f8) select ".text.inttab1.intvec8.0ff";
            }
            "__INTTAB_CPU1" = (LCF_INTVEC1_START);
        }
    }

    /*Near Abbsolute Addressable Data Sections*/
    section_layout :vtc:abs18
    {
        /*Near Absolute Data, selectable with patterns and user defined sections*/
        group
        {
            group (ordered, contiguous, align = 4, attributes=rw, run_addr = mem:dsram1)
            {
                select "(.zdata.zdata_cpu1|.zdata.zdata_cpu1.*)";
                select "(.zbss.zbss_cpu1|.zbss.zbss_cpu1.*)";
            }

        }

        /*Near Absolute Data, selectable by toolchain*/
#        if LCF_DEFAULT_HOST == LCF_CPU1
        group (ordered, contiguous, align = 4, attributes=rw, run_addr = mem:dsram1)
#        endif
        {
            group zdata_mcal(attributes=rw)
            {
                select ".zdata.dsprInit.cpu1.32bit";
                select ".zdata.dsprInit.cpu1.16bit";
                select ".zdata.dsprInit.cpu1.8bit";
            }
            
            group zdata_powerOn(attributes=rw)
            {
                select ".zdata.dsprPowerOnInit.cpu1.32bit";
                select ".zdata.dsprPowerOnInit.cpu1.16bit";
                select ".zdata.dsprPowerOnInit.cpu1.8bit";
            }
            
            group zbss_mcal(attributes=rw)
            {
                select ".zbss.dsprClearOnInit.cpu1.32bit";
                select ".zbss.dsprClearOnInit.cpu1.16bit";
                select ".zbss.dsprClearOnInit.cpu1.8bit";
            }
            
            group zbss_noClear(attributes=rw)
            {
                select ".zbss.dsprNoInit.cpu1.32bit";
                select ".zbss.dsprNoInit.cpu1.16bit";
                select ".zbss.dsprNoInit.cpu1.8bit";
            }
            
            group zbss_powerOn(attributes=rw)
            {
                select ".zbss.dsprPowerOnClear.cpu1.32bit";
                select ".zbss.dsprPowerOnClear.cpu1.16bit";
                select ".zbss.dsprPowerOnClear.cpu1.8bit";
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
            group (ordered, contiguous, align = 4, attributes=r, run_addr=mem:pfls1)
            {
                select ".zrodata.Ifx_Ssw_Tc1.*";
                select ".zrodata.Cpu1_Main.*";
                
                /*Near Absolute Const, selectable by toolchain*/
                select ".zrodata.const.cpu1.32bit";
                select ".zrodata.const.cpu1.16bit";
                select ".zrodata.const.cpu1.8bit";
                select ".zrodata.config.cpu1.32bit";
                select ".zrodata.config.cpu1.16bit";
                select ".zrodata.config.cpu1.8bit";
                select "(.zrodata|.zrodata.*)";
            }
        }
    }
    /*Relative A0/A1/A8/A9 Addressable Sections*/
    section_layout :vtc:linear
    {
        /*Relative A0 Addressable Data, selectable by toolchain*/
#        if LCF_DEFAULT_HOST == LCF_CPU1
        group a0 (ordered, contiguous, align = 4, attributes=rw, run_addr = mem:dsram1)
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
#        if LCF_DEFAULT_HOST == LCF_CPU1
        group  a1 (ordered, align = 4, attributes=r, run_addr=mem:pfls1)
#        endif
        {
			select "(.srodata|.srodata.*)";
            select "(.ldata|.ldata.*)";
			select "(.rodata_a1|.rodata_a1.*)";
        }
        "_LITERAL_DATA_" := sizeof(group:a1) > 0 ? addressof(group:a1) : addressof(group:a1) & 0xF0000000 + 32k;
        "__A1_MEM" = "_LITERAL_DATA_";
        
        /*Relative A9 Addressable Data, selectable with patterns and user defined sections*/
        group a9 (ordered, align = 4, run_addr=mem:cpu1_dlmu)
        {
            select "(.a9sdata|.a9sdata.*)";
            select "(.data_a9|.data_a9.*)";
            select "(.a9sbss|.a9sbss.*)";
            select "(.bss_a9|.bss_a9.*)";
        }
        "_A9_DATA_" := sizeof(group:a9) > 0 ? addressof(group:a9) : addressof(group:a9) & 0xF0000000 + 32k;
        "__A9_MEM" = "_A9_DATA_";

        /*Relative A8 Addressable Const, selectable with patterns and user defined sections*/
#        if LCF_DEFAULT_HOST == LCF_CPU1
        group  a8 (ordered, align = 4, run_addr=mem:pfls1)
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
                group (ordered, attributes=rw, run_addr=mem:dsram1)
                {
                    select ".data.Ifx_Ssw_Tc1.*";
                    select ".data.Cpu1_Main.*";
                    select "(.data.data_cpu1|.data.data_cpu1.*)";
                    select ".bss.Ifx_Ssw_Tc1.*";
                    select ".bss.Cpu1_Main.*";
                    select "(.bss.bss_cpu1|.bss.bss_cpu1.*)";
                }
            }

            /*LMU Data sections*/
            group
            {
                group (ordered, attributes=rw, run_addr = mem:cpu1_dlmu)
                {
                    select "(.data.lmudata_cpu1|.data.lmudata_cpu1.*)";
                    select "(.bss.lmubss_cpu1|.bss.lmubss_cpu1.*)";
                }
	    }
        group
        {
            /*LMU Shared variable for TriCore CPUs*/
            group shared_lmuram (ordered, align = 4, attributes=rwu, run_addr=mem:cpu1_dlmu)
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
#        if LCF_DEFAULT_HOST == LCF_CPU1
        group (ordered, contiguous, align = 4, attributes=rw, run_addr = mem:dsram1)
#        endif
        {
            group data_mcal(attributes=rw)
            {
                select ".data.farDsprInit.cpu1.32bit";
                select ".data.farDsprInit.cpu1.16bit";
                select ".data.farDsprInit.cpu1.8bit";
            }

            group bss_mcal(attributes=rw)
            {
                select ".bss.farDsprClearOnInit.cpu1.32bit";
                select ".bss.farDsprClearOnInit.cpu1.16bit";
                select ".bss.farDsprClearOnInit.cpu1.8bit";
            }

            group bss_noInit(attributes=rw)
            {
                select ".bss.farDsprNoInit.cpu1.32bit";
                select ".bss.farDsprNoInit.cpu1.16bit";
                select ".bss.farDsprNoInit.cpu1.8bit";
            }

            group data(attributes=rw)
            {
                select "(.data|.data.*)";
                select "(.bss|.bss.*)";
            }
        }

        /*Heap allocation*/
#        if LCF_DEFAULT_HOST == LCF_CPU1
        group (ordered, align = 4, run_addr = mem:dsram1[LCF_HEAP1_OFFSET])
#        endif
        {
            heap "heap" (size = LCF_HEAP_SIZE);
        }

        /*Far Const Sections, selectable with patterns and user defined sections*/
        group
        {
            group (ordered, align = 4, attributes=r, run_addr=mem:pfls1)
            {
                select ".rodata.Ifx_Ssw_Tc1.*";
                select ".rodata.Cpu1_Main.*";
                select "(.rodata.rodata_cpu1|.rodata.rodata_cpu1.*)";
            }
        }

        /*Far Const Sections, selectable by toolchain*/
#        if LCF_DEFAULT_HOST == LCF_CPU1
        group (ordered, align = 4, run_addr=mem:pfls1)
#        endif
        {
            select ".rodata.farConst.cpu1.32bit";
            select ".rodata.farConst.cpu1.16bit";
            select ".rodata.farConst.cpu1.8bit";
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
                group code_psram1 (ordered, attributes=rwx, copy, run_addr=mem:psram1)
                {
                    select "(.text.cpu1_psram|.text.cpu1_psram.*)";
                    select "(.text.psram_text_cpu1|.text.psram_text_cpu1.*)";
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
                group (ordered, align = 4, attributes=rx, run_addr=mem:pfls1)
                {
                    select ".text.Ifx_Ssw_Tc1.*";
                    select ".text.Cpu1_Main.*";
                    select ".text.CompilerTasking.Ifx_C_Init";
                    select "(.text.text_cpu1|.text.text_cpu1.*)";
                }
            }
        }

        /*Code Sections, selectable by toolchain*/
#        if LCF_DEFAULT_HOST == LCF_CPU1
        group (ordered, run_addr=mem:pfls1)
#        endif
        {
            select ".text.fast.pfls.cpu1";
            select ".text.slow.pfls.cpu1";
            select ".text.5ms.pfls.cpu1";
            select ".text.10ms.pfls.cpu1";
            select ".text.callout.pfls.cpu1";
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
