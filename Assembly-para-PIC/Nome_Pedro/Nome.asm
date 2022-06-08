#include <P18F4550.INC>

contador    equ	    0x0D

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
incf		contador, 1
retfie		FAST

tabela:

andlw		B'00001111'
RLNCF		WREG, W
addwf		PCL, F

;			  PGFEDCBA
RETLW		B'01110011' ; letra P
RETLW		B'01111001' ; letra E
RETLW		B'00001111' ; letra D
RETLW		B'01110111' ; letra R
RETLW		B'00111111' ; letra O


inicio:

movlw		B'00000000'
movwf		TRISD
movlw		B'00000000'
movwf		TRISB

movlw		0x0F
movwf		ADCON1

movlw		0x85
movwf		TMR0H
movlw		0xEE
movwf		TMR0L

movlw		B'10000101'
movwf		T0CON

movlw		B'10000100'
movwf		INTCON2
movlw		B'11100000'
movwf		INTCON


loop:

movlw		0x00
CPFSEQ		contador
goto		outras_letras_e_d_r_o
goto		letra_P

letra_P:
movlw		B'00000001'
movwf		PORTB
movf		contador, W
RCALL		tabela
movwf		PORTD
goto	    loop

outras_letras_e_d_r_o:

movlw		0x01
CPFSEQ		contador
goto		outras_letras_d_r_o
goto		letra_E

letra_E:

movlw		B'00000010'
movwf		PORTB
movf		contador, W
RCALL		tabela
movwf		PORTD
goto	    loop

outras_letras_d_r_o:

movlw		0x02
CPFSEQ		contador
goto		outras_letras_r_o
goto		letra_D

letra_D:

movlw		B'00000100'
movwf		PORTB
movf		contador, W
RCALL		tabela
movwf		PORTD
goto	    loop

outras_letras_r_o:

movlw		0x03
CPFSEQ		contador
goto		outras_letras_o
goto		letra_R

letra_R:

movlw		B'00001000'
movwf		PORTB
movf		contador, W
RCALL		tabela
movwf		PORTD
goto	    loop

outras_letras_o:

movlw		0x04
CPFSEQ		contador
goto		limpar
goto		letra_O

letra_O:

movlw		B'00010000'
movwf		PORTB
movf		contador, W
RCALL		tabela
movwf		PORTD
goto	    loop

limpar:

clrf		contador
clrf		PORTD
goto		loop


end

