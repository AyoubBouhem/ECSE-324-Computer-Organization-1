			.text
			.global _start

_start:
			/*code that pushes the contents of R0 onto the stack*/
			
			MOV R0, #10		//store value of 10 into R0
			SUB SP, SP, #4		//stack grows upwards in main memory, so we subtract current address to add new item
			STR R0, [SP]		//store new item on the stack
			LDR R0, [SP]		//load value of stack's top into R0
			ADD SP, SP, #4		//increase stack pointer to point to next element in the stack
			LDR R1, [SP]		//load next value			
			ADD SP, SP, #4		//increase stack pointer to point to next element in the stack
			LDR R2, [SP]		
			ADD SP, SP, #4
END:		B END