segment .data      ;data segment
a               dq 1.0
b               dq 5.0
c               dq 4.0
constant        dq -4.0

no_solution	db 'There is no real solution!',0xa
no_solution_len	equ	$ - no_solution

msg_solution_1	db 'Solution 1 is: '
msg_solution_1_len	equ	$ - msg_solution_1

msg_solution_2	db 'Solution 2 is: '
msg_solution_2_len	equ	$ - msg_solution_2

new_line	db 0xa
new_line_len	equ	$ - new_line

segment .bss
buffer: RESB 30
radical: RESQ 1
denominator: RESQ 1
solution_1: RESQ 1
solution_2: RESQ 1

segment .text	   ;code segment
   global _start    ;must be declared for linker
   extern float_to_string


_start:	           ;tell linker entry point



   ;polish notation
   fld qword [constant]    ;st: constant
   fld qword [a]           ;st: a,constant
   fld qword [c]           ;st: c,a,constant
   fmulp st1               ;st: a*c,constant
   fmulp st1               ;st: a*c*constant
   fld qword [b]           ;st: b,a*c*constant
   fld qword [b]           ;st: b,b,a*c*constant
   fmulp st1               ;st: b*b,a*c*constant
   faddp st1               ;st: b*b + a*c*constant

   ftst
   fstsw ax
   sahf
   jb no_real_solution
   fsqrt                   ;st: sqrt(b*b + a*c*constant)
   fstp qword [radical]    ;st: empty
   fld1                    ;st: 1.0
   fld qword [a]           ;st: a,1.0
   fscale                  ;st: 2*a,1.0
   fdivp st1               ;st: 1/2*a
   fst qword [denominator]
   fld qword [radical]     ;st: radical,1/2*a
   fld qword [b]           ;st: b,radical,1/2*a
   fsubp st1               ;st: radical - b,1/2*a
   fmulp st1               ;st: (radical - b)/2*a
   fstp qword [solution_1] ;st: empty
   fld qword [denominator] ;st: 1/2*a
   fld qword [radical]     ;st: radical,1/2*a
   fchs                    ;st: -radical,1/2*a
   fld qword [b]           ;st: b,-radical,1/2*a

   fsubp st1               ;st: -radical - b,1/2*a
   fmulp st1               ;st: (-radical - b)/2*a
   fstp qword [solution_2] ;st: empty


   ;print buffer
   mov rdx,msg_solution_1_len	   ;message length
   mov rcx,msg_solution_1          ;message to write
   mov rbx,0x1	                   ;file descriptor (stdout)
   mov rax,0x4	                   ;system call number (sys_write)
   int 0x80	                   ;call kernel

   ; pass argiments call function and clean the stack
   push rbp ;safe base pointer
   mov  rbp, rsp ;asign base pointer to stack pointer
   mov  rax, [solution_1]
   push rax ;push first argument the number
   push buffer ;push second argument the buffer
   call float_to_string ;call the function
   add rsp, 0x10 ;clean stack
   pop  rbp ;recover base pointer

   ;print buffer
   mov rdx,rax	   ;message length
   mov rcx,buffer     ;message to write
   mov rbx,0x1	   ;file descriptor (stdout)
   mov rax,0x4	   ;system call number (sys_write)
   int 0x80	   ;call kernel

   ;print buffer
   mov rdx,new_line_len	   ;message length
   mov rcx,new_line        ;message to write
   mov rbx,0x1	           ;file descriptor (stdout)
   mov rax,0x4	           ;system call number (sys_write)
   int 0x80	           ;call kernel



   ;print buffer
   mov rdx,msg_solution_2_len	   ;message length
   mov rcx,msg_solution_2          ;message to write
   mov rbx,0x1	                   ;file descriptor (stdout)
   mov rax,0x4	                   ;system call number (sys_write)
   int 0x80	                   ;call kernel

   ; pass argiments call function and clean the stack
   push rbp ;safe base pointer
   mov  rbp, rsp ;asign base pointer to stack pointer
   mov  rax, [solution_2]
   push rax ;push first argument the number
   push buffer ;push second argument the buffer
   call float_to_string ;call the function
   add rsp, 0x10 ;clean stack
   pop  rbp ;recover base pointer

   ;print buffer
   mov rdx,rax	   ;message length
   mov rcx,buffer     ;message to write
   mov rbx,0x1	   ;file descriptor (stdout)
   mov rax,0x4	   ;system call number (sys_write)
   int 0x80	   ;call kernel

   ;print buffer
   mov rdx,new_line_len	   ;message length
   mov rcx,new_line        ;message to write
   mov rbx,0x1	           ;file descriptor (stdout)
   mov rax,0x4	           ;system call number (sys_write)
   int 0x80	           ;call kernel


   jmp exit

no_real_solution:
   ;print buffer
   mov rdx,no_solution_len	   ;message length
   mov rcx,no_solution     ;message to write
   mov rbx,0x1	   ;file descriptor (stdout)
   mov rax,0x4	   ;system call number (sys_write)
   int 0x80	   ;call kernel


exit:
   mov eax,1       ;system call number (sys_exit)
   int 0x80	   ;call kernel
