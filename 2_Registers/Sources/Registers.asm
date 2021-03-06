;Processor registers are grouped in three categories:
;-general registers
;-control registers
;-segment registers
;
;General registers are divided into the following groups:
;-data registers
;-pointer registers
;-index registers
;
;The data registers are (part of general registers):
;-EAX (accumulator, commonly used to storing result of instruction)
;-EBX (base register, commonly used in indexed addressing)
;-ECX (count register, commonly used to store loop count in iterative operations)
;-EDX (data register, commonly used in input,output operations)
;
;The lower halves of this register can be used as (16 bit):
;-AX
;-BX
;-CX
;-DX
;
;And the lower halves can be separated to lower and higher halves as (8 bit):
;-AL and AH
;-BL and BH
;-CL and CH
;-DL and DH
;
;Pointer registers are (part of general registers):
;-EIP (instruction pointer,as IP stores the offset address of the next instruction to be executed commonly associated with code segment CS:IP)
;-ESP (stack pointer, as SP provide offset value in the program stack commonly associated with stack segment SS:SP)
;-EBP (base pointer,as BP helps in referencing parameter variables passed to subroutines, can be combined with source index and destination index)
;
;The lower halves of this register can be used as (16 bit):
;-IP
;-SP
;-BP
;
;Index Registers are (part of general registers):
;-SI (Source index, it is used as source index for string operations)
;-DI (Destination index, it is used as destination index for string operations)
;
;Control Registers
;-The 32-bit instruction pointer register and the 32-bit flags register combined are considered as the control registers.
;-Many instructions involve comparisons and mathematical calculations and change the status of the flags and some other
; conditional instructions test the value of these status flags to take the control flow to other location
;
;The common flag bits are:
;-OF (Overflow flag, it indicates the overflow of a high-order bit (leftmost bit) of data after a signed arithmetic operation)
;-DF (Direction flag, it determines left or right direction for moving or comparing string data. When the DF value is 0,
;     the string operation takes left-to-right direction and when the value is set to 1, the string operation takes right-to-left direction)
;-IF (Interrupt flag ,it determines whether the external interrupts like keyboard entry, etc., are to be ignored or processed.
;     It disables the external interrupt when the value is 0 and enables interrupts when set to 1)
;-TF (Trap flag, it allows setting the operation of the processor in single-step mode.
;     The DEBUG program we used sets the trap flag, so we could step through the execution one instruction at a time)
;-SF (Sign flag, it shows the sign of the result of an arithmetic operation.
;     This flag is set according to the sign of a data item following the arithmetic operation.
;     The sign is indicated by the high-order of leftmost bit. A positive result clears the value of SF to 0 and negative result sets it to 1)
;-ZF (Zero flag, it indicates the result of an arithmetic or comparison operation.
;     A nonzero result clears the zero flag to 0, and a zero result sets it to 1)
;-AF (Auxiliary carry flag, it contains the carry from bit 3 to bit 4 following an arithmetic operation used for specialized arithmetic.
;     The AF is set when a 1-byte arithmetic operation causes a carry from bit 3 into bit 4)
;-PF (Parity flag, it indicates the total number of 1-bits in the result obtained from an arithmetic operation.
;     An even number of 1-bits clears the parity flag to 0 and an odd number of 1-bits sets the parity flag to 1)
;-CF (Carry flag, it contains the carry of 0 or 1 from a high-order bit (leftmost) after an arithmetic operation.
;     It also stores the contents of last bit of a shift or rotate operation)
;
;Segment Registers are:
;-CS (Code segment, it contains all the instruction to be executed)
;-DS (Data segment, it contains data, constants and work areas)
;-SS (Stack segment, it contains data and return addresses of subroutines)


segment	.data
msg db 'Displaying 9 stars',0xa ;a message
len equ $ - msg  ;length of message
s2 times 9 db '*'

segment	.text
   global _start	 ;must be declared for linker (gcc)

_start:	         ;tell linker entry point
   mov	edx,len  ;message length
   mov	ecx,msg  ;message to write
   mov	ebx,1    ;file descriptor (stdout)
   mov	eax,4    ;system call number (sys_write)
   int	0x80     ;call kernel

   mov	edx,9    ;message length
   mov	ecx,s2   ;message to write
   mov	ebx,1    ;file descriptor (stdout)
   mov	eax,4    ;system call number (sys_write)
   int	0x80     ;call kernel

   mov	eax,1    ;system call number (sys_exit)
   int	0x80     ;call kernel


