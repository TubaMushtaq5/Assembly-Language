.model small 
.stack 100h
.386

.data
	inputString db "Enter Number of seconds (0 - 65535): $"
	outputHourString db "Hours: $"
	outputMinuteString db 10, 13, "Minutes: $"
	outputSecondString db 10, 13, "Seconds: $"

.code
  main proc
	mov AX, @data
	mov DS, AX
	
	mov dx, offset inputString
	mov ah, 09h
	int 21h
	
	call takeDecimalInput
	
	mov dx, offset outputHourString
	mov ah, 09h
	int 21h
	
	mov ax, bx
	
	mov cx, 3600
	call convert
	
	push ax
	
	mov dx, offset outputMinuteString
	mov ah, 09h
	int 21h
	
	pop ax
	
	mov cx, 60
	call convert
	
	push ax
	
	mov dx, offset outputSecondString
	mov ah, 09h
	int 21h
	
	pop ax
	
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
	push ax
	push cx
	
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
	
	pop cx
	pop ax
	ret
  printDecimalOutput endP
  
  convert proc
	
	push ax
	
	mov bx, cx
	mov dx, 0
	
	div bx
	
	call printDecimalOutput
	
	mov bx, cx
	mov dx, 0
	
	mul bx
	
	mov dx, ax
	
	pop ax
	
	sub ax, dx
	
	ret
  convert endP
  
end main
	