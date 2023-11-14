# Package

version       = "0.1.0"
author        = "!!Dean"
description   = "Cross compile for ARM to demonstrate svd2nim-generated code"
license       = "MIT"
srcDir        = "src"
bin           = @["main_before", "main_after"]


# Dependencies

requires "nim >= 1.6.0"


# Tasks

import std/strformat
import std/strutils

when defined(windows):
  let odBin = "arm-none-eabi-objdump.exe"
else:
  let odBin = "arm-none-eabi-objdump"

task dis, "Disassembles all build/nimcache/*.o files":
  assert findExe(odBin).len > 0, "{odBin} not found in PATH"
  withDir("./build/nimcache"):
    for fn in listFiles(getCurrentDir()):
      if fn.endsWith(".o"):
        let disasmfn = fn & ".disasm.txt"
        exec(fmt"{odBin} -D {fn} > {disasmfn}")
        echo fmt"wrote {disasmfn}"
