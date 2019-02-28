	AREA	Lotto, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =TICKETS
	LDR R2, =COUNT
	LDRB R2, [R2] ; Number of tickets remaining
	
ticket
	LDR R3, =6 ; ticketCount
	LDR R4, =0 ; setting current match count to 0
	
ticketNumber
	CMP R3, #0	; while ( ticketCount != 0 )
	BEQ ticketNumber ; {
	LDRB R5, [R1]	;	load in ticket number
	LDR R6, =DRAW ; start adress of new draw numbers
	LDR R7, = 6 ; drawCount

drawingNumbers
	CMP R7 , #0 ; while drawCount != 0
	BEQ endDrawingNumbers	; {
	LDRB R8, [R6] ; load in draw numbers
	CMP R5, R8 ; if ( ticket number = draw number )
	BNE notEqual	;{
	ADD R4, R4, #1 ; matchCount ++
	B endDrawingNumbers
	
notEqual	;	else
	ADD R6, R6, #1 ; drawNumbers ++
	SUB R7, R7,#1 ; drawCount--
	B drawingNumbers ; }
	
endDrawingNumbers ;
	ADD R1, R1, #1 ; TICKETS++
	SUB R3, R3, #1	; ticketCount--
	B ticketNumber ;

endTicketNumber ; }
	SUB R2, R2, #1 ; NumberOfTickets--
	CMP R4, #4 ; if ( matchCount >= 4)
	BLO findNextTicket ; {
	
	CMP R4, #6 ; if ( matchCount = 6 )
	BNE notMATCH6 ; {
	LDR R9, =MATCH6 ;
	LDRB R10, [R9]	; load in previous number of MATCH6  tickets
	ADD R10, R10, #1 ; MATCH6++
	STRB R10, [R9] ; }
	B findNextTicket

notMATCH6
	CMP R4, #5 ; if ( matchCount = 5 )
	BNE notMATCH5 ; {
	LDR R9, =MATCH5 ;
	LDRB R10, [R9] ; load in previous number of MATCH5 tickets
	ADD R10, R10, #1 ; MATCH5++
	STRB R10, [R9] ; }
	B findNextTicket
	
notMATCH5 ; if (matchCount = 4 )
	;LDR R9, MATCH4 ;
	;LDRB R10, [R9] ; load in previous number of MATCH4 tickets
	;ADD R10, R10, #1 ; MATCH4++
	;STRB R10, [R9] ; }
	
findNextTicket ; }
	CMP R2, #0 ; if ( number of tickets remaining > 0 )
	BEQ ended ; go to ticket and go through whole loop again
	B ticket ;
	
ended
	
		
stop	B	stop 



	AREA	TestData, DATA, READWRITE
	
COUNT	DCD	3			; Number of Tickets
TICKETS	DCB	3, 8, 11, 21, 22, 31	; Tickets
	DCB	7, 23, 25, 28, 29, 32
	DCB	10, 11, 12, 22, 26, 30
	

DRAW	DCB	10, 11, 12, 22, 26, 30	; Lottery Draw

MATCH4	DCD	0
MATCH5	DCD	0
MATCH6	DCD	0

	END	
