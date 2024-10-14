.global _start

.data
list: .word 17, 13, 8, 15, 20, 16, 1, 12, 19, 3, 11, 14, 6, 10, 7, 9, 2, 18, 5, 4
size: .word 20

.text
ldr r1, =list

ldr r11, =size   @list size
ldr r11, [r11]   @loading into r11
mov r12, #4 @storing the size
mul r11, r11, r12 @multiplying size by to get last address
add r4, r1, r11 @storing the last element address

mov r2, #0x0 @init to max so any smaller value would replace it

loop0:
	cmp r1, r4 @checking if the list reached the end
	beq End
	
	ldr r9, [r1] @loading list
	add r1, r1, r12 @change address to point the next location
	
	cmp r9, r2
	bgt set_max
	
	b loop0

	set_max:
		mov r2, r9
	b loop0
		
End:
	mov r7, #1
	swi 0
	.end 