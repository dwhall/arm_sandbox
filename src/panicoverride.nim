# Simplest:
#[
proc rawoutput(s: string) = discard
proc panic(s: string) = discard
]#

# A more elaborate option
proc puts(s: cstring) {.importc, header: "<stdio.h>", cdecl.}
proc putchar(c: int) {.importc, header: "<stdio.h>", cdecl.}
proc exit(code: int) {.importc, header: "<stdlib.h>", cdecl.}
let EXIT_FAILURE {.importc, header: "<stdlib.h>", nodecl.}: int

{.push stack_trace: off, profiler:off.}

proc panic*(s: string) =
  puts(s.cstring)
  const newline = ord('\n')
  putchar(newline)
  exit(EXIT_FAILURE)

{.pop.}
