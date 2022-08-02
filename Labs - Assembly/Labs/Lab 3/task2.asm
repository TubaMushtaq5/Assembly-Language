.model small
.stack 100h

.data

.code 
  main proc

	mov ax, @data
	mov ds, ax

	mov ah, 01h
	int 21h

	mov cl, al
	
	mov dl, 10
	mov ah, 02h
	int 21h
	
	
	mov dl, 13
	mov ah, 02h
	int 21h
	
	mov dl, cl
	mov ah, 02h
	int 21h

	

	mov ah, 4ch
	int 21h

  main endp
end main