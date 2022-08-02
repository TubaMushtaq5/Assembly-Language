.model small
.stack 100h

.data
	str1 db 100 dup('$')
	enterStr db "Enter a String: $"
	newStr db "You Entered: $"

.code
   main proc
	
	mov ax, @data 
	mov ds, ax
	
	mov dx, offset enterStr	
	mov ah, 09h
	int 21h
	
	mov si, offset str1
	call stringInput

	mov dx, offset newStr
	mov ah, 09h
	int 21h
	
	mov cx, 0
	mov bl, '1'

	mov si, offset str1

noSpc:
	mov al, [si]
	
	cmp al, 32
	je space

	cmp al, '$'
	je lastChar
	
	inc cx
	inc si
	jmp noSpc
	
lastChar:
	dec si
	mov bl, '$'
		
space:
	inc cx
	push si
	
print:
	mov dl, [si]
	mov ah, 02h
	int 21h
	
	dec si
	dec cx
	jnz print
	
	cmp bl, '$'
	je exit
	
	pop si
	inc si
	
	mov dl, ' '
	mov ah, 02h
	int 21h
	
	jmp noSpc

exit:
	mov ah, 4ch
	int 21h

   main endP
   
   stringInput proc
   
input: 	
    mov ah, 01h
	int 21h

	cmp al, 13
	je exitInp

	mov [si], al
	inc si

	jmp input

exitInp:
	ret
    stringInput endP
   
end main