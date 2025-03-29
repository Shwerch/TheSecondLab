.section .bss
num:    .space 4         # Reserve space for integer num
i:      .space 4         # Reserve space for loop variable i
j:      .space 4         # Reserve space for loop variable j

.section .text
.globl _start

_start:
    # Read integer from stdin
    mov rax, 0           # syscall: sys_read
    mov rdi, 0           # file descriptor: stdin
    lea rsi, [num]       # buffer to store input
    mov rdx, 4           # number of bytes to read
    syscall

    # Convert input string to integer (assuming valid input)
    mov rax, [num]       # Load the address of num
    sub rax, '0'         # Convert ASCII to integer (only works for single digit)
    mov [num], rax       # Store the integer back in num

    # Outer loop: i from 1 to num
outer_loop:
    mov eax, [num]       # Load num into eax
    cmp eax, 0           # Compare with 0
    jle end_program      # If num <= 0, exit

    # Initialize i = 1
    mov dword ptr [i], 1

inner_loop:
    mov eax, [i]         # Load i
    cmp eax, [num]       # Compare i with num
    jg end_outer_loop    # If i > num, exit outer loop

    # Print characters from 'A' + (num - i) down to 'A'
    mov dword ptr [j], 0 # Initialize j = 0

print_inner_loop:
    mov eax, [j]         # Load j
    cmp eax, [i]         # Compare j with i
    jge end_inner_loop   # If j >= i, exit inner loop

    # Calculate character to print: 'A' + (num - i) - j
    mov eax, [num]
    sub eax, [i]
    sub eax, [j]
    add eax, 'A'         # Convert to character

    call print_char      # Call print_char function

    ; Print space after character
    mov rax, 1           # syscall: sys_write
    mov rdi, 1           # file descriptor: stdout
    lea rsi, [space]     # address of space character
    mov rdx, 1           # number of bytes to write
    syscall

    inc dword ptr [j]    # j++
    jmp print_inner_loop  # Repeat inner loop

end_inner_loop:
    ; Print newline after inner loop
    mov rax, 1           # syscall: sys_write
    mov rdi, 1           # file descriptor: stdout
    lea rsi, [newline]     # address of newline character
    mov rdx, 1           # number of bytes to write
    syscall

    inc dword ptr [i]     # i++
    jmp outer_loop        # Repeat outer loop

end_outer_loop:
end_program:
    mov rax, 60          # syscall: sys_exit
    xor rdi, rdi         # status: 0
    syscall

# Function to print a character in rax
print_char:
    push rax             # Save rax on stack
    mov rax, 1           # syscall: sys_write
    mov rdi, 1           # file descriptor: stdout
    lea rsi, [rax]       # address of character to print (in rax)
    mov rdx, 1           # number of bytes to write
    syscall
    pop rax              # Restore rax from stack
    ret

.section .data
space:   .asciz " "      # Space character for output
newline: .asciz "\n"     # Newline character for output
