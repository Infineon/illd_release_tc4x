
architecture ARC_HS
{
    endianness
    {
        little;
    }
    
    space linear
    {
        id = 1;
        mau = 8;
        map           ( size = 4G, dest = bus:local_bus );
        start_address ( symbol = "_START" );
        copytable     ( align = 4, dest = linear);
        heap "heap"   ( align = 4, min_size=32k, fixed );
    }

    bus local_bus
    {
        mau = 8;
        width = 32;
    }
}

architecture PPU extends ARC_HS
{
}

architecture PPU_TC4Dx extends PPU
{
}


#define LCF_PPU_VSTACK_SIZE   1k
#define LCF_PPU_STACK_SIZE    5k

#define LCF_PPU_FLASH_SIZE    1024k 
#define LCF_PPU_FLASH_START   0x81300000

#define LCF_PPU_IF_POINTER    LCF_PPU_FLASH_START

#define LCF_PPU_VEC_START  LCF_PPU_FLASH_START+16
#define LCF_PPU_VEC_SIZE   84 * 4       

derivative PPU_TC4Dx 
{
    core ppu
    {
        architecture = PPU_TC4Dx;
    }
    
    bus ppu_bus
    {
        mau = 8;
        width = 32;
        map (size=4G, dest=bus:ppu:local_bus);
    }
    
    bus sys_bus
    {
        mau = 8;
        width = 32;
    }

    memory csm
    {
        mau = 8;
        type = ram;
        size = 512k;        
        map cached     ( dest = bus:ppu_bus, dest_offset = 0x92080000,           size = 512k );
        map not_cached ( dest = bus:ppu_bus, dest_offset = 0xB2080000, reserved, size = 512k );
    }

    memory vmem
    {
        mau = 8;
        type = ram;
        size = 128k;
        map            ( dest = bus:ppu_bus, dest_offset = 0xC0000000,           size = 128k );
    }
    
    memory lmu9
    {
        mau = 8;
        type = ram;
        size = 256k;
        map cached     ( dest = bus:ppu_bus, dest_offset = 0x90880000,           size = 256k );
        map not_cached ( dest = bus:ppu_bus, dest_offset = 0xB0880000, reserved, size = 256k );
    }

    memory pflash5_ppu
    {
        mau = 8;
        type = rom;
        size = LCF_PPU_FLASH_SIZE;
        map            ( dest = bus:ppu_bus, dest_offset = LCF_PPU_FLASH_START,  size = LCF_PPU_FLASH_SIZE );
    }
         

    section_setup :ppu:linear
    {
        vector_table "vector_table" (
                    template =        ".text.handler_address",
                    template_symbol = "_lc_vector_handler",
                    vector_prefix =   ".vector.",
                    vector_size =     4,
                    size =            84,
                    run_addr =        LCF_PPU_FLASH_START + 16,
                    fill =            loop,
                    no_inline )
        {
            vector( id = 0,       fill = "_START");
            vector( id = [1..15], fill = loop);
        }
        
    }
    
    section_setup :ppu:linear
    {
        stack "vstack" ( align = 4, grows = high_to_low, min_size = 1k);
        stack "stack"  ( align = 4, grows = high_to_low, min_size = 5k);
    }
    
    section_layout :ppu:linear
    {
        group(ordered, run_addr=mem:vmem)
        {
            select "(.vbss|.vbss.*)";
            select "(.vdata|.vdata.*)";
        }
        
        group(ordered,  run_addr=mem:vmem[sizeof(mem:vmem)-LCF_PPU_VSTACK_SIZE-8], attributes = s )
        {
            stack "vstack";
        }
        
        "__IF_CONST" := LCF_PPU_IF_POINTER;



        group(ordered,  run_addr=mem:csm[0x00] )
        {
            section ".hier_macht_der_TC_den_Vector_hin" (size=0x150, attributes=rwx)
            {
            	
            }
        }

        group(ordered,  run_addr=mem:csm )
        {
            stack "stack";
        }
        
        group(ordered, run_addr=mem:csm)
        {
            select "(.text.csmtext_ppu|.text.csmtext_ppu.*)";
        }
        
        group(ordered, align = 4, attributes=rwu, run_addr=mem:lmu9/not_cached)
        {
            select "(.bss.uncached|.bss.uncached.*)";
        }
        
        group(ordered, run_addr=mem:csm)
        {
            select "(.bss.csmbss_ppu|.bss.csmbss_ppu.*)";
        }
        
        group(ordered, run_addr=mem:csm)
        {
            	select "(.data.csmdata_ppu|.data.csmdata_ppu.*)";
            	select "(.data.*)";
        }
        
        group sda (ordered, run_addr=mem:csm)
        {

            select "(.sdata|.sdata.*)";
            select "(.sbss|.sbss.*)";
        }
        "_SDA_BASE_" := sizeof(group:sda) > 0 ? (addressof(group:sda) + (sizeof(group:sda) / 2)) & 0xFFFFFFFC : 0;
                
        group interface_table (ordered, run_addr=mem:pflash5_ppu)
        {
        	struct "my_IfTable"
			{
				LCF_PPU_VEC_START 			 : 4;
				0xB2080000 					 : 4;
				LCF_PPU_VEC_SIZE			 : 4;
				addressof(group:shared_data) : 4;
			}
        }
        
        // Next in the memory is the vector table then wee need a bit filler to get back to cache size
        
        group little_filler (ordered, run_addr=mem:pflash5_ppu[0x160])
       	{
       		 section "GetBackToCacheLineAlign" (size=32, attributes=rx, fill=[0x78, 0xE0])
       		 {
       		 
       		 }
       	}

        group(ordered, align=64, run_addr=mem:pflash5_ppu)
        {
        	section ".text" (blocksize=64, attributes=rx, fill=[0x78, 0xE0])
        	{
            	select "(.text|.text.*)";
        	}
        }
        
        group(ordered, align=64, run_addr=mem:pflash5_ppu)
        {
        	section "copy_table" (blocksize=256, attributes=rx, fill=[0x78, 0xE0])
        	{
            	select "table";
        	}
        }
        
        group(ordered, align=64, run_addr=mem:pflash5_ppu)
        {
        	section ".rodata" (blocksize=64, attributes=r, fill=[0x78, 0xE0])
        	{
            	select "(.rodata|.rodata.*)";
        	}
        }
        
        group ROM_COPY (ordered, align=64, run_addr=mem:pflash5_ppu)
        {

             section ".data_ROM" (blocksize=64, attributes=r, fill=[0x78, 0xE0])
             {
             	select "(\[.data.csmdata_ppu\]|\[.data.csmdata_ppu.*\])";
            	select "(\[.data.*\])";
            	select "(\[.sdata.*\])";
            	select "(\[.shared_data_ppu_tc.*\])";
            	select "(\[.shared_data_ppu_tc\])";
            	select "(\[.shared_data_ppu_tc\])";
            	select "(\[.vdata.*\])";
             }
        }



        group shared_data (ordered, attributes=rwu, run_addr=mem:lmu9/not_cached)
        {
            select "(*.shared_data_ppu_tc|*.shared_data_ppu_tc.*)";
            select "(*.shared_bss_ppu_tc|*.shared_bss_ppu_tc.*)";
        }
    }
     
}
