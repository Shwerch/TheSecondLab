INPUT_SIZE=2
DIGIT_NUMBER_DIFFERENCE=48

STDIN=0
STDOUT=1
STDERR=2

sys_write=1
sys_read=0
sys_exit=60

inputRegister=%rsp

firstDigit=%r8b
secondDigit=%r9b

numberByte=%r10b
numberWord=%r10w
numberQuad=%r10

iStart=0
iLimit=%r8
i=%r9

jStart=0
jLimit=%r10
j=%r13

letterRegister=%r14

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

oneDigit:
  # Конвертация символа из firstDigit в еденицы числа
  subb $DIGIT_NUMBER_DIFFERENCE, firstDigit
  movb firstDigit, numberByte

  # Проверка символа из firstDigit на то, что он является цифрой
  cmpb $1, firstDigit
  jb error
  cmpb $9, firstDigit
  ja error

  jmp digitFunctionEnd

twoDigits:
  # Конвертация символа из secondDigit в еденицы числа
  subb $DIGIT_NUMBER_DIFFERENCE, secondDigit
  movb secondDigit, numberByte

  # Проверка символа из secondDigit на то, что он является цифрой
  cmpb $1, secondDigit
  jb error
  cmpb $9, secondDigit
  ja error

  # Конвертация символа из firstDigit в десятки числа
  subb $DIGIT_NUMBER_DIFFERENCE, firstDigit
  movb firstDigit, %al
  movb $10, %r12b
  mulb %r12b
  addw %ax, numberWord

  # Проверка символа из firstDigit на то, что он является цифрой
  cmpb $1, firstDigit
  jb error
  cmpb $9, firstDigit
  ja error

  jmp digitFunctionEnd

_start:
  # Вывести привестственное сообщение
  movq $sys_write, %rax
  movq $STDOUT, %rdi
  movq $MESSAGE, %rsi
  movq $MESSAGE_LEN, %rdx
  syscall
  
  # Ввод числа как массива INPUT_SIZE символов в %rsp
  movq $sys_read, %rax
  movq $STDIN, %rdi
  movq inputRegister, %rsi
  movq $2048, %rdx
  syscall

  # Перемещение символов в разные регистры
  movb 0(inputRegister), firstDigit
  movb 1(inputRegister), secondDigit
  
  # Определение, сколько цифр были введено и запись результата в numberQuad
  movq $0, numberQuad
  cmpb $10, secondDigit
  je oneDigit
  jmp twoDigits
  digitFunctionEnd:

  # Проверка числа на корректность
  cmpb $1, numberByte
  jb error
  cmpb $26, numberByte
  ja error

  # Объявление первого цикла с i
  movq numberQuad, iLimit
  movq $iStart, i
  firstLoop:

    # Объявление второго цикла с j
    movq i, jLimit
    addq $1, jLimit
    movq $jStart, j
    secondLoop:
      
      # Рассчет кодов символов для вывода буквы
      movq iLimit, letterRegister
      subq j, letterRegister
      subq $1, letterRegister

      # Вывести букву с кодом из регистра letterRegister 
      movq $sys_write, %rax
      movq $STDOUT, %rdi
      movq $LETTERS, %rsi
      addq letterRegister, %rsi
      movq $1, %rdx
      syscall

      # Вывести пробел
      movq $sys_write, %rax
      movq $STDOUT, %rdi
      movq $SPACE, %rsi
      movq $1, %rdx
      syscall

      # Завершение второго цикла с j
      addq $1, j
      cmpq j, jLimit
      je secondLoopEnd
      jmp secondLoop
    secondLoopEnd:

    # Вывести символ новой строки
    movq $sys_write, %rax
    movq $STDOUT, %rdi
    movq $NEWLINE, %rsi
    movq $1, %rdx
    syscall

    # Завершение первого цикла с i
    addq $1, i
    cmpq i, iLimit
    je firstLoopEnd
    jmp firstLoop
  firstLoopEnd:

  jmp exit

error:
  # Вывод сообщения об ошибке
  movq $sys_write, %rax
  movq $STDOUT, %rdi
  movq $ERROR, %rsi
  movq $ERROR_LEN, %rdx
  syscall

  # Завершение работы программы с ошибкой
  movq $sys_exit, %rax
  movq $1, %rdi
  syscall

exit:
  # Завершение работы программы
  movq $sys_exit, %rax
  movq $0, %rdi
  syscall
