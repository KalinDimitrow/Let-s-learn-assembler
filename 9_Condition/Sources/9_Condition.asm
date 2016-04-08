;Conditions
;Conditional Jump:
;- For signed data
;   JE/JZ 	Jump Equal or Jump Zero 	        ZF
;   JNE/JNZ 	Jump not Equal or Jump Not Zero 	ZF
;   JG/JNLE 	Jump Greater or Jump Not Less/Equal 	OF, SF, ZF
;   JGE/JNL 	Jump Greater/Equal or Jump Not Less 	OF, SF
;   JL/JNGE 	Jump Less or Jump Not Greater/Equal 	OF, SF
;   JLE/JNG 	Jump Less/Equal or Jump Not Greater 	OF, SF, ZF
;- For unsigned data
;   JE/JZ 	Jump Equal or Jump Zero 	        ZF
;   JNE/JNZ 	Jump not Equal or Jump Not Zero 	ZF
;   JA/JNBE 	Jump Above or Jump Not Below/Equal 	CF, ZF
;   JAE/JNB 	Jump Above/Equal or Jump Not Below 	CF
;   JB/JNAE 	Jump Below or Jump Not Above/Equal 	CF
;   JBE/JNA 	Jump Below/Equal or Jump Not Above 	AF, CF
;- Special conditional jumps
;   JXCZ 	Jump if CX is Zero 	                none
;   JC 	        Jump If Carry 	                        CF
;   JNC 	Jump If No Carry 	                CF
;   JO 	        Jump If Overflow 	                OF
;   JNO 	Jump If No Overflow 	                OF
;   JP/JPE 	Jump Parity or Jump Parity Even 	PF
;   JNP/JPO 	Jump No Parity or Jump Parity Odd 	PF
;   JS 	        Jump Sign (negative value) 	        SF
;   JNS 	Jump No Sign (positive value) 	        SF

segment	.data

   msg db "The largest digit is: ", 0xA,0xD
   len equ $- msg
   num1 dd '47'
   num2 dd '22'
   num3 dd '31'

segment .bss
   largest resb 2


segment	.text
   global _start         ;must be declared for using gcc

_start:	                 ;tell linker entry point
   mov   ecx, [num1]
   cmp   ecx, [num2]
   jg    check_third_num
   mov   ecx, [num2]

check_third_num:

   cmp   ecx, [num3]
   jg    _exit
   mov   ecx, [num3]

_exit:

   mov   [largest], ecx
   mov   ecx,msg
   mov   edx, len
   mov   ebx,1	;file descriptor (stdout)
   mov   eax,4	;system call number (sys_write)
   int   0x80	;call kernel

   mov   ecx,largest
   mov   edx, 2
   mov   ebx,1	;file descriptor (stdout)
   mov   eax,4	;system call number (sys_write)
   int   0x80	;call kernel

   mov   eax, 1
   int   80h


