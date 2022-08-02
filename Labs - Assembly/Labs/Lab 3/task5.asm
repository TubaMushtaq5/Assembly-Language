.model small
.stack 100h

.data
	str1 db "Enter a Character: $"
	str2 db 10, 13, "You Entered: $"

.code 
  main proc

	mov ax, @data
	mov ds, ax
	
	mov dx, offset str1
	mov ah, 09h
	int 21h

	mov ah, 01h
	int 21h

	xor al, 20h

	mov dx, offset str2
	mov ah, 09h
	int 21h
	
	mov dl, al
	mov ah, 02h
	int 21h

	mov ah, 4ch
	int 21h

  main endp
end main