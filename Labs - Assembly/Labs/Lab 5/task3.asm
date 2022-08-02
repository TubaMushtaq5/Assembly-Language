.model small
.stack 100h
.386

.data
	enterStr db 10, 13, "Enter a Binary Number upto 8 digits: $"
	illegalStr db 10, 13, "Illegal character, try again: $"
	sumStr db 10, 13, "The Binary Sum is: $"

.code
   main proc 
	
	mov ax, @data
	mov ds, ax

	mov dx, offset enterStr
	mov ah, 09h
	int 21h

	mov bx, 0
	mov ch, 2
	
againInp:
	mov cl, 8
	mov bl, 0
	
input:
	mov ah, 01h
	int 21h

	cmp al, 13
	je endinp

	cmp al, 48
	je valid
	
	cmp al, 49
	je valid

	mov dx, offset illegalStr
	mov ah, 09h
	int 21h

	jmp input

valid:
	shl bl, 1

	sub al, 48
	
	or bl, al
	
	dec cl
	jnz input
	
endinp:
	cmp ch, 1
	je exitInp
	
	mov bh, bl
	
	mov dx, offset enterStr
	mov ah, 09h
	int 21h
	
	dec ch
	jmp againInp
	

exitInp:	

	mov dx, offset sumStr
	mov ah, 09h
	int 21h
	
	mov ch, 8
	add bh, bl
	
printAgain:
	rol bh, 1
	jc print1
	
	mov dl, '0'
	
	jmp print
	
print1:
	mov dl, '1'
	
print:
	mov ah, 02h
	int 21h
	
	dec ch
	jnz printAgain
	
	mov ah, 4ch
	int 21h
	
   main endP
  end main
	
	