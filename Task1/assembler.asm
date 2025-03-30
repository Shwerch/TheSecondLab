.data
msg:
  .ascii "Enter the N number: "
  .set msg_len, . - msg

.text
.globl _start

output:
  movq $1, %rax       # Номер функции sys_write
  movq $1, %rdi       # Дескриптор стандартного выходного потока
  movq $msg, %rsi     # Адрес начала строки
  movq $msg_len, %rdx # Длина строки
  syscall
  ret

input:
  movq $0, %rax   # Номер функции sys_read
  movq $0, %rdi   # Дескриптор стандартного входного потока
  movq (%rsp), %rsi # Адрес сохранения строки
  movq $8, %rdx   # Длина строки
  syscall
  ret

print:
  movq $1, %rax       # Номер функции sys_write
  movq $1, %rdi       # Дескриптор стандартного выходного потока
  movq (%rsp), %rsi     # Адрес начала строки
  movq $8, %rdx # Длина строки
  syscall
  ret

_start:
  movq %rsp, %rbp # Сохранение начального состояния %rsp в %rbp
  call output
  subq $8, %rsp   # Выделение 8 байт в стеке
  call input
  call print
  jmp exit

exit:
  movq %rbp, %rsp # Восстановление %rsp (освобождение стека)
  movq $60, %rax  # Номер функции sys_exit
  movq $0, %rdi   # Код возврата
  syscall
  ret
