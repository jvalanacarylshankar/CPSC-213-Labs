ld $a, r0                # addr of a[0]
ld $s, r1                # addr of s[0]
ld $tos, r6              # addr of tos
ld $tmp, r7              # addr of tmp
ld (r6), r2              # r2 = value of tos
ld (r7), r3              # r3 = value of tmp
ld (r0), r4              # r4 = value of a[0]
st r4, (r1, r2, 4)       # s[tos] = a[0]
inc r2                   # r2 = r2 + 1
ld $1, r5                # constant 1
ld (r0, r5, 4), r4       # r4 = value of a[1]
st r4, (r1, r2, 4)       # s[tos] = a[1]
inc r2                   # r2 = r2 + 1
ld $2, r5                # constant 2
ld (r0, r5, 4), r4       # r4 = value of a[2]
st r4, (r1, r2, 4)       # s[tos] = a[1]
inc r2                   # r2 = r2 + 1
dec r2                   # r2 = r2 - 1
ld (r1, r2, 4), r4       # r4 = value of s[tos]
mov r4, r3               # r3 = r4
dec r2                   # r2 = r2 - 1
ld (r1, r2, 4), r4       # r4 = value of s[tos]
add r4, r3               # r3 = r3 + r4
dec r2                   # r2 = r2 - 1
ld (r1, r2, 4), r4       # r4 = value of s[tos]
add r4, r3               # r3 = r3 + r4

st r2, (r6)              # storing value at addr of tos
st r3, (r7)              # storing value at addr of tmp

halt

.pos 0x1000
a :
.long 3                  # variable a[0]
.long 2                  # variable a[1]
.long 1                  # variable a[2]

.pos 0x2000
s :
.long 0                  # variable s[0]
.long 0                  # variable s[1]
.long 0                  # variable s[2]
.long 0                  # variable s[3]
.long 0                  # variable s[4]

.pos 0x3000
tos :
.long 0                  # variable tos

.pos 0x4000
tmp :
.long 0                  # variable tmp


