; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
#include "p16f628a.inc"

; CONFIG
; __config 0xFF70
 __CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF
RES_VECT  CODE    0x0000            ; processor reset vector
BSF	STATUS,RP0
BCF	TRISB,0
BCF	TRISB,1
BCF	TRISB,2
BCF	TRISB,3
BCF	TRISA,0
BCF	STATUS,RP0
BCF	PORTA,0
BCF	PORTB,0
BCF	PORTB,1
BSF	PORTB,2
BCF	PORTB,3

NO1
  BTFSS	    PORTA,3
  GOTO	    NO2	
NO3
  BTFSC	    PORTA,4
  GOTO	    HORARIOPRESS
  GOTO	    NO4
HORARIOPRESS
  BCF	    PORTB,3
  BTFSC	    PORTA,1
  GOTO	    ANTIHORARIOPRESS
  GOTO	    NO5
ANTIHORARIOPRESS
  BTFSC	    PORTA,2
  GOTO	    NO1
  GOTO	    NO6  
NO2
  BCF	    PORTA,0
  BCF	    PORTB,0
  BCF	    PORTB,1
  BSF	    PORTB,2
  GOTO	    NO1
  
NO4
  BCF	    PORTA,0
  BCF	    PORTB,0
  BCF	    PORTB,1
  BSF	    PORTB,2
  BSF	    PORTB,3  
DESLIGAPRESS
  BTFSC	    PORTA,3
  GOTO	    DESLIGAPRESS
  BCF	    PORTB,2
  GOTO	    NO1 
NO5
  BTFSC	    PORTB,1
  GOTO	    NO1
  BSF	    PORTA,0
  BSF	    PORTB,0 
  BCF	    PORTB,2
  GOTO	    NO1
  
NO6
  BTFSC     PORTB,0
  GOTO	    NO1
  BSF	    PORTA,0
  BSF	    PORTB,1
  BCF	    PORTB,2
  GOTO	    NO1
    
				    ; go to beginning of program
END