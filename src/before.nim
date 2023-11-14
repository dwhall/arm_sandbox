# Snippets taken from the converted output of an SVD file
# for an STM32F446 microcontroller

import std/bitops
import std/volatile


# "standin" types are so I don't have to make
# a bunch of different types for registers
# that are not used in this demonstration

#
# RCC
#
type RCC_AHB1ENR_Type* = object
  loc: uint
type RCC_standin_Type* = object
  loc: uint

type RCC_Type* = object
  CR*: RCC_standin_Type
  PLLCFGR*: RCC_standin_Type
  CFGR*: RCC_standin_Type
  CIR*: RCC_standin_Type
  AHB1RSTR*: RCC_standin_Type
  AHB2RSTR*: RCC_standin_Type
  AHB3RSTR*: RCC_standin_Type
  APB1RSTR*: RCC_standin_Type
  APB2RSTR*: RCC_standin_Type
  AHB1ENR*: RCC_AHB1ENR_Type
  AHB2ENR*: RCC_standin_Type
  AHB3ENR*: RCC_standin_Type
  APB1ENR*: RCC_standin_Type
  APB2ENR*: RCC_standin_Type
  AHB1LPENR*: RCC_standin_Type
  AHB2LPENR*: RCC_standin_Type
  AHB3LPENR*: RCC_standin_Type
  APB1LPENR*: RCC_standin_Type
  APB2LPENR*: RCC_standin_Type
  BDCR*: RCC_standin_Type
  CSR*: RCC_standin_Type
  SSCGR*: RCC_standin_Type
  PLLI2SCFGR*: RCC_standin_Type
  PLLSAICFGR*: RCC_standin_Type
  DCKCFGR*: RCC_standin_Type
  CKGATENR*: RCC_standin_Type
  DCKCFGR2*: RCC_standin_Type

const RCC* = RCC_Type(
  CR: RCC_standin_Type(loc: 0x40023800'u),
  PLLCFGR: RCC_standin_Type(loc: 0x40023804'u),
  CFGR: RCC_standin_Type(loc: 0x40023808'u),
  CIR: RCC_standin_Type(loc: 0x4002380c'u),
  AHB1RSTR: RCC_standin_Type(loc: 0x40023810'u),
  AHB2RSTR: RCC_standin_Type(loc: 0x40023814'u),
  AHB3RSTR: RCC_standin_Type(loc: 0x40023818'u),
  APB1RSTR: RCC_standin_Type(loc: 0x40023820'u),
  APB2RSTR: RCC_standin_Type(loc: 0x40023824'u),
  AHB1ENR: RCC_AHB1ENR_Type(loc: 0x40023830'u),
  AHB2ENR: RCC_standin_Type(loc: 0x40023834'u),
  AHB3ENR: RCC_standin_Type(loc: 0x40023838'u),
  APB1ENR: RCC_standin_Type(loc: 0x40023840'u),
  APB2ENR: RCC_standin_Type(loc: 0x40023844'u),
  AHB1LPENR: RCC_standin_Type(loc: 0x40023850'u),
  AHB2LPENR: RCC_standin_Type(loc: 0x40023854'u),
  AHB3LPENR: RCC_standin_Type(loc: 0x40023858'u),
  APB1LPENR: RCC_standin_Type(loc: 0x40023860'u),
  APB2LPENR: RCC_standin_Type(loc: 0x40023864'u),
  BDCR: RCC_standin_Type(loc: 0x40023870'u),
  CSR: RCC_standin_Type(loc: 0x40023874'u),
  SSCGR: RCC_standin_Type(loc: 0x40023880'u),
  PLLI2SCFGR: RCC_standin_Type(loc: 0x40023884'u),
  PLLSAICFGR: RCC_standin_Type(loc: 0x40023888'u),
  DCKCFGR: RCC_standin_Type(loc: 0x4002388c'u),
  CKGATENR: RCC_standin_Type(loc: 0x40023890'u),
  DCKCFGR2: RCC_standin_Type(loc: 0x40023894'u),
)

type
  RCC_AHB1ENR_Fields* = distinct uint32

proc read*(reg: static RCC_AHB1ENR_Type): RCC_AHB1ENR_Fields {.inline.} =
  volatileLoad(cast[ptr RCC_AHB1ENR_Fields](reg.loc))

proc write*(reg: RCC_AHB1ENR_Type, val: RCC_AHB1ENR_Fields) {.inline.} =
  volatileStore(cast[ptr RCC_AHB1ENR_Fields](reg.loc), val)

proc write*(reg: RCC_AHB1ENR_Type, OTGHSULPIEN: bool = false, OTGHSEN: bool = false, DMA2EN: bool = false, DMA1EN: bool = false, BKPSRAMEN: bool = false, CRCEN: bool = false, GPIOHEN: bool = false, GPIOGEN: bool = false, GPIOFEN: bool = false, GPIOEEN: bool = false, GPIODEN: bool = false, GPIOCEN: bool = false, GPIOBEN: bool = false, GPIOAEN: bool = false) =
  var x: uint32
  x.setMask((OTGHSULPIEN.uint32 shl 30).masked(30 .. 30))
  x.setMask((OTGHSEN.uint32 shl 29).masked(29 .. 29))
  x.setMask((DMA2EN.uint32 shl 22).masked(22 .. 22))
  x.setMask((DMA1EN.uint32 shl 21).masked(21 .. 21))
  x.setMask((BKPSRAMEN.uint32 shl 18).masked(18 .. 18))
  x.setMask((CRCEN.uint32 shl 12).masked(12 .. 12))
  x.setMask((GPIOHEN.uint32 shl 7).masked(7 .. 7))
  x.setMask((GPIOGEN.uint32 shl 6).masked(6 .. 6))
  x.setMask((GPIOFEN.uint32 shl 5).masked(5 .. 5))
  x.setMask((GPIOEEN.uint32 shl 4).masked(4 .. 4))
  x.setMask((GPIODEN.uint32 shl 3).masked(3 .. 3))
  x.setMask((GPIOCEN.uint32 shl 2).masked(2 .. 2))
  x.setMask((GPIOBEN.uint32 shl 1).masked(1 .. 1))
  x.setMask((GPIOAEN.uint32 shl 0).masked(0 .. 0))
  reg.write x.RCC_AHB1ENR_Fields

template modifyIt*(reg: RCC_AHB1ENR_Type, op: untyped): untyped =
  block:
    var it {.inject.} = reg.read()
    op
    reg.write(it)

proc `GPIOAEN=`*(r: var RCC_AHB1ENR_Fields, val: bool) {.inline.} =
  var tmp = r.uint32
  tmp.clearMask(0 .. 0)
  tmp.setMask((val.uint32 shl 0).masked(0 .. 0))
  r = tmp.RCC_AHB1ENR_Fields


#
# GPIOA
#
type GPIOA_MODER_Type* = object
  loc: uint
type GPIOA_BSRR_Type* = object
  loc: uint
type GPIOA_standin_Type* = object
  loc: uint

type GPIOA_Type* = object
  MODER*: GPIOA_MODER_Type
  OTYPER*: GPIOA_standin_Type
  OSPEEDR*: GPIOA_standin_Type
  PUPDR*: GPIOA_standin_Type
  IDR*: GPIOA_standin_Type
  ODR*: GPIOA_standin_Type
  BSRR*: GPIOA_BSRR_Type
  LCKR*: GPIOA_standin_Type
  AFRL*: GPIOA_standin_Type
  AFRH*: GPIOA_standin_Type

const GPIOA* = GPIOA_Type(
  MODER: GPIOA_MODER_Type(loc: 0x40020000'u),
  OTYPER: GPIOA_standin_Type(loc: 0x40020004'u),
  OSPEEDR: GPIOA_standin_Type(loc: 0x40020008'u),
  PUPDR: GPIOA_standin_Type(loc: 0x4002000c'u),
  IDR: GPIOA_standin_Type(loc: 0x40020010'u),
  ODR: GPIOA_standin_Type(loc: 0x40020014'u),
  BSRR: GPIOA_BSRR_Type(loc: 0x40020018'u),
  LCKR: GPIOA_standin_Type(loc: 0x4002001c'u),
  AFRL: GPIOA_standin_Type(loc: 0x40020020'u),
  AFRH: GPIOA_standin_Type(loc: 0x40020024'u),
)

type
  GPIOA_MODER_Fields* = distinct uint32
  GPIOA_BSRR_Fields* = distinct uint32

proc read*(reg: static GPIOA_MODER_Type): GPIOA_MODER_Fields {.inline.} =
  volatileLoad(cast[ptr GPIOA_MODER_Fields](reg.loc))

proc write*(reg: GPIOA_MODER_Type, val: GPIOA_MODER_Fields) {.inline.} =
  volatileStore(cast[ptr GPIOA_MODER_Fields](reg.loc), val)

proc write*(reg: GPIOA_MODER_Type, MODER15: uint32 = 2, MODER14: uint32 = 2, MODER13: uint32 = 2, MODER12: uint32 = 0, MODER11: uint32 = 0, MODER10: uint32 = 0, MODER9: uint32 = 0, MODER8: uint32 = 0, MODER7: uint32 = 0, MODER6: uint32 = 0, MODER5: uint32 = 0, MODER4: uint32 = 0, MODER3: uint32 = 0, MODER2: uint32 = 0, MODER1: uint32 = 0, MODER0: uint32 = 0) =
  var x: uint32
  x.setMask((MODER15 shl 30).masked(30 .. 31))
  x.setMask((MODER14 shl 28).masked(28 .. 29))
  x.setMask((MODER13 shl 26).masked(26 .. 27))
  x.setMask((MODER12 shl 24).masked(24 .. 25))
  x.setMask((MODER11 shl 22).masked(22 .. 23))
  x.setMask((MODER10 shl 20).masked(20 .. 21))
  x.setMask((MODER9 shl 18).masked(18 .. 19))
  x.setMask((MODER8 shl 16).masked(16 .. 17))
  x.setMask((MODER7 shl 14).masked(14 .. 15))
  x.setMask((MODER6 shl 12).masked(12 .. 13))
  x.setMask((MODER5 shl 10).masked(10 .. 11))
  x.setMask((MODER4 shl 8).masked(8 .. 9))
  x.setMask((MODER3 shl 6).masked(6 .. 7))
  x.setMask((MODER2 shl 4).masked(4 .. 5))
  x.setMask((MODER1 shl 2).masked(2 .. 3))
  x.setMask((MODER0 shl 0).masked(0 .. 1))
  reg.write x.GPIOA_MODER_Fields

template modifyIt*(reg: GPIOA_MODER_Type, op: untyped): untyped =
  block:
    var it {.inject.} = reg.read()
    op
    reg.write(it)

proc `MODER5=`*(r: var GPIOA_MODER_Fields, val: uint32) {.inline.} =
  var tmp = r.uint32
  tmp.clearMask(10 .. 11)
  tmp.setMask((val shl 10).masked(10 .. 11))
  r = tmp.GPIOA_MODER_Fields

# BSRR a is write-only register
proc write*(reg: GPIOA_BSRR_Type, val: GPIOA_BSRR_Fields) {.inline.} =
  volatileStore(cast[ptr GPIOA_BSRR_Fields](reg.loc), val)

proc write*(reg: GPIOA_BSRR_Type, BR15: bool = false, BR14: bool = false, BR13: bool = false, BR12: bool = false, BR11: bool = false, BR10: bool = false, BR9: bool = false, BR8: bool = false, BR7: bool = false, BR6: bool = false, BR5: bool = false, BR4: bool = false, BR3: bool = false, BR2: bool = false, BR1: bool = false, BR0: bool = false, BS15: bool = false, BS14: bool = false, BS13: bool = false, BS12: bool = false, BS11: bool = false, BS10: bool = false, BS9: bool = false, BS8: bool = false, BS7: bool = false, BS6: bool = false, BS5: bool = false, BS4: bool = false, BS3: bool = false, BS2: bool = false, BS1: bool = false, BS0: bool = false) =
  var x: uint32
  x.setMask((BR15.uint32 shl 31).masked(31 .. 31))
  x.setMask((BR14.uint32 shl 30).masked(30 .. 30))
  x.setMask((BR13.uint32 shl 29).masked(29 .. 29))
  x.setMask((BR12.uint32 shl 28).masked(28 .. 28))
  x.setMask((BR11.uint32 shl 27).masked(27 .. 27))
  x.setMask((BR10.uint32 shl 26).masked(26 .. 26))
  x.setMask((BR9.uint32 shl 25).masked(25 .. 25))
  x.setMask((BR8.uint32 shl 24).masked(24 .. 24))
  x.setMask((BR7.uint32 shl 23).masked(23 .. 23))
  x.setMask((BR6.uint32 shl 22).masked(22 .. 22))
  x.setMask((BR5.uint32 shl 21).masked(21 .. 21))
  x.setMask((BR4.uint32 shl 20).masked(20 .. 20))
  x.setMask((BR3.uint32 shl 19).masked(19 .. 19))
  x.setMask((BR2.uint32 shl 18).masked(18 .. 18))
  x.setMask((BR1.uint32 shl 17).masked(17 .. 17))
  x.setMask((BR0.uint32 shl 16).masked(16 .. 16))
  x.setMask((BS15.uint32 shl 15).masked(15 .. 15))
  x.setMask((BS14.uint32 shl 14).masked(14 .. 14))
  x.setMask((BS13.uint32 shl 13).masked(13 .. 13))
  x.setMask((BS12.uint32 shl 12).masked(12 .. 12))
  x.setMask((BS11.uint32 shl 11).masked(11 .. 11))
  x.setMask((BS10.uint32 shl 10).masked(10 .. 10))
  x.setMask((BS9.uint32 shl 9).masked(9 .. 9))
  x.setMask((BS8.uint32 shl 8).masked(8 .. 8))
  x.setMask((BS7.uint32 shl 7).masked(7 .. 7))
  x.setMask((BS6.uint32 shl 6).masked(6 .. 6))
  x.setMask((BS5.uint32 shl 5).masked(5 .. 5))
  x.setMask((BS4.uint32 shl 4).masked(4 .. 4))
  x.setMask((BS3.uint32 shl 3).masked(3 .. 3))
  x.setMask((BS2.uint32 shl 2).masked(2 .. 2))
  x.setMask((BS1.uint32 shl 1).masked(1 .. 1))
  x.setMask((BS0.uint32 shl 0).masked(0 .. 0))
  reg.write x.GPIOA_BSRR_Fields

proc `BR5=`*(r: var GPIOA_BSRR_Fields, val: bool) {.inline.} =
  var tmp = r.uint32
  tmp.clearMask(21 .. 21)
  tmp.setMask((val.uint32 shl 21).masked(21 .. 21))
  r = tmp.GPIOA_BSRR_Fields

proc `BS5=`*(r: var GPIOA_BSRR_Fields, val: bool) {.inline.} =
  var tmp = r.uint32
  tmp.clearMask(5 .. 5)
  tmp.setMask((val.uint32 shl 5).masked(5 .. 5))
  r = tmp.GPIOA_BSRR_Fields

