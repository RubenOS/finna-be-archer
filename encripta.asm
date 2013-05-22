;ARROYO ALVAREZ ERICK DANIEL 
;PROGRAMA QUE ENCRIPTA Y DESENCRIPTA UN MENSAJE 
;encripta -c/-d mensaje
.model small 
.data
  nomvar db ?
	cifrar1 db 'cifrar $' 
	decifrar1 db 'decifrar $'
.stack
.code
	inicio:
		mov ax,@data
		mov ds,ax
		mov bl,es:[80h]
		mov si,85h
		
		mov al,es:[83h]
		cmp al,'d'
		je decifrar
		cmp al,'c'
		je cifrar
		cmp al,'D'
		je decifrar
		cmp al,'C'
		je cifrar
		jmp fin
		
	cifrar:
		lea dx,cifrar1
		mov ah,9h
		int 21h
		corrimiento:
			mov al,es:[si]
			cmp al,'z'
			je resta
			cmp al,'y'
			je resta
			cmp al,'Z'
			je resta
			cmp al,'Y'
			je resta			
			add al,2h
			jne lee
		lee:
			mov dl,al
			mov ah,2h
			int 21h
			inc si
			dec bl
			cmp bl,5h
			jae corrimiento
			jmp fin
		resta:
			sub al,24d
			jmp lee			
			jmp fin
	mov si,85h		
	decifrar:
		lea dx,decifrar1
		mov ah,9h
		int 21h
			decremento:
			mov al,es:[si]
			cmp al,'a'
			je suma
			cmp al,'b'
			je suma
			cmp al,'A'
			je suma
			cmp al,'B'
			je suma	
			sbb al,2h
		lee1:			
			mov dl,al
			mov ah,2h
			int 21h
			inc si
			dec bl
			cmp bl,5h
			jae decremento
			jmp fin
		suma:
			add al,24d
			jmp lee1
	fin:
		mov ah,4ch
		int 21H
	end inicio 
