%define number qword [rbp - 0x8]
%define local_variable qword [rbp - 0x18]

segment .data
constant dd -0.5

segment .bss


segment .text
global truncate_float

truncate_float:
sub rsp,0x8                ;allocate memory for local variable
mov rbx,0x8000000000000000 ;2^63
and rbx,number             ; save sign of number in base register
;finit                      ;clear fpu
fld number                 ;load function's argument into fpu
fadd st0, st0              ;effectively doubling the number
fabs                       ;make it positive (st0)
fadd dword [constant]      ;add constant
fistp local_variable       ;move number to local variable
mov rax,local_variable     ;move local variable to rax register
sar rax,0x1                ;shift to the right while save the sign (effectively divide by 2)
cmp rbx,0x0                ;check sign of the number
jz exit_float_to_string    ;jump to exit if it's positive
not rax                    ;make result negative
add rax,0x1                ;
exit_float_to_string:
add rsp,0x8                ;remove local variable from the stack
;mov rax,0x5
ret                        ;return
