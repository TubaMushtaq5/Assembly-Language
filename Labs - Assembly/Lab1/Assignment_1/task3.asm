.model small
.stack 100h
.386

.data
	operatorMessage db 10, 13, "Enter an Operator (+, *, ^): $"
	firstNumberMessage db 10, 13, "Enter First Number (0-65535): $"
	secondNumberMessage db 10, 13, "Enter Second Number (0-65535): $"
	resultMessage db 10, 13, "Result is: $"
	errorMessage db 10, 13, "Invalid Operator!! Enter Again.$"
	first dw ?
	second dw ?

.code
  main proc
 
 	mov ax,@data
	mov ds,ax
	mov es,ax
	
	lea dx, firstNumberMessage
	mov ah, 09h
	int 21h
	
	call takeDecimalInput
	mov first, bx
	
	lea dx, secondNumberMessage
	mov ah, 09h
	int 21h
	
	call takeDecimalInput
	mov second, bx
invalid:
	lea dx, operatorMessage
	mov ah, 09h
	int 21h
	
	mov ah, 01h
	int 21h
	
	cmp al, '+'
	je plus
	
	cmp al, '*'
	je multi
	
	cmp al, '^'
	je pow
	
	lea dx, errorMessage
	mov ah, 09h
	int 21h
	
	jmp invalid
	
plus:
	lea dx, resultMessage
	mov ah, 09h
	int 21h
	
	call adder
	
	mov ax, first
	
	call printDecimalOutput
	
	jmp exit

multi:
	lea dx, resultMessage
	mov ah, 09h
	int 21h
	
	call multiply
	
	mov ax, first
	
	call printDecimalOutput
	
	jmp exit
	
pow:
	lea dx, resultMessage
	mov ah, 09h
	int 21h
	
	call power
	
	mov ax, first
	
	call printDecimalOutput

exit:
	mov ah,4ch
	int 21h
  main endP
  
  adder proc
  
	mov cx, second
	mov dx, first
incAgain:
	inc dx
	dec cx
	jnz incAgain
	
	mov first, dx
	ret
	
  adder endP
  
  multiply proc
  
	mov cx, second
	push cx
	dec cx
	mov dx, first
	mov second, dx
	
addAgain:
	push cx
	call adder
	pop cx
	
	dec cx
	jnz addAgain
	
	pop cx
	mov second, cx
	
	ret
  multiply endP
  
  power proc
  
	mov cx, second
	dec cx
	mov dx, first
	mov second, dx
	
multiplyAgain:
	push cx
	call multiply
	pop cx
	
	dec cx
	jnz multiplyAgain
	
	ret
  
  power endP
  
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
 
end main