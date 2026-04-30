###############################################################################
#                                                                             #
#       Copyright (c) 2026 Infineon Technologies AG. All rights reserved.     #
#                                                                             #
#                                                                             #
#                              IMPORTANT NOTICE                               #
#                                                                             #
#                                                                             #
# Infineon Technologies AG (Infineon) licenses this file to you under the     #
# Infineon Automotive SW Lab License v2025-01 (IFASLL). You may not use       #
# this file except in compliance with IFASLL.                                 #
#                                                                             #
# The full license text is contained in IFASLL202501.pdf delivered with this  #
# SW. Unless required by applicable law or agreed to in writing, software     #
# distributed under this license is distributed "AS IS" without any warranty  #
# or liability of any kind and Infineon hereby expressly disclaims any        #
# warranties or representations, whether express, implied, statutory or       #
# otherwise, including but not limited to warranties of workmanship,          #
# merchantability, fitness for a particular purpose, defects in the licensed  #
# items, or non-infringement of third parties' intellectual property rights.  #
# See the full license text for the specific language governing permissions   #
# and limitations under IFASLL.                                               #
#                                                                             #
###############################################################################

B_WINDRIVER_TRICORE_PATH= C:\Tools\Compilers\WindRiver-5.9.9.1\compilers\diab-5.9.9.1\WIN32

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