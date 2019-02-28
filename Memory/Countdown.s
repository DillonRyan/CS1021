	AREA	Countdown, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =cdWord	; Load in start adr of word
	LDR	R2, =cdLetters	; Load in start adr of letters
	LDR R0, = 1 	; if possible
	LDR R10, = '$'	;replacement char
elemA
	LDR	R2, =cdLetters	;ptr2 = start adr of letters
	LDRB R12, [R1]	;load cdWords into R12
	CMP R12, #0	;{
	BEQ endelemA
elemB
	LDRB R11, [R2]	;load cdLetters into R10
	CMP R11, #0	 ;{
	BEQ endelemB2
	CMP R12, R11	;if (adr1 != adr2)
	BEQ endelemB1	;{
	ADD R2, R2, #1	;adr2++
	B elemB ;}
endelemB1	
	STRB R10, [R2]
	ADD R1, R1, #1	;adr1++
	B elemA	;}
endelemB2
	LDR R0, = 0	;if impossible
endelemA
	
stop	B	stop



	AREA	TestData, DATA, READWRITE
	
cdWord
	DCB	"beets",0

cdLetters
	DCB	"daetebzsb",0
	
	END	
