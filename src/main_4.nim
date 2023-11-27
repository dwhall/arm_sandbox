# Attempt to use <base>.<reg>

import std/bitops
import std/volatile


type
  RegisterVal = uint

#
# RCC
#
type RCC_Base = distinct RegisterVal
const RCC* = RCC_Base(0x40023800)

type RCC_AHB1ENR_Val* = distinct RegisterVal
type RCC_AHB1ENR_Ptr = ptr RCC_AHB1ENR_Val
const RCC_AHB1ENR = cast[RCC_AHB1ENR_Ptr](0x40023830)

# TODO: {.borrow.} more bit-wise ops
#proc `or` (x: RCC_AHB1ENR_Val, y: RegisterVal): RCC_AHB1ENR_Val {.borrow.}

template AHB1ENR*(base: static RCC_Base): RCC_AHB1ENR_Val = volatileLoad(RCC_AHB1ENR)
template `AHB1ENR=`*(base: static RCC_Base, val: RCC_AHB1ENR_Val) = volatileStore(RCC_AHB1ENR, val)

template modifyIt*(reg: static RCC_AHB1ENR_Ptr, op: untyped): untyped =
  block:
    var it {.inject.} = RCC.AHB1ENR
    op
    RCC.AHB1ENR = it

proc `GPIOAEN=`*(r: var RCC_AHB1ENR_Val, val: RegisterVal) {.inline.} =
  var tmp = r.RegisterVal
  tmp = tmp and bitnot(1u shl 0)
  tmp = tmp or ((val shl 0) and (1u shl 0))
  r = tmp.RCC_AHB1ENR_Val


#
# GPIOA MODER
#
type GPIOA_Base = distinct RegisterVal
const GPIOA* = GPIOA_Base(0x40020000)

type GPIOA_MODER_Val* = distinct RegisterVal
type GPIOA_MODER_Ptr = ptr GPIOA_MODER_Val
const GPIOA_MODER* = cast[GPIOA_MODER_Ptr](0x40020000)

template MODER*(base: static GPIOA_Base): GPIOA_MODER_Val = volatileLoad(GPIOA_MODER)
template `MODER=`*(base: static GPIOA_Base, val: GPIOA_MODER_Val) = volatileStore(GPIOA_MODER, val)

template modifyIt*(reg: static GPIOA_MODER_Ptr, op: untyped): untyped =
  block:
    var it {.inject.} = GPIOA.MODER
    op
    GPIOA.MODER = it

proc `MODER5=`*(r: var GPIOA_MODER_Val, val: RegisterVal) {.inline.} =
  var tmp = r.RegisterVal
  tmp = tmp and bitnot(0b11u shl 10)
  tmp = tmp or ((val and 0b11) shl 10)
  r = tmp.GPIOA_MODER_Val

#
# GPIOA BSRR (write-only)
#
type GPIOA_BSRR_Val* = distinct RegisterVal
type GPIOA_BSRR_Ptr = ptr GPIOA_BSRR_Val
const GPIOA_BSRR* = cast[GPIOA_BSRR_Ptr](0x40020018)

template `BSRR=`*(base: static GPIOA_Base, val: GPIOA_BSRR_Val) = volatileStore(GPIOA_BSRR, val)

proc `BR5=`*(r: var GPIOA_BSRR_Val, val: RegisterVal) {.inline.} =
  var tmp = r.RegisterVal
  tmp = tmp and bitnot(1u shl 21)
  tmp = tmp or ((val shl 21) and (1u shl 21))
  r = tmp.GPIOA_BSRR_Val

proc `BS5=`*(r: var GPIOA_BSRR_Val, val: RegisterVal) {.inline.} =
  var tmp = r.RegisterVal
  tmp = tmp and bitnot(1u shl 5)
  tmp = tmp or ((val shl 5) and (1u shl 5))
  r = tmp.GPIOA_BSRR_Val


proc main =
  # Configure A5 as a GPIO output pin
  modifyIt(RCC_AHB1ENR): it.GPIOAEN = 1
  modifyIt(GPIOA_MODER): it.MODER5 = 1

  # Perform bit-set, bit-clear on A5
  while true:
    GPIOA.BSRR = (1 shl 5).GPIOA_BSRR_Val
    GPIOA.BSRR = (1 shl 21).GPIOA_BSRR_Val


when isMainModule:
  main()
