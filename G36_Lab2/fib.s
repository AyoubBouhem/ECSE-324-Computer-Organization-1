					.text
					.global _start
_start:
					MOV R0, #11 				//R0 will be our return value
					BL FIBONACCI				//Go to subroutine Fibonacci
STOP:				        B STOP					//Done case

FIBONACCI:
					PUSH {R1,R2,LR}				//We use R1, R2, as temporary registers during this subroutine so we store them on the stack as they change value
					MOV R1, R0				//R1 gets the value of R0 it is a temporary variable essentially
					CMP	R0, #2				//Our exit case if (N<=2}
					MOVEQ R0, #1				//If true, store 1
					BLE FIB_DONE				//And exit
					SUB R0, R1, #2				//Subtract R0 by two i.e (n = n -2)
					BL FIBONACCI				//Branch back i.e Fib(n-2);
					MOV R2, R0				//This is for the case Fib(n-1);
					SUB R0, R1, #1				//Basically n = n-1;
					BL FIBONACCI				//Fib(n-1);
					ADD R0, R0, R2				//Do the sum of Fib(n-1) and Fib(n-2);
FIB_DONE:
					POP {R1,R2,PC}				//We pop all our variables of the stack because we are done
					
