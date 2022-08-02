;task5

.model small
.stack 100h

.data
	str1 db 100 dup('$')
	enterStr db "Enter a String: $"
	newStr db "New String is: $"
	newLinw db 10, 13, '$'

.code
   main proc
	
	mov ax, @data 
	mov ds, ax

	mov si, offset str1

	mov dx, offset enterStr	
	mov ah, 09h
	int 21h

input: 	mov ah, 01h
	int 21h

	cmp al, 13
	je exitInp

	mov [si], al
	inc si

	jmp input

exitInp:
	mov dx, offset newStr
	mov ah, 09h
	int 21h
	
	mov di, si
	inc di

	mov si, offset str1

again:	mov cx, 0

noSpc:	mov al, [si]
	cmp al, 32				;40
	je space

	cmp al, '$'
	je space

	inc cx
	inc si
	jmp noSpc
		
space:	mov bx, cx
	dec si
print:	mov dl, [si]
	mov ah, 02h
	int 21h

	dec si
	dec bx
	jnz print

	add si, cx
	inc si
	inc si

	mov dl, ' '
	mov ah, 02h
	int 21h

	cmp si, di
	je exit

	jmp again

exit:	mov ah, 4ch
	int 21h

   main endP
end main