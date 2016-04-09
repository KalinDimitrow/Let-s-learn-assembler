segment	.bss
num resb 1

segment	.text
   global _start        ;must be declared for using gcc

_start:	                ;tell linker entry point
   mov rcx,10
   mov eax, '1'

l1:
   mov [num], eax
   mov eax, 4
   mov ebx, 1
   PUSH rcx; Push rcx(64bit ecx) to the stack

   mov ecx, num
   mov edx, 1
   int 0x80

   mov eax, [num]
   sub eax, '0'
   inc eax
   add eax, '0'
   POP rcx; Pop rcx(64bit ecx) from the stack
   loop l1

   mov eax,1             ;system call number (sys_exit)
   int 0x80              ;call kernel

