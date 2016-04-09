segment	.data
msg db 'Factorial 3 is:',0xa
len equ $ - msg

segment .bss
fact resb 1

segment	.text
   global _start         ;must be declared for using gcc

_start:                  ;tell linker entry point

   mov ebx, 3             ;for calculating factorial 3
   call  proc_fact
   add   eax, '0'
   mov  [fact], eax

   mov	  edx,len        ;message length
   mov	  ecx,msg        ;message to write
   mov	  ebx,1          ;file descriptor (stdout)
   mov	  eax,4          ;system call number (sys_write)
   int	  0x80           ;call kernel

   mov   edx,1            ;message length
   mov	  ecx,fact       ;message to write
   mov	  ebx,1          ;file descriptor (stdout)
   mov	  eax,4          ;system call number (sys_write)
   int	  0x80           ;call kernel

   mov	  eax,1          ;system call number (sys_exit)
   int	  0x80           ;call kernel

proc_fact:
   cmp   ebx, 1
   jg    do_calculation
   mov   eax, 1
   ret

do_calculation:
   dec   ebx
   call  proc_fact
   inc   ebx
   mul   ebx        ;ax = al * bl
   ret

