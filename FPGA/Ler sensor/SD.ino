#include <avr/io.h>
#include <inttypes.h>

volatile uint16_t T;

int main(){
  
  DDRC &= 0b11111110; //A0 entrada
  
  ADMUX  |= 0b01000000; //Utiliza VCC como referência 
  ADCSRA |= 0b10000000; //Habilita ADC
  
  Serial.begin(9600);
  
  while(1){
  
    ADMUX  &= 0b11110000; //Limpa valores do multiplexador
    ADMUX  |= 0b00000000; //Lendo PC0
    ADCSRA |= 0b01000000; //Inicia a conversão
    while(!(ADCSRA & 0b00010000)); //Até a conversão ADC ser concluida
    T = ADC;

    Serial.println(T);
  }
}
