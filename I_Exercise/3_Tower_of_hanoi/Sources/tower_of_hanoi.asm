%define argument_source qword [rbp - 0x8]
%define argument_mid qword [rbp - 0x10]
%define argument_destination qword [rbp - 0x18]
%define argument_elements qword [rbp - 0x20]


segment .data

segment .bss
buffer resb 20
segment .text
global tower_of_hanoi
extern move_element
extern unsigned_to_string

tower_of_hanoi:

   mov rax, argument_elements
   cmp rax,0x1
   jz exit_condition

   mov rax,argument_source
   mov rbx,argument_mid
   mov rcx,argument_destination
   mov rdx,argument_elements
   sub rdx, 0x1

   push rbp                      ;safe base pointer
   mov  rbp, rsp                 ;asign base pointer to stack pointer
   push rax                      ;push first argument the number
   push rcx                      ;push second argument the number
   push rbx                      ;push third argument the number
   push rdx                      ;push fourth argument the number
   call tower_of_hanoi           ;call the function
   add rsp, 0x20                 ;clean stack
   pop  rbp                      ;recover base pointer

   mov rax,argument_source
   mov rbx,argument_destination

   push rbp             ;safe base pointer
   mov  rbp, rsp        ;asign base pointer to stack pointer
   push rax             ;push first argument the number
   push rbx             ;push second argument the number
   call move_element    ;call the function
   add rsp, 0x10        ;clean stack
   pop  rbp             ;recover base pointer


   mov rax,argument_source
   mov rbx,argument_mid
   mov rcx,argument_destination
   mov rdx,argument_elements
   sub rdx, 0x1

   push rbp                      ;safe base pointer
   mov  rbp, rsp                 ;asign base pointer to stack pointer
   push rbx                      ;push first argument the number
   push rax                      ;push second argument the number
   push rcx                      ;push third argument the number
   push rdx                      ;push fourth argument the number
   call tower_of_hanoi           ;call the function
   add rsp, 0x20                 ;clean stack
   pop  rbp                      ;recover base pointer

ret

exit_condition:
   mov rax,argument_source
   mov rbx,argument_destination

   push rbp             ;safe base pointer
   mov  rbp, rsp        ;asign base pointer to stack pointer
   push rax             ;push first argument the number
   push rbx             ;push second argument the number
   call move_element    ;call the function
   add rsp, 0x10        ;clean stack
   pop  rbp             ;recover base pointer

ret
