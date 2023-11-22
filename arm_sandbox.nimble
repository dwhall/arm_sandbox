# Package

version       = "0.1.0"
author        = "!!Dean"
description   = "Cross compile for ARM to demonstrate svd2nim-generated code"
license       = "MIT"
srcDir        = "src"
bin           = @["main_orig"]


# Dependencies

requires "nim >= 1.6.0"


# Tasks

import std/os
import std/strformat
import std/strutils

let gccBin = "arm-none-eabi-gcc"
let odBin = "arm-none-eabi-objdump"
let sizeBin = "arm-none-eabi-size"

task cross, "Cross-compiles all src/*.nim files":
  assert findExe(gccBin).len > 0, "{gccBin} not found in PATH"
  for fn in listFiles(getCurrentDir() & DirSep & srcDir):
    if fn.endsWith(".nim"):
      exec(fmt"nim c --arm.any.gcc.exe={gccBin} {fn}")
  withDir("./build/nimcache"):
    exec(fmt"{sizeBin} *.o")

task dis, "Disassembles all build/nimcache/*.o files":
  assert findExe(odBin).len > 0, "{odBin} not found in PATH"
  withDir("./build/nimcache"):
    for fn in listFiles(getCurrentDir()):
      if fn.endsWith(".o"):
        let disasmfn = fn & ".disasm.txt"
        exec(fmt"{odBin} -D {fn} > {disasmfn}")
        echo fmt"wrote {disasmfn}"
