STDIN=0
STDOUT=1

sys_read=0
sys_write=1
sys_exit=60

INPUT=16

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

backup:
  pushq %rax
  pushq %r8
  pushq %r9
  pushq %r10
  pushq %r11
  pushq %r12
  pushq %r13
  pushq %r14
  pushq %r15
  ret

clear:
  movq $0, %rax
  movq $0, %r8
  movq $0, %r9
  movq $0, %r10
  movq $0, %r11
  movq $0, %r12
  movq $0, %r13
  movq $0, %r15
  movq $0, %r14
  ret

_start:
  # Вывести привестственное сообщение
  movq $sys_write, %rax
  movq $STDOUT, %rdi
  movq $MESSAGE, %rsi
  movq $MESSAGE_LEN, %rdx
  syscall

  # Выделить место в стеке в размере INPUT байт
  subl $INPUT, %esp
  
  # Ввод числа как массива INPUT символов в стек
  movq $sys_read, %rax
  movq $STDIN, %rdi
  movq %rsp, %rsi
  addq $INPUT, %rsi
  syscall

  # Бэкапирование и обнуление значений регистров %rax %r8 %r9 %r10 %r11 %r12 %r13 %r14 %r15
  call backup
  call clear

  # Определение адреса начала строки
  movq %rsp, %r10
  addq $INPUT, %r10
  addq $32, %r10

  # Перемещение символов в регистры %r8 и %r9
  movb 0(%r10), %r8b
  movb 1(%r10), %r9b
  subq $'0', %r8
  subq $'0', %r9

  # Проверка символа из %r8 на то, что он является цифрой
  cmpq $1, %r8
  jb error
  cmpq $9, %r8
  ja error
  
  # Определение, сколько цифр было введено и запись результата в %r11
  cmpq $10, %r9
  je oneDigit
  jmp twoDigits

  oneDigit:
  # Конвертация символа из %r8 в еденицы числа в %r11
  addq %r8, %r11

  jmp digitFunctionEnd

  twoDigits:
  # Проверка символа из %r9 на то, что он является цифрой
  cmpq $1, %r9
  jb error
  cmpq $9, %r9
  ja error

  # Конвертация символа из %r8 в десятки числа в %r11
  movq %r8, %rax
  movq $10, %r12
  mulq %r12
  addq %rax, %r11

  # Конвертация символа из %r9 в еденицы числа в %r11
  addq %r9, %r10

  jmp digitFunctionEnd

  digitFunctionEnd:

  # Проверка числа на корректность
  cmpq $1, %r11
  jb error
  cmpq $26, %r11
  ja error

  # Бэкапирование и обнуление значений регистров %rax %r8 %r9 %r10 %r11 %r12
  pushq %rax
  pushq %r8
  pushq %r9
  pushq %r10
  pushq %r11
  pushq %r12

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
