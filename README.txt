# NIM ARM Cross-compile sandbox

This project is a sandbox to experiment with different
ways of converting SVD files to Nim code and study the resulting
binary/disassembly.  The goal is to generate evidence
of improvements over existing `svd2nim` output in order to provide
feedback to the svd2nim project.

## Requirements

An `arm-none-eabi-*` toolchain must be in your PATH.
If you don't have that installed, check your OS/distro's package manager.
If you still can't find one, try here: https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain

## HOW-TO use this project

1) Run `nimble cross` to generate .o files (ELF 32-bit LSB relocatable, ARM, EABI5)
2) Run `nimble dis` to disassemble the .o files to text/assembly
3) Compare the sequence of main_<#>.o and disassembly files
4) Review the contents of Notes.txt to understand the changes of each main_<#>.nim file and its impact.
4) Experiment with your own modifications to the next main_<#>.nim file to see if you can make the .o files even more efficient.
