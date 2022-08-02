.model small
.stack 100h

.data
	newLine db 10, 13, "$"

.code 
  main proc

	mov ax, @data
	mov ds, ax
	
	mov dl, '?'
	mov ah, 02h
	int 21h

	mov ah, 01h
	int 21h

	mov ch, al

	mov ah, 01h
	int 21h
	
	mov cl, al

	mov dx, offset newLine
	mov ah, 09h
	int 21h
	
	and cl, 0DFh
	and ch, 0DFh

	cmp ch, cl
	ja aa
	
	mov dl, ch
	mov ah, 02h
	int 21h

	mov dl, cl
	mov ah, 02h
	int 21h

	jmp bb

aa: 	mov dl, cl
	mov ah, 02h
	int 21h

	mov dl, ch
	mov ah, 02h
	int 21h

bb:	mov ah, 4ch
	int 21h
	

  main endp
end main