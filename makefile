# Working Makefile
############################
# Command for removing files
RM := rm -rf
-include "C:\MinGW\bin" 
############################
# Compiler
#CC := arm-none-eabi-gcc
############################
# Linker
LL := arm-none-eabi-gcc
############################
# Binary/exectable to build
EXE := \
  ./debug/PES_Project_2.axf
PC_EXE := \
  ./debug/PES_Project_2.exe
  
  
 ###########################
 # PC object files 
 PC_OBJS := ./debug/main.o \
 			./debug/flash.o
############################
# List of object files
OBJS := \
  ./debug/main.o \
  ./debug/startup_MKL25Z4.o \
  ./debug/system_MKL25Z4.o  \
  ./debug/board.o       \
  ./debug/clock_config.o \
  ./debug/peripherals.o \
  ./debug/pin_mux.o \
  ./debug/fsl_clock.o \
  ./debug/fsl_common.o \
  ./debug/fsl_flash.o   \
  ./debug/fsl_gpio.o    \
  ./debug/fsl_lpsci.o   \
  ./debug/fsl_smc.o     \
  ./debug/fsl_uart.o    \
  ./debug/flash.o       \
  ./debug/fsl_debug_console.o
  
############################
# List of dependency files
C_DEPS = \
  ./debug/main.d \
  ./debug/startup_MKL25Z4.d \
  ./debug/system_MKL25Z4.d  \
  ./debug/board.d       \
  ./debug/clock_config.d \
  ./debug/peripherals.d \
  ./debug/pin_mux.d \
  ./debug/fsl_clock.d \
  ./debug/fsl_common.d \
  ./debug/fsl_flash.d   \
  ./debug/fsl_gpio.d    \
  ./debug/fsl_lpsci.d   \
  ./debug/fsl_smc.d     \
  ./debug/fsl_uart.d    \
  ./debug/flash.d       \
  ./debug/fsl_debug_console.d
  
  
 ###########################
 # Included directories
 INCLUDES := \
        -I"CMSIS" \
        -I"board" \
        -I"drivers" \
        -I"source" \
        -I"utilities"
        
PC_INCLUDES := \
		-I"source"
        
############################
# Determine the platform the board is on


############################
# Include generated dependcy files (only if not clean target)
ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

ifeq ($(MAKECMDGOALS), all)
	PLATFORM := FB
	CC := arm-none-eabi-gcc
	CC_OPTIONS := -c -std=gnu99 -O0 -g -ffunction-sections -fdata-sections -fno-builtin -mcpu=cortex-m0plus -mthumb -DCPU_MKL25Z128VLK4 -D__USE_CMSIS $(INCLUDES)
	CC_OPTIONS += -DFB_RUN -DSDK_DEBUGCONSOLE
	LL := arm-none-eabi-gcc
	LL_OPTIONS := -nostdlib -Xlinker -Map="debug/PES_Project_2.map" -Xlinker --gc-sections -Xlinker -print-memory-usage -mcpu=cortex-m0plus -mthumb -T PES_Project_2_Debug.ld -o $(EXE)
endif

ifeq ($(MAKECMDGOALS), fb_run)
	PLATFORM := FB
    CC := arm-none-eabi-gcc
    CC_OPTIONS := -c -std=gnu99 -O0 -g -ffunction-sections -fdata-sections -fno-builtin -mcpu=cortex-m0plus -mthumb -DCPU_MKL25Z128VLK4 -D__USE_CMSIS $(INCLUDES)
    CC_OPTIONS += -DFB_RUN -DSDK_DEBUGCONSOLE
	LL := arm-none-eabi-gcc
	LL_OPTIONS := -nostdlib -Xlinker -Map="debug/PES_Project_2.map" -Xlinker --gc-sections -Xlinker -print-memory-usage -mcpu=cortex-m0plus -mthumb -T PES_Project_2_Debug.ld -o $(EXE)
endif

ifeq ($(MAKECMDGOALS), pc_run)
	PLATFORM := PC
    CC := gcc
    CC_OPTIONS := -Wall -Werror $(PC_INCLUDES)
    CC_OPTIONS += -DPC_RUN
	LL := gcc
endif

ifeq ($(MAKECMDGOALS), fb_debug)
	PLATFORM := FB
    CC := arm-none-eabi-gcc
    CC_OPTIONS := -c -std=gnu99 -O0 -g -ffunction-sections -fdata-sections -fno-builtin -mcpu=cortex-m0plus -mthumb -DCPU_MKL25Z128VLK4 -D__USE_CMSIS $(INCLUDES)
    CC_OPTIONS += -DFB_DEBUG -DSDK_DEBUGCONSOLE
	LL := arm-none-eabi-gcc
	LL_OPTIONS := -nostdlib -Xlinker -Map="debug/PES_Project_2.map" -Xlinker --gc-sections -Xlinker -print-memory-usage -mcpu=cortex-m0plus -mthumb -T PES_Project_2_Debug.ld -o $(EXE)
endif

ifeq ($(MAKECMDGOALS), pc_debug)
	PLATFORM := PC
    CC := gcc
    CC_OPTIONS := -Wall -Werror $(PC_INCLUDES)
    CC_OPTIONS += -DPC_DEBUG
	LL := gcc
endif

############################
# Compiler options (Handled above)
#CC_OPTIONS := -c -std=gnu99 -O0 -g -ffunction-sections -fdata-sections -fno-builtin -mcpu=cortex-m0plus -mthumb -DCPU_MKL25Z128VLK4 -D__USE_CMSIS $(INCLUDES)
############################
# Linker Options
#LL_OPTIONS := -nostdlib -Xlinker -Map="debug/PES_Project_2.map" -Xlinker --gc-sections -Xlinker -print-memory-usage -mcpu=cortex-m0plus -mthumb -T PES_Project_2_Debug.ld -o $(EXE)
############################
# Main (all) target
all: $(EXE)
	@echo "*** finished building ***"

fb_run: $(EXE)
	@echo "*** FINISHED BUILDING FB_RUN ***"
    
pc_run: $(PC_EXE)
	@echo "*** FINISHED BUILDING PC_RUN ***"
    
fb_debug: $(EXE)
	@echo "*** FINISHED BUILDING FB_DEBUG ***"
    
pc_debug: $(PC_EXE)
	@echo "*** FINISHED BUILDING PC_DEBUG ***"
	
############################
# Clean target
clean:
	-$(RM) $(EXECUTABLES) $(OBJS) $(EXE) $(PC_EXE)
	-$(RM) ./debug/*.map
	-@echo ' '
############################
# Rule to link the executable on FB
ifeq ($(PLATFORM), FB)

$(EXE): $(OBJS) $(USER_OBJS) ./Debug/PES_Project_2_Debug.ld
	@echo 'Building target: $@'
	@echo 'Invoking: Linker'
	$(LL) $(LL_OPTIONS) $(OBJS) $(LIBS) $(INCLUDES)
	@echo 'Finished building target: $@'
	@echo ' '
	
	
############################
# Rule to build the files in the source folder
./debug/main.o: ./source/main.c ./source/main.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
	
./debug/flash.o: ./source/flash.c ./source/flash.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
endif

ifeq ($(PLATFORM), PC)

$(PC_EXE):  ./source/main.c ./source/flash.c
	$(CC) -o $(PC_EXE) $(CC_OPTIONS) ./source/main.c ./source/flash.c
	
endif

	
# Rule to build the files in the CMSIS folder
./debug/system_MKL25Z4.o: ./CMSIS/system_MKL25Z4.c ./CMSIS/system_MKL25Z4.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
./debug/startup_MKL25Z4.o: ./startup/startup_MKL25Z4.c
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
./debug/board.o: ./board/board.c ./board/board.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
./debug/clock_config.o: ./board/clock_config.c ./board/clock_config.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
./debug/peripherals.o: ./board/peripherals.c ./board/peripherals.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
./debug/pin_mux.o: ./board/pin_mux.c ./board/pin_mux.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
    
./debug/fsl_clock.o: ./drivers/fsl_clock.c ./drivers/fsl_clock.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
./debug/fsl_common.o: ./drivers/fsl_common.c ./drivers/fsl_common.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
./debug/fsl_flash.o: ./drivers/fsl_flash.c ./drivers/fsl_flash.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
./debug/fsl_gpio.o: ./drivers/fsl_gpio.c ./drivers/fsl_gpio.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
./debug/fsl_lpsci.o: ./drivers/fsl_lpsci.c ./drivers/fsl_lpsci.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
./debug/fsl_port.o: ./drivers/fsl_port.c ./drivers/fsl_port.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
./debug/fsl_smc.o: ./drivers/fsl_smc.c ./drivers/fsl_smc.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
    
./debug/fsl_uart.o: ./drivers/fsl_uart.c ./drivers/fsl_uart.h
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
    
    
./debug/fsl_debug_console.o: ./utilities/fsl_debug_console.c 
	@echo 'Building file: $<'
	$(CC) $(CC_OPTIONS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
