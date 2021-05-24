	.include"m8535def.inc"
	.def aux = r16
	.def aux2 = r17
	.def auxH = r18
	.def auxL = r19
	.def cont =r20

reset:
	rjmp main
	.org $008
	rjmp onda2
	rjmp onda
main:
	ldi aux,low(RAMEND)
	out spl,aux
	ldi aux,high(RAMEND)
	out sph,aux
	rcall config_io
fin:
	nop
	nop
	rjmp fin
config_io:
	ldi cont,0
	ser aux
	out ddra,aux
	out ddrc,aux
	ldi aux,1
	out tccr0,aux
	out tccr1b,aux
	ldi aux,1; 0000 0001
	out timsk,aux; toie0
	ldi aux2,215
	ldi auxH,$FC
	ldi auxL,$23
	out tcnt0,aux2
	out tcnt1H,auxH
	out tcnt1L,auxL
	sei
	ret
onda:
	nop
	nop
	out tcnt0,aux2
	in aux,pina
	com aux
	out porta,aux
	inc cont
	cpi cont,20
	breq cambio 
	reti
onda2:
;	nop
	out tcnt1H,auxH
	out tcnt1L,auxL
	in aux,pinc
	com aux
	out portc,aux
	ldi aux,1; 0000 0001
	out timsk,aux; toie0
	reti
cambio:
	ldi aux,4; 0000 0001
	out timsk,aux; toie0
	clr cont
	reti
		
