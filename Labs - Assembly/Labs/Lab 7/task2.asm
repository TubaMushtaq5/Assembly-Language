.model small
.stack 100h

.data
	inputString1 db "Enter First Number: $"
	inputString2 db "Enter Second Number: $"
	outputString db "The Difference is: $"

.code
   main proc
	
	mov ax, @data 
	mov ds, ax
	
	mov dx, offset inputString1	
	mov ah, 09h
	int 21h
	
	call takeDecimalInput
	
	mov cx, bx
	
	mov dx, offset inputString2
	mov ah, 09h
	int 21h
	
	call takeDecimalInput
	
	mov dx, offset outputString
	mov ah, 09h
	int 21h
	
	cmp bx, cx
	ja printBX
	
	sub cx, bx
	mov ax, cx
	
	jmp go
	
printBX:
	sub bx, cx
	mov ax, bx
	
go:
	call printDecimalOutput
	
	mov ah, 4ch
	int 21h
	
   main endP
   
  takeDecimalInput proc
  
	mov bx, 0
	
againInput:
	mov ah, 01h
	int 21h
	
	cmp al, 13
	je endInput
	
	sub al, 48
	and ax, 000fh
	
	push ax
	mov ax, 10
	
	mul bx
	
	pop bx
	
	add bx, ax
	
	jmp againInput
	
endInput:
	ret
	
  takeDecimalInput endP
   
   
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