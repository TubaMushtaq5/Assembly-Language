;task4

 .model small 
.stack 100h
.386

.data
	newLine db 10, 13, '$'
	enterStr db "Enter a Character: $"
	asciiStr1 db "The ASCII code of $"
	asciiStr2 db " in HEX is: $"

.code
   main proc 

	mov ax, @data
	mov ds, ax

again: 	mov dx, offset enterStr
	mov ah, 09h
	int 21h

	mov ah, 01h
	int 21h
	
	cmp al, 13
	je exit

	mov bl, al
	
	mov dx, offset newLine
	mov ah, 09h
	int 21h

	mov dx, offset asciiStr1
	mov ah, 09h
	int 21h
	
	mov dl, bl
	mov ah, 02h
	int 21h

	mov dx, offset asciiStr2
	mov ah, 09h
	int 21h

	mov cl, 2

print:	rol bl, 4
	
	mov bh, bl
	and bh, 0Fh

	cmp bh, 9
	ja letter

	add bh, 48
	jmp aa 

	
letter: add bh, 55

aa:	mov dl, bh
	mov ah, 02h
	int 21h

	dec cl
	jnz print

	mov dx, offset newLine
	mov ah, 09h
	int 21h

	jmp again
	
exit:	mov ah, 4ch
	int 21h
   main endP
end main