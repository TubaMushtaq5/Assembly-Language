.model small
.stack 100h

.data
	newLine db 10, 13, '$'
.code 
  main proc

	mov ax, @data
	mov ds, ax
	
	

	mov ch, 10
	
outer:	mov cl, 10

inner:	mov dl, '*'
	mov ah, 02h
	int 21h
	
	dec cl
	jnz inner

	mov dx, offset newLine
	mov ah, 09h
	int 21h

	dec ch
	jnz outer

	mov ah, 4ch
	int 21h

  main endp
end main