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
  # Вывод приветственного сообщения
  movq $1, %rax
  movq $1, %rdi
  movq $MESSAGE, %rsi
  movq $MESSAGE_LEN, %rdx
  syscall

  # Выделение INPUT байт в стеке
  subq $INPUT, %rsp

  # Ввод строки длинной INPUT байт в стек
  movq $0, %rax
  movq $0, %rdi
  movq %rsp, %rsi
  addq $INPUT, %rsi
  movq $INPUT, %rdx
  syscall

  # Вычисление адреса начала строки
  movq %rsp, %rax
  addq $INPUT, %rax

  # Отправка символов в разные регистры
  movq $0, %r8
  movq $0, %r9
  movq $0, %r10
  movb 0(%rax), %r8b
  movb 1(%rax), %r9b
  movb 2(%rax), %r10b

  # Проверка строки на наличие цифры
  cmpq $10, %r9
  je oneDigit
  cmpq $10, %r10
  je twoDigits
  jmp error

  # Рассчет числа при одной введенной цифре
  oneDigit:
    # Перевод значения из кода символа в цифру
    subq $'0', %r8

    # Проверка значения на то, что оно является цифрой
    cmpq $1, %r8
    jb error
    cmpq $9, %r8
    ja error
  jmp digitFunctionEnd

  # Рассчет числа при двух введенных цифрах
  twoDigits:
    # Перевод значения из кода символа в цифру
    subq $'0', %r9
    subq $'0', %r8

    # Проверка значения на то, что оно является цифрой
    cmpq $1, %r9
    jb error
    cmpq $9, %r9
    ja error
    cmpq $1, %r8
    jb error
    cmpq $9, %r8
    ja error

    # Пересчет значения цифры в десятки числа
    movq %r8, %rax
    movq $10, %rdx
    mulq %rdx
    movq %rax, %r8
    addq %r9, %r8
  jmp digitFunctionEnd

  digitFunctionEnd:

  # Проверка числа на корректность
  cmpq $1, %r8
  jb error
  cmpq $26, %r8
  ja error

  # Рассчет длины выводимой строки по формуле арифметической прогрессии
  # Sn = n * (a1 + an) / 2 = n * (2 + 2 * n) / 2 =  n * (n + 1)
  movq %r8, %rax
  addq $1, %rax
  movq %r8, %rdx
  mulq %rdx
  movq %rax, %r9

  # Рассчет адреса начала выводимой строки
  movq %rsp, %r15
  subq $1, %r15

  # Добавление символа новой строки в конец строки,
  # Так как строка выводится задом наперед
  movw $'\n', %ax
  pushw %ax

  # Добавление символов в строку в стеке
  movq %r8, %r10
  movq $0, %r11
  firstLoop:

    movq %r8, %r12
    subq %r11, %r12
    movq $0, %r13
    secondLoop:

      # Рассчет кода выводимой буквы
      movq $'A', %r14
      addq %r13, %r14
      addq %r11, %r14

      # Добавление пробела после буквы
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

    # Замена пробела на символ новой строки в конце строки
    popw %ax
    movb $'\n', %al
    pushw %ax

    addq $1, %r11
    cmpq %r10, %r11
    je firstLoopEnd
    jmp firstLoop
  firstLoopEnd:

  # Сохранение значения регистра в стеке
  pushq %r15

  # Вывод строки в консоль задом наперед, из конца в начало
  movq $1, %rax
  movq $1, %rdi
  movq %r15, %rsi
  subq %r9, %rsi
  movq %r9, %rdx
  syscall

  # Очистка стека от данных
  popq %r15
  addq $1, %r15
  addq $INPUT, %r15
  movq %r15, %rsp

  jmp exit

error:
  # Вывод сообщения об ошибке
  movq $1, %rax
  movq $1, %rdi
  movq $ERROR, %rsi
  movq $ERROR_LEN, %rdx
  syscall

  # Завершение работы программы с кодом 1
  movq $60, %rax
  movq $1, %rdi
  syscall

exit:
  # Завершение работы программы с кодом 0
  movq $60, %rax
  movq $0, %rdi
  syscall
