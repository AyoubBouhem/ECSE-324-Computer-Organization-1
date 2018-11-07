			.text
			.equ HEX_3_to_0, 0xFF200020
			.equ HEX_5_to_4, 0xFF200030
			.global  HEX_write_ASM
			/*This subroutine will display a value between 0-F to which HEX display is passed as the parameter*/
HEX_write_ASM: 
			LDR R6, =HEX_3_to_0
			LDR R2, =HEX_5_to_4	
			MOV R3, #0
			MOV R4, #0
			LDR R7, [R6]
			LDR R8, [R2]
CHECK_FOR_HEX_0:
			/*Check condition if HEX0 is passed, if so we write to it, else we check the other displays*/
			CMP	R0, #0x00000001
			BEQ WRITE_NUM_HEX_0
			BNE CHECK_FOR_HEX_1
CHECK_FOR_HEX_1:
			/*Check condition if HEX1 is passed, if so we write to it, else we check the other displays*/
			CMP	R0, #0x00000002
			BEQ WRITE_NUM_HEX_1
			BNE CHECK_FOR_HEX_2
CHECK_FOR_HEX_2:
			/*Check condition if HEX2 is passed, if so we write to it, else we check the other displays*/
			CMP R0, #0x00000004
			BEQ WRITE_NUM_HEX_2
			BNE CHECK_FOR_HEX_3
CHECK_FOR_HEX_3:
			/*Check condition if HEX3 is passed, if so we write to it, else we check the other displays*/
			CMP R0, #0x00000008
			BEQ WRITE_NUM_HEX_3
			BNE CHECK_FOR_HEX_4
CHECK_FOR_HEX_4:
			/*Check condition if HEX4 is passed, if so we write to it, else we check the other displays*/
			CMP R0, #0x00000010
			BEQ WRITE_NUM_HEX_4
			BNE CHECK_FOR_HEX_5
CHECK_FOR_HEX_5:
			/*Check condition if HEX5 is passed, if so we write to it, else we exit subroutine as nothing else is left to display*/
			CMP R0, #0x00000020
			BEQ WRITE_NUM_HEX_5
			BNE DONE
WRITE_NUM_HEX_0:
			/*Check which values to write for HEX0*/
			CMP R1, #0 //0
			MOVEQ R3, #0x00003f 
			CMP R1, #1 //1
			MOVEQ R3, #0x000006
			CMP R1, #2 //2
			MOVEQ R3, #0x00005b
			CMP R1, #3 //3
			MOVEQ R3, #0x00004f
			CMP R1, #4 //4
			MOVEQ R3,#0x000066
			CMP R1, #5 //5
			MOVEQ R3, #0x00006d
			CMP R1, #6 //6
			MOVEQ R3, #0x00007d
			CMP R1, #7 //7 
			MOVEQ R3, #0x000007
			CMP R1, #8 //8 
			MOVEQ R3, #0x00007f
			CMP R1, #9 //9
			MOVEQ R3, #0x000067
			CMP R1, #10 //A
			MOVEQ R3, #0x000077
			CMP R1, #11 //B
			MOVEQ R3, #0x00007c
			CMP R1, #12 //C 
			MOVEQ R3, #0x000039
			CMP R1, #13 //D
			MOVEQ R3, #0x00005e
			CMP R1, #14 //E 
			MOVEQ R3, #0x000079
			CMP R1, #15 //F
			MOVEQ R3, #0x000071
			STRB R3, [R6]
			B CHECK_FOR_HEX_1
WRITE_NUM_HEX_1:
			/*Check which values to write for HEX1*/
			CMP R1, #0
			MOVEQ R3, #0x00003f 
			CMP R1, #1
			MOVEQ R3, #0x000006
			CMP R1, #2
			MOVEQ R3, #0x00005b
			CMP R1, #3
			MOVEQ R3, #0x00004f
			CMP R1, #4
			MOVEQ R3,#0x000066
			CMP R1, #5
			MOVEQ R3, #0x00006d
			CMP R1, #6
			MOVEQ R3, #0x00007d
			CMP R1, #7
			MOVEQ R3, #0x000007
			CMP R1, #8
			MOVEQ R3, #0x00007f
			CMP R1, #9
			MOVEQ R3, #0x000067
			CMP R1, #10
			MOVEQ R3, #0x000077
			CMP R1, #11
			MOVEQ R3, #0x00007c
			CMP R1, #12
			MOVEQ R3, #0x000039
			CMP R1, #13
			MOVEQ R3, #0x00005e
			CMP R1, #14
			MOVEQ R3, #0x000079
			CMP R1, #15
			MOVEQ R3, #0x000071
			STRB R3, [R6,#1]
			B CHECK_FOR_HEX_2
WRITE_NUM_HEX_2:
			/*Check which values to write for HEX2*/
			CMP R1, #0
			MOVEQ R3, #0x00003f
			CMP R1, #1
			MOVEQ R3, #0x000006
			CMP R1, #2
			MOVEQ R3, #0x00005b
			CMP R1, #3
			MOVEQ R3, #0x00004f
			CMP R1, #4
			MOVEQ R3,#0x000066
			CMP R1, #5
			MOVEQ R3, #0x00006d
			CMP R1, #6
			MOVEQ R3, #0x00007d
			CMP R1, #7
			MOVEQ R3, #0x000007
			CMP R1, #8
			MOVEQ R3, #0x00007f
			CMP R1, #9
			MOVEQ R3, #0x000067
			CMP R1, #10
			MOVEQ R3, #0x000077
			CMP R1, #11
			MOVEQ R3, #0x00007c
			CMP R1, #12
			MOVEQ R3, #0x000039
			CMP R1, #13
			MOVEQ R3, #0x00005e
			CMP R1, #14
			MOVEQ R3, #0x000079
			CMP R1, #15
			MOVEQ R3, #0x000071
			STRB R3, [R6,#2]
			B CHECK_FOR_HEX_3
WRITE_NUM_HEX_3:
			/*Check which values to write for HEX3*/
			CMP R1, #0
			MOVEQ R3, #0x00003f
			CMP R1, #1
			MOVEQ R3, #0x000006
			CMP R1, #2
			MOVEQ R3, #0x00005b
			CMP R1, #3
			MOVEQ R3, #0x00004f
			CMP R1, #4
			MOVEQ R3,#0x000066
			CMP R1, #5
			MOVEQ R3, #0x00006d
			CMP R1, #6
			MOVEQ R3, #0x00007d
			CMP R1, #7
			MOVEQ R3, #0x000007
			CMP R1, #8
			MOVEQ R3, #0x00007f
			CMP R1, #9
			MOVEQ R3, #0x000067
			CMP R1, #10
			MOVEQ R3, #0x000077
			CMP R1, #11
			MOVEQ R3, #0x00007c
			CMP R1, #12
			MOVEQ R3, #0x000039
			CMP R1, #13
			MOVEQ R3, #0x00005e
			CMP R1, #14
			MOVEQ R3, #0x000079
			CMP R1, #15
			MOVEQ R3, #0x000071
			STRB R3, [R6,#3]
			B CHECK_FOR_HEX_4
WRITE_NUM_HEX_4:
			/*Check which values to write for HEX4*/
			CMP R1, #0
			MOVEQ R4, #0x0000003f
			CMP R1, #1
			MOVEQ R4, #0x00000006
			CMP R1, #2
			MOVEQ R4, #0x0000005b
			CMP R1, #3
			MOVEQ R4, #0x0000004f
			CMP R1, #4
			MOVEQ R4, #0x00000066
			CMP R1, #5
			MOVEQ R4, #0x0000006d
			CMP R1, #6
			MOVEQ R4, #0x0000007d
			CMP R1, #7
			MOVEQ R4, #0x00000007
			CMP R1, #8
			MOVEQ R4, #0x0000007f
			CMP R1, #9
			MOVEQ R4, #0x00000067
			CMP R1, #10
			MOVEQ R4, #0x00000077
			CMP R1, #11
			MOVEQ R4, #0x0000007c
			CMP R1, #12
			MOVEQ R4, #0x00000039
			CMP R1, #13
			MOVEQ R4, #0x0000005e
			CMP R1, #14
			MOVEQ R4, #0x00000079
			CMP R1, #15
			MOVEQ R4, #0x00000071
			STRB R4, [R2]
			B CHECK_FOR_HEX_5
WRITE_NUM_HEX_5:
			/*Check which values to write for HEX5*/
			CMP R1, #0
			MOVEQ R4, #0x00003f
			CMP R1, #1
			MOVEQ R4, #0x000006
			CMP R1, #2
			MOVEQ R4, #0x00005b
			CMP R1, #3
			MOVEQ R4, #0x00004f
			CMP R1, #4
			MOVEQ R4,#0x000066
			CMP R1, #5
			MOVEQ R4, #0x00006d
			CMP R1, #6
			MOVEQ R4, #0x00007d
			CMP R1, #7
			MOVEQ R4, #0x000007
			CMP R1, #8
			MOVEQ R4, #0x00007f
			CMP R1, #9
			MOVEQ R4, #0x000067
			CMP R1, #10
			MOVEQ R4, #0x000077
			CMP R1, #11
			MOVEQ R4, #0x00007c
			CMP R1, #12
			MOVEQ R4, #0x000039
			CMP R1, #13
			MOVEQ R4, #0x00005e
			CMP R1, #14
			MOVEQ R4, #0x000079
			CMP R1, #15
			MOVEQ R4, #0x000071
			STRB R4, [R2,#1]
			B DONE
DONE:		BX LR
