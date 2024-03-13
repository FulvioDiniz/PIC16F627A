; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
#include "p16f628a.inc"

; CONFIG
; __config 0xFF70
 __CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF

 ;Usando MEMORIA
 CBLOCK	0x20
    FLAGS
    FILTRO
 ENDC
 
 #define    Ja_Li   FLAGS,0   ; nome do bit 0 da memoria 0x20 da FLAGS
 
 
 V_FILTRO   equ	    .100

RES_VECT  CODE    0x0000            ; vetor de reset indica a posição inicial do programa da memoria flash
    BSF	    STATUS,RP0		    ; selecionando o banco 1 da memoria RAM
    BCF	    TRISA,0		    ; configurando o pino 0 da porta como saida
    BCF	    STATUS,RP0		    ; selecionando banco 0 da memoria ram
    BCF	    PORTB,0		    ; apaga a lampada  (reseta o bit 0)
_ZERA_JA_LI
    BCF	    Ja_Li		    ; Zera a variavel JA_LI
    MOVLW   V_FILTRO			    ; w = 50
    MOVWF   FILTRO		    ; FIltro = 50
_LE_BOTAO
    BTFSC   PORTB,1		    ; le e testa o bit 1 do PORTA
    GOTO    _ZERA_JA_LI		    ; se 1 pula para _LE_BOTAO
    BTFSC   Ja_Li		    ; SE VALE 0 PULA
    GOTO    _LE_BOTAO
    DECFSZ  FILTRO,F		    ;decremente filtro e volta para f
    GOTO    _LE_BOTAO
    BSF	    Ja_Li		    ; colo 1 no jali
    BTFSS   PORTB,0
    GOTO    _ACENDE_LAMP		    ; se 0 pula para ACENDE_LAMP
    BCF	    PORTB,0
    GOTO    _LE_BOTAO		    
    
_ACENDE_LAMP
    BSF	    PORTB,0
    GOTO    _LE_BOTAO
       
END