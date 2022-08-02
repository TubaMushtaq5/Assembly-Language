.model small
.stack 100h
.386

.data
	enterStr db 10, 13, "Enter a hex number (0 to FFFF): $"
	illegalStr db 10, 13, "Illegal hex digit, try again: $"
	binaryStr db 10, 13, "In binary it is: $"

.code
   main proc 
	
	mov ax, @data
	mov ds, ax

	mov dx, offset enterStr
	mov ah, 09h
	int 21h

	mov bx, 0
	mov ch, 4

input:
	mov ah, 01h
	int 21h

	cmp al, 13
	je endinp

	cmp ch, 0
	je input

	cmp al, 47
	ja digitnext

	jmp invalid


digitnext:
	cmp al, 58
	jb valid

	cmp al, 64
	ja letternext

	jmp invalid

letternext:
	cmp al, 71
	jb valid

	jmp invalid

invalid:

	mov dx, offset illegalStr
	mov ah, 09h
	int 21h

	jmp input


valid:
	shl bx, 4
	
	cmp al, 58
	ja letter
	
	sub al, 30h
	jmp store
	
letter:
	sub al, 37h

store:
	or bl, al
	
	dec ch
	jmp input
	

endinp:

	mov dx, offset binaryStr
	mov ah, 09h
	int 21h
	
	mov ch, 16
	
printAgain:
	rol bx, 1
	
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
	
	