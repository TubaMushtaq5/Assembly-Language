.model small 
.stack 100h
.386

.data
	inputString db "Enter any key: $"
	outputString db 10, 13, "The ASCII code is: $"

.code
  main proc
	mov ax, @data
	mov ds, ax
	
	mov dx, offset inputString
	mov ah, 09h
	int 21h
	
	mov ah, 01h
	int 21h
	
	mov dx, offset outputString
	mov ah, 09h
	int 21h
	
	mov ah, 0
	call printDecimalOutput
	
	mov ah, 4ch
	int 21h
  main endP
  
  printDecimalOutput proc
  
	mov cx, 0
	mov bx, 10
	
againOutput:
	mov dx, 0
	
	div bx
	push dx
	
	inc cx
	cmp ax, 0
	jne againOutput
	
print:
	pop dx
	add dl, 30h
	mov ah, 02h
	int 21h
	
	dec cx
	jnz print
	
	ret
  printDecimalOutput endP
  
end main
	