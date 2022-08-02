.model small
.stack 100h

.data
	firstStringMessage db "Enter First String: $"
	secondStringMessage db "Enter Second String: $"
	isASubString db "Yes!! it is a sub string$"
	notASubString db "No!! it is not a sub string$"
	string db 200 dup('$')
	subSring db 200 dup('$')
	
.code
   main proc
	
	mov ax, @data 
	mov ds, ax
	mov es, ax

	lea dx, firstStringMessage
	mov ah, 09h
	int 21h
	
	lea di, string
	call inputString

	lea dx, secondStringMessage
	mov ah, 09h
	int 21h
	
	mov bx, cx
	
	lea di, subSring
	call inputString
	
	cmp bx, cx
	jb notSub
	
	sub bx, cx
	inc bx
	mov dx, cx
	
	lea si, string
	
checkAgain:
	lea di, subSring
	push si
	
	repe cmpsb
	
	dec si
	dec di
	cmpsb
	jne dontCheckCX
	
	cmp cx, 0
	je subStringFound
	
dontCheckCX:
	mov cx, dx
	pop si
	inc si
	dec bx 
	jnz checkAgain
notSub:
	lea dx, notASubString
	jmp print
	
subStringFound:
	lea dx, isASubString

print:
	mov ah, 09h
	int 21h
	
	mov ah, 4ch
	int 21h
	
   main endP
   
 inputString proc
 
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
	ret
 inputString endP
end main