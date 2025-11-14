// include the generic scr architecture description
#include "arch_scr3g.lsl"

////////////////////////////////////////////////////////////////////////////
//
// memory definitions
//
memory iram
{
    mau = 8;
    type = ram;
    size = 256;
    map ( dest=bus:scr3g:idata_bus, src_offset=0x0, dest_offset=0x0, size=256 );
}
memory xram
{
    mau = 8;
    type = ram;
    size = 64k;
    map ( dest=bus:scr3g:xdata_bus, src_offset=0x0, dest_offset=0x0, size=64k );
}
memory xrom
{
    mau = 8;
    type = rom;
    size = 64k;
    map ( dest=bus:scr3g:code_bus, src_offset=0x0, dest_offset=0x0, size=64k );
}

//
// reserve the first and last byte of xdata to prevent unintentional xdata NULL pointers and to allow overflow check
//
section_setup scr3g:scr3g:xdata
{
    reserved (tag="prevent xdata NULL pointer") 0x0 .. 0x1;
    reserved (tag="allow xdata overflow check") 0xffff .. 0x10000;
}
#  if  __BASE_PDATA
//
// reserve the first byte of pdata to prevent unintentional pdata NULL pointers
//
section_setup scr3g:scr3g:pdata
{
    reserved (tag="prevent pdata NULL pointer") 0x0 .. 0x1;
}
#  endif /*  __BASE_PDATA */
