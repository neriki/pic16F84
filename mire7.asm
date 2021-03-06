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
CPTL3 EQU H'0F'
TRISA	EQU	H'85'
TRISB	EQU	H'86'

	ORG	0000
	BSF STATUS, 5
	MOVLW	H'00'
	MOVWF	TRISB
	BCF STATUS, 5

;##########################################################################
;#############################premiere trame###############################
;##########################################################################

;#############################Synchro verticale############################
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

;##########################post egalisation###############################

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

;##########################serie de ligne trame 1#########################

	movlw H'05'
	movwf CPTL3
	nop
	nop
	bsf PORTB, 2
	nop
	nop
IMGL1	movlw H'0A'
	movwf CPTL1
	bsf PORTB, 0
	movlw H'32'
	movwf CPTL2
	
	movlw H'6'
	movwf CPT
LOOPLH1	nop
	nop
	decfsz CPT
	goto LOOPLH1
	bcf PORTB, 0
	nop
	bcf PORTB, 2
	nop
	nop
	nop
	nop
	bsf PORTB,2
	call LIGNEH
	nop
	nop
	nop
	bsf PORTB,2
	call LIGNEH
	nop
	nop
	nop
	bsf PORTB,2
	call LIGNEH
	nop
	nop
	nop
	bsf PORTB,2
	call LIGNEH
	nop
	nop
	nop

IMGL11	bsf PORTB, 2
	call LIGNEH
	decfsz CPTL1,1
	goto IMGL11
	nop
IMGL12	BSF PORTB, 2
	call LIGNEV
	decfsz CPTL2,1
	goto IMGL12
	nop
	bsf PORTB, 2
	decfsz CPTL3,1
	goto IMGL1

;###########################pre egalisation################################

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
LOOP5	decfsz CPT
	goto LOOP5
	nop
	nop
	nop
	nop
	bcf PORTB, 2

;##########################################################################
;#############################deuxieme trame###############################
;##########################################################################

;#############################Synchro verticale############################
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

;##########################post egalisation###############################
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

;##########################serie de ligne trame 2#########################

	movlw H'05'
	movwf CPTL3
	nop
	nop
	bsf PORTB, 2
	nop
	nop
IMGL2	movlw H'0A'
	movwf CPTL1
	bsf PORTB, 0
	movlw H'32'
	movwf CPTL2
	
	movlw H'6'
	movwf CPT
LOOPLH2	nop
	nop
	decfsz CPT
	goto LOOPLH2
	bcf PORTB, 0
	nop
	bcf PORTB, 2
	nop
	nop
	nop
	nop
	bsf PORTB,2
	call LIGNEH
	nop
	nop
	nop
	bsf PORTB,2
	call LIGNEH
	nop
	nop
	nop
	bsf PORTB,2
	call LIGNEH
	nop
	nop
	nop

IMGL21	bsf PORTB, 2
	call LIGNEH
	decfsz CPTL1,1
	goto IMGL21
	nop
IMGL22	BSF PORTB, 2
	call LIGNEV
	decfsz CPTL2,1
	goto IMGL22
	nop
	bsf PORTB, 2
	decfsz CPTL3,1
	goto IMGL2
;###########################pre egalisation################################

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

;#################################################################
;################Sous programme trame ligne verticale#############
;#################################################################

LIGNEV	nop
	movlw H'A'
	movwf CPT
LOOPLV	bsf PORTB, 0
	bcf PORTB, 0
	decfsz CPT
	goto LOOPLV
	nop
	nop
	nop
	bcf PORTB, 2
	return

;#################################################################
;################Sous programme trame ligne horizontale###########
;#################################################################

LIGNEH	nop
	movlw H'0A'
	movwf CPT
	bsf PORTB, 0
LOOPLH	nop
	nop
	decfsz CPT
	goto LOOPLH
	bcf PORTB, 0
	nop
	bcf PORTB, 2
	return

;#################################################################
;##############Sous programme pre post egalisation################
;#################################################################

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

;################################################################
;#############Sous programme synchro verticale###################
;################################################################

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
	