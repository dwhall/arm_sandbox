# NIM ARM Cross-compile sandbox

This project is a sandbox to experiment with different
ways of converting SVD files to Nim code and study the resulting
binary/disassembly.  The goal is to generate evidence
of improvements over existing `svd2nim` output in order to provide
feedback to the svd2nim project.

## Requirements

An `arm-none-eabi-*` toolchain must be in your PATH.

## HOW-TO use this project

1) Run `nimble build` to generate .o files (ELF 32-bit LSB relocatable, ARM, EABI5)
2) Run `nimble dis` to disassemble the .o files to text/assembly
3) Compare the before and after .o and disassembly files

## Enhancements to svd2nim output

These are the enhancements made so far:

0) Create RegisterVal type for the size of the current target.  This type is re-used by all distrinct register value types and provides one place to change all their sizes.
1) Create _Val and _Ptr types for each register.
2) Create one const register.  Grouping register address constants into a peripheral creates a table in the `.data` section.  Regardless of how many registers are used by the program, the entire table is loaded into `.data`.  This is a waste.  Just create one independent const pointer for each register.  Give it a name `<peripheral>_<register>` so it is distinguished.
3) Eliminate the the large write procedures `proc write*(reg: RCC_AHB1ENR_Type, ... every field ...)`.  I don't understand the use case here (please correct me if this procedure is useful to anyone).  It seems dangerous to offer this procedure; an unwitting user might call this `write()` and provide some select fields thinking the other fields that he did not specify will remain unmodified.  However, the fields not given will be written to their default values.
4) Fields that are one-bit wide should be of type RegisterValue, not boolean, to remain consistent with every other field getter/setter.  The programmer may convert to Boolean true/false at a higher level of abstraction.

**TODO:** there is still some opportunity for improvement in the bit shifting and masking operations.


## Observations

Notice that the "before" examples already use the `static` modifier to the register argument of all the `read()` procedures, which is an unreleased change to `svd2nim`.

Notice that there is no `@mafter.nim.c.o` file created because there are no register address grouped into lookup tables for the `.data` section.  The register addresses are strictly in the `@mmain_*.nim.c.o` files and placed in the `.text` section.


## Learning Nim for embedded systems

I'm learning Nim (started in 2023) and finding there are tricks
to making it cross-compile for a deeply embedded target.

First, what is a "deeply embedded target"?
I consider a deeply embedded target to have a single-chip
microcontroller that lacks a virtual memory system.
If it can run a desktop-class OS, like linux, it's not deeply embedded.
If it has enough RAM or non-volatile memory that you don't
need to be concerned about running out, it's not deeply embedded.

Here are some things in addition to normal Nim knowledge
that are necessary to build Nim for deeply embedded systems:

### 1. Cross-compiling for the target

Look at the top of this project's `nim.cfg` to see build arguments
that direct the Nim build system to use a cross-compiler.
This project uses the `arm-none-eabi-*` toolchain for cross-compiling
to an ARM 32-bit microcontroller.  The register definitions in
`before.nim` and `after.nim` target the STM32F4 family of devices
which are derivatives of the ARM Cortex-M4.

This project is special in that we're only interested in the .o files;
that is why we have the `noLinking` flag set.  How you plan to link
your .o files is beyond the scope of this document.  Linking is usually
highly-specific to your target device.

### 2. Build Nim for a resource-constrained device

Nim's default build arguments assume you're building for a desktop-class machine.
The lower half of this project's `nim.cfg` direct the Nim build system
to target a deeply embedded device.
