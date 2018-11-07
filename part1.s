			.text
		    .global _start

_start:
			LDR R4, =RESULT 	//R4 points to the memory location of result
			LDR R2, [R4, #4]	//Using offset addressing mode, r2 holds size
			ADD R3, R4, #8		//R3 will point to the first element
			LDR R0, [R3] 		//R0 now holds the first element 

LOOP:		SUBS R2, R2, #1		//Decrement the loop counter, i.e reduce size
			BEQ DONE			//End loop if counter has reached, i.e N = 0
			ADD R3, R3, #4		//R3 now points to the next number
			LDR R1, [R3]		//R1 holds the next number
			CMP R0, R1			//Check with the first element
			BGE LOOP			//If no, branch back
			MOV R0, R1			//If yes, replace value in R0	
			B LOOP

DONE:		STR R0, [R4]		//Store the result to the memory location
END:		B END				//Infinite loop!

RESULT:		.word	0			//Memory assigned for result location
N:			.word	7			//Number of entries in the list
NUMBERS: 	.word 	4, 5, 3, 6  //The list data
			.word	1, 8, 2

 
