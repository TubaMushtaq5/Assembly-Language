;task1 

.model small 
.stack 100h
.386

.data
	str1 db 100 dup('$')
	enterStr db "Enter a String: $"
	reverseStr db "In reverse oder: $"

.code
   main proc 

	mov ax, @data
	mov ds, ax
	
	mov si, offset str1
	mov di, offset str1

	mov dx, offset enterStr
	mov ah, 09h
	int 21h

input:	mov ah, 01h
	int 21h

	cmp al, 13
	je endInp

	mov [si], al
	inc si
	
	jmp input

endInp:
	mov dx, offset reverseStr
	mov ah, 09h
	int 21h

print:	dec si
	mov dl, [si]
	mov ah, 02h
	int 21h

	
	cmp si, di
	je exit

	jmp print


exit:	mov ah, 4ch
	int 21h
   main endP
end main