TMR0	EQU	H'01'
PCL	EQU	H'02'
STATUS	EQU	H'03'
FSR	EQU	H'04'
PORTA	EQU	H'05'
PORTB	EQU	H'06'
EEDATA	EQU	H'08'
EEADR	EQU	H'09'
PCLATH	EQU	H'0A'
INCON	EQU	H'0B'
CPT EQU H'0C'
CPTL1 EQU H'0D'
CPTL2 EQU H'0E'
DELAI EQU H'0F'
TRISA	EQU	H'85'
TRISB	EQU	H'86'

	ORG	0000
	BSF STATUS, 5
	MOVLW	H'00'
	MOVWF	TRISB
	BCF STATUS, 5
	
IMAGE	bcf PORTB, 2
	nop
	nop
	call SYNCV
	call SYNCV
	call SYNCV
	call SYNCV

	nop
	nop
	movlw 7
	movwf CPT
LOOP3	decfsz CPT
	goto LOOP3
	bsf PORTB, 2
	nop
	nop
	nop
	nop
	bcf PORTB, 2
	nop
	nop
	bsf PORTB, 2
	movlw 7
	movwf CPT
LOOP4	decfsz CPT
	goto LOOP4
	nop
	nop
	nop
	nop

	call PREE
	call PREE
	call PREE
	call PREE
	
	bcf PORTB, 2

	movlw H'32'
	movwf CPTL2
	movlw H'FF'
	movwf CPTL1
IMG1	bsf PORTB, 2
	call LIGNE
	decfsz CPTL1,1
	goto IMG1
	nop
IMG2	BSF PORTB, 2
	call LIGNE
	decfsz CPTL2,1
	goto IMG2

	call PREE
	call PREE
	call PREE
	call PREE


	;call PREE
	nop
	nop
	bcf PORTB, 2
	nop
	nop
	bsf PORTB, 2
	movlw 7
	movwf CPT
LOOP5	decfsz CPT
	goto LOOP5
	nop
	nop
	nop
	nop
	bcf PORTB, 2
	nop
	nop
	call SYNCV
	call SYNCV
	call SYNCV
	call SYNCV


	nop
	nop
	movlw 7
	movwf CPT
LOOP6	decfsz CPT
	goto LOOP6
	bsf PORTB, 2
	nop
	nop
	nop
	nop
	bcf PORTB, 2
	nop
	nop
	bsf PORTB, 2
	movlw 7
	movwf CPT
LOOP7	decfsz CPT
	goto LOOP7
	nop
	nop
	nop
	nop

	call PREE
	call PREE
	call PREE
	call PREE
	call PREE
	
	bcf PORTB, 2

	movlw H'31'
	movwf CPTL2
	movlw H'FF'
	movwf CPTL1
IMG3	bsf PORTB, 2
	call LIGNE
	decfsz CPTL1,1
	goto IMG3
	nop
IMG4	BSF PORTB, 2
	call LIGNE
	decfsz CPTL2,1
	goto IMG4


	call PREE
	call PREE
	call PREE
	call PREE
	call PREE

	nop
	nop
	bcf PORTB, 2
	nop
	nop
	bsf PORTB, 2
	movlw 7
	movwf CPT
LOOP8	decfsz CPT
	goto LOOP8
	nop
	nop	

	goto IMAGE

LIGNE	nop
	movlw H'A'
	movwf CPT
LOOPL	bsf PORTB, 0
	bcf PORTB, 0
	decfsz CPT
	goto LOOPL
	nop
	nop
	nop
	bcf PORTB, 2
	return

PREE	bcf PORTB, 2
	nop
	nop
	bsf PORTB, 2
	movlw 7
	movwf CPT
LOOP2	decfsz CPT
	goto LOOP2
	nop
	nop
	return

SYNCV	movlw 7
	movwf CPT
LOOP1	decfsz CPT
	goto LOOP1
	bsf PORTB, 2
	nop
	nop
	nop
	nop
	bcf PORTB, 2
	return

	end
	