#include <P18F4550.INC>

UNIDADDE		 equ			0x2D
DEZENA			 equ			0x0D
TROCAR_DISPLAY   equ			0x21

CONFIG FOSC = HS;
CONFIG PWRT = ON;
CONFIG WDT = OFF;
CONFIG MCLRE = OFF;
CONFIG DEBUG = OFF;
CONFIG LVP = OFF;
;CONFIG BOREN = OFF

org			0x00
goto		inicio


org			0x08

bcf			INTCON, T0IF
movlw		0x85
movwf		TMR0H
movlw		0xEE
movwf		TMR0L
INCF		UNIDADE, 1
retfie		FAST


org			0x18

bcf			PIR1, TMR1IF
movlw		0xE2
movwf		TMR1H
movlw		0xAC
movwf		TMR1L
INCF		TROCAR_DISPLAY, 1
retfie		FAST

tabela:

andlw		B'00001111'
RLNCF		WREG, W
addwf		PCL, F

;			  PGFEDCBA
RETLW		B'00111111' ; N 0
RETLW		B'00000110' ; N 1
RETLW		B'01011011' ; N 2
RETLW		B'01001111' ; N 3
RETLW		B'01100110' ; N 4
RETLW		B'01101101' ; N 5
RETLW		B'01111101' ; N 6
RETLW		B'00000111' ; N 7
RETLW		B'01111111' ; N 8
RETLW		B'01101111' ; N 9



inicio:

movlw 		B'00000000'
movwf		TRISD
bcf			TRISA, 2	; Responsavel por ATIVAR A DEZENA
bcf			TRISA, 3	; Responsavel por ATIVAR A UNIDADE

movlw		0x0F
movwf		ADCON1

movlw		0x85
movwf		TMR0H
movlw		0xEE
movwf		TMR0L
movlw		0xE2
movwf		TMR1H
movlw		0xAC
movwf		TMR1L


movlw		B'10001111'
movwf		T0CON

movlw		B'11110101'
movwf		T1CON

bsf			RCON, IPEN
movlw		B'10000100'
movwf		INTCON2
movlw		B'11100000'
movwf		INTCON
bcf			IPR1, TMR1IP
bsf			PIE1, TMR1IE


loop:

movlw		0x0A
CPFSEQ		UNIDADE
goto		continua
goto		analisa_a_dezena

analisa_a_dezena:

movlw		0x05
CPFSEQ		DEZENA
goto		limpa
goto		limpa_tudo

continua:

movlw		0x00
CPFSEQ		TROCAR_DISPLAY
goto		passa
goto		mostra_dezena

mostra_dezena:

bcf			PORTA, 3
movf		DEZENA, W
RCALL		tabela
movwf		PORTD
bsf			PORTA, 2
goto		loop

passa:

movlw		0x01
CPFSEQ	    TROCAR_DISPLAY
goto		limpa_a_troca
goto		mostra_unidade

mostra_unidade:

bcf			PORTA, 2
movf		UNIDADE, W
RCALL		tabela
movwf		PORTD
bsf			PORTA, 3
goto		loop

limpa_a_troca:

clrf		TROCAR_DISPLAY
goto		loop

limpa:

clrf		UNIDADE
INCF		DEZENA, 1
goto		loop

limpa_tudo:

clrf		UNIDADE
clrf		DEZENA
goto		loop



END



	



	








