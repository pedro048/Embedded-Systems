#include <LoRaMESH.h>
#include <SoftwareSerial.h>
#include <stdint.h>

uint16_t localId; 

uint16_t localNet;

uint16_t localUniqueId;

/* IDS dos modulos sensores */
uint16_t LDRID = 3;
uint16_t LEDID = 2;

/* Payload buffer */
uint8_t bufferPayload[MAX_PAYLOAD_SIZE] = {0};

/* Valor de entrada do LDR */
uint16_t AdcIn;

/*Valor configurado para os modulos*/ 
uint16_t baudrate = 9600;

SoftwareSerial* hSerialCommands = NULL;


boolean ledstatus = false;
uint16_t MAXLIGHT = 300; // Configurado conforme ambiente
void setup() {
  Serial.begin(9600); 
  
  /*Inicializa interface serial com modulo mestre*/
  hSerialCommands = SerialCommandsInit(7, 6, baudrate); //rx tx
  
  /* Verificação se está corretamente conectado */
  delay(500);
  while(LocalRead(&localId, &localNet, &localUniqueId) != MESH_OK)
    Serial.print("Nao foi possivel inicializar com LocalID\n\n");
  
  delay(500);
  /* Configuração das portas como entrada analogica no modulo LDR e saída digital no módulo LED */
  if(GpioConfig(LDRID, GPIO6, ANALOG_IN, PULL_OFF) != MESH_OK)
    Serial.print("Erro configurando GPIO6 do LDR\n\n");
  if(GpioConfig(LEDID, GPIO6, DIGITAL_OUT, PULL_OFF) != MESH_OK)
    Serial.print("Erro configurando GPIO6 do LED\n\n");
  
}

void loop() {
  float result;
  delay(500);
  /* Leitura do LDR */
  if(GpioRead(LDRID, GPIO6, &AdcIn) != MESH_OK)
    Serial.print("\nErro de comunicacao com LDR\n\n");
  else
  {
    result = float(AdcIn);
    Serial.print("\nLDR: ");
    Serial.println(result);
    if(result>MAXLIGHT){ // Valor de máximo 
      if(ledstatus==true){
        //Escrita no módulo LED
        if(GpioWrite(LEDID, GPIO6,0) != MESH_OK)
          Serial.print("\nErro de comunicacao com LED\n\n");
       else
          ledstatus = false;
      }
    }
    else{
      if(ledstatus == false){
        //Escrita no módulo LED
        if(GpioWrite(LEDID, GPIO6,1) != MESH_OK)
          Serial.print("\nErro de comunicacao com LED\n\n");
        else
          ledstatus = true;
      }
    }
  }
}
