segment .data
achar db '0'

segment	.text
   global _start        ;must be declared for using gcc

_start:	                ;tell linker entry point
   call    display
   mov	eax,1	        ;system call number (sys_exit)
   int	0x80	        ;call kernel

display:
   mov    rcx, 256

next:
   push    rcx
   mov     eax, 4
   mov     ebx, 1
   mov     ecx, achar
   mov     edx, 1
   int     80h

   pop     rcx
;   mov	dx, [achar]
   cmp	byte [achar], 0dh
   inc	byte [achar]
   loop    next
   ret

