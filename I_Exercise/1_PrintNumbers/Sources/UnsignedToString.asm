; Representation of unsigned integer number in computer
; unsigned is represented as series of degrees of 2 with coefficients 0 or 1
; for example in 8 bit number with binary representation 01101010 is equivalent of
; 0*2^7 + 1*2^6 + 1*2^5 + 0*2^4 + 1*2^3 + 0*2^2 + 1*2^1 + 0*2^0
;In this exercise we extract all digits of the number (in decimal)
;We doing it through similar representation in decimal
; the number 123 in decimal can be presented as 1*10^2 +2*10^1 + 3*10^0
;To get all digits from rightmost to the leftmost in loop we divide the number
;If the result of dividing is zero there is no point to continue and the residue is the current digit

%define argument_number qword [rbp - 0x8]
%define argument_buffer qword [rbp - 0x10]

segment .data      ;data segment

segment .bss

segment .text	   ;code segment
global unsigned_to_string

unsigned_to_string:
   mov rax, argument_number ;get first argument from the stack
   mov rcx,0x0
   mov rbx,0xA
collect:
   ;collect all digits in decimal and put them into the stack
   mov rdx,0x0
   div rbx
   add rdx,'0'
   push rdx
   add rcx,0x1 ;increment counter, number of digits we collect
   cmp rax,0x0
   jz end_of_collect
   jmp collect
end_of_collect:
   mov rdx,rcx
   mov rbx,argument_buffer ;get second argument from the stack
fill_loop:
   ;put get all collected digits from the stack and put them into the buffer (second argument)
   pop rax
   mov [rbx],al
   add rbx,0x1
   loop fill_loop
   mov rax,rdx ;return parameter (number of digits)
   ret ;return
