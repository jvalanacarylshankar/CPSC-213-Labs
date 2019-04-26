
ld $0, r0
ld $proc , r1

j *(r1)

halt


foo : inc r0
      halt

.pos 0x1000
x :                      
.long 0

.pos 0x2000
proc :
.long foo