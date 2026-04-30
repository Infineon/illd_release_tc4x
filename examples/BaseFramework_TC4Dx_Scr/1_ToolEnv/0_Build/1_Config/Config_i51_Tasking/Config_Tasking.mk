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

