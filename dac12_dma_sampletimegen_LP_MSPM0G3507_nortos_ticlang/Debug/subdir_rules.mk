################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccstheia110/ccs/tools/compiler/ti-cgt-armllvm_2.1.3.LTS/bin/tiarmclang.exe" -c @"syscfg/device.opt"  -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O2 -I"C:/Users/hoatsosa/workspace_ccstheia/dac12_dma_sampletimegen_LP_MSPM0G3507_nortos_ticlang" -I"C:/Users/hoatsosa/workspace_ccstheia/dac12_dma_sampletimegen_LP_MSPM0G3507_nortos_ticlang/Debug" -I"C:/ti/mspm0_sdk_1_20_01_06/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_1_20_01_06/source" -gdwarf-3 -MMD -MP -MF"$(basename $(<F)).d_raw" -MT"$(@)" -I"C:/Users/hoatsosa/workspace_ccstheia/dac12_dma_sampletimegen_LP_MSPM0G3507_nortos_ticlang/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

build-53961313: ../dac12_dma_sampletimegen.syscfg
	@echo 'Building file: "$<"'
	@echo 'Invoking: SysConfig'
	"C:/ti/sysconfig_1.18.0/sysconfig_cli.bat" -s "C:/ti/mspm0_sdk_1_20_01_06/.metadata/product.json" --script "C:/Users/hoatsosa/workspace_ccstheia/dac12_dma_sampletimegen_LP_MSPM0G3507_nortos_ticlang/dac12_dma_sampletimegen.syscfg" -o "syscfg" --compiler ticlang
	@echo 'Finished building: "$<"'
	@echo ' '

syscfg/device_linker.cmd: build-53961313 ../dac12_dma_sampletimegen.syscfg
syscfg/device.opt: build-53961313
syscfg/device.cmd.genlibs: build-53961313
syscfg/ti_msp_dl_config.c: build-53961313
syscfg/ti_msp_dl_config.h: build-53961313
syscfg/Event.dot: build-53961313
syscfg/: build-53961313

syscfg/%.o: ./syscfg/%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccstheia110/ccs/tools/compiler/ti-cgt-armllvm_2.1.3.LTS/bin/tiarmclang.exe" -c @"syscfg/device.opt"  -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O2 -I"C:/Users/hoatsosa/workspace_ccstheia/dac12_dma_sampletimegen_LP_MSPM0G3507_nortos_ticlang" -I"C:/Users/hoatsosa/workspace_ccstheia/dac12_dma_sampletimegen_LP_MSPM0G3507_nortos_ticlang/Debug" -I"C:/ti/mspm0_sdk_1_20_01_06/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_1_20_01_06/source" -gdwarf-3 -MMD -MP -MF"syscfg/$(basename $(<F)).d_raw" -MT"$(@)" -I"C:/Users/hoatsosa/workspace_ccstheia/dac12_dma_sampletimegen_LP_MSPM0G3507_nortos_ticlang/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

startup_mspm0g350x_ticlang.o: C:/ti/mspm0_sdk_1_20_01_06/source/ti/devices/msp/m0p/startup_system_files/ticlang/startup_mspm0g350x_ticlang.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/ti/ccstheia110/ccs/tools/compiler/ti-cgt-armllvm_2.1.3.LTS/bin/tiarmclang.exe" -c @"syscfg/device.opt"  -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O2 -I"C:/Users/hoatsosa/workspace_ccstheia/dac12_dma_sampletimegen_LP_MSPM0G3507_nortos_ticlang" -I"C:/Users/hoatsosa/workspace_ccstheia/dac12_dma_sampletimegen_LP_MSPM0G3507_nortos_ticlang/Debug" -I"C:/ti/mspm0_sdk_1_20_01_06/source/third_party/CMSIS/Core/Include" -I"C:/ti/mspm0_sdk_1_20_01_06/source" -gdwarf-3 -MMD -MP -MF"$(basename $(<F)).d_raw" -MT"$(@)" -I"C:/Users/hoatsosa/workspace_ccstheia/dac12_dma_sampletimegen_LP_MSPM0G3507_nortos_ticlang/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '


