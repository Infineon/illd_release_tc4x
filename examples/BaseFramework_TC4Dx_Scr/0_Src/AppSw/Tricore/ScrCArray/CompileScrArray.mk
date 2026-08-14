#
# Copyright (C) 2026 Infineon Technologies AG. All rights reserved.
#
#                                 IMPORTANT NOTICE
#
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

