			AREA	Sets, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R1, =AElems ; adress elements of A
	LDR R2, =ASize ; adress of elems in A
	LDR R3, [R2] ;NO OF ELEMENTS
	MOV R11, #0 ; OFFESET 0
		
	LDR R5, =CElems ; elemnets of c
	MOV R6, #0 ; OFFSET 0
	
WH1
	LDR R4, =BElems ; elements of B
	LDR R5, =BSize ; num of elems in B
	LDR R9, [R5]	; load the number of elements in set B into R9
	MOV R7, #0 	; set the offset to zero
	LDR R0, [R1, R3]	;	load an element from A into R0
	
elementsOfA
	LDR R8, [R4, R7]
	CMP R0, R8	; while (Count of A != 0)
	BNE elementsOfB	; {
	STR R0, [R5, R6]
	ADD R6 , R6, #4	; Adr++
	ADD R10, R10, #1 ; SIZE COUNTER c
	
elementsOfB
	
	ADD R7, R7, #1 ;offset++
	SUB R9, R9, #4	; bElements--
	CMP R9, #0	; while (bElements != 0)
	BNE elementsOfA
	
	ADD R11, R11, #4 ; adrA ++
	SUB R3, R3, #1	; set A count --
	CMP R3, #0
	BNE WH1
	
	LDR R0, =CSize	; load in adr of CSize into R0
	STR R10, [R0]	;store the size of set C into R10
	
	
stop	B	stop


	AREA	TestData, DATA, READWRITE
	
ASize	DCD	8			; Number of elements in A
AElems	DCD	4,6,2,13,19,7,1,3	; Elements of A

BSize	DCD	6			; Number of elements in B
BElems	DCD	13,9,1,9,5,8		; Elements of B

CSize	DCD	0			; Number of elements in C
CElems	SPACE	56			; Elements of C

	END
