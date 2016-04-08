;Linux system calls
;To call linux system call you need to :
;- Put the system call number in the EAX register
;- Store the arguments to the system call in the registers EBX, ECX, EDX, ESI, EDI, and EBP
;- Call the relevant interrupt 80h
;- The result is usually returned in the EAX register
;If there are more than six arguments, then the memory location of the first argument is stored in the EBX register.
;All the syscalls are listed in /usr/include/asm/unistd_32.h or /usr/include/asm/unistd_64.h,
;together with their numbers (the value to put in EAX before you call int 80h)


segment .data                           ;Data segment
   userMsg db 'Please enter a number: ' ;Ask the user to enter a number
   lenUserMsg equ $-userMsg             ;The length of the message
   dispMsg db 'You have entered: '
   lenDispMsg equ $-dispMsg

segment .bss           ;Uninitialized data
   num resb 5

segment .text          ;Code Segment
   global _start

_start:                ;User prompt
   mov eax, 4
   mov ebx, 1
   mov ecx, userMsg
   mov edx, lenUserMsg
   int 80h

   ;Read and store the user input
   mov eax, 3
   mov ebx, 2
   mov ecx, num
   mov edx, 5          ;5 bytes (numeric, 1 for sign) of that information
   int 80h

   ;Output the message 'The entered number is: '
   mov eax, 4
   mov ebx, 1
   mov ecx, dispMsg
   mov edx, lenDispMsg
   int 80h

   ;Output the number entered
   mov eax, 4
   mov ebx, 1
   mov ecx, num
   mov edx, 5
   int 80h

   ; Exit code
   mov eax, 1
   mov ebx, 0
   int 80h
