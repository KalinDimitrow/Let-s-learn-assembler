%define argument_number qword [rbp - 0x8]
%define argument_buffer qword [rbp - 0x10]
%define local_additional_symbols qword [rbp - 0x20]
%define local_truncate_result qword [rbp - 0x28]
%define local_integer_digits qword [rbp - 0x30]

segment .data
constant   dq 15                ;number of digits in double

power_of_ten dq 0x1             ;10^0
	     dq 0xA             ;10^1
	     dq 0x64            ;10^2
	     dq 0x3E8           ;10^3
	     dq 0x2710          ;10^4
	     dq 0x186A0         ;10^5
	     dq 0xF4240         ;10^6
	     dq 0x989680        ;10^7
	     dq 0x5F5E100       ;10^8
	     dq 0x3B9ACA00      ;10^9
	     dq 0x2540BE400     ;10^10
	     dq 0x174876E800    ;10^11
	     dq 0xE8D4A51000    ;10^12
	     dq 0x9184E72A000   ;10^13
	     dq 0x5AF3107A4000  ;10^14
segment .bss

segment .text
extern truncate_float
extern signed_to_string
extern unsigned_to_string
global float_to_string

float_to_string:
sub rsp,0x18                             ;allocate memory for local variables
mov local_additional_symbols,0x0         ;additional digits in buffer (zero if number is positive 1 if negative)
mov  rax,argument_number

push rbp                                 ;safe base pointer
mov  rbp, rsp                            ;asign base pointer to stack pointer
push rax                                 ;push first argument the number
call truncate_float                      ;call the function
add  rsp, 0x8                            ;clean stack
pop  rbp                                 ;recover base pointer
mov local_truncate_result,rax            ;save truncate result

mov rbx,argument_buffer                  ;move buffer in rbx
mov rcx,0x8000000000000000               ;2^63
and rcx,argument_number                  ; save sign of number in base register
cmp rcx,0x0                              ;check sign of the number
jz float_to_string_convert_whole_part    ;jump to exit if it's positive
not rax                                  ;reverse sign
add rax,0x1                              ;
mov [rbx],byte '-'                       ;add sign symbol in the buffer
add rbx,0x1                              ;
mov local_additional_symbols,0x1         ;additional digits in buffer (zero if number is positive 1 if negative)

float_to_string_convert_whole_part:

push rbp                                 ;safe base pointer
mov  rbp, rsp                            ;asign base pointer to stack pointer
push rax                                 ;push first argument the number
push rbx                                 ;push second argument the buffer
call unsigned_to_string                  ;call the function
add rsp, 0x10                            ;clean stack
pop  rbp                                 ;recover base pointer
add local_additional_symbols,rax
mov local_integer_digits,rax

;add decimal point
mov  rbx,argument_buffer                 ;move buffer in rbx
add rbx,local_additional_symbols
mov [rbx],byte '.'                       ;add sign symbol in the buffer
add local_additional_symbols,0x1
					 ;calculate number of digits left to print
mov rax,[constant]
mov rbx,local_integer_digits
sub rax,rbx
mov rbx,0x8                              ;multiply by 8 to find offset in power_of_ten
mul rbx

;finit                                    ;clear fpu
fld argument_number                      ;get fractional part of floating point number as integer
;fabs
fild local_truncate_result
fsub
fabs
fild qword [power_of_ten + rax]
fmulp
fstp local_truncate_result

mov  rax,local_truncate_result

push rbp                                 ;safe base pointer
mov  rbp, rsp                            ;asign base pointer to stack pointer
push rax                                 ;push first argument the number
call truncate_float                      ;call the function
add  rsp, 0x8                            ;clean stack
pop  rbp                                 ;recover base pointer
mov local_truncate_result,rax            ;save truncate result

mov  rbx,argument_buffer
add rbx,local_additional_symbols
push rbp                                 ;safe base pointer
mov  rbp, rsp                            ;asign base pointer to stack pointer
push rax                                 ;push first argument the number
push rbx                                 ;push second argument the buffer
call unsigned_to_string                  ;call the function
add rsp, 0x10                            ;clean stack
pop  rbp                                 ;recover base pointer
add local_additional_symbols,rax

add rsp,0x18                             ;remove local variables from the stack
mov rax,local_additional_symbols         ;additional digits in buffer (zero if number is positive 1 if negative)
ret                                      ;return
