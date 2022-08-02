;task3

 .model small 
.stack 100h
.386

.data
	newLine db 10, 13, '$'
	enterStr db "Enter a Character: $"
	asciiStr1 db "The ASCII code of $"
	asciiStr2 db " in binary is: $"
	bitStr db "The number of 1 bits is: $"

.code
   main proc 

	mov ax, @data
	mov ds, ax

	mov dx, offset enterStr
	mov ah, 09h
	int 21h

	mov ah, 01h
	int 21h

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

	mov ch, 8
	mov cl, 48

again:	rcl bl, 1
	jc print1

	mov dl, '0'
	jmp aa

	
print1: mov dl, '1'
	inc cl

aa:	mov ah, 02h 
	int 21h

	dec ch
	jnz again

	mov dx, offset newLine
	mov ah, 09h
	int 21h

	mov dx, offset bitStr
	mov ah, 09h
	int 21h

	mov dl, cl
	mov ah, 02h
	int 21h
	
	mov ah, 4ch
	int 21h
   main endP
end main