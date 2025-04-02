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
  pushq %r11
  pushq %r12
  pushq %r13
  pushq %r14
  pushq %r15

  movq $0, %r8
  movq $0, %r9

  movq %rsp, %r10
  addq $INPUT, %r10
  addq $64, %r10  # Так как было сохранено 8 регистров по 8 байт
  
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

    movq %r8, %rax
    movq $10, %rdx
    mulq %rdx
    addq %rax, %r10
  jmp digitFunctionEnd

  digitFunctionEnd:

  movq %r10, %r8
  movq $0, %r9
  movq $0, %r10

  cmpq $1, %r8
  jb error
  cmpq $26, %r8
  ja error

  movq %r8, %rax
  addq $1, %rax
  movq %r8, %rdx
  mulq %rdx
  movq %rax, %r9

  movq %r8, %r10
  movq $0, %r11
  firstLoop:

    movq %r11, %r12
    addq $1, %r12
    movq $0, %r13
    secondLoop:

      movq %r8, %r14
      subq %r13, %r14
      subq $1, %r14
      addq $'A', %r14

      movq $0, %rax
      movw %r14w, %ax
      movw $0x100, %cx
      mulw %cx
      addw $' ', %ax
      pushw %ax

      addq $1, %r13
      cmpq %r12, %r13
      je secondLoopEnd
      jmp secondLoop
    secondLoopEnd:

    popw %ax
    movb $'\n', %al
    pushw %ax

    addq $1, %r11
    cmpq %r10, %r11
    je firstLoopEnd
    jmp firstLoop
  firstLoopEnd:

  movq $1, %rax
  movq $1, %rdi
  movq %rsp, %rsi
  movq %r9, %rdx
  syscall
  
  movq %r15, %rsp
  movq 0(%r15), %rax
  r1:

  popq %r15
  popq %r14
  popq %r13
  popq %r12
  popq %r11
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

  movq $60, %rax
  movq $1, %rdi
  syscall

exit:
  movq $60, %rax
  movq $0, %rdi
  syscall
