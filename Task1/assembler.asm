.data
msg:
  .ascii "Enter the N number: "
  .set msg_len, . - msg
inputSize:
  .quad 8

.text
.globl _start

output:
  movq $1, %rax       # Номер функции sys_write
  movq $1, %rdi       # Дескриптор стандартного выходного потока STDOUT
  movq $msg, %rsi     # Адрес начала строки
  movq $msg_len, %rdx # Длина строки
  syscall
  ret

input:
  movq $0, %rax         # Номер функции sys_read
  movq $1, %rdi         # Дескриптор стандартного выходного потока STDOUT
  movq %rsp, %rsi       # Адрес сохранения строки
  movq $inputSize, %rdx # Длина строки
  syscall
  ret

# %rsp - адрес начала строки
# %rsi - адрес конца строки
# %rbx - основание системы счисления
toNumber:
  movq $1, %rcx       # Множитель 10 в степени N
  movq $0, %rdi       # Регистр для хранения результата
  toNumberLoop:
    movq $0, %rax     # Обнуляем %rax
    movb 0(%rsi), %al # Сохранить код символа в %al
    subq $48, %rax    # Преобразовать код цифры в цифру
    mul %rcx          # Умножить на 10 в степени N
    addq %rax, %rdi   # Добавить к результату в %rdi
    subq $1, %rsi     # Сместь %rsi левее
    cmpq %rsp, %rsi
    jb toNumberLoopEnd
    jmp toNumberLoop
  toNumberLoopEnd:
  ret

_start:
  movq %rsp, %rbp # Сохранение начального состояния %rsp в %rbp
  
  # Вывод приветственного сообщения
  call output

  subq $inputSize, %rsp # Выделение $inputSize байт в стеке
  
  # Ввод числа как массива символов
  call input

  # Преобразование строки в число
  movq %rsp, %rsi         # Адрес начала строки
  addq %rax, %rsi         # Прибавление кол-ва введенных символов к адресу начала строки
  subq $2, %rsi           # Теперь %rsi содержит адрес последнего символа числа
  movq $10, %rbx          # Основание системы счисления
  call toNumber
  toNumberEnd:
  
  movq %rbp, %rsp # Восстановление %rsp (освобождение стека)
  movq $60, %rax  # Номер функции sys_exit
  movq $0, %rdi   # Код возврата
  syscall

  
  # movq $1, %rax         # Номер функции sys_write
  # movq $1, %rdi         # Дескриптор стандартного выходного потока STDOUT
  # movq %rsp, %rsi       # Адрес начала строки
  # movq $inputSize, %rdx # Длина строки
  # syscall
