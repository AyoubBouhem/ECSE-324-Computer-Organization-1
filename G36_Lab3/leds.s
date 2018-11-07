			.text
			.equ LED_ADDRESS, 0xFF200000
			.global read_LEDs_ASM, write_LEDs_ASM
			
read_LEDs_ASM:
			/*Read LED register*/
			LDR R1, =LED_ADDRESS		
			LDR R0, [R1]
			BX LR

write_LEDs_ASM:
			/*Store R0 in the LED register*/
			LDR R2, =LED_ADDRESS
			STR R0, [R2]
			BX LR
.end
