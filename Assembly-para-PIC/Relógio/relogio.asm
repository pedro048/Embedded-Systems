#include <P18F4550.INC>

cont_segundos_unidad		equ			0x0D
cont_segundos_dezen			equ			0x20
cont_minutos_unidad			equ			0x21
cont_minutos_dezen			equ			0x22
cont_horas_unidad			equ			0x23
cont_horas_dezen			equ			0x24


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
incf		cont_segundos_unidad, 1
retfie		FAST

org			0x18

bcf			PIR1, TMR1IF
movlw		0xE2
movwf		TMR1H
movlw		0xAC
movwf		TMR1L

movf	  	cont_segundos_dezen, W
RCALL		tabela	
bcf			PORTB, 5
movwf		PORTD
bsf			PORTB, 4

movf		cont_minutos_unidad, W
RCALL		tabela
bcf			PORTB, 3
movwf		PORTC
bsf			PORTB, 2

movf		cont_horas_unidad, W
RCALL		tabela
bcf			PORTB, 1
movwf		PORTA
bsf			PORTB, 0

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

movlw		B'00000000'
movwf		TRISD
movlw		B'00000000'
movwf		TRISC
movlw		B'00000000'
movwf		TRISA
movlw		B'00000000'
movwf		TRISB

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

movlw		B'10000111'
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
CPFSEQ		cont_segundos_unidad
goto		unidad_seg
goto		limpar_unidad_seg

unidad_seg:

movf		cont_segundos_unidad, W
RCALL		tabela
bcf			PORTB, 4
movwf		PORTD		
bsf			PORTB, 5

movf		cont_minutos_unidad, W
RCALL		tabela
bcf			PORTB, 2
movwf		PORTC
bsf			PORTB, 3

movf		cont_horas_unidad, W
RCALL		tabela
bcf			PORTB, 0
movwf		PORTA
bsf			PORTB, 1

goto		loop

limpar_unidad_seg:

clrf	    cont_segundos_unidad
movlw		0x05
CPFSEQ		cont_segundos_dezen
goto		incrementa_deze_seg
goto		limpa_deze_seg

incrementa_deze_seg:

incf		cont_segundos_dezen, 1		
goto		loop

limpa_deze_seg:

clrf		cont_segundos_dezen
incf		cont_minutos_unidad, 1
movlw		0x0A
CPFSEQ		cont_minutos_unidad
goto		loop
clrf		cont_minutos_unidad
movlw		0x05
CPFSEQ		cont_minutos_dezen
goto		incrementa_deze_minutos
goto		limpa_deze_minutos

incrementa_deze_minutos:

incf		cont_minutos_dezen, 1
goto		loop

limpa_deze_minutos:

clrf		cont_minutos_dezen
incf		cont_horas_unidad, 1
movlw		0x0A
CPFSEQ		cont_horas_unidad
goto		analise_unidad_hora
clrf		cont_horas_unidad
incf		cont_horas_dezen, 1
goto		loop

analise_unidad_hora:

movlw		0x02
CPFSEQ		cont_horas_dezen
goto		loop
movlw		0x03
CPFSEQ		cont_horas_unidad
goto		loop
clrf		cont_horas_unidad
clrf		cont_horas_dezen
goto		loop



END