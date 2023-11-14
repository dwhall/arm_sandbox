# NIM ARM Cross-compile sandbox

This project is a sandbox to experiment with different
ways of converting SVD files to Nim code and study the resulting
binary/disassembly.

The primary goal is to generate evidence of improvements
over existing `svd2nim` output in order to provide
feedback to the svd2nim project.


## Nimble tasks

* `nimble build` - build this project's "before" and "after" binaries (to .o files)
* `nimble dis` - disassemble .o files


## Learning Nim for embedded systems

I'm learning Nim (started in 2023) and finding there are tricks
to making it cross-compile for a deeply embedded target.

First, what is a "deeply embedded target"?
I consider a deeply embedded target to have a single-chip
microcontroller that lacks a virtual memory system.
If it can run a desktop-class OS, like linux, it's not deeply embedded.
If it has enough RAM or non-volatile memory that you don't
need to be concerned about running out, it's not deeply embedded.

1. Cross-compiling for the target
2. Build Nim for a resource-constrained device

## 1. Cross-compiling for the target

Look at the top of this project's `nim.cfg` to see build arguments
that direct the Nim build system to use a cross-compiler.
This project is special, in that we're only interested in the .o files;
that is why we have the `noLinking` flag set.  How you plan to link
your .o files is beyond the scope of this document.  Linking is usually
highly-specific to your target device.

## 2. Build Nim for a resource-constrained device

Nim's default build arguments assume you're building for a desktop-class machine.
The lower half of this project's `nim.cfg` direct the Nim build system
to target a deeply embedded device.