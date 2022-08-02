.model small
.stack 100h
.386

.data
	enterStr db 10, 13, "Enter a Binary Number upto 16 digits: $"
	illegalStr db 10, 13, "Illegal character, try again: $"
	hexaStr db 10, 13, "In Hexa it is: $"

.code
   main proc 
	
	mov ax, @data
	mov ds, ax

	mov dx, offset enterStr
	mov ah, 09h
	int 21h

	mov bx, 0

	mov ch, 0

input:
	mov ah, 01h
	int 21h

	cmp al, 13
	je endinp

	cmp ch, 16
	je input

	cmp al, 48
	je valid
	
	cmp al, 49
	je valid

	mov dx, offset illegalStr
	mov ah, 09h
	int 21h

	jmp input

valid:
	shl bx, 1

	sub al, 48
	
	or bl, al
	
	inc ch
	jmp input
	

endinp:	

	mov dx, offset hexaStr
	mov ah, 09h
	int 21h
	
	mov ch, 4
	
print:
	rol bx, 4
	
	mov dl, bl
	
	and dl, 0fh
	
	cmp dl, 9
	ja printLetter
	
	add dl, 30h
	jmp aa
	
printLetter:
	add dl, 37h
aa:	
	mov ah, 02h
	int 21h
	
	dec ch
	jnz print

	
	mov ah, 4ch
	int 21h
	
   main endP
  end main
	
	