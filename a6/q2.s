ld $a, r0                 # r0 = &a
ld $s, r1                 # r1 = &s
ld (r1), r1               # r1 = s
ld $i, r2                 # r2 = &i
ld $0, r3                 # r3 = 0
st r3, (r2)               # i = 0
ld (r2), r2               # r2 = i
ld $5, r3                 # r3 = 5

loop:  beq r3, end_loop   # goto end_loop if r3==0
       ld (r0, r2, 4), r4 # r4 = a[i]
       bgt r4, body       # goto body if r4 > 0  (a[i] > 0)
else:  inc r2             # r2 = r2 + 1
       dec r3             # r3 = r3 - 1
       br loop            # goto loop

body: add r4, r1          # r1 = r1 + r4  (s += a[i])
      br else             # goto else

end_loop: ld $s, r6       # r6 = &s
          st r1, (r6)     # s = r1
          ld $i, r6       # r6 = &i
          st r2, (r6)     # i = r2
          halt



.pos 0x1000
i :                       # i
.long 10

.pos 0x2000
a :
.long 10                  # a[0]
.long 0xFFFFFFE2          # a[1]
.long 0xFFFFFFF4          # a[2]
.long 4                   # a[3]
.long 8                   # a[4]

.pos 0x3000
s :                       # s
.long 0