###############################################################################
#                                                                             #
#       Copyright (c) 2018 Infineon Technologies AG. All rights reserved.     #
#                                                                             #
#                                                                             #
#                              IMPORTANT NOTICE                               #
#                                                                             #
#                                                                             #
# Infineon Technologies AG (Infineon) is supplying this file for use          #
# exclusively with Infineon’s microcontroller products. This file can be      #
# freely distributed within development tools that are supporting such        #
# microcontroller products.                                                   #
#                                                                             #
# THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED #
# OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF          #
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.#
# INFINEON SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL,#
# OR CONSEQUENTIAL DAMAGES, FOR	ANY REASON WHATSOEVER.                        #
#                                                                             #
###############################################################################

B_GHS_TRICORE_PATH= C:\Tools\Compilers\GreenHills\2025.1

B_GHS_TRICORE_CC_OPTIONS= -c11 -cpu=tc1v18 -farcalls -frigor=accurate \
			-globalcheck=normal -globalcheck_qualifiers --gnu_asm -lnk=-no_append \
			-Mn -Mx -Ogeneral -Omax -sda=none -g -dwarf2

B_GHS_TRICORE_ASM_OPTIONS= $(B_GHS_TRICORE_CC_OPTIONS)

B_GHS_TRICORE_LD_OPTIONS= -cpu=tc1v18 -no-crt0 -delete -data_delete -ignore_debug_references

#Include path for library directories. Add each path with following format as shown below.
#Each path prefixed with -L and separated by a space.
#B_GHS_TRICORE_LIB_INC=-L<path>[ -L<path>][..]
B_GHS_TRICORE_LIB_INC= -L"$(B_GHS_TRICORE_PATH)/lib/tri18"

#Libraries to include shall be listed with option -l, with following format.
#B_GHS_TRICORE_LIBS=-l<lib name>[ -l<lib name>][..]
B_GHS_TRICORE_LIBS= -lsys -lwc_s32 -lansi -lstartup -lind_sf -larch -lmath_sd
