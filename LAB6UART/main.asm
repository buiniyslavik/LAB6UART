.include "m328Pdef.inc" 
.org 0 
  jmp Reset 
.org 0x002 
  jmp knopka 
.org 0x004
	jmp pingas
Reset: 
  ldi r16,low(RAMEND) 
  out spl,r16 
  ldi r16,high(RAMEND)  
  out sph,r16 
  ldi r16, 0x0f 
  sts EICRA, r16 
  ldi r16, 0x03 
  out EIMSK, r16 
  cbi ddrd, 2 
  cbi ddrd, 3 
  ldi r16, 0xff 
  out ddrc, r16 
.equ CLK=16000000 
.equ BAUD=9600 
.equ UBRR0_value = (CLK/(BAUD*16)) - 1 
  ldi r16, high(UBRR0_value) 
  sts UBRR0H, r16 
  ldi r16, low(UBRR0_value) 
  sts UBRR0L, r16 
  ldi r16, 0x18;(1<<TXEN0|RXEN0)           
  sts UCSR0B,R16 
  ldi r16,(1<< UCSZ00)|(1<< UCSZ01) 
  sts UCSR0C,R16             
  ldi r24,0 
  out DDRD,r24 
  ldi r24,0x0C 
  out PORTD,r24
  
  ;ldi r24, 0x10
  sbi DDRB, 5
  cbi PORTB, 5
  
  sei  
main: jmp main 
knopka:    
  ;ldi r16, 0x77 
  ;sts   UDR0,r16 
  cbi PORTB, 0x05
  lds r16, UDR0
  sts UDR0, r16
  cpi r16, 0x33
  brne lightoff
	sbi PORTB, 0x05
  lightoff:
  Reti 

pingas:
	ldi r16, 0x76
	sts UDR0, r16