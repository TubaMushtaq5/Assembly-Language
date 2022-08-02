.model small 
.stack 100h
.386

.data
	enterStr db 10, 13, "Enter a Binary Number:  $"
	hexaStr db 10, 13, "Hexadecimal number is:  $"

.code
  main proc
	mov AX, @data
	mov DS, AX
	
	call BinaryInput
	call HexadecimalOutput
	call HexadecimalOutputReverse

	mov ah, 4ch
	int 21h
  main endP
  
  BinaryInput proc
	mov dx, offset enterStr
	mov ah, 09h
	int 21h
	
	mov bl, 0
	mov ch, 8
input:
	mov ah, 01h
	int 21h
	
	sub al, 30h
	
	cmp al, 1
	je valid
	
	cmp al, 0
	je valid
	
	jmp input
valid:
	shl bl, 1
	or bl, al
	dec ch
	jnz input
	ret
  BinaryInput endP
  
  HexadecimalOutput proc
	mov dx, offset hexaStr
	mov ah, 09h
	int 21h
	
	mov ch, 2
printAgain:
	rol bl, 4
	mov dl, bl
	and dl,0fh
	
	cmp dl, 9
	ja letter
	
	add dl, 30h
	jmp print
	
letter: 
	add dl, 37h
print:
	mov ah, 02h
	int 21h
	
	dec ch 
	jnz printAgain
  
	ret
  HexadecimalOutput endP
  
  HexadecimalOutputReverse proc
	mov dx, offset hexaStr
	mov ah, 09h
	int 21h
	
	mov ch, 2
printAgain:
	mov dl, bl
	and dl,0fh
	
	cmp dl, 9
	ja letter
	
	add dl, 30h
	jmp print
	
letter: 
	add dl, 37h
print:
	mov ah, 02h
	int 21h
	
	rol bl, 4
	dec ch 
	jnz printAgain
  
	ret
  HexadecimalOutputReverse endP
  
end main
	