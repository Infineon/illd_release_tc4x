###############################################################################
#                                                                             #
#       Copyright (c) 2019 Infineon Technologies AG. All rights reserved.     #
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

B_WINDRIVER_TRICORE_PATH= C:\Tools\Compilers\WindRiver-5.9.9.0\compilers\diab-5.9.9.0\WIN32

B_WINDRIVER_TRICORE_CC_OPTIONS= -ei1824 -ei4047 -ei7266 -O2 -tTC18MH:simple -Xdialect-c11 -Xenum-is-best -Xno-common \
        -Xkeep-assembly-file=2 -Xsection-split=1 -Xsmall-const=0 -Xsmall-data=0 -g3

B_WINDRIVER_TRICORE_CPP_OPTIONS= -ei1824 -ei4047 -ei7266 -O2 -tTC18MH:simple -Xdialect-c++11 -Xenum-is-best \
        -Xkeep-assembly-file=2 -Xsection-split=1 -Xsmall-const=0 -Xsmall-data=0 -g3

B_WINDRIVER_TRICORE_ASM_OPTIONS= $(B_WINDRIVER_TRICORE_CC_OPTIONS)

B_WINDRIVER_TRICORE_LD_OPTIONS= -tTC18MH:simple -m6 -Xremove-unused-sections

#Include path for library directories. Add each path with following format as shown below.
#Each path prefixed with -L and separated by a space.
#B_WINDRIVER_TRICORE_LIB_INC=-L<path>[ -L<path>][..]
B_WINDRIVER_TRICORE_LIB_INC=

B_WINDRIVER_TRICORE_LIBS= -lc -lcdinkum -lmdinkum