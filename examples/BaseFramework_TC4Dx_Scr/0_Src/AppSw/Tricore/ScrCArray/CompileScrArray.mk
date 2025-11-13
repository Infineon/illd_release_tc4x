#
# Copyright (C) 2015-2017 Infineon Technologies AG. All rights reserved.
#
#                                 IMPORTANT NOTICE
#
# Infineon Technologies AG (Infineon) is supplying this file for use
# exclusively with Infineon's microcontroller products. This file can be freely
# distributed within development tools that are supporting such microcontroller
# products.
#
# THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
# OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
# INFINEON SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL,
# OR CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
# 
# -----------------------------------------------------------------------------

B_GEN_CUSTOBJS_TRICORE_TC+= $(B_GEN_OUT_FOLDER_I51)/CArray.o
B_GEN_CUSTOBJS_TRICORE_TC0+= $(B_GEN_OUT_FOLDER_I51)/CArray.o

ifeq ($(B_GEN_TOOLCHAIN_PRIMARY_TRICORE),Windriver)
$(B_GEN_OUT_FOLDER_I51)/CArray.o: $(B_GEN_OUT_FOLDER_I51)/CArray.c $(B_GEN_CONFIG_TRICORE_WINDRIVER) $(B_CONFIG_FILES_FOLDER)/Config.xml
	@echo Compiling $< ! for Windriver Tricore
	$(B_GEN_TRICORE_WINDRIVER_CC) $(B_WINDRIVER_TRICORE_CC_OPTIONS) -c $(@:.o=.c) -o $@ -Xmake-dependency=4 -Xmake-dependency-savefile=$(@:.o=.d)
endif
ifeq ($(B_GEN_TOOLCHAIN_PRIMARY_TRICORE),Ghs)
$(B_GEN_OUT_FOLDER_I51)/CArray.o: $(B_GEN_OUT_FOLDER_I51)/CArray.c $(B_GEN_CONFIG_TRICORE_DCC) $(B_CONFIG_FILES_FOLDER)/Config.xml
	@echo Compiling $< ! for Ghs Tricore
	$(B_GEN_TRICORE_GHS_CC) $(B_GHS_TRICORE_CC_OPTIONS)  $< -c -o $@ --make_depends
endif
ifeq ($(B_GEN_TOOLCHAIN_PRIMARY_TRICORE),Gnuc)
$(B_GEN_OUT_FOLDER_I51)/CArray.o: $(B_GEN_OUT_FOLDER_I51)/CArray.c $(B_GEN_CONFIG_TRICORE_GNUC) $(B_CONFIG_FILES_FOLDER)/Config.xml
	@echo Compiling $< ! for Gnuc Tricore
	$(B_GEN_TRICORE_GNUC_CC) $(B_GNUC_TRICORE_CC_OPTIONS) -c $(@:.o=.c) -o $@ -save-temps=obj -MMD
endif
ifeq ($(B_GEN_TOOLCHAIN_PRIMARY_TRICORE),Gcc)
$(B_GEN_OUT_FOLDER_I51)/CArray.o: $(B_GEN_OUT_FOLDER_I51)/CArray.c $(B_GEN_CONFIG_TRICORE_GCC) $(B_CONFIG_FILES_FOLDER)/Config.xml
	@echo Compiling $< ! for Gcc Tricore
	$(B_GEN_TRICORE_GCC_CC) $(B_GCC_TRICORE_CC_OPTIONS) -c $(@:.o=.c) -o $@ -save-temps=obj -MMD
endif
ifeq ($(B_GEN_TOOLCHAIN_PRIMARY_TRICORE),Hightec)
$(B_GEN_OUT_FOLDER_I51)/CArray.o: $(B_GEN_OUT_FOLDER_I51)/CArray.c $(B_GEN_CONFIG_TRICORE_HIGHTEC) $(B_CONFIG_FILES_FOLDER)/Config.xml
	@echo Compiling $< ! for Hightec Tricore
	$(B_GEN_TRICORE_HIGHTEC_CC) $(B_HIGHTEC_TRICORE_CC_OPTIONS) -c $(@:.o=.c) -o $@ -save-temps=obj -MMD
endif
ifeq ($(B_GEN_TOOLCHAIN_PRIMARY_TRICORE),Tasking)
$(B_GEN_OUT_FOLDER_I51)/CArray.o: $(B_GEN_OUT_FOLDER_I51)/CArray.c $(B_GEN_CONFIG_TRICORE_TASKING) $(B_CONFIG_FILES_FOLDER)/Config.xml
	@echo Compiling $< ! for Tasking Tricore
	$(B_GEN_TRICORE_TASKING_CC) -o $@ $< -c $(B_TASKING_TRICORE_CC_OPTIONS)
endif

