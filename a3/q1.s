ld $a, r0                # addr of a[0]
ld $3, r1                # constant 3
ld $i, r2                # addr of i
ld (r0, r1, 4), r3       # r3 = a[r0 + r1*4]
st r3, (r2)              # i = a[3]
ld (r2), r4              # value of i
ld (r0, r4, 4), r3       # r3 = a[r0 + r4*4]
st r3, (r2)              # i = a[i]
ld $j, r2                # addr of j
ld $p, r3                # addr of p
st r2, (r3)              # p = &j
ld (r3), r4              # value of p
ld $4, r5                # constant 4
st r5, (r2)              # *p = 4 -> makes j = 4
ld $2, r5                # constant 2
ld (r0, r5, 4), r4       # r3 = a[r0 + r5*4]
shl $2, r4               # r4 = r4*4
add r0, r4               # r4 = r0 + r4
st r4, (r3)              # p = &a[a[2]]
ld (r3), r4              # r4 = &a[a[2]]
ld (r4), r5              # value at a[a[2]]
ld $4, r7                # constant 4
ld (r0, r7, 4), r6       # r6 = a[r0 + r7*4]
add r6, r5               # r5 = r5 + r6
st r5, (r4)              # *p = r5 -> makes a[a[2]] = r5

halt



.pos 0x1000
i :                      # variable i
.long 0

.pos 0x2000
j :                      # variable j
.long 0

.pos 0x3000
p :                      # variable p
.long 0

.pos 0x4000
a :
.long 11                 # variable a[0]
.long 9                  # variable a[1]
.long 8                  # variable a[2]
.long 7                  # variable a[3]
.long 6                  # variable a[4]
.long 5                  # variable a[5]
.long 4                  # variable a[6]
.long 3                  # variable a[7]
.long 2                  # variable a[8]
.long 1                  # variable a[9]