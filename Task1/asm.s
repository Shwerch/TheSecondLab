.data
msg:
  .ascii "Enter the N number: "
  .set msg_len, . - msg
first:
  .byte 1
second:
  .byte 1

.text
.globl _start

notice:
  movq $1, %rax
  movq $msg, %rsi
  movq $msg_len, %rdx
  syscall
  ret

input:
  movq $0, %rax
  movq $0, %rdi
  movq $first, %rsi
  movq $1, %rdx
  syscall

  movq $0, %rax
  movq $0, %rdi
  movq $second, %rsi
  movq $1, %rdx
  syscall

  ret

convert:
  movl $second, %eax
  movl $10, %r8d
  mul %r8d
  add $first, %eax
  ret

_start:
  movq $1, %rdi
  call notice
  call input
  call convert

  jmp exit

exit:
  movq $60, %rax
  xor %rdi, %rdi
  syscall

