; PIC16F628A Configuration Bit Settings
; Assembly source line config statements
#include "p16f628a.inc"
; CONFIG
; __config 0xFF70
 __CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF

 #define BANK0	BCF STATUS,RP0
 #define BANK1	BSF STATUS,RP0
 #define bt1	PORTA,1
 #define bt2	PORTA,2
 #define bt3	PORTA,3
 ;nomeando posição da memória RAM
 CBLOCK	0x20
    DELAY_1	;0x20
    DELAY_2	;0x21
    DELAY_3	;0x22
    DELAY_4	;0x23
 ENDC
 
;saídas
#define LED	    PORTA,0	    
 
;constantes 
V_DELAY_1   equ	    .125
V_DELAY_2   equ	    .250
V_DELAY_3   equ	    .132
V_DELAY_4   equ	    .250
   
;=== programa ==============
RES_VECT  CODE    0x0000    ;vetor de reset, indica a posição inicial do programa na FLASH
    BANK1	    	    ;seleciona o banco 1 da memória RAM
    BCF	    TRISA,0	    ;configura o bir 0 do PORTA como saída
    BCF	    LED	
    BANK0		    ;seleciona o banco 0 da memória RAM
    
LACO_PRINCIPAL
    BTFSS   bt1
    GOTO    PISCA_500MS
    BTFSS   bt2
    GOTO    PISCA_200MS
    BTFSS   bt3
    GOTO    DESLIGA_LED
    GOTO    LACO_PRINCIPAL  ;pula para repetir    
    
DELAY_500MS
    MOVLW   V_DELAY_1		;W = V_DELAY_1				(1)
    MOVWF   DELAY_1		;DELAY_1 = V_DELAY_1			(1)
CARREGA_DELAY_2
    MOVLW   V_DELAY_2		;W = V_DELAY_2				(1)
    MOVWF   DELAY_2		;DELAY_2 = V_DELAY_2			(1)
DECREMENTA_DELAY_2 
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    DECFSZ  DELAY_2,F		;decrementa e testa se DELAY_2 zerou	(1/2)
    GOTO    DECREMENTA_DELAY_2	;se não zerou, decrementa de novo	(2)
    DECFSZ  DELAY_1,F		;decrementa e testa se DELAY_1 zerou	(1/2)
    GOTO    CARREGA_DELAY_2	;se não zerou, repete tudo		(2)
    RETURN			;					(2)
    
DELAY_200MS
    MOVLW   V_DELAY_3		;W = V_DELAY_1				(1)
    MOVWF   DELAY_3		;DELAY_1 = V_DELAY_1			(1)
CARREGA_DELAY_4
    MOVLW   V_DELAY_4		;W = V_DELAY_2				(1)
    MOVWF   DELAY_4		;DELAY_2 = V_DELAY_2			(1)
DECREMENTA_DELAY_4 
    NOP
    NOP
    NOP
    DECFSZ  DELAY_4,F		;decrementa e testa se DELAY_2 zerou	(1/2)
    GOTO    DECREMENTA_DELAY_4	;se não zerou, decrementa de novo	(2)
    DECFSZ  DELAY_3,F		;decrementa e testa se DELAY_1 zerou	(1/2)
    GOTO    CARREGA_DELAY_4	;se não zerou, repete tudo		(2)
    RETURN   

PISCA_200MS
    BTFSS   bt3
    GOTO    LACO_PRINCIPAL 
    BSF	    LED		    ;liga a lâmpada conectada no pino 0 do PORTA
    CALL    DELAY_200MS	    ;chama a subrotina de delay
    BCF	    LED		    ;apaga a lâmpada conectada no pino 0 do PORTA
    CALL    DELAY_200MS	    ;chama a subrotina de delay
    GOTO    PISCA_200MS  ;pula para repetir
    
PISCA_500MS
    BTFSS   bt3
    GOTO    LACO_PRINCIPAL 
    BSF	    LED		    ;liga a lâmpada conectada no pino 0 do PORTA
    CALL    DELAY_500MS	    ;chama a subrotina de delay
    BCF	    LED		    ;apaga a lâmpada conectada no pino 0 do PORTA
    CALL    DELAY_500MS	    ;chama a subrotina de delay
    GOTO    PISCA_500MS  ;pula para repetir
    
DESLIGA_LED
    BTFSS   bt3
    BCF	    LED
    GOTO    LACO_PRINCIPAL    
 
    
END