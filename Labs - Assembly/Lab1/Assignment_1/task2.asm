.model small
.stack 100h

.data
	inputMessage db 10, 13, "Enter an Algebric Expression: $"
	correctMessage db 10, 13, "Expression is correct$"
	rightBracketError db 10, 13, "Too many right brackets, Begin again$"
	leftBracketError db 10, 13, "Too many left brackets, Begin again$"
	isAgain db 10, 13, "Type Y if you want to continue: $"
	expression db 200 dup('$')
	
.code
   main proc
	
	mov ax, @data 
	mov ds, ax
	mov es, ax
	
continueAgain:
	lea dx, inputMessage
	mov ah, 09h
	int 21h
	
	lea si, expression
	mov sp, 0100h
	mov cx, 0100h
	
input:
	mov ah, 01h
	int 21h
	
	cmp al, 13
	je exitInput
	
	cmp al, '('
	je leftBracket
	
	jmp next
	
leftBracket:
	push ax	
	
next:
	cmp al, ')'
	je rightBracket
	
	stosb
	jmp input
	
rightBracket:
	pop ax
	
	cmp al, '('
	jne right

	jmp input
exitInput:
	cmp sp, cx
	jb left
	
	cmp sp, cx
	ja right
	
	jmp correct 
left:
	lea dx, leftBracketError
	mov ah, 09h
	int 21h
	pop ax
	jmp continueAgain
	
right:
	lea dx, rightBracketError
	mov ah, 09h
	int 21h
	push ax
	jmp continueAgain
correct:
	lea dx, correctMessage
	mov ah, 09h
	int 21h
again:
	lea dx, isAgain
	mov ah, 09h
	int 21h
	
	mov ah, 01h
	int 21h
	
	or al, 20h

	cmp al, 'y'
	je continueAgain
	
	mov ah, 4ch
	int 21h
	
   main endP
end main