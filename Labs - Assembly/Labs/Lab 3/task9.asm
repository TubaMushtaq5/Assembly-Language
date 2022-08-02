.model small
.stack 100h

.data
	str1 db 'Enter a Number(0 to 9): $'
	newLine db 10, 13, '$'

.code 
  main proc

	mov ax, @data
	mov ds, ax

	mov dx, offset str1
	mov ah, 09h
	int 21h

	mov ah, 01h
	int 21h

	mov cl, al
	sub cl, 47

	mov bl, 48

	

again:	mov dx, offset newLine
	mov ah, 09h
	int 21h

	mov dl, bl
	mov ah, 02h
	int 21h

	inc bl
	dec cl
	jnz again

	mov ah, 4ch
	int 21h
	

  main endp
end main