###############################################################################
#                                                                             #
#       Copyright (c) 2019 Infineon Technologies AG. All rights reserved.     #
#                                                                             #
#                                                                             #
#                              IMPORTANT NOTICE                               #
#                                                                             #
#                                                                             #
# Infineon Technologies AG (Infineon) is supplying this file for use          #
# exclusively with Infineon's microcontroller products. This file can be      #
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

B_TASKING_I51_PATH:= C:\Tools\Compilers\Tasking\SmartCode v10.4r1\c51

B_TASKING_I51_CC_OPTIONS= -Ms --registerbank=0 -Ag --core=scr3g

B_TASKING_I51_ASM_OPTIONS= $(B_TASKING_I51_CC_OPTIONS)

B_TASKING_I51_LD_OPTIONS= --core=scr3g

#Include path for library directories. Add each path with following format as shown below.
#Each path prefixed with -L and separated by a space.
#B_TASKING_8051_LIB_INC=-L<path>[ -L<path>][..]
B_TASKING_I51_LIB_INC=

#Libraries to include shall be listed with option -l, with following format.
#B_GNUC_8051_LIBS=-l<lib name>[ -l<lib name>][..]
B_TASKING_I51_LIBS:= -lc51ss0 -lfp51ls -lrt51

