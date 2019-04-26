ld $b, r0                # addr of b
ld $a, r7                # addr of b
ld (r0), r1              # r[1] = value of b

mov r1, r2               #value of temp to store initial value of b
ld $4, r3                #value of constant

inc r1                   # r[1] = r[1] + 1
add r3, r1               # r[1] = r[1] + 4

shr $1, r1               # r[1] = r[1] >> 1 or r[1] = r[1] / 2

and r2, r1               # r[1] = r[1] & temp

shl $2, r1               # r[1] = r[1] << 2 or r[1] = r[1] * 4

st r1, (r7)              # a = r[1] ( where r[1] = b)


.pos 0x1000
a :                      # variable a
.long 0

.pos 0x2000
b :                      # variable b
.long 1