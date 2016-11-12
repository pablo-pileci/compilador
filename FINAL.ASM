.MODEL LARGE ;
.386 ;
.STACK 200h ;


.DATA
	MAXTEXTSIZE EQU 50
	msgPRESIONE DB 0DH,0AH, "presione una tecla para continuar..." ,'$'
	NEWLINE    DB 0Dh,0Ah,'$'
	PUNTO       DB ".$"
	GUION       DB "-" ,'$'
	&1    dd   1
	&0    dd   0
	_&leftCond     dd    0 
	_&rightCond    dd    0 
	&cad1 db 30 dup (?),'$'
	&cad2 db 30 dup (?),'$'
	&inc_aux dd ? 
	&aux_f dd 1000 
	&aux_prec dd 100000 
	&auxN dd 0 
	aux_trunc dd 0 
	truncn dw 0 
	truncv dw 0 
	variableInt 	 DD 	 ? 
	variableString 	 DB 	 50 dup('$') 
	inputString 	 DB 	 50 dup('$') 
	concatenada 	 DB 	 50 dup('$') 
	mensaje 	 DB 	 50 dup('$') 
	_Ingrese_parte_1_ 	 DB 	 "Ingrese parte 1 " , 50 dup('$') 
	_Ingrese_parte_2_ 	 DB 	 "Ingrese parte 2 " , 50 dup('$') 
	_La_union_es_ 	 DB 	 "La union es " , 50 dup('$') 
	@aux10 	 DB 	 50 dup('$') 
	@aux15 	 DB 	 50 dup('$') 


 .CODE ; Zona de codigo

	 ;***STRLEN***
	 STRLEN PROC
		 mov bx,0
		 STRL:
			 cmp BYTE PTR [SI+BX],"$"
			 je STREND
			 inc BX
			 jmp STRL
		 STREND:
			 ret
	 STRLEN ENDP 

	 ;***COPIAR***
	 COPIAR PROC
		call STRLEN  ;***STRLEN***
			 cmp bx,MAXTEXTSIZE
			 jle COPIARSIZEOK
			 mov bx,MAXTEXTSIZE
		 COPIARSIZEOK:
			 mov cx,bx ; la copia se hace de ’CX’ caracteres
			 cld ; cld es para que la copia se realice hacia adelante
			 rep movsb ; copia la cadea
			 mov al,"$" ; carácter terminador
			 mov BYTE PTR [DI],al
			 ret
	 COPIAR ENDP

	 ;***CONCAT***
	 CONCAT PROC
	 push ds
		 push si
		 call STRLEN  ;***STRLEN***
		 mov dx,bx ; guardo en DX la cantidad de caracteres en el origen.
		 mov si,di
		 push es
		 pop ds
		 call STRLEN  ;***STRLEN***
		 add di,bx ; DI ya queda apuntando al final delprimer string
		 add bx,dx ; tamaño total
		 cmp bx,MAXTEXTSIZE ; excede el tamaño maximo
		 jg CONCATSIZEMAL
		 CONCATSIZEOK: ; La suma no excede el maximo, copio todos
			 mov cx,dx ; los caracteres del segundo string.
			 jmp CONCATSIGO
		 CONCATSIZEMAL: ; La suma de caracteres de los 2 strings exceden el maximo
			 sub bx,MAXTEXTSIZE
			 sub dx,bx
			 mov cx,dx ; copio lo maximo permitido el resto se pierde.
		 CONCATSIGO:
			 push ds
			 pop es
			 pop si
			 pop ds
			 cld ; cld es para que la copia se realice hacia adelante
			 rep movsb ; copia la cadea
			 mov al,"$" ; carácter terminador
			 mov BYTE PTR [DI],al ; el regis>
				ret
	CONCAT ENDP

	;***DisplayINT***
	DisplayINT PROC
		 xor edx,edx
		 div ecx
		 add DL,30H
		 mov [di],dl ;lo pasa a cadena
		 inc di ;inc 1 a cadena
		 add &inc_aux,1
		 ret
	DisplayINT ENDP 

	E_display PROC 
		 call DisplayINT 
		 cmp eax,0
		 jne E_display
		 lea di,&cad2 ;cadena fuente
		 mov ebx,&inc_aux
		 mov cx,di
		 add ecx,ebx
		 mov di, cx
		 mov al,'$'
		 mov byte ptr [di],al
		 dec di
		 mov ecx,&inc_aux
		 lea si,&cad1 ;cadena fuente
		 repite:
			 lodsb ;pone en al un caracter
			 mov [di],al ;lo pasa a cad2
			 dec di ;resto 1 a cad2
		 loop repite
		 MOV AX, SEG &cad2 
		 MOV DS, AX 
		 MOV DX, OFFSET &cad2
		 MOV AH, 9 
		 INT 21h ; Imprime
		 ret
	E_display ENDP

	FLOAT_INT PROC 
		 rcl  eax,1;   //left shift acc to remove the sign
		 mov  ebx,eax; //save the acc
		 mov  edx,4278190080; //clear reg edx;4278190080
		 and  eax,edx; //and acc to retrieve the exponent
		 shr  eax,24;
		 sub  eax,7fh; //subtract 7fh(127) to get the actual power
		 mov  edx,eax; //save acc val power
		 mov  eax,ebx; //retrieve from ebx
		 rcl  eax,8;     //trim the left 8 bits that contain the power
		 mov  ebx,eax; //store
		 mov  ecx, 1fh; //subtract 17 h
		 sub  ecx,edx;
		 mov  edx,00000000h;
		 cmp  ecx,0;
		 je   loop2;
		 shr  eax,1;
		 or   eax,80000000h;
		 loop1:   
			 shr  eax,1; //shift (total bits - power bits);
			 sub  ecx,1;
			 add  edx,1;
			 cmp  ecx,0;
			 ja   loop1;
		 loop2:  
			 ret
	FLOAT_INT ENDP 

	NEGATIVO PROC 
		 MOV DX, OFFSET GUION ; Agrega guiom
		 MOV AH,09
		 INT 21h
		 mov eax, &auxN
		 NEG eax 
		 ret
	NEGATIVO ENDP 

	LIMPIA PROC 
		 FFREE ST(0)
		 FFREE ST(1)
		 FFREE ST(2)
		 FFREE ST(3)
		 FFREE ST(4)
		 FFREE ST(5)
		 FFREE ST(6)
		 FFREE ST(7)
		 ret
	LIMPIA ENDP 

	ROUND PROC 
		 frndint ;(Redondea y el resultado queda en el tope)
		 ret
	ROUND ENDP 

	TRUNC PROC 
		 fstp aux_trunc   
		 xor eax,eax 
		 fstcw truncv 
		 fwait 
		 mov ax,truncv 
		 or ax,0c00h 
		 mov truncn,ax 
		 fldcw truncn 
		 fld aux_trunc 
		 frndint       
		 ret
	TRUNC ENDP 



MAIN:
		 mov ax,@data ; zona de codigo
		 mov ds,ax; zona de codigo

		 mov es,ax

		 FINIT ;Inicializacion Copo
	@et0:	 MOV AX, SEG _Ingrese_parte_1_ 
			 MOV DS, AX 
			 MOV DX, OFFSET _Ingrese_parte_1_ 
			 MOV AH, 9 
			 INT 21h ; Imprime 
			 MOV DX, OFFSET NEWLINE ; Agrega newline
			 MOV AH,09
			 INT 21h

	@et2:	  MOV SI, 0000 
	@Inicio2:	  MOV AX, 0000 
			  MOV AH, 01h 
			  INT 21h 
			  MOV variableString[si], al 
			  INC SI 
			  CMP AL, 0dh 
			  JNE @Inicio2 
			  MOV AH, 02h 
			  MOV DL, al 
			  INT 21h 
	@et4:	 MOV AX, SEG _Ingrese_parte_2_ 
			 MOV DS, AX 
			 MOV DX, OFFSET _Ingrese_parte_2_ 
			 MOV AH, 9 
			 INT 21h ; Imprime 
			 MOV DX, OFFSET NEWLINE ; Agrega newline
			 MOV AH,09
			 INT 21h

	@et6:	  MOV SI, 0000 
	@Inicio6:	  MOV AX, 0000 
			  MOV AH, 01h 
			  INT 21h 
			  MOV inputString[si], al 
			  INC SI 
			  CMP AL, 0dh 
			  JNE @Inicio6 
			  MOV AH, 02h 
			  MOV DL, al 
			  INT 21h 
	@et8:	 MOV SI, OFFSET variableString 
			 MOV DI, OFFSET @aux10 
			 CALL COPIAR

			 MOV SI, OFFSET inputString 
			 MOV DI, OFFSET @aux10 
			 CALL CONCAT

	@et10:	 MOV SI, OFFSET @aux10 
			 MOV DI, OFFSET concatenada 
			 CALL COPIAR

	@et13:	 MOV SI, OFFSET _La_union_es_ 
			 MOV DI, OFFSET @aux15 
			 CALL COPIAR

			 MOV SI, OFFSET concatenada 
			 MOV DI, OFFSET @aux15 
			 CALL CONCAT

	@et15:	 MOV SI, OFFSET @aux15 
			 MOV DI, OFFSET mensaje 
			 CALL COPIAR

	@et18:	 MOV AX, SEG concatenada 
			 MOV DS, AX 
			 MOV DX, OFFSET concatenada 
			 MOV AH, 9 
			 INT 21h ; Imprime 
			 MOV DX, OFFSET NEWLINE ; Agrega newline
			 MOV AH,09
			 INT 21h

	@et20:	 MOV AX, SEG mensaje 
			 MOV DS, AX 
			 MOV DX, OFFSET mensaje 
			 MOV AH, 9 
			 INT 21h ; Imprime 
			 MOV DX, OFFSET NEWLINE ; Agrega newline
			 MOV AH,09
			 INT 21h



	@et22:	 MOV DX, OFFSET NEWLINE
		 MOV ah, 09
		 int 21h

		 MOV dx,OFFSET msgPRESIONE
		 MOV ah,09
		 INT 21h
		 MOV ah, 01
		 INT 21h
		 MOV ax, 4C00h
		 INT 21h
END MAIN
