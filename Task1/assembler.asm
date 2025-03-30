INPUT_SIZE=2
DIGIT_INT_DIFFERENCE=48
CHAR_INT_DIFFERENCE=65

STDIN=0
STDOUT=1
STDERR=2

sys_write=1
sys_read=0
sys_exit=60

numberRegister=%r10b

iStart=0
iLimit=%r8b
i=%r9b

jStart=0
jLimit=%r10b
j=%r11b

.data
message:
  .ascii "Enter the N number: "
  .set message_len, . - message

.text
.globl _start

oneDigit:
  subb $DIGIT_INT_DIFFERENCE, %r8b
  movb %r8b, numberRegister
  jmp digitFunctionEnd

twoDigits:
  subb $DIGIT_INT_DIFFERENCE, %r8b
  subb $DIGIT_INT_DIFFERENCE, %r9b
  movb %r9b, numberRegister
  movb %r8b, %al
  movb $10, %r12b
  mulb %r12b
  addw %ax, %r10w
  jmp digitFunctionEnd

_start:
  # Сохранение начального состояния %rsp в %rbp
  movq %rsp, %rbp
  
  # Вывод приветственного сообщения
  movq $sys_write, %rax
  movq $STDOUT, %rdi
  movq $message, %rsi
  movq $message_len, %rdx
  syscall

  # Выделение INPUT_SIZE байт в стеке
  subq $INPUT_SIZE, %rsp
  
  # Ввод числа как массива INPUT_SIZE символов в %rsp
  movq $sys_read, %rax
  movq $STDIN, %rdi
  movq %rsp, %rsi
  movq $INPUT_SIZE, %rdx
  syscall

  # Перемещение символов в разные регистры
  movb 0(%rsp), %r8b
  movb 1(%rsp), %r9b
  
  # Определение, сколько цифр были введено и запись результата в numberRegister
  cmpb $10, %r9b
  je oneDigit
  jmp twoDigits
  digitFunctionEnd:

  # Объявление первого цикла с i
  movb numberRegister, iLimit
  movb iStart, i
  firstLoop:
    # Объявление второго цикла с j
    movb i, jLimit
    add $1, jLimit
    movb jStart, j
    secondLoop:
      
      # Рассчет кодов символов для вывода буквы
      movb iLimit, %r12b
      subb j, %r12b
      subb $1, %r12b
      addb $CHAR_INT_DIFFERENCE, %r12b
      addw $0xa00, %r12w

      # Вывод символ буквы и пробела
      movq $sys_write, %rax
      movq $STDOUT, %rdi
      movq (%r12), %rsi
      movq $2, %rdx
      syscall

      # Завершение второго цикла с j
      addb $1, j
      cmpb j, jLimit
      je secondLoopEnd
      jmp secondLoop
    secondLoopEnd:

    # Вывод символа конца строки '\n'
    movq $sys_write, %rax
    movq $STDOUT, %rdi
    movq $'\n', %rsi
    movq $1, %rdx
    syscall

    # Завершение первого цикла с i
    addb $1, i
    cmpb i, iLimit
    je firstLoopEnd
    jmp firstLoop
  firstLoopEnd:


  jmp exit

exit:
  # Восстановление %rsp (освобождение стека)
  movq %rbp, %rsp

  # Завершение работы программы
  movq $sys_exit, %rax
  movq $0, %rdi
  syscall
