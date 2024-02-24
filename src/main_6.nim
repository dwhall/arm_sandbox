# Try to allow this chained rmw construction:
# RCC.AHB1ENR.GPIOAEN(1).write()

import std/bitops
import std/volatile

type
  RegisterAddr = uint32
  RegisterVal = uint32

func getField[T](regVal: T, bitOffset: static int, bitWidth: static int): T {.inline.} =
  ## Returns the field from the regVal and down-shifts it to no bit offset
  doAssert bitOffset < sizeof(RegisterVal) * 8, "bitOffset exceeds register size"
  const bitEnd = bitOffset + bitWidth - 1
  doAssert bitEnd < sizeof(RegisterVal) * 8, "bitEnd exceeds register size"
  const bitMask = toMask[uint32](bitOffset .. bitEnd)
  var r = regVal.RegisterVal
  r = r and bitMask
  r = r shr bitOffset
  r.T

func setField[T](
    regVal: T, bitOffset: static int, bitWidth: static int, fieldVal: RegisterVal
): T {.inline.} =
  ## Returns the regVal with the given bitfield (offset, width) replaced with fieldVal's bits
  doAssert bitOffset < sizeof(RegisterVal) * 8, "bitOffset exceeds register size"
  const bitEnd: int = bitOffset + bitWidth - 1
  doAssert bitEnd < sizeof(RegisterVal) * 8, "bitEnd exceeds register size"
  const bitMask = toMask[uint32](bitOffset .. bitEnd)
  assert((fieldVal and bitnot(bitMask)) == 0, "fieldVal exceeds field mask")
  var r = regVal.RegisterVal
  r = r and bitnot(bitMask)
  r = r or ((fieldVal shl bitOffset) and bitMask)
  r.T

# RCC peripheral
type RCC_Base = distinct RegisterAddr
const RCC* = RCC_Base(0x40023800)

# RCC.AHB1ENR register
type RCC_AHB1ENR_Val* = distinct RegisterVal
type RCC_AHB1ENR_Ptr = ptr RCC_AHB1ENR_Val
const RCC_AHB1ENR_Offset = 0x30'u32
const RCC_AHB1ENR = cast[RCC_AHB1ENR_Ptr](RCC.uint32 + RCC_AHB1ENR_Offset)

# reg read
template AHB1ENR*(base: static RCC_Base): RCC_AHB1ENR_Val =
  volatileLoad(RCC_AHB1ENR)

# reg write
template `AHB1ENR=`*(base: static RCC_Base, val: RCC_AHB1ENR_Val) =
  volatileStore(RCC_AHB1ENR, val)

template `AHB1ENR=`*(base: static RCC_Base, val: uint32) =
  volatileStore(RCC_AHB1ENR, val.RCC_AHB1ENR_Val)

# field read
template GPIOAEN*(regVal: RCC_AHB1ENR_Val): RCC_AHB1ENR_Val =
  getField[RCC_AHB1ENR_Val](regVal, 0, 1)

# chained field modify
template GPIOAEN*(regVal: RCC_AHB1ENR_Val, fieldVal: uint32): RCC_AHB1ENR_Val =
  setField[RCC_AHB1ENR_Val](regVal, 0, 1, fieldVal)

# write the modified fields to the reg
template write*(regVal: RCC_AHB1ENR_Val) =
  volatileStore(RCC_AHB1ENR, regVal)

proc main() =
  var r = RCC.AHB1ENR # reg read
  RCC.AHB1ENR = r.uint32 + 1 # reg write
  var en = RCC.AHB1ENR.GPIOAEN # field read
  RCC.AHB1ENR                       # reg read
     .GPIOAEN(en.uint32 or 1'u32)   # field modify
     .write()                       # reg write

when isMainModule:
  main()
