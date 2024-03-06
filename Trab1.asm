    
; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
#include "p16f628a.inc"

; CONFIG
; __config 0xFF70
 __CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF
 
  CBLOCK	0x20
    FLAGS1
    FLAGS2
    FLAGS3
    FLAGS4  
 ENDC
 
 
#define    BT1_TESTE   FLAGS1,0 
#define    BT2_TESTE   FLAGS2,0 
#define    BT3_TESTE   FLAGS3,0 
#define    BT4_TESTE   FLAGS4,0 
 

RES_VECT  CODE    0x0000            ; processor reset vector
    BSF	    STATUS,RP0		    ; selecionando o banco 1 da memoria RAM
    BCF	    TRISB,0		    ; configurando o pino 0 da porta como saida
    BCF	    STATUS,RP0		    ; selecionando banco 0 da memoria ram
    BCF	    PORTB,0    
    BSF	    STATUS,RP1
    BCF	    TRISA,0
    BCF	    STATUS,RP1
    BCF	    PORTA,1    
LE_BOTAO
    BTFSS   PORTA,1
    BCF	    PORTB,0
    GOTO    ACENDE_LED1
ACENDE_LED1
    BSF	    PORTB,0 
        
END
   


