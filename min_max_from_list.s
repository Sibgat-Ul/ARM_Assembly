.global _start

.data
list: .word 17, 13, 8, 15, 20, 1, 16, 2, 1, 12, 19, 3, 11, 10, 14, 6, 10, 7, 9, 2, 20, 18, 5, 4
maxv: .word 0
minv: .word 1000000
size: .word 24

.text
ldr r1, =list

ldr r11, =size   @list size
ldr r11, [r11]   @loading into r11
mov r12, #4 @storing the size
mul r11, r11, r12 @multiplying size by to get last address
add r4, r1, r11 @storing the last element address

mov r2, #0x0fffffff @setting to max so any smaller value would replace it
mov r3, #0x00000000 @setting to min so any bigger value would replace it

loop0:
	cmp r1, r4 @checking if the list reached the end
	beq End
	
	ldr r9, [r1] @loading list
	add r1, r1, r12 @change address to point the next bit
	
	ldr r10, [r1]
	add r1, r1, r12 @change address to point the next bit
	
	cmp r9, r10
	beq loop0
	blt min

	max:
		cmp r9, r3
		ble check_2
		
		mov r3, r9
		b check_2

	min:
		cmp r9, r2
		bge check_2
		
		mov r2, r9
		b check_2

check_2:
	set_min_2:
		cmp r10, r2
		bge loop0
		mov r2, r10
	b loop0
		
	set_max_2:
		cmp r10, r3
		ble loop0
		mov r3, r10
	b loop0

End:
	mov r7, #1
swi 0