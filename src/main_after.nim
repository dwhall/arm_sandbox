import after


proc main_after =
  # Configure A5 as a GPIO output pin
  modifyIt(RCC_AHB1ENR): it.GPIOAEN = 1
  modifyIt(GPIOA_MODER): it.MODER5 = 1

  # Perform bit-set, bit-clear on A5
  while true:
    GPIOA_BSRR.write((1 shl 5).GPIOA_BSRR_Val)
    GPIOA_BSRR.write((1 shl 21).GPIOA_BSRR_Val)


when isMainModule:
  main_after()
