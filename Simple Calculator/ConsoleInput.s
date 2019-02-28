	AREA	ConsoleInput, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start
	LDR R4, = 0
	LDR R5, = 10
	LDR R6, = 0
	LDR R7, = 0
	LDR R8, = 0
	LDR R9, = 0
	LDR R10, = 0
	LDR R11, = 0
	LDR R12, = 0
Read
	BL	getkey		; read key from console
	CMP	R0, #0x0D  	; while (key != enter)
	BEQ	endRead		; {
	BL	sendchar	;   echo key back to console

	MUL R4, R5, R4	; Result = Result * 10
	SUB R0, R0, #0x30	;Converting ASCII to numeric
	ADD R4, R0, R4	;Result = Result + value inputted
	B	Read		; }
	
endRead

stop	B	stop

	END	