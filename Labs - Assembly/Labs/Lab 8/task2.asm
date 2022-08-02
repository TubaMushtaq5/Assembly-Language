.model small
.stack 100h

.data
	inputStr db "Enter a String: $"
	outputStr1 db "String is Successfully stored in the Memory.$"
	outputStr2 db 10, 13, "You Entered: $"
	string db 200 dup('$')

.code
   main proc
	
	mov ax, @data 
	mov ds, ax
	mov es, ax
	
	lea dx, inputStr
	mov ah, 09h
	int 21h
	
	lea di, string
	
input:
	mov ah, 01h
	int 21h
	
	cmp al, 13
	je exitInput
	
	stosb
	jmp input
	
exitInput:
	
	lea dx, outputStr1
	mov ah, 09h
	int 21h
	
	lea dx, outputStr2
	mov ah, 09h
	int 21h
	
	lea dx, string
	mov ah, 09h
	int 21h
	
	mov ah, 4ch
	int 21h
	
   main endP
end main