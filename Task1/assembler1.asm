INPUT=16

.data
MESSAGE:
  .ascii "Enter the N number: "
  .set MESSAGE_LEN, . - MESSAGE
ERROR:
  .ascii "The N number must be from 1 to 26!\n"
  .set ERROR_LEN, . - ERROR
SPACE:
  .ascii " "
NEWLINE:
  .ascii "\n"
LETTERS:
  .ascii "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

.text
.globl _start

_start:
  movq $1, %rax
  movq $1, %rdi
  movq $MESSAGE, %rsi
  movq $MESSAGE_LEN, %rdx
  syscall

  subq $INPUT, %rsp

  movq $0, %rax
  movq $0, %rdi
  movq %rsp, %rsi
  addq $INPUT, %rsi
  movq $INPUT, %rdx
  syscall

  pushq %r8
  pushq %r9
  pushq %r10

  movq $0, %r8
  movq $0, %r9

  movq %rsp, %r10
  addq $INPUT, %r10
  addq $24, %r10
  
  movb 0(%r10), %r8b
  movb 1(%r10), %r9b
  
  movq $0, %r10

  cmpb $10, %r9b
  je oneDigit
  jmp twoDigits

  oneDigit:
    subb $'0', %r8b

    cmpb $1, %r8b
    jb error
    cmpb $9, %r8b
    ja error

    movb %r8b, %r10b
  jmp digitFunctionEnd

  twoDigits:
    subb $'0', %r9b
    subb $'0', %r8b

    cmpb $1, %r9b
    jb error
    cmpb $9, %r9b
    ja error

    cmpb $1, %r8b
    jb error
    cmpb $9, %r8b
    ja error

    movb %r9b, %r10b

    pushw %ax

    movb %r8b, %al
    movb $10, %ah
    mulb %ah
    addw %ax, %r10w

    popw %ax
  jmp digitFunctionEnd

  digitFunctionEnd:

  r2:

  popq %r10
  popq %r9
  popq %r8

  jmp exit

error:
  movq $1, %rax
  movq $1, %rdi
  movq $ERROR, %rsi
  movq $ERROR_LEN, %rdx
  syscall

  movq $0, %rax
  movq $1, %rdi
  syscall

exit:
  movq $60, %rax
  movq $0, %rdi
  syscall
