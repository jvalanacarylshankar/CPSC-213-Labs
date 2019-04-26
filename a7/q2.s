.pos 0x100
start:
    ld $sb, r5	#load stack bottom (sb) into r5
    inca    r5	#increase address of r5
    gpc $6, r6	#set address of next instruction to r6
    j main		#jump to main
    halt

f:
    deca r5			#allocate more stack space
    ld $0, r0			#r0 = 0
    ld 4(r5), r1		#r1 = local_variable_1
    ld $0x80000000, r2	#r2 = 0x80000000
f_loop:
    beq r1, f_end		#if(r1 == 0), goto f_end
    mov r1, r3			#r3 = r1
    and r2, r3			#r3 = r3 & r2
    beq r3, f_if1		#if(r3==0), branch to f_ifl
    inc r0				#r0++
f_if1:
    shl $1, r1			#r1 = r1/2
    br f_loop			#branch to f_loop
f_end:
    inca r5			#deallocate stack space
    j(r6)				#jump to return address

main:
    deca r5	#allocate stack space
    deca r5	#allocate more stack space	
    st r6, 4(r5)#store return address
    ld $8, r4	#r4 = 8
main_loop:
    beq r4, main_end	#if(r4 == 0), goto main_end
    dec r4			#r4--
    ld $x, r0		#r0 = &x
    ld (r0,r4,4), r0	#r0 = x[r4]
    deca r5		#allocate more stack space
    st r0, (r5)		#store local_variable_1 = x[r4]
    gpc $6, r6		#r6 = return address
    j f			#jump to f
    inca r5		#deallocate stack space
    ld $y, r1		#r1 = &y
    st r0, (r1,r4,4)	#y[r4] = r0
    br main_loop	#branch to main_loop
main_end:
    ld 4(r5), r6	#load return address
    inca r5		#deallocate stack space
    inca r5		#deallocate stack space
    j (r6)			#jump to return address

.pos 0x2000
x:
    .long 1
    .long 2
    .long 3
    .long 0xffffffff
    .long 0xfffffffe
    .long 0
    .long 184
    .long 340057058

y:
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0

.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0

