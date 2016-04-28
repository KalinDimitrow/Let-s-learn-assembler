; Representation of signed integer number in computer
; signed is represented as series of degrees of 2 with coefficients 0 or 1 as unsigned but with small difference
; first (biggest degree is get as negative value)
; for example in 8 bit number with binary representation 01101010 is equivalent of
; -0*2^7 + 1*2^6 + 1*2^5 + 0*2^4 + 1*2^3 + 0*2^2 + 1*2^1 + 0*2^0
; To check if number in binary representation is negative it's enought to check coefficient before his firts (biggest) degree
; if it different from zero (it's 1) the number is negative
; To convert negative number as unsigned with the same absolute value we must
; remove firts (biggest) degree from the number (with substracting or xor)
; then from firts (biggest) degree substract the rest.


%define argument_number qword [rbp - 0x8]
%define argument_buffer qword [rbp - 0x10]


segment .data      ;data segment

segment .bss

segment .text	   ;code segment
extern unsigned_to_string
global signed_to_string

signed_to_string:
   ; check if the number is positive
   mov rax, argument_number ;get first argument from the stack
   ;mov rbx,0x1
   ;shl rbx,0x1F
   mov rbx,0x8000000000000000 ;2^63
   mov rcx,rbx
   and rcx,rax
   cmp rcx,0x0
   jz positive ; jump at positive part
   ; conver signed to unsigned
   ;mov rcx,rax
   ;sub rcx,rbx
   ;sub rbx,rcx
   ;mov rax,rbx
   not rax
   add rax,0x1
   ; put '-' at front of the string
   mov rbx,argument_buffer ;get second argument from the stack
   mov [rbx],byte '-'
   ; calculate address of the string buffer wtihout '-' symbol at the front
   mov rbx,argument_buffer ;get second argument from the stack
   add rbx,1
   ; pass argumetns and call unsigned_to_string
   push rbp ;safe base pointer
   mov rbp,rsp ;asign base pointer to stack pointer
   push rax    ;push first argument the number
   push rbx    ;push second argument the buffer
   call unsigned_to_string ;call the function
   add rsp, 0x10       ;clean stack
   pop rbp             ;recover base pointer
   add rax,0x1 ;add 1 to return value (number of symbols, bonus '-')
   ret;return
positive:
   ; pass argumetns and call unsigned_to_string
   mov rbx,argument_buffer
   push rbp ;safe base pointer
   mov rbp,rsp ;asign base pointer to stack pointer
   push rax ;push first argument the number
   push rbx ;push second argument the buffer
   call unsigned_to_string ;call the function
   add rsp, 0x10 ;clean stack
   pop rbp ;recover base pointer
   ret ; return
