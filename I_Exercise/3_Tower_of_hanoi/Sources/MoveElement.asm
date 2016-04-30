%define argument_source qword [rbp - 0x8]
%define argument_destination qword [rbp - 0x10]


segment .data
msg_from db "Move from "
msg_from_len equ	$ - msg_from
msg_to db " to "
msg_to_len equ	$ - msg_to
new_line	db 0xa
new_line_len	equ	$ - new_line
msg_element_len equ 0x1

segment .bss

segment .text

global move_element

move_element:

   mov   ecx, msg_from
   mov   edx, msg_from_len
   mov   eax, 4
   mov   ebx, 1
   int   80h

   mov   rcx, argument_source
   mov   edx, msg_element_len
   mov   eax, 4
   mov   ebx, 1
   int   80h

   mov   ecx, msg_to
   mov   edx, msg_to_len
   mov   eax, 4
   mov   ebx, 1
   int   80h

   mov   rcx, argument_destination
   mov   edx, msg_element_len
   mov   eax, 4
   mov   ebx, 1
   int   80h

   mov   ecx, new_line
   mov   edx, new_line_len
   mov   eax, 4
   mov   ebx, 1
   int   80h

ret
