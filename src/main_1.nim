import std/bitops
import std/volatile


type
  RegisterVal = uint

#
# RCC
#
type RCC_AHB1ENR_Val* = distinct RegisterVal
type RCC_AHB1ENR_Ptr = ptr RCC_AHB1ENR_Val
const RCC_AHB1ENR* = cast[RCC_AHB1ENR_Ptr](0x40023830)

proc read*(reg: static RCC_AHB1ENR_Ptr): RCC_AHB1ENR_Val {.inline.} = volatileLoad(reg)
proc write*(reg: static RCC_AHB1ENR_Ptr, val: RCC_AHB1ENR_Val) {.inline.} = volatileStore(reg, val)

template modifyIt*(reg: static RCC_AHB1ENR_Ptr, op: untyped): untyped =
  block:
    var it {.inject.} = reg.read()
    op
    reg.write(it)

proc `GPIOAEN=`*(r: var RCC_AHB1ENR_Val, val: RegisterVal) {.inline.} =
  var tmp = r.RegisterVal
  tmp.clearMask(0 .. 0)
  tmp.setMask((val shl 0).masked(0 .. 0))
  r = tmp.RCC_AHB1ENR_Val


#
# GPIOA MODER
#
type GPIOA_MODER_Val* = distinct RegisterVal
type GPIOA_MODER_Ptr = ptr GPIOA_MODER_Val
const GPIOA_MODER* = cast[GPIOA_MODER_Ptr](0x40020000)

proc read*(reg: static GPIOA_MODER_Ptr): GPIOA_MODER_Val {.inline.} = volatileLoad(reg)
proc write*(reg: static GPIOA_MODER_Ptr, val: GPIOA_MODER_Val) {.inline.} = volatileStore(reg, val)

template modifyIt*(reg: static GPIOA_MODER_Ptr, op: untyped): untyped =
  block:
    var it {.inject.} = reg.read()
    op
    reg.write(it)

proc `MODER5=`*(r: var GPIOA_MODER_Val, val: RegisterVal) {.inline.} =
  var tmp = r.RegisterVal
  tmp.clearMask(10 .. 11)
  tmp.setMask((val shl 10).masked(10 .. 11))
  r = tmp.GPIOA_MODER_Val


#
# GPIOA BSRR (write-only)
#
type GPIOA_BSRR_Val* = distinct RegisterVal
type GPIOA_BSRR_Ptr = ptr GPIOA_BSRR_Val
const GPIOA_BSRR* = cast[GPIOA_BSRR_Ptr](0x40020018)

proc write*(reg: static GPIOA_BSRR_Ptr, val: GPIOA_BSRR_Val) {.inline.} = volatileStore(reg, val)

proc `BR5=`*(r: var GPIOA_BSRR_Val, val: RegisterVal) {.inline.} =
  var tmp = r.RegisterVal
  tmp.clearMask(21 .. 21)
  tmp.setMask((val shl 21).masked(21 .. 21))
  r = tmp.GPIOA_BSRR_Val

proc `BS5=`*(r: var GPIOA_BSRR_Val, val: RegisterVal) {.inline.} =
  var tmp = r.RegisterVal
  tmp.clearMask(5 .. 5)
  tmp.setMask((val shl 5).masked(5 .. 5))
  r = tmp.GPIOA_BSRR_Val


proc main =
  # Configure A5 as a GPIO output pin
  modifyIt(RCC_AHB1ENR): it.GPIOAEN = 1
  modifyIt(GPIOA_MODER): it.MODER5 = 1

  # Perform bit-set, bit-clear on A5
  while true:
    GPIOA_BSRR.write((1 shl 5).GPIOA_BSRR_Val)
    GPIOA_BSRR.write((1 shl 21).GPIOA_BSRR_Val)


when isMainModule:
  main()
