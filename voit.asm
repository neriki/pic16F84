TMR0	EQU	H'01'
PCL	EQU	H'02'
STATUS	EQU	H'03'
FSR	EQU	H'04'
PORTA	EQU	H'05'
PORTB	EQU	H'06'
EEDATA	EQU	H'08'
EEADR	EQU	H'09'
PCLATH	EQU	H'0A'
INTCON	EQU	H'0B'
DUREE EQU H'0C'
CPT EQU H'0D'
REF EQU H'0E'
DELAI EQU H'0F'
BOUCLE EQU H'10'
ANTIR	EQU	H'11'
ANTIR2	EQU	H'12'
TRISA	EQU	H'85'
TRISB	EQU	H'86'

	ORG	0000
	goto INIT
	
	ORG 4
	;programme d'interuption
	; on teste si ANTIR2 est egal à 0 et on execute l'interuption
	;qu'a cette condition
	movf ANTIR2,1
	btfss STATUS,2
	goto RETINT
	;on initialise ANTIR a FF
	movlw H'FF'
	movwf ANTIR
	; on initialise ANTIR2 a une certaine valeur
	movlw H'10'
	movwf ANTIR2

	;on regarde si le port b3 est allumée
	btfsc PORTB,3
	goto FINCYC
	;si il est eteint, on sauvegarde la valeur de DUREE dans REF
	movf DUREE,0
	movwf REF
	; et on allume le port b3
	bsf PORTB,3
	goto RETINT
	; si le port B3 est allumée, on l'eteint
FINCYC	bcf PORTB,3
RETINT	bcf INTCON,1
	retfie

INIT	BSF STATUS, 5
	MOVLW	H'03'
	MOVWF	TRISB
	BCF STATUS, 5
	
	;initialisation des interuptions
	bsf INTCON,4
	bsf INTCON,7	
	
	bcf PORTB,3
	bcf PORTB,2

PRINC	nop
	;bcf PORTB, 2

	;boucle d'attente
	movlw H'19'
	movwf BOUCLE
LOOP	nop
	decfsz BOUCLE,1
	goto LOOP

	;decrementation du compteur antirebon 
	movf ANTIR,1
	btfsc STATUS,2
	goto DECAR
	decf ANTIR,1
	goto FINAR
DECAR	movf ANTIR2,1
	btfss STATUS,2
	decf ANTIR2,1
	movlw H'FF'
	movwf ANTIR
FINAR	nop

	call MESURE
	call REACT
	nop

	;boucle d'attente
	movlw H'19'
	movwf BOUCLE
LOOP1	nop
	decfsz BOUCLE,1
	goto LOOP1

	goto PRINC

	;sous programme de mesure du temp.
MESURE	btfss PORTB,1
	;si le signal est à 1, on incremente CPT
	goto STOP
	incf CPT,1
	;Si CPT atteint 255, on met REF dans CPT
	;Comme ca il n'y a pas de debordement de valeur 
	movlw H'FF'
	subwf CPT,0
	btfss STATUS,2
	goto RETOUR
	movf REF, 0
	movwf CPT
	goto RETOUR	
STOP    ;si le signal revient à 0
	;on verifie que le compteur n'est pas a zero
	movf CPT,1
	btfsc STATUS,2
	goto RETOUR
	;on sauvegarde la valeur du compteur
	movf CPT,0
	movwf DUREE
	;on reinitialise le compteur à 0
	movlw 0
	movwf CPT
RETOUR	return

REACT	btfss PORTB,3
	;teste si le port b3 est allumée, donc si on réagit
	goto FINBIP
	;si DUREE<REF alors
	movf REF, 0
	subwf DUREE, 0
	btfsc STATUS,0
	goto FINBIP
	;on bippe
	bsf PORTB,2
	goto RETOUR1
FINBIP	bcf PORTB,2
RETOUR1	return



	end
	
