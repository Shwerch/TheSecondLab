INPUT_SIZE=2
DIGIT_NUMBER_DIFFERENCE=48

STDIN=0
STDOUT=1
STDERR=2

sys_write=1
sys_read=0
sys_exit=60

iStart=0
iLimit=%r8
i=%r9

jStart=0
jLimit=%r10
j=%r13

.data
MESSAGE:
  .ascii "Enter the N number: "
  .set MESSAGE_LEN, . - MESSAGE
SPACE:
  .ascii " "
NEWLINE:
  .ascii "\n"
LETTERS:
  .ascii "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

.text
.globl _start

oneDigit:
  # Конвертация символа из %r8b в еденицы числа
  subb $DIGIT_NUMBER_DIFFERENCE, %r8b
  movb %r8b, %r10b

  jmp digitFunctionEnd

twoDigits:
  # Конвертация символа из %r9b в еденицы числа
  subb $DIGIT_NUMBER_DIFFERENCE, %r9b
  movb %r9b, %r10b

  # Конвертация символа из %r8b в десятки числа
  subb $DIGIT_NUMBER_DIFFERENCE, %r8b
  movb %r8b, %al
  movb $10, %r12b
  mulb %r12b
  addw %ax, %r10w
  
  jmp digitFunctionEnd

printHelloMessage:
  movq $sys_write, %rax
  movq $STDOUT, %rdi
  movq $MESSAGE, %rsi
  movq $MESSAGE_LEN, %rdx
  syscall
  ret


printSpace:
  movq $sys_write, %rax
  movq $STDOUT, %rdi
  movq $SPACE, %rsi
  movq $1, %rdx
  syscall
  ret

printNewLine:
  movq $sys_write, %rax
  movq $STDOUT, %rdi
  movq $NEWLINE, %rsi
  movq $1, %rdx
  syscall
  ret

# Код символа берется из %r14
printLetter:
  movq $sys_write, %rax
  movq $STDOUT, %rdi
  movq $LETTERS, %rsi
  addq %r14, %rsi
  movq $1, %rdx
  syscall
  ret

_start:
  # Сохранение начального состояния %rsp в %rbp
  movq %rsp, %rbp
  
  call printHelloMessage

  # Выделение INPUT_SIZE байт в стеке
  subq $INPUT_SIZE, %rsp
  
  # Ввод числа как массива INPUT_SIZE символов в %rsp
  movq $sys_read, %rax
  movq $STDIN, %rdi
  movq %rsp, %rsi
  movq $2048, %rdx
  syscall

  # Перемещение символов в разные регистры
  movb 0(%rsp), %r8b
  movb 1(%rsp), %r9b
  
  # Определение, сколько цифр были введено и запись результата в %r10b
  cmpb $10, %r9b
  je oneDigit
  jmp twoDigits
  digitFunctionEnd:

  # Объявление первого цикла с i
  movq %r10, iLimit
  movq $iStart, i
  firstLoop:

    # Объявление второго цикла с j
    movq i, jLimit
    addq $1, jLimit
    movq $jStart, j
    secondLoop:
      
      # Рассчет кодов символов для вывода буквы
      movq iLimit, %r14
      subq j, %r14
      subq $1, %r14
      
      call printLetter

      call printSpace

      # Завершение второго цикла с j
      addq $1, j
      cmpq j, jLimit
      je secondLoopEnd
      jmp secondLoop
    secondLoopEnd:

    call printNewLine

    # Завершение первого цикла с i
    addq $1, i
    cmpq i, iLimit
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
