			.text
			.equ HEX_3_to_0, 0xFF200020
			.equ HEX_5_to_4, 0xFF200030
			.global  HEX_clear_ASM
			
			/*This subroutine clears all the display segments of whichever HEX display is passed in the parameter*/
			/*It does so by simply clearing all display segements by passing 0 to it which turns all segemtns off*/
HEX_clear_ASM: 
			LDR R1, =HEX_3_to_0
			LDR R2, =HEX_5_to_4	
HEX_0:
			TST	R0, #0x00000001
			BNE CLEAR_HEX_0
			BEQ HEX_1
CLEAR_HEX_0:
			MOV R3, #0
			STR R3, [R1]
HEX_1:
			
			TST R0, #0x00000002
			BNE CLEAR_HEX_1
			BEQ HEX_2
CLEAR_HEX_1:
			MOV R3, #0
			STR R3, [R1]
HEX_2:		
			TST R0, #0x00000004
			BNE CLEAR_HEX_2
			BEQ HEX_3
CLEAR_HEX_2:
			MOV R3, #0
			STR R3, [R1]
HEX_3:
			
			TST R0, #0x00000008
			BNE CLEAR_HEX_3
			BEQ HEX_4
CLEAR_HEX_3:
			MOV R3, #0
			STR R3, [R1]
HEX_4:
			TST R0, #0x00000010
			BNE CLEAR_HEX_4
			BEQ HEX_5
CLEAR_HEX_4:
			MOV R4, #0
			STR R4, [R2]
HEX_5:
			TST R0, #0x00000020
			BNE CLEAR_HEX_5
			BEQ DONE
CLEAR_HEX_5:		
			MOV R4, #0
			STR R4, [R2]
DONE:		
			BX LR
.end
