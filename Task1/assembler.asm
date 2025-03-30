.data
msg:
  .ascii "Enter the N number: "
  .set msg_len, . - msg
system:
  .ascii "'"
  .set system_len, . - system
first:
  .quad 0
second:
  .quad 0

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

  movq $second, %r8
  movq $10, %r9
  cmpq %r8, %r9
  je exit

  ret

output:
  movq $1, %rax
  movq $1, %rdi
  movq $system, %rsi
  movq $system_len, %rdx
  syscall

  movq $1, %rax
  movq $1, %rdi
  movq $first, %rsi
  movq $2, %rdx
  syscall

  movq $1, %rax
  movq $1, %rdi
  movq $second, %rsi
  movq $2, %rdx
  syscall
  
  movq $1, %rax
  movq $1, %rdi
  movq $system, %rsi
  movq $system_len, %rdx
  syscall
  ret

_start:
  movq $1, %rdi
  call notice
  call input
  call output
  jmp exit

exit:
  movq $60, %rax
  movq $0, %rdi
  syscall
