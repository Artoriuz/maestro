# Maestro
This repository contains a 5 stage pipeline implementation of the RV32I ISA strongly inspired by [David Patterson's and John Hennessy's Computer Organization and Design RISC-V Edition.](https://www.amazon.com/dp/0128122757) The project is entirely academic, it was delevoped at Rio Grande do Norte's Federal University and it does not aim to be competitive against complex implementations. The rationale behind it was basically learning about RISC-V, the ISA, and processor design in general. If you want to deploy a RISC-V core, [I strongly recommend using a fully-featured and tested core instead.](https://github.com/riscv/riscv-wiki/wiki/RISC-V-Cores-and-SoCs)  

## Current Design
- Entirely written in VHDL.
- 5-stage pipeline.
- Not designed with multiple RISC-V harts in mind, the memory model is relaxed.
- The privileged ISA is **not** implemented.
- FENCE, FENCE.I and CSR instructions are not implemented.
- Unimplemented instructions (including extensions) will be executed as NOPs.

## User Guide
- The repository contains a Quartus Prime 18.1 project file.
- The repository contains Altera memory files generated for the Cyclone IV GX FPGA. If you wish to use it on a different Altera FPGA you'll have to use the Megawizard plug-in manager to reconfigure them.
- Progmem.mif comes with a simple fibonacci program for quick debugging.
- Outputs that start with "debug" are not mandatory and only exist to make debugging easier.

## Inconveniences
- If you want to run compiled code, [Sifive's elf2hex](https://github.com/sifive/elf2hex) might help. The core, however, is only intended to be used academically and writing assembly or even the machine code yourself is usually reasonable for super simple programs.
- The processor does not have any output. Use the debug output or load to memory to move data out of it. 

## Simplified Schematic
![Schematic](https://raw.githubusercontent.com/Artoriuz/maestro/master/images/schematic.png)
