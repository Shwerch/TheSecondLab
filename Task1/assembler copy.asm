INPUT_SIZE=2

STDIN=0
STDOUT=1

sys_write=1
sys_read=0
sys_exit=60

.data
message:
  .ascii "Enter the N number: "
  .set message_len, . - message

.text
.globl _start

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
  
  # Ввод числа как массива символов
  movq $sys_read, %rax
  movq $STDIN, %rdi
  movq %rsp, %rsi
  movq $INPUT_SIZE, %rdx
  syscall

  movw (%rsp), %r8w

  jmp exit

exit:
  movq %rbp, %rsp # Восстановление %rsp (освобождение стека)
  movq $sys_exit, %rax
  movq $0, %rdi   # Код возврата
  syscall
