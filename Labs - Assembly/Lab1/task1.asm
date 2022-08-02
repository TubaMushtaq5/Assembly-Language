.model small 
.stack 100h
.386

.data
	firstNumberMessage db "Enter First Number(M) (0-65535): $"
	secondNumberMessage db 10,13, "Enter Second Number(N) (0-65535): $"
	secondNumberZeroMessage db "Cannot divide by 0, Begin agin, $"
	outputMessage db "The Greatest Common Divisor (GCD) of M and N is: $"
	
.code
  main proc
	mov ax, @data
	mov ds, ax
	mov es, ax
	
	lea dx, firstNumberMessage
	mov ah, 09h
	int 21h
	
	call takeDecimalInput
	
	push bx
secondAgain:
	lea dx, secondNumberMessage
	mov ah, 09h
	int 21h
	
	call takeDecimalInput
	
	cmp bx, 0
	jne valid
	
	lea dx, secondNumberZeroMessage
	mov ah, 09h
	int 21h
	
	jmp secondAgain
	
valid:
	pop ax
	
	call findGCD
	
	lea dx, outputMessage
	mov ah, 09h
	int 21h
	
	mov ax, bx
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
 
 findGCD proc
 
divAgain:
	mov dx, 0
	div bx
	
	cmp dx, 0
	je divEnd
	
	mov ax, bx
	mov bx, dx
	
	jmp divAgain
	
divEnd:
	ret
 findGCD endP
  
end main
	