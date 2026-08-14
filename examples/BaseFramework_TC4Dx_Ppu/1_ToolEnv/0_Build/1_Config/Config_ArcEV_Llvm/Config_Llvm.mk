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

B_LLVM_ARCEV_PATH= C:\Tools\Compilers\IFX_LLVM_v21.1.8\arc-llvm

# PPU target CPU. Selects the TC4D newlib/startup set (-mcpu=tc4d) shipped with arc-llvm.
B_LLVM_BUILD_CONFIG= tc4d

# ARC architecture used by the PPU scalar/vector core.
B_LLVM_ARCEV_ARCH= av2hs

B_LLVM_ARCEV_CC_OPTIONS= -march=$(B_LLVM_ARCEV_ARCH) -mcpu=$(B_LLVM_BUILD_CONFIG) -DIFX_ILLD_PPU_USAGE \
                          -O2 -g -fshort-enums -ffunction-sections -fdata-sections

B_LLVM_ARCEV_CC_OPTIONS_KERNEL= $(B_LLVM_ARCEV_CC_OPTIONS)

B_LLVM_ARCEV_ASM_OPTIONS= -march=$(B_LLVM_ARCEV_ARCH) -mcpu=$(B_LLVM_BUILD_CONFIG)

B_LLVM_ARCEV_LD_OPTIONS= -march=$(B_LLVM_ARCEV_ARCH) -mcpu=$(B_LLVM_BUILD_CONFIG) -lcrt0 -lnsim \
                          -Wl,--gc-sections -Wl,-Csections -Wl,-Csize -Wl,-Csymbols -Wl,-Cunmangle

# Optional debug-only linker report flags (spec Options Set2/Set3). Verified accepted by the
# arc-llvm ld.lld driver (2026-07-03 smoke test). Report-only (no effect on the binary).
# The spec's -Wl,-zlistunref is NOT supported by ld.lld (warns "unknown -z value"); its working
# equivalent is -Wl,--print-gc-sections (lists sections removed by --gc-sections), used here instead.
# Kept commented pending senior review before enabling.
#B_LLVM_ARCEV_LD_OPTIONS+= -Wl,-Ccrossref -Wl,-Ccrossfunc -Wl,-Cglobals -Wl,-Cfunctions -Wl,-Ctables -Wl,--print-gc-sections

#Include path for library directories. Add each path with following format as shown below.
#Each path prefixed with -L and separated by a space.
#B_LLVM_ARCEV_LIB_INC=-L<path>[ -L<path>][..]
#The newlib/crt library directory for -mcpu=tc4d is resolved automatically by the clang driver.
B_LLVM_ARCEV_LIB_INC=

#Libraries to include shall be listed with option -l, with following format.
#B_LLVM_ARCEV_LIBS=-l<lib name>[ -l<lib name>][..]
#crt0 / nsim are already passed through B_LLVM_ARCEV_LD_OPTIONS above.
B_LLVM_ARCEV_LIBS=
