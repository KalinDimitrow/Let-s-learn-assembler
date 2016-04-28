;segment .data      ;data segment
;real   dq 1538.65
;number dq -112

;segment .bss
;buffer: RESB 10
;segment .text	   ;code segment
;   global _start    ;must be declared for linker
;   extern unsigned_to_string
;   extern signed_to_string
;   extern truncate_float
;   extern float_to_string

;_start:	           ;tell linker entry point


;   ; pass argiments call function and clean the stack
;   push rbp ;safe base pointer
;   mov  rbp, rsp ;asign base pointer to stack pointer
;   mov  rax, [real]
;   push rax ;push first argument the number
;   push buffer ;push second argument the buffer
;   call float_to_string ;call the function
;   add rsp, 0x10 ;clean stack
;   pop  rbp ;recover base pointer





;;   push rbp ;safe base pointer
;;   mov  rbp, rsp ;asign base pointer to stack pointer
;;   mov  rax, [real]
;;   push rax ;push first argument the number
;;   call truncate_float ;call the function
;;   add rsp, 0x8 ;clean stack
;;   pop  rbp ;recover base pointer
;;   mov [number],rax


;   ; pass argiments call function and clean the stack
;;   push rbp ;safe base pointer
;;   mov  rbp, rsp ;asign base pointer to stack pointer
;;   mov  rax, [number]
;;   push rax ;push first argument the number
;;   push buffer ;push second argument the buffer
;;   call signed_to_string ;call the function
;;   add rsp, 0x10 ;clean stack
;;   pop  rbp ;recover base pointer

;   ;print buffer
;   mov rdx,rax	   ;message length
;   mov rcx,buffer     ;message to write
;   mov rbx,0x1	   ;file descriptor (stdout)
;   mov rax,0x4	   ;system call number (sys_write)
;   int 0x80	   ;call kernel

;exit:
;   mov eax,1       ;system call number (sys_exit)
;   int 0x80	   ;call kernel

