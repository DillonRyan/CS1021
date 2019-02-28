	AREA	ExpEval, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start
	LDR R4, = 0
	LDR R5, = 10
	LDR R11, = 0
	LDR R7, = 0
	LDR R8, = 0
	LDR R9, = 0
	LDR R10, = 0
	LDR R11, = 0
	LDR R12, = 0
Read
	BL	getkey		; read key from console
	CMP	R0, #0x0D  	; while (key != CR)
	BEQ	branchone		; {
	BL	sendchar	;   echo key back to console
	CMP R0, #0x30	
	BLT branchone	;while (0x30
	
	;operatorinput
	CMP R0, #0x02B	;Subtract R0 from 0x2B ignoring the result but updating the carry flags	
	BEQ branchone	;Branch if the answer is equal to zero 
	CMP R0, #0x2D	;Subtract R0 from 0x2D ignoring the result but updating the carry flags
	BEQ branchone	;Branch if the answer is equal to zero
	CMP R0, #0x2A	;Subtract R0 from 0x2A ignoring the result but updating the carry flags
	BEQ branchone	;Branch if the answer is equal to zero
	
	
	MUL R4, R5, R4	;result = 10 * result
	SUB R0, R0, #0x30	;convert ASCII to numberic
	ADD R4, R0, R4	; result =value input + result
	
branchone
finishread
	MOV R0, R11	;Move whats in R0 into R11
	BL getkey	;Read key from console
	CMP R0, #0x0D	;while (key != CR)
	BEQ endfinishread	;{
	BL sendchar	;echo back to console
	
	MUL R10, R5, R10	;result = 10 * result 
	SUB R0, R0, #0x30	;convert ASCII to numberic
	ADD R10, R0, R10	;result =value input + result
	
	B finishread
endfinishread
	
stop	B	stop

	END	

	CMP R11, #0x2B	;Subtract R0 from 0x2B ignoring the result but updating the carry flags	
	BNE endaddition	;Branch if the answer is equal to zero
	ADD R5, R4, R11	;result = value input + result
endaddition

	CMP R11, #0x2D	;Subtract R0 from 0x2D ignoring the result but updating the carry flags	
	BNE endsubtraction ;Branch if the answer is equal to zero
	SUB R5, R4, R11	;result = value input - result
endsubtraction

	CMP R11, #0x2A	;Subtract R0 from 0x2A ignoring the result but updating the carry flags	
	BNE endmultiplication	;Branch if the answer is equal to zero
	MUL R5, R4, R11	;result = value input * result
endmultiplication

END