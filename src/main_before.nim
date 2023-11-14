import before


proc main_before =
  # Configure A5 as a GPIO output pin
  modifyIt(RCC.AHB1ENR): it.GPIOAEN = true
  modifyIt(GPIOA.MODER): it.MODER5 = 1

  # Perform bit-set, bit-clear on A5
  # TODO: Is there a way to create a "let" value, v, to pass to write()?
  var setval:GPIOA_BSRR_Fields
  var clrval:GPIOA_BSRR_Fields
  setval.BS5 = true
  clrval.BR5 = true
  while true:
    GPIOA.BSRR.write(setval)
    GPIOA.BSRR.write(clrval)


when isMainModule:
  main_before()
