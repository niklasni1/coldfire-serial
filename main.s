.global start
start:
  jsr sys_init
  jsr uart_init
  lea.l hello_str,%a0
  jsr send_c_string
  jmp .

.equ hello_str, . ; .asciz "hello"
