#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=adc/adc.c lcdan/lcdan.c lcdan/lcdan_aux.c pinGetLevel/pinGetLevel.c main.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/adc/adc.o ${OBJECTDIR}/lcdan/lcdan.o ${OBJECTDIR}/lcdan/lcdan_aux.o ${OBJECTDIR}/pinGetLevel/pinGetLevel.o ${OBJECTDIR}/main.o
POSSIBLE_DEPFILES=${OBJECTDIR}/adc/adc.o.d ${OBJECTDIR}/lcdan/lcdan.o.d ${OBJECTDIR}/lcdan/lcdan_aux.o.d ${OBJECTDIR}/pinGetLevel/pinGetLevel.o.d ${OBJECTDIR}/main.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/adc/adc.o ${OBJECTDIR}/lcdan/lcdan.o ${OBJECTDIR}/lcdan/lcdan_aux.o ${OBJECTDIR}/pinGetLevel/pinGetLevel.o ${OBJECTDIR}/main.o

# Source Files
SOURCEFILES=adc/adc.c lcdan/lcdan.c lcdan/lcdan_aux.c pinGetLevel/pinGetLevel.c main.c

# Pack Options 
PACK_COMPILER_OPTIONS=-I "${DFP_DIR}/include"
PACK_COMMON_OPTIONS=-B "${DFP_DIR}/gcc/dev/atmega328p"



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=ATmega328P
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/adc/adc.o: adc/adc.c  .generated_files/flags/default/f22e1e4494a41745629358979b3fa28cac6ef162 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/adc" 
	@${RM} ${OBJECTDIR}/adc/adc.o.d 
	@${RM} ${OBJECTDIR}/adc/adc.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p ${PACK_COMPILER_OPTIONS} ${PACK_COMMON_OPTIONS} -g -DDEBUG  -gdwarf-2  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -funsigned-char -funsigned-bitfields -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -Wall -MD -MP -MF "${OBJECTDIR}/adc/adc.o.d" -MT "${OBJECTDIR}/adc/adc.o.d" -MT ${OBJECTDIR}/adc/adc.o  -o ${OBJECTDIR}/adc/adc.o adc/adc.c  -DXPRJ_default=$(CND_CONF)  $(COMPARISON_BUILD) 
	
${OBJECTDIR}/lcdan/lcdan.o: lcdan/lcdan.c  .generated_files/flags/default/be535f4ace10953cc039cef640945ffa0dfcbeb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/lcdan" 
	@${RM} ${OBJECTDIR}/lcdan/lcdan.o.d 
	@${RM} ${OBJECTDIR}/lcdan/lcdan.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p ${PACK_COMPILER_OPTIONS} ${PACK_COMMON_OPTIONS} -g -DDEBUG  -gdwarf-2  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -funsigned-char -funsigned-bitfields -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -Wall -MD -MP -MF "${OBJECTDIR}/lcdan/lcdan.o.d" -MT "${OBJECTDIR}/lcdan/lcdan.o.d" -MT ${OBJECTDIR}/lcdan/lcdan.o  -o ${OBJECTDIR}/lcdan/lcdan.o lcdan/lcdan.c  -DXPRJ_default=$(CND_CONF)  $(COMPARISON_BUILD) 
	
${OBJECTDIR}/lcdan/lcdan_aux.o: lcdan/lcdan_aux.c  .generated_files/flags/default/6ff35b4a7da89b798873ba1097363d43554758d4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/lcdan" 
	@${RM} ${OBJECTDIR}/lcdan/lcdan_aux.o.d 
	@${RM} ${OBJECTDIR}/lcdan/lcdan_aux.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p ${PACK_COMPILER_OPTIONS} ${PACK_COMMON_OPTIONS} -g -DDEBUG  -gdwarf-2  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -funsigned-char -funsigned-bitfields -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -Wall -MD -MP -MF "${OBJECTDIR}/lcdan/lcdan_aux.o.d" -MT "${OBJECTDIR}/lcdan/lcdan_aux.o.d" -MT ${OBJECTDIR}/lcdan/lcdan_aux.o  -o ${OBJECTDIR}/lcdan/lcdan_aux.o lcdan/lcdan_aux.c  -DXPRJ_default=$(CND_CONF)  $(COMPARISON_BUILD) 
	
${OBJECTDIR}/pinGetLevel/pinGetLevel.o: pinGetLevel/pinGetLevel.c  .generated_files/flags/default/cb3c01dc80f0b72d9df36f9898bf26877ff50768 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/pinGetLevel" 
	@${RM} ${OBJECTDIR}/pinGetLevel/pinGetLevel.o.d 
	@${RM} ${OBJECTDIR}/pinGetLevel/pinGetLevel.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p ${PACK_COMPILER_OPTIONS} ${PACK_COMMON_OPTIONS} -g -DDEBUG  -gdwarf-2  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -funsigned-char -funsigned-bitfields -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -Wall -MD -MP -MF "${OBJECTDIR}/pinGetLevel/pinGetLevel.o.d" -MT "${OBJECTDIR}/pinGetLevel/pinGetLevel.o.d" -MT ${OBJECTDIR}/pinGetLevel/pinGetLevel.o  -o ${OBJECTDIR}/pinGetLevel/pinGetLevel.o pinGetLevel/pinGetLevel.c  -DXPRJ_default=$(CND_CONF)  $(COMPARISON_BUILD) 
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/default/50d79929edd4642ff9a57a04f501c3b705312c04 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p ${PACK_COMPILER_OPTIONS} ${PACK_COMMON_OPTIONS} -g -DDEBUG  -gdwarf-2  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -funsigned-char -funsigned-bitfields -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -Wall -MD -MP -MF "${OBJECTDIR}/main.o.d" -MT "${OBJECTDIR}/main.o.d" -MT ${OBJECTDIR}/main.o  -o ${OBJECTDIR}/main.o main.c  -DXPRJ_default=$(CND_CONF)  $(COMPARISON_BUILD) 
	
else
${OBJECTDIR}/adc/adc.o: adc/adc.c  .generated_files/flags/default/6a3c5b1c6dd8b9c95946d6b8f751d32a49d1eae0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/adc" 
	@${RM} ${OBJECTDIR}/adc/adc.o.d 
	@${RM} ${OBJECTDIR}/adc/adc.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p ${PACK_COMPILER_OPTIONS} ${PACK_COMMON_OPTIONS}  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -funsigned-char -funsigned-bitfields -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -Wall -MD -MP -MF "${OBJECTDIR}/adc/adc.o.d" -MT "${OBJECTDIR}/adc/adc.o.d" -MT ${OBJECTDIR}/adc/adc.o  -o ${OBJECTDIR}/adc/adc.o adc/adc.c  -DXPRJ_default=$(CND_CONF)  $(COMPARISON_BUILD) 
	
${OBJECTDIR}/lcdan/lcdan.o: lcdan/lcdan.c  .generated_files/flags/default/87686bd4d2c1cbfbe3940561dc37915ca2bd3c9e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/lcdan" 
	@${RM} ${OBJECTDIR}/lcdan/lcdan.o.d 
	@${RM} ${OBJECTDIR}/lcdan/lcdan.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p ${PACK_COMPILER_OPTIONS} ${PACK_COMMON_OPTIONS}  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -funsigned-char -funsigned-bitfields -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -Wall -MD -MP -MF "${OBJECTDIR}/lcdan/lcdan.o.d" -MT "${OBJECTDIR}/lcdan/lcdan.o.d" -MT ${OBJECTDIR}/lcdan/lcdan.o  -o ${OBJECTDIR}/lcdan/lcdan.o lcdan/lcdan.c  -DXPRJ_default=$(CND_CONF)  $(COMPARISON_BUILD) 
	
${OBJECTDIR}/lcdan/lcdan_aux.o: lcdan/lcdan_aux.c  .generated_files/flags/default/b4a637503f7c92a8f216cea46ed10ede3b93d7c7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/lcdan" 
	@${RM} ${OBJECTDIR}/lcdan/lcdan_aux.o.d 
	@${RM} ${OBJECTDIR}/lcdan/lcdan_aux.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p ${PACK_COMPILER_OPTIONS} ${PACK_COMMON_OPTIONS}  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -funsigned-char -funsigned-bitfields -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -Wall -MD -MP -MF "${OBJECTDIR}/lcdan/lcdan_aux.o.d" -MT "${OBJECTDIR}/lcdan/lcdan_aux.o.d" -MT ${OBJECTDIR}/lcdan/lcdan_aux.o  -o ${OBJECTDIR}/lcdan/lcdan_aux.o lcdan/lcdan_aux.c  -DXPRJ_default=$(CND_CONF)  $(COMPARISON_BUILD) 
	
${OBJECTDIR}/pinGetLevel/pinGetLevel.o: pinGetLevel/pinGetLevel.c  .generated_files/flags/default/8fdf69bf8452d126ca7a576c8a2ec1fc530e0472 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/pinGetLevel" 
	@${RM} ${OBJECTDIR}/pinGetLevel/pinGetLevel.o.d 
	@${RM} ${OBJECTDIR}/pinGetLevel/pinGetLevel.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p ${PACK_COMPILER_OPTIONS} ${PACK_COMMON_OPTIONS}  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -funsigned-char -funsigned-bitfields -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -Wall -MD -MP -MF "${OBJECTDIR}/pinGetLevel/pinGetLevel.o.d" -MT "${OBJECTDIR}/pinGetLevel/pinGetLevel.o.d" -MT ${OBJECTDIR}/pinGetLevel/pinGetLevel.o  -o ${OBJECTDIR}/pinGetLevel/pinGetLevel.o pinGetLevel/pinGetLevel.c  -DXPRJ_default=$(CND_CONF)  $(COMPARISON_BUILD) 
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/default/5abb6aaddc1b0216789c09ab9f68f9db6e435e1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p ${PACK_COMPILER_OPTIONS} ${PACK_COMMON_OPTIONS}  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -funsigned-char -funsigned-bitfields -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -Wall -MD -MP -MF "${OBJECTDIR}/main.o.d" -MT "${OBJECTDIR}/main.o.d" -MT ${OBJECTDIR}/main.o  -o ${OBJECTDIR}/main.o main.c  -DXPRJ_default=$(CND_CONF)  $(COMPARISON_BUILD) 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -mmcu=atmega328p ${PACK_COMMON_OPTIONS}   -gdwarf-2 -D__$(MP_PROCESSOR_OPTION)__  -Wl,-Map="${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.map"    -o ${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}      -DXPRJ_default=$(CND_CONF)  $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1 -Wl,--gc-sections -Wl,--start-group  -Wl,-lm -Wl,--end-group 
	
	${MP_CC_DIR}/avr-objcopy -j .eeprom --set-section-flags=.eeprom=alloc,load --change-section-lma .eeprom=0 --no-change-warnings -O ihex "${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}" "${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.eep" || exit 0
	
	
	
	
else
${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -mmcu=atmega328p ${PACK_COMMON_OPTIONS}  -D__$(MP_PROCESSOR_OPTION)__  -Wl,-Map="${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.map"    -o ${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}      -DXPRJ_default=$(CND_CONF)  $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION) -Wl,--gc-sections -Wl,--start-group  -Wl,-lm -Wl,--end-group 
	${MP_CC_DIR}/avr-objcopy -O ihex "${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}" "${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.hex"
	${MP_CC_DIR}/avr-objcopy -j .eeprom --set-section-flags=.eeprom=alloc,load --change-section-lma .eeprom=0 --no-change-warnings -O ihex "${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}" "${DISTDIR}/ATmega328Pmplabx.X.${IMAGE_TYPE}.eep" || exit 0
	
	
	
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(wildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
