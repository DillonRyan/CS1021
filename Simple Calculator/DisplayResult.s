	AREA	DisplayResult, CODE, READONLY
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



	start
	BL	getkey		; read key from console
	CMP	R0, #0x0D  	; while (key != CR)
	BEQ	endRead		; {
	BL	sendchar	;   echo key back to console

while
	CMP R0, #0	; subtratct R0 from 0
	BEQ endwh ; while (y != 0) {
	MUL r0, r1, r0 ; result = result × x
	SUB r2, r2, #1 ; y = y - 1
	B while ; }

	ADD R0, R1, #count++
	MOV R11, R0	;moving the result into R11
	BL sendchar
endwh
	
	start
	BL	getkey		; read key from console
	CMP	R0, #0x0D  	; while (key != CR)
	BEQ	endRead		; {
	BL	sendchar	;   echo key back to console

	MOV R0, R4  ; move R0 into R4
	MOV R0, #0; quotient = 0
	MOV R1, R9; remainder is stored in R9

	CMP R1, #0;  if( R1  >= 0 )
	BLE endifzero; {
	
whOne
	CMP R1, R9;
	BLT endwhOne ; while (remainder >= R1) {
	
	ADD R0, R0, #1; quotient = quotient + 1
	SUB R1, R1, R9; remainder = remainder - R1
	
	B whOne ; }
	
endwhOne

endifzero   ; }

	CMP R0, #9
	BLS notquotient	;{
	BL sendchar	;prints out answer
endnotquotient	;}
	
	SUB R11, #1	;lowering the power of 10 by 1
	B	reset
	
elsenotquotient	;{	
	ADD R11, #1	;adding one to the power of 10
	B	reset
	MOV R11, R5	;moving whats in R5 into R11
	BL sendchar



stop	B	stop

	END	