; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
#include "p16f628a.inc"

; CONFIG
; __config 0xFF70
 __CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF

 ;Usando MEMORIA
 CBLOCK	0x20
    FLAGS
    FILTRO
    UNIDADE  ;0x22
 ENDC
 
;SAIDA
 #define 
;Constantes  
 V_FILTRO   equ	    .100

;----- progmrama ------
RES_VECT  CODE    0x0000            ; vetor de reset indica a posição inicial do programa da memoria flash
    BSF	    STATUS,RP0		    ; selecionando o banco 1 da memoria RAM
    MOVLW   B'00000000'		    ;W = B'11110000'	(240)
    MOVWF   TRISB		    ;TRISB = B'11110000'	(240)
    BCF	    STATUS,RP0		    ; selecionando banco 0 da memoria ram
    CLRF    UNIDADE		    ; ZERA UNIDADE
    MOVF    UNIDADE,W		    ; MOVE UNIDADE PARA W
    CALL    ESCREVE_DISPLAY	    ; Chama função para escrever no display
    ;CLRF    NUMERO		    ; ZERA (PORTB) = 0	    ; apaga a lampada  (reseta o bit 0)
_ZERA_JA_LI
    BCF	    Ja_Li		    ; Zera a variavel JA_LI
    MOVLW   V_FILTRO		    ; w = 50
    MOVWF   FILTRO		    ; FIltro = 50
_LE_BOTAO
    BTFSC   BOTAO		    ; le e testa o bit 1 do PORTA
    GOTO    _ZERA_JA_LI		    ; volta no zera ja li			  
    BTFSC   Ja_Li	
    GOTO    _LE_BOTAO
    DECFSZ  FILTRO,F		    ;decremente filtro e volta para f
    GOTO    _LE_BOTAO
    BSF	    Ja_Li
    INCF    UNIDADE,F		    ; UNIDADE ++
    MOVLW  .10		;W = 10    	    ;FLAGS DA ULA (C,Z,DC) (C QUANDO ESTOURA A SOMA DO BIT), (Z -> ZERO) e (DC FOI 1 NO MEIO DO CAMINHO?,DO 4 PARA QUINTO)
    SUBWF   UNIDADE,W		    ; W = UNIDADE - W
    BTFSC   STATUS,C		    ;TESTA O BIT C QUE ESTA EM STATUS (TESTE NEGATIVO)
    CLRF    UNIDADE		    ;ZERA UNIDADE
    MOVF    UNIDADE,W		    ; MOVE UNIDADE PARA W
    CALL    ESCREVE_DISPLAY	    ; Chama função para escrever no display
    MOVWF   NUMERO		    ; MOVENDO PARA PORTB QUE [E NUMERO
    GOTO    _LE_BOTAO
    
ESCREVE_DISPLAY
    CALL    BUSCA_CODIGO	    ; CHAMANDO FUNÇÃO BUSCA CODIGO
    MOVWF   NUMERO		    ;NUMERO = W (CODIGO DE 7 SEGMENTOS)
    RETURN			    ; RETORNA NA CHAMADA DE ROTINA
BUSCA_CODIGO
    ADDWF   PCL,F
    RETLW   .254
    RETLW   .56
    RETLW   .221
    RETLW   .125
    RETLW   .59
    RETLW   .119
    RETLW   .247
    RETLW   .60
    RETLW   .255
    RETLW   .127
    
END