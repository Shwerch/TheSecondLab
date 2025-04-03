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
  movq $0, %r10
  movq $0, %r11
  movq $0, %r12
  movq $0, %r13
  movq $0, %r14
  movq $0, %r15

  movb 0(%rax), %r8b
  movb 1(%rax), %r9b

  cmpq $10, %r9
  je oneDigit
  jmp twoDigits

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

  # В %r8 хранится введеное число

  movq %r8, %rax
  addq $1, %rax
  movq %r8, %rdx
  mulq %rdx
  movq %rax, %r9

  # В %r9 хранится длина выводимой строки

  movq %rsp, %r15

  # В %r15 хранится адрес начала выводимой строки

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
  movq $1, %rdx
  movq %r15, %rsi

  movq %r9, %r10
  movq $0, %r11
  printLoop:
    pushq %r10
    pushq %r11
    pushq %r15

    syscall

    popq %r15
    popq %r11
    popq %r10

    subq $1, %rsi

    addq $1, %r11
    cmpq %r10, %r11
    je printLoopEnd
    jmp printLoop
  printLoopEnd:
  
  pushw $'\n'
  movq %rsp, %rsi
  syscall
  popw %ax
  
  movq %r15, %rsp

  popq %r15
  popq %r14
  popq %r13
  popq %r12
  popq %r11
  popq %r10
  popq %r9
  popq %r8

  addq $INPUT, %rsp

  r2:

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
