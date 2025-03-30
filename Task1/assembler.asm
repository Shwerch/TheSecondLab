.data
msg:
  .ascii "Enter the N number: "
  .set msg_len, . - msg
inputSize:
  .quad 8

.text
.globl _start

_start:
  movq %rsp, %rbp # Сохранение начального состояния %rsp в %rbp
  
  movq $1, %rax       # Номер функции sys_write
  movq $1, %rdi       # Дескриптор стандартного выходного потока
  movq $msg, %rsi     # Адрес начала строки
  movq $msg_len, %rdx # Длина строки
  syscall

  subq $inputSize, %rsp # Выделение $inputSize байт в стеке
  
  movq $0, %rax         # Номер функции sys_read
  movq $1, %rdi         # Дескриптор стандартного входного потока
  movq %rsp, %rsi       # Адрес сохранения строки
  movq $inputSize, %rdx # Длина строки
  syscall
  
  movq %rbp, %rsp # Восстановление %rsp (освобождение стека)
  movq $60, %rax  # Номер функции sys_exit
  movq $0, %rdi   # Код возврата
  syscall
