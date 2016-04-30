segment .data      ;data segment

S db "S"
M db "M"
D db "D"

elements_count dq 0x3
new_line	db 0xa


segment .bss
buffer resb 20

segment .text	   ;code segment

   global _start                 ;must be declared for linker
   extern move_element
   extern unsigned_to_string
   extern tower_of_hanoi



_start:	                         ;tell linker entry point


   push rbp                      ;safe base pointer
   mov  rbp, rsp                 ;asign base pointer to stack pointer
   push qword S                  ;push first argument the number
   push qword M                  ;push second argument the number
   push qword D                  ;push third argument the number
   push qword [elements_count]   ;push fourth argument the number
   call tower_of_hanoi           ;call the function
   add rsp, 0x20                 ;clean stack
   pop  rbp                      ;recover base pointer

exit:
   mov eax,1            ;system call number (sys_exit)
   int 0x80	        ;call kernel


