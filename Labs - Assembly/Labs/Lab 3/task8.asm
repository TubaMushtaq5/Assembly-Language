.model small
.stack 100h

.data
	str1 db 10, 13, 'Enter Two Digits: $'
	str2 db 10, 13, 'Enter Operator(+ or -): $'
	sum db 10, 13, "Sum is $"
	diff db 10, 13, "Difference is $"

.code 
  main proc

	mov ax, @data
	mov ds, ax

	mov dx, offset str1
	mov ah, 09h
	int 21h

	mov ah, 01h
	int 21h

	mov ch, al

	mov ah, 01h
	int 21h
	
	mov cl, al
	
	sub cl, 48
	sub ch, 48

	mov dx, offset str2
	mov ah, 09h
	int 21h

	mov ah, 01h
	int 21h

	cmp al, '+'
	je summ

	mov dx, offset diff
	mov ah, 09h
	int 21h

	sub ch, cl
	add ch, 48
	mov dl, ch
	mov ah, 02h
	int 21h

	jmp exi


summ:	mov dx, offset sum
	mov ah, 09h
	int 21h
	add ch, cl
	add ch, 48
	mov dl, ch
	mov ah, 02h
	int 21h

	

exi:	mov ah, 4ch
	int 21h
	

  main endp
end main