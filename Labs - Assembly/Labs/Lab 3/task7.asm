.model small
.stack 100h

.data
	str1 db 10, 13, 'Enter Two Digits: $'
	error db 10, 13, "Error! Sum is greater than 9$"
	success db 10, 13, "Sum is $"

.code 
  main proc

	mov ax, @data
	mov ds, ax

	mov dx, offset str1
	mov ah, 09h
	int 21h

again:	mov ah, 01h
	int 21h

	mov ch, al

	mov ah, 01h
	int 21h
	
	mov cl, al
	
	sub cl, 48
	sub ch, 48

	add ch, cl
	
	cmp ch, 9
	ja wrong

	mov dx, offset success
	mov ah, 09h
	int 21h
	
	add ch, 48
	mov dl, ch
	mov ah, 02h
	int 21h

	jmp exi

	
wrong: 	mov dx, offset error
	mov ah, 09h
	int 21h

	mov dx, offset str1
	mov ah, 09h
	int 21h
	
	jmp again
	
	

exi:	mov ah, 4ch
	int 21h
	

  main endp
end main