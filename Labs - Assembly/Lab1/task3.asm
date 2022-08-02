.model small
.stack 100h

.data
	encode db 65 dup(' '), "YHNMJUILKOPBGTRFVCDEWSXZAQ", 6 dup(?), "yhnmjuilkopbgtrfvcdewsxzaq"										   				 
						   ;ABCDEFGHIJKLMNOPQRSTUVWXYZ
	decode db 65 dup(' '), "YLRSTPMBGEIHDCJKZOVNFQUWAX", 6 dup(?), "ylrstpmbgeihdcjkzovnfquwax"
	inputMessage db "Enter a String: $"
	outputMessage1 db "After Encoding: $"
	outputMessage2 db 10, 13, "After decoding: $"
	string db 200 dup('$')
	
.code
  main proc
  
	mov ax, @data	
	mov ds, ax
	mov es, ax
	
	lea dx, inputMessage
	mov ah, 09h
	int 21h
	lea di, string
	mov cx, 0

input:
	mov ah, 01h
	int 21h
	
	cmp al, 13
	je exitInput
	
	stosb
	inc cx 
	jmp input

exitInput:
	lea dx, outputMessage1
	mov ah, 09h
	int 21h
	
	lea si, string
	lea bx, encode
	mov dx, cx
	
encodeString:
	mov al, [si]
	xlat
	mov [si], al
	
	inc si
	loop encodeString
	
	mov cx, dx
	
	lea dx, string
	mov ah, 09h
	int 21h
	
	lea dx, outputMessage2
	mov ah, 09h
	int 21h
	
	lea si, string
	lea bx, decode
	
decodeString:
	mov al, [si]
	xlat
	mov [si], al
	
	inc si
	loop decodeString
	
	lea dx, string
	mov ah, 09h
	int 21h
	
	mov ah, 4ch
	int 21h
	
  main endP
end main