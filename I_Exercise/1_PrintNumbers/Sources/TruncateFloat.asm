%define number dword [rbp - 0x8]
%define local_variable qword [rbp - 0x18]

segment .data
num dq 0
constant dd -0.5

segment .bss
old_rounding resw 1

segment .text
global truncate_float

truncate_float:
sub rsp,0x8             ;allocate memory for local variable
mov rbx,0x80000000      ;2^31
and ebx,number          ; save sign of number in base register
fld number              ;load function's argument into fpu
fadd st0, st0           ;effectively doubling the number
fabs                    ;make it positive (st0)
fadd dword [constant]   ;add constant
fistp local_variable    ;move number to local variable
mov rax,local_variable  ;move local variable to rax register
sar rax,0x1             ;shift to the right while save the sign (effectively divide by 2)
cmp rbx,0x0             ;check sign of the number
jz exit_float_to_string ;jump to exit if it's positive
not rax                 ;make result negative
add rax,0x1             ;
exit_float_to_string:
add rsp,0x8             ;remove local variable from the stack
ret                     ;return
