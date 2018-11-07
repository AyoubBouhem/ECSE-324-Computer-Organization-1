				.text
				.global	_start

_start:
				LDR R4, =RESULT			//R4 points to result location
				LDR R2, [R4, #4]		//R2 holds the list size
				ADD R3, R4,	#8		//R3 holds the first number
				LDR R0, [R3]			//R3 points to the first number
				BL  LOOP			//we call our subroutine, 'LOOP' and store the address of next instruction in LR, that is the return address
END:
				B END				//infinite exit loop

LOOP:
				SUBS R2, R2, #1			//decrement the loop counter
				BXEQ 	 LR			//end loop is condition flag is 0 meaning counter is 0
				ADD R3, R3, #4			//R3 points to next element in the list
				LDR R1, [R3]			//R1 holds the next element in the list
				CMP R0, R1			//check if current value greater than max
				BGE LOOP			//if no, go back
				MOV R0, R1			//if yes, update value
				B  LOOP				//return to next instruction

DONE:		
				STR R0, [R4]			//store the result in the memory location


RESULT:			        .word 0
N:				.word 7
NUMBERS:		        .word 4, 5, 3, 6
				.word 1, 8, 2
