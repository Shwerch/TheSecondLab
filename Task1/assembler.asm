INPUT=16

.data
MESSAGE:
  .ascii "Enter the N number from 1 to 26: "
  .set MESSAGE_LEN, . - MESSAGE
ERROR:
  .ascii "The N number must be from 1 to 26!\n"
  .set ERROR_LEN, . - ERROR

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

  movq %rsp, %rax
  addq $INPUT, %rax

  movq $0, %r8
  movq $0, %r9
  movq $0, %r10

  movb 0(%rax), %r8b
  movb 1(%rax), %r9b
  movb 2(%rax), %r10b

  cmpq $10, %r9
  je oneDigit
  cmpq $10, %r10
  je twoDigits
  jmp error

  oneDigit:
    subq $'0', %r8

    cmpq $1, %r8
    jb error
    cmpq $9, %r8
    ja error

  jmp digitFunctionEnd

  twoDigits:
    subq $'0', %r9
    subq $'0', %r8

    cmpq $1, %r9
    jb error
    cmpq $9, %r9
    ja error

    cmpq $1, %r8
    jb error
    cmpq $9, %r8
    ja error

    movq %r8, %rax
    movq $10, %rdx
    mulq %rdx
    movq %rax, %r8

    addq %r9, %r8
  jmp digitFunctionEnd

  digitFunctionEnd:

  cmpq $1, %r8
  jb error
  cmpq $26, %r8
  ja error

  movq %r8, %rax
  addq $1, %rax
  movq %r8, %rdx
  mulq %rdx
  movq %rax, %r9

  movq %rsp, %r15
  addq $1, %r15

  popw %ax
  movb $'\n', %al
  pushw %ax

  movq %r8, %r10
  movq $0, %r11
  firstLoop:

    movq %r8, %r12
    subq %r11, %r12
    movq $0, %r13
    secondLoop:

      movq $'A', %r14
      addq %r13, %r14
      addq %r11, %r14

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

  pushq %r15

  movq $1, %rax
  movq $1, %rdi
  movq %r15, %rsi
  subq %r9, %rsi
  movq %r9, %rdx
  syscall

  popq %r15
  subq $1, %r15
  addq $INPUT, %r15

  movq %r15, %rsp

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
