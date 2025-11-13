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

B_METAWARE_ARCEV_PATH= C:\Tools\Compilers\Metaware\mwaurix_v2_1\MetaWare\arc

B_METAWARE_BUILD_CONFIG = TC4DA_PPU
B_METAWARE_BUILD_TYPE = release

B_METAWARE_SPEED_PATH = $(subst \,/,$(B_METAWARE_ARCEV_PATH))/../../prebuilt/$(B_METAWARE_BUILD_CONFIG)_$(B_METAWARE_BUILD_TYPE)

B_METAWARE_ARCEV_TCF_FILE = $(subst \,/,$(B_METAWARE_ARCEV_PATH))/../../config/set/$(B_METAWARE_BUILD_CONFIG)/arc.tcf

B_METAWARE_ARCEV_CC_DEFS= -DSPEED_MEMORY_ACCESS_ARCDIRECT -DkFlagAutosarOS=0 -DkMaxCoresNum=7 \
                          -DkMaxVmNum=8 -Dsnps_kMaxCluster=1 -Dspeed_control_kNumARCProcessors=1 -Dspeed_control_kNumEmergencyBF=17 \
                          -Dspeed_control_kNumRegularBF=17 -Dspeed_control_kShrMemArraySize=0x7f800 -Dspeed_messaging_kFifoDepth=4 \
                          -Dspeed_messaging_kLogMsgSize=280 -Dspeed_trace_kTraceStackSize=0x200000
                             
B_METAWARE_ARCEV_CC_OPTIONS= $(B_METAWARE_ARCEV_CC_DEFS) -DIFX_ILLD_PPU_USAGE -DSPEED_SYSTEM_ADDRESS_SIZE_BITS=32 \
                          -Hnosdata -Hnocopyr -Hpurge -Mb -Wa,-offwarn=121 -g \
                          -Hvdsp_vector_c -Hinlinehint_threshold=1000  -Hvdsplib \
                          -tcf=$(B_METAWARE_ARCEV_TCF_FILE) -tcf_core_config

#B_METAWARE_ARCEV_CC_OPTIONS= $(B_METAWARE_ARCEV_CC_DEFS) -DIFX_ILLD_PPU_USAGE -Hnosdata -Hnocopyr -Hpurge -Mb -Wa,-offwarn=121 -O1 \
                          -Hvdsp_vector_c -Hinlinehint_threshold=1000 \
                          -tcf=$(B_METAWARE_ARCEV_TCF_FILE) -tcf_core_config

B_METAWARE_ARCEV_CC_OPTIONS_KERNEL= $(B_METAWARE_ARCEV_CC_OPTIONS) -Hkernel -Hpipeline

B_METAWARE_ARCEV_ASM_OPTIONS=$(B_METAWARE_ARCEV_CC_OPTIONS)


B_METAWARE_ARCEV_LD_OPTIONS= -Hnosdata -Mb -Hnocopyr -Hhostlib= -Hnocrt -Hpurge -Wa,-offwarn=121 -Hcppext=C,cpp,ii,cc,cxx          \
                          -u_ZN8snps_arc8metaware5speed3hal21do_initcalls_instanceE -uspeed_hal_initcall_ptr \
                          -Hlib=ev71_full -Hldopt=-Xnocompress -uspeed_StuInitCall_ptr -m -Csymbols           \
                          -uspeed_StuDestructCall_ptr -Hheap=32768 \
                          -tcf=$(B_METAWARE_ARCEV_TCF_FILE) -tcf_core_config 

#Include path for library directories. Add each path with following format as shown below.
#Each path prefixed with -L and separated by a space.
#B_METAWARE_ARCEV_LIB_INC=-L<path>[ -L<path>][..]

B_METAWARE_ARCEV_LIB_INC= -L$(subst \,/,${B_METAWARE_SPEED_PATH})/lib

#Libraries to include shall be listed with option -l, with following format.
#B_METAWARE_ARCEV_LIBS=-l<lib name>[ -l<lib name>][..]

B_METAWARE_ARCEV_LIBS= -lcrt -lhal -lc_fusa -lspeed -lstu -lfusa_libc_wrapper
