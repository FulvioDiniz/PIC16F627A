; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
#include "p16f628a.inc"

; CONFIG
; __config 0xFF70
 __CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF

 
#DEFINE BANK0	BCF	    STATUS,RP0
#DEFINE BANK1	BSF	    STATUS,RP0
 ;Usando MEMORIA
 CBLOCK	0x20
    DELAY_1
    DELAY_2
 ENDC
 
;SAIDA
 #define LED PORTA,0
;Constantes  
V_DELAY_1   equ	    .255
V_DELAY_2   equ	    .255

;----- progmrama ------
RES_VECT  CODE    0x0000            
    BCF	    STATUS,RP0
    BCF	    TRISA,0
    BSF	    STATUS,RP0
LACO_PRINCIPAL
    BSF	    LED			;LIGA LAMPADA
    CALL    DELAY_500MS	    	;SUBOTINA
    BCF	    LED			;apaga led
    CALL    DELAY_500MS		;SUBROTINA
    GOTO    LACO_PRINCIPAL	;VOLTA
DELAY_500MS
    MOVLW   V_DELAY_1		; CARREGA CONSTANTE EM W
    MOVWF   DELAY_1
CARREGA_DELAY_2
    MOVLW   V_DELAY_2		; CARREGA CONSTANTE EM W
    MOVWF   DELAY_2
DECREMENTA_DELAY_2
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    DECFSZ  DELAY_2,F		;DECREMENTA E TESTA DELAY_2 ZEROU
    GOTO    DECREMENTA_DELAY_2	;SE N ZEROU PULA PARA DECREMENTAR ATE ZERAR
    DECFSZ  DELAY_1,F		;DECREMENTA E TESTA DELAY_2 ZEROU
    GOTO    DECREMENTA_DELAY_2	;SE N ZEROU PULA PARA DECREMENTAR ATE ZERAR
    RETURN			;
END