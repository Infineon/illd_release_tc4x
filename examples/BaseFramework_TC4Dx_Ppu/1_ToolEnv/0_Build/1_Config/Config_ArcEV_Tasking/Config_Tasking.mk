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

B_TASKING_ARCEV_PATH= C:\Tools\Compilers\Tasking\SmartCode v10.3r1\carc

B_TASKING_BUILD_CONFIG= tc4dx

B_TASKING_ARCEV_CC_OPTIONS= --core=ppu_$(B_TASKING_BUILD_CONFIG) --fp-model=1 -DIFX_ILLD_PPU_USAGE \
	--global-type-checking --iso=11 --language=+volatile --optimize=2  --tradeoff=1 \
	--c++=11 --misrac-version=2012 -g

B_TASKING_ARCEV_ASM_OPTIONS= --core=ppu_$(B_TASKING_BUILD_CONFIG) --list-format=L1

B_TASKING_ARCEV_LD_OPTIONS= --global-type-checking -OcLtXY --force-c++ -Hlib=ev71_full

#Include path for library directories. Add each path with following format as shown below.
#Each path prefixed with -L and separated by a space.
#B_TASKING_ARCEV_LIB_INC=-L<path>[ -L<path>][..]
B_TASKING_ARCEV_LIB_INC= --include-directory="${B_TASKING_ARCEV_PATH}\include"

#Libraries to include shall be listed with option -l, with following format.
#B_GNUC_ARCEV_LIBS=-l<lib name>[ -l<lib name>][..]
B_TASKING_ARCEV_LIBS= -lrt -lc_fpu -L"$(subst \,/,${B_TASKING_ARCEV_PATH})/lib/$(B_TASKING_BUILD_CONFIG)"
