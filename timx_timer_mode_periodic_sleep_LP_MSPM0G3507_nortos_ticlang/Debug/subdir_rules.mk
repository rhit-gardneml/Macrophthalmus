################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccstheia110/ccs/tools/compiler/ti-cgt-armllvm_2.1.3.LTS/bin/tiarmclang.exe" -c @"device.opt"  -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O2 -I"C:/Users/hoatsosa/workspace_ccstheia/timx_timer_mode_periodic_sleep_LP_MSPM0G3507_nortos_ticlang" -I"C:/Users/hoatsosa/workspace_ccstheia/timx_timer_mode_periodic_sleep_LP_MSPM0G3507_nortos_ticlang/Debug" -I"C:/ti/mspm0_sdk_1_30_00_03/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_1_30_00_03/source" -gdwarf-3 -MMD -MP -MF"$(basename $(<F)).d_raw" -MT"$(@)"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

build-1511618591: ../timx_timer_mode_periodic_sleep.syscfg
	@echo 'Building file: "$<"'
	@echo 'Invoking: SysConfig'
	"C:/ti/sysconfig_1.19.0/sysconfig_cli.bat" -s "C:/ti/mspm0_sdk_1_30_00_03/.metadata/product.json" --script "C:/Users/hoatsosa/workspace_ccstheia/timx_timer_mode_periodic_sleep_LP_MSPM0G3507_nortos_ticlang/timx_timer_mode_periodic_sleep.syscfg" -o "." --compiler ticlang
	@echo 'Finished building: "$<"'
	@echo ' '

device_linker.cmd: build-1511618591 ../timx_timer_mode_periodic_sleep.syscfg
device.opt: build-1511618591
device.cmd.genlibs: build-1511618591
ti_msp_dl_config.c: build-1511618591
ti_msp_dl_config.h: build-1511618591
Event.dot: build-1511618591

%.o: ./%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccstheia110/ccs/tools/compiler/ti-cgt-armllvm_2.1.3.LTS/bin/tiarmclang.exe" -c @"device.opt"  -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O2 -I"C:/Users/hoatsosa/workspace_ccstheia/timx_timer_mode_periodic_sleep_LP_MSPM0G3507_nortos_ticlang" -I"C:/Users/hoatsosa/workspace_ccstheia/timx_timer_mode_periodic_sleep_LP_MSPM0G3507_nortos_ticlang/Debug" -I"C:/ti/mspm0_sdk_1_30_00_03/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_1_30_00_03/source" -gdwarf-3 -MMD -MP -MF"$(basename $(<F)).d_raw" -MT"$(@)"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

startup_mspm0g350x_ticlang.o: C:/ti/mspm0_sdk_1_30_00_03/source/ti/devices/msp/m0p/startup_system_files/ticlang/startup_mspm0g350x_ticlang.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccstheia110/ccs/tools/compiler/ti-cgt-armllvm_2.1.3.LTS/bin/tiarmclang.exe" -c @"device.opt"  -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O2 -I"C:/Users/hoatsosa/workspace_ccstheia/timx_timer_mode_periodic_sleep_LP_MSPM0G3507_nortos_ticlang" -I"C:/Users/hoatsosa/workspace_ccstheia/timx_timer_mode_periodic_sleep_LP_MSPM0G3507_nortos_ticlang/Debug" -I"C:/ti/mspm0_sdk_1_30_00_03/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_1_30_00_03/source" -gdwarf-3 -MMD -MP -MF"$(basename $(<F)).d_raw" -MT"$(@)"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '


