			.text
			.equ HEX_3_to_0, 0xFF200020
			.equ HEX_5_to_4, 0xFF200030
			.global  HEX_flood_ASM

			/*This subroutine turns on all the display segments of whichever HEX display is passed in the parameter*/
			/*Do this by passing specific values to each HEX display which map to 8 for that specific HEX display*/	
HEX_flood_ASM: 
			LDR R1, =HEX_3_to_0
			LDR R2, =HEX_5_to_4	
			MOV R5, R0
			MOV R3, #0
			MOV R4, #0
HEX_0:
			TST	R0, #0x00000001
			BNE FLOOD_HEX_0
			BEQ HEX_1
FLOOD_HEX_0:
			ADD R3, R3,	#0x0000007F
			STR R3, [R1]
HEX_1:
			MOV R0, R5
			TST R0, #0x00000002
			BNE FLOOD_HEX_1
			BEQ HEX_2
FLOOD_HEX_1:
			ADD R3, R3, #0x00007F00
			STR R3, [R1]
HEX_2:		
			MOV R0, R5
			TST R0, #0x00000004
			BNE FLOOD_HEX_2
			BEQ HEX_3
FLOOD_HEX_2:
			ADD R3, R3, #0x007F0000
			STR R3, [R1]
HEX_3:
			MOV R0, R5
			TST R0, #0x00000008
			BNE FLOOD_HEX_3
			BEQ HEX_4
FLOOD_HEX_3:
			ADD R3, R3, #0X7F000000
			STR R3, [R1]
HEX_4:
			MOV R0, R5
			TST R0, #0x00000010
			BNE FLOOD_HEX_4
			BEQ HEX_5
FLOOD_HEX_4:
			ADD R4, R4, #0x0000007F
			STR R4, [R2]
HEX_5:
			MOV R0, R5
			TST R0, #0x00000020
			BNE FLOOD_HEX_5
			BEQ DONE
FLOOD_HEX_5:		
			ADD R4, R4, #0x00007F00
			STR R4, [R2]
DONE:		
			BX LR
.end
