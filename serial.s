# on entry:
#   A0 - base address
# on exit:
#   A0 - end of string
#   D0 - 0x0 
.global send_c_string

send_c_string:
  move.b %a0@+,%d0
  tst.b %d0
  beq return
  jsr uart_send_byte
  jmp send_c_string
return:
  rts


