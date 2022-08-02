.model small
.stack 100h

.data
	str1 db 10, 13, 'Enter a Number: $'
	newLine db 10, 13, '$'
	wrong db 10, 13, "Wrong Entry!$"
	runAgain db 10, 13, "Do you want to exit <y> or restart <n>: $"
	wrongCharacter db 10, 13, "Sorry! You have entered a wrong Character!$"

.code 
  main proc

	mov ax, @data
	mov ds, ax

inp:	mov dx, offset str1
	mov ah, 09h
	int 21h

	mov ah, 01h
	int 21h

	cmp al, 47
	ja next
	mov dx, offset wrong
	mov ah, 09h
	int 21h
	jmp inp

	

next: 	cmp al, 59
	jb suces

	mov dx, offset wrong
	mov ah, 09h
	int 21h
	jmp inp

	

suces:	mov cl, al
	sub cl, 47

	mov bl, 48

	mov dl, 48
again:	mov dx, offset newLine
	mov ah, 09h
	int 21h

	mov dl, bl
	mov ah, 02h
	int 21h

	inc bl
	dec cl
	jnz again

runAg:	mov dx, offset runAgain
	mov ah, 09h
	int 21h
	
	mov ah, 01h
	int 21h

	cmp al, 'y'
	je exi

	cmp al, 'n'
	je inp

	mov dx, offset wrongCharacter
	mov ah, 09h
	int 21h
	jmp runAg

exi:	mov ah, 4ch
	int 21h
	

  main endp
end main