;Addressing modes
;The three basic modes of addressing are:
;-Register addressing (use register as operand, (MOV	AX, DX))
;-Immediate addressing (use constant or expression as operand, (MOV	AX, 150))
;-Memory addressing (use memory address as operand)
;Memory addressing can be used as :
;-Direct memory addressing (use variable(address of the variable) as operand, (ADD	BYTE_VALUE, DL))
;-Direct-offset addressing (use offset to variable(address of the variable) as operand)
;	MOV CL, BYTE_TABLE[2]	; Gets the 3rd element of the BYTE_TABLE
;	MOV CL, BYTE_TABLE + 2	; Gets the 3rd element of the BYTE_TABLE
;	MOV CX, WORD_TABLE[3]	; Gets the 4th element of the WORD_TABLE
;	MOV CX, WORD_TABLE + 3	; Gets the 4th element of the WORD_TABLE
;-Indirect memory addressing (use register which contain variable address as operand)
;	MY_TABLE TIMES 10 DW 0  ; Allocates 10 words (2 bytes) each initialized to 0
;	MOV EBX, [MY_TABLE]     ; Effective Address of MY_TABLE in EBX
;	MOV [EBX], 110          ; MY_TABLE[0] = 110
;	ADD EBX, 2              ; EBX = EBX +2
;	MOV [EBX], 123          ; MY_TABLE[1] = 123


segment	.data
name db 'Zara Ali '

segment	.text
   global _start     ;must be declared for linker (ld)
_start:             ;tell linker entry point

   ;writing the name 'Zara Ali'
   mov	edx,9       ;message length
   mov	ecx, name   ;message to write
   mov	ebx,1       ;file descriptor (stdout)
   mov	eax,4       ;system call number (sys_write)
   int	0x80        ;call kernel

   mov	[name],  dword 'Nuha'    ; Changed the name to Nuha Ali

   ;writing the name 'Nuha Ali'
   mov	edx,8       ;message length
   mov	ecx,name    ;message to write
   mov	ebx,1       ;file descriptor (stdout)
   mov	eax,4       ;system call number (sys_write)
   int	0x80        ;call kernel

   mov	eax,1       ;system call number (sys_exit)
   int	0x80        ;call kernel


