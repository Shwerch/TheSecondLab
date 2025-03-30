INPUT_SIZE=2
CHAR_INT_DIFFERENCE=0x30

STDIN=0
STDOUT=1
STDERR=2

sys_write=1
sys_read=0
sys_exit=60

numberRegister=%r10b

iStart=1
iLimit=%r8b
i=%r9b

jStart=1
jLimit=%r10b
j=%r11b

.data
message:
  .ascii "Enter the N number: "
  .set message_len, . - message

.text
.globl _start

oneDigit:
  subb $CHAR_INT_DIFFERENCE, %r8b
  movb %r8b, %r10b
  jmp digitFunctionEnd

twoDigits:
  subb $CHAR_INT_DIFFERENCE, %r8b
  subb $CHAR_INT_DIFFERENCE, %r9b
  movb %r9b, %r10b
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


  movb numberRegister, iLimit
  movb iStart, i
  firstLoop:
    movb %r10b, i
    subb $1, i


  jmp exit

exit:
  # Восстановление %rsp (освобождение стека)
  movq %rbp, %rsp

  # Завершение работы программы
  movq $sys_exit, %rax
  movq $0, %rdi
  syscall
