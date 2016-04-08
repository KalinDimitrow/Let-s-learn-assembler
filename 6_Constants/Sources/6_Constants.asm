;Constants
;Directives to define constatns:
;-EQU (CONSTANT_NAME EQU expression)
;    LENGTH equ 20
;    WIDTH  equ 10
;    AREA   equ length * width
;-%assign (The %assign directive can be used to define numeric constants like the EQU directive. This directive allows redefinition)
;    %assign TOTAL 10
;    Later in the code, you can redefine it as
;    %assign  TOTAL  20
;-%define (The %define directive allows defining both numeric and string constants. This directive is similar to the #define in C)
;    %define PTR [EBP+4]






SYS_EXIT  equ 1
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

segment	 .data
msg1 db	'Hello, programmers!',0xA,0xD
len1 equ $ - msg1

msg2 db 'Welcome to the world of,', 0xA,0xD
len2 equ $ - msg2

msg3 db 'Linux assembly programming! '
len3 equ $- msg3

segment	 .text
   global _start    ;must be declared for using gcc

_start:             ;tell linker entry point
   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, msg1
   mov edx, len1
   int 0x80

   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, msg2
   mov edx, len2
   int 0x80

   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, msg3
   mov edx, len3
   int 0x80

   mov eax,SYS_EXIT    ;system call number (sys_exit)
   int 0x80            ;call kernel


