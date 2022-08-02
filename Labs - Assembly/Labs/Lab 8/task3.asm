.model small 
.stack 100h
.386

.data
	startString db "Enter a string: $"
	inputStr db 100 dup('$')
	outputString db "The count of vowels character is: $"
	vowels db "aeiou"
	lengthOfString dw ?

.code
  main proc
	mov AX, @data
	mov DS, AX
	mov ES, AX
	
	mov dx, offset startString
	mov ah, 09h
	int 21h
	
	mov cx, 0
	lea di, inputStr
	
inputContinue:
	mov ah, 01h
	int 21h
	
	cmp al, 13
	je exitInput
	
	inc cx
	or al, 20h
	
	stosb
	
	jmp inputContinue
	
exitInput:
	
	inc cx
	mov dx, 0
	mov lengthOfString, cx
	mov bx, 5
	lea si, vowels
	
nextVowel:
	lea di, inputStr
	mov al, [si]
	mov cx, lengthOfString
	
vowelCheck:
	repne scasb
	
	cmp cx, 0
	je stringEnd
	
	inc dx
	jmp vowelCheck
	
stringEnd:
	inc si
	dec bx
	jnz nextVowel
	
	mov bx, dx
	
	lea dx, outputString
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
  
end main
	