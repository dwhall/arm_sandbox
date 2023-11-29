# Try to allow this chained rmw construction:
# RCC.AHB1ENR.GPIOAEN(1).write()

import std/bitops
import std/volatile


type
  RegisterVal = uint

func setField[T](regVal: T, bitOffset: static uint, bitMask: static uint, fieldVal: RegisterVal): T {.inline.} =
  ## Incoming bitMask and fieldVal are bit-0-based (not yet shifted into final position)
  assert((fieldVal and bitnot(bitMask)) == 0, "fieldVal exceeds field mask")
  var r = regVal.RegisterVal
  r = r and bitnot(bitMask shl bitOffset)
  r = r or ((fieldVal and bitMask) shl bitOffset)
  r.T


#
# RCC peripheral
#
type RCC_Base = distinct RegisterVal
const RCC* = RCC_Base(0x40023800)

#
# RCC.AHB1ENR register
#
type RCC_AHB1ENR_Val* = distinct RegisterVal
type RCC_AHB1ENR_Ptr = ptr RCC_AHB1ENR_Val
const RCC_AHB1ENR = cast[RCC_AHB1ENR_Ptr](0x40023830)

template AHB1ENR*(base: static RCC_Base): RCC_AHB1ENR_Val = volatileLoad(RCC_AHB1ENR)
template `AHB1ENR=`*(base: static RCC_Base, val: RCC_AHB1ENR_Val) = volatileStore(RCC_AHB1ENR, val)
template write(val: RCC_AHB1ENR_Val) = volatileStore(RCC_AHB1ENR, val)

template GPIOAEN*(regVal: RCC_AHB1ENR_Val, fieldVal: RegisterVal): RCC_AHB1ENR_Val =
  setField[RCC_AHB1ENR_Val](regVal, 0u, 0b1u, fieldVal)


#
# GPIOA peripheral
#
type GPIOA_Base = distinct RegisterVal
const GPIOA* = GPIOA_Base(0x40020000)

#
# GPIOA.MODER register
#
type GPIOA_MODER_Val* = distinct RegisterVal
type GPIOA_MODER_Ptr = ptr GPIOA_MODER_Val
const GPIOA_MODER* = cast[GPIOA_MODER_Ptr](0x40020000)

template MODER*(base: static GPIOA_Base): GPIOA_MODER_Val = volatileLoad(GPIOA_MODER)
template `MODER=`*(base: static GPIOA_Base, val: GPIOA_MODER_Val) = volatileStore(GPIOA_MODER, val)
template write(val: GPIOA_MODER_Val) = volatileStore(GPIOA_MODER, val)

template MODER5*(regVal: GPIOA_MODER_Val, fieldVal: RegisterVal): GPIOA_MODER_Val =
  setField[GPIOA_MODER_Val](regVal, 10u, 0b11u, fieldVal)

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
  RCC.AHB1ENR.GPIOAEN(1).write()        # replaced modifyIt()
  GPIOA.MODER.MODER5(1).write()

  # Perform bit-set, bit-clear on A5
  while true:
    GPIOA.BSRR = (1 shl 5).GPIOA_BSRR_Val
    GPIOA.BSRR = (1 shl 21).GPIOA_BSRR_Val


when isMainModule:
  main()
