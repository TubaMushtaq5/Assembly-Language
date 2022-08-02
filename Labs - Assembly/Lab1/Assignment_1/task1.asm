.model small 
.stack 100h
.386

.data
	inputMessage db "Enter a String: $"
	outputMessage db "Sorted String is: $"
	inputStr db 200 dup('$')
	
.code
  main proc
	mov ax, @data
	mov ds, ax
	mov es, ax
	
	lea dx, inputMessage
	mov ah, 09h
	int 21h
	
	mov cx, 0
	call takeInput
	
	lea dx, outputMessage
	mov ah, 09h
	int 21h
	
	call sortString
	
	lea dx, inputStr
	mov ah, 09h
	int 21h
	
	mov ah, 4ch
	int 21h
  main endP

  takeInput proc

	lea di, inputStr
	
input:
	mov ah, 01h
	int 21h
	
	cmp al, 13
	je exitInput
	
	inc cx
	stosb
	jmp input
	
  exitInput:
	ret
	
  takeInput endP
  
  sortString proc
  
	lea si, inputStr
	
outerLoop:
	mov al, [si]
	
	mov di, si
	
	mov bx, cx
	
innerLoop:
	
	cmp al, [di]
	ja swap
	
	jmp noSwap
	
swap:
	xchg al, [di]
	mov [si],al
	
noSwap:
	
	inc di
	dec bx 
	jnz innerLoop
	
	inc si
	loop outerLoop
stringEnd:
	ret
  sortString endP
  
end main
	