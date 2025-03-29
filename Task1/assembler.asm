.data
msg:
  .ascii "Enter the N number: "
  .set msg_len, . - msg
buffer:
  .space 10

.text
.globl _start

notice:
  mov $1, %rax
  mov $msg, %rsi
  mov $msg_len, %rdx
  syscall
  ret

input:
  mov $0, %rax
  mov $0, %rdi
  mov $buffer, %rsi
  mov $10, %rdx
  syscall
  ret

output:
  mov $1, %rax
  mov $1, %rdi
  mov $buffer, %rsi
  mov $10, %rdx
  syscall
  ret

_start:
  mov $1, %rdi
  call notice
  call input
  call output
  jmp exit

exit:
  mov $60, %rax
  xor %rdi, %rdi
  syscall
