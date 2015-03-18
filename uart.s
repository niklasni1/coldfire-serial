#registers
.equ uart1_umr,mbar+0x140
.equ uart1_usr_ucsr,mbar+0x144 
.equ uart1_ucr,mbar+0x148
.equ uart1_buf,mbar+0x14c
.equ uart1_ipcr_uacr,mbar+0x150
.equ uart1_ir,mbar+0x154
.equ uart1_ubg1,mbar+0x158
.equ uart1_ubg2,mbar+0x15c 
.equ uart1_uivr,mbar+0x170
.equ uart1_ip,mbar+0x174
.equ uart1_op_set,mbar+0x178
.equ uart1_op_reset,mbar+0x17c

.equ uart2_umr,mbar+0x180 
.equ uart2_usr,mbar+0x184 
.equ uart2_ucr,mbar+0x188
.equ uart2_buf,mbar+0x18c
.equ uart2_ipcr_uacr,mbar+0x190
.equ uart2_ir,mbar+0x194
.equ uart2_ubg1,mbar+0x198
.equ uart2_ubg2,mbar+0x19c 
.equ uart2_uivr,mbar+0x1b0
.equ uart2_ip,mbar+0x1b4
.equ uart2_op_set,mbar+0x1b8
.equ uart2_op_reset,mbar+0x1bc

#handy constants
.equ uart_umr1,0b11110011 /* 8n1 etc user manual 499 */
.equ uart_umr2,0b00000111 /* no flow control, 1 stop bit */
.equ uart_clock_x16,0b11101110 
.equ uart_clock_x1,0b11111111 

#commands
.equ uart_cmd_misc_none,0b000<<4
.equ uart_cmd_misc_reset_mode_register_pointer,0b001<<4
.equ uart_cmd_misc_reset_receiver,0b010<<4
.equ uart_cmd_misc_reset_transmitter,0b011<<4
.equ uart_cmd_misc_reset_error_status,0b100<<4
.equ uart_cmd_misc_reset_break_change,0b101<<4
.equ uart_cmd_misc_start_break,0b110<<4
.equ uart_cmd_misc_stop_break,0b111<<4

.equ uart_cmd_tx_none,0b00<<2
.equ uart_cmd_tx_enable,0b01<<2
.equ uart_cmd_tx_disable,0b10<<2

.equ uart_cmd_rx_none,0b00
.equ uart_cmd_rx_enable,0b01
.equ uart_cmd_rx_disable,0b10

.global uart_init

uart_init:
  # reset receiver and transmitter (command)
  lea.l uart1_ucr,%a0 
  move.b #uart_cmd_misc_reset_receiver,%a0@
  move.b #uart_cmd_misc_reset_transmitter,%a0@

  # programme vector number for uart interrupt
  # enable interrupt sources (UIMR)
  lea.l uart1_ir,%a0
  move.b #0b10000000,%a0@
  # initalise input enable (UACR)
  lea.l uart1_ipcr_uacr,%a0
  move.b #0b0,%a0@

  # select clock (UCSR)
  lea.l uart1_usr_ucsr,%a0
  move.b #uart_clock_x1,%a0@

  # mode1
  lea.l uart1_umr,%a0
  move.b #uart_umr1,%a0@
  # mode2
  move.b #uart_umr2,%a0@

  lea.l uart1_ucr,%a0
  move.b #uart_cmd_misc_reset_mode_register_pointer,%a0@

  # enable receiver and transmitter
  lea.l uart1_ucr,%a0
  move.b #uart_cmd_tx_enable | uart_cmd_rx_enable, %a0@ 
  rts

.global uart_send_byte

uart_send_byte:
  lea.l uart1_buf,%a1
  move.b %d0,%a1@
  rts
