.global sys_init
.global mbar

.equ mbar,0x10000000

.equ uart1_ir,mbar+0x1f 
.equ avecen,0b10010000

.equ imr,mbar+0x36 
.equ ipr,mbar+0x3a
.equ uart1_interrupt_mask,0b1<11

sys_init:
  # set base address
  .equ syscfg,mbar | 0b00001
  move.l #syscfg,%d0
  movec %d0,#0xc0f
  lea uart1_ir,%a0
  move.b #avecen,%a0@
  lea imr,%a0
  move.w uart1_interrupt_mask,%a0@ 
  rts
