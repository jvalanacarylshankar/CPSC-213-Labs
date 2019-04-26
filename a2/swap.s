ld $t, r1                # addr of t
ld (r1), r0              # r[0] = value of t

ld $array, r2            # r2 = addr of array base
ld (r2), r4              # r4 = value at arr[0] -->2

ld $1, r3                # r3 = 1
ld (r2, r3, 4), r5       # r5 = value at arr[1] -->4

mov r4, r0               # r0 = r4
mov r5, r4               # r4 = r5
mov r0, r5               # r5 = r0

st r4, (r2)              # arr[0] = r[4]
st r5, (r2, r3, 4)       # arr[1] = r[5]

.pos 0x1000
t :                      # variable t
.long 0

.pos 0x2000
array :
.long 2                  # variable arr[0]
.long 4                  # variable arr[1]