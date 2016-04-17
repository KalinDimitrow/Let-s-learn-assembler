segment .data      ;data segment
number dw 112
segment .bss
buffer: RESB 10
segment .text	   ;code segment
   global _start    ;must be declared for linker
   extern unsigned_to_string
   extern signed_to_string

_start:	           ;tell linker entry point
   mov [number], dword -1135
   ; pass argiments call function and clean the stack
   push rbp ;safe base pointer
   mov  rbp, rsp ;asign base pointer to stack pointer
   mov  rax, [number]
   push rax ;push first argument the number
   push buffer ;push second argument the buffer
   call signed_to_string ;call the function
   add rsp, 0x10 ;clean stack
   pop  rbp ;recover base pointer

   ;print buffer
   mov rdx,rax	   ;message length
   mov rcx,buffer     ;message to write
   mov rbx,0x1	   ;file descriptor (stdout)
   mov rax,0x4	   ;system call number (sys_write)
   int 0x80	   ;call kernel

exit:
   mov eax,1       ;system call number (sys_exit)
   int 0x80	   ;call kernel

