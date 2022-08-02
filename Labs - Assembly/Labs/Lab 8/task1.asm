.model small 
.stack 100h
.386

.data
	str1 db "String 1 is: $"
	str2 db 10, 13, "String after copying is: $"
	STRING_1 db "Hola!! This is just a String.$"
	STRING_2 db 100 dup('$')
	
.code
  main proc
	mov ax, @data
	mov ds, ax
	mov es, ax
	
	lea dx, str1
	mov ah, 09h
	int 21h
	
	lea dx, STRING_1
	mov ah, 09h
	int 21h
	
	lea si, STRING_1
	mov cx, 0
	mov al, '$'
	
countAgain:
	inc cx
	scasw 
	je endCount
	jmp countAgain
endCount:

	;mov cx, 30
	
	lea si, STRING_1
	lea di, STRING_2
	
	rep movsb
	
	lea dx, str2
	mov ah, 09h
	int 21h
	
	lea dx, STRING_2
	mov ah, 09h
	int 21h
	
	mov ah, 4ch
	int 21h
  main endP
end main
	