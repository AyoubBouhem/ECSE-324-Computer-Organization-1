			.text
			.equ PB_BASE, 0xFF200050
			.equ PB_EDGECAPTURE, 0xFF20005C
			.equ PB_INT_EDGECAPTURE, 0xFF200058
			.global read_PB_data_ASM, read_PB_edgecap_ASM, PB_edgecap_is_pressed_ASM, PB_clear_edgecp_ASM, enable_PB_INT_ASM, disable_PB_INT_ASM, PB_data_is_pressed_ASM

read_PB_data_ASM:
			LDR R1, =PB_BASE			//Read simple pushbotton data register
			LDR R0, [R1]	
			BX LR
read_PB_edgecap_ASM:
			LDR R4, =PB_EDGECAPTURE  //Read edgcapture push button register
			LDR R0, [R4]
			BX LR
PB_edgecap_is_pressed_ASM:
			LDR R3, =PB_EDGECAPTURE
			LDR R3, [R3]
			TST R0, R3
			BNE STORE_1
			BEQ STORE_0
STORE_1:	MOV R0, #1
			B DONE
STORE_0:	MOV R0, #0
DONE:		BX LR

PB_data_is_pressed_ASM:
			LDR R1, =PB_BASE		//Load the memory address of the data register of the push button into R1
			LDR R2, [R1]			//load the value stored in the memory address into R2
		
			TST R2, R0				//test if the sent pushbutton is 1 in memory
			MOVNE R0, #1			//if so store 1 in R0 and return 
			BXNE LR
		
			MOV R0, #0				//else store 0 in R0 and return 
			BX LR

PB_clear_edgecp_ASM:
			LDR R5, =PB_EDGECAPTURE
			STR R0, [R5]
			BX LR

enable_PB_INT_ASM:

			LDR R2, =PB_INT_EDGECAPTURE	
			STR R0, [R2]
			BX LR

disable_PB_INT_ASM:
			LDR R1, =PB_INT_EDGECAPTURE		//Load the memory address of the interrupt register of the push button into R1
			STR R0,[R1]						//store it back to the memory address
			BX LR
			.end


