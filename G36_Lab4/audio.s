
			.text
			.global audio
			.equ FIFO_SPACE, 0xFF203044 
			.equ LEFTDATA, 0xFF203048
			.equ RIGHTDATA, 0xFF20304C

audio:




			LDR R1, =FIFO_SPACE
			LDR R2, [R1]
			
			AND R4, R2, #0xFF000000	//Extract for WSLC
			AND R5, R2, #0x00FF0000	//Extract for WSRC
			LSR R4, R4, #6			//LSR to get their actual values
			LSR R5, R5, #4			//LSR to get their actual values

			CMP R4, #1				//check if space
			BLT EXIT				//none, exit
			CMP R5, #1				//check if space
			BLT EXIT				//none, exit

			LDR R6, =LEFTDATA		//load left data
			LDR R7, =RIGHTDATA		//load right data
			STR R0,[R6]				//str back in left
			STR R0,[R7]				//str back in rigth
			MOV R0, #1				//return true
			BX LR					//bx lr

EXIT:		
			MOV R0, #0				//all failed exit
			BX LR

			.end
