;task2

.model small 
.stack 100h
.386

.data
	str1 db 100 dup('$')
	enterStr db "Enter a String: $"
	vowel db "Vowel Characters are: $"

.code
   main proc 

	mov ax, @data
	mov ds, ax
	
	mov si, offset str1
	mov cx, 48

	mov dx, offset enterStr
	mov ah, 09h
	int 21h

input:	mov ah, 01h
	int 21h

	cmp al, 13
	je endInp

	mov [si], al
	inc si

	or al, 20h

	cmp al, 'a'
	je increment
	
	cmp al, 'e'
	je increment
	
	cmp al, 'i'
	je increment
	
	cmp al, 'o'
	je increment
	
	cmp al, 'u'
	je increment

	jmp input


increment: inc cx
	jmp input


endInp:	

	mov dx, offset vowel
	mov ah, 09h
	int 21h

	mov dl, cl
	mov ah, 02h
	int 21h


	mov ah, 4ch
	int 21h
   main endP
end main