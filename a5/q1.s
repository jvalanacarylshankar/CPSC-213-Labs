## This is the solution to CPSC 213 Assignment 3
## Do not distribute this to anyone in any way.
## Do not remove this comment.

## Code - TODO: Comment and translated to C in q1()
.pos 0x1000

## C statement 1
S1:
ld    $i, r0            # r0 = &i
ld    (r0), r0          # r0 = i (value)
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a (value) --> &b1.a1
ld    (r1), r1          # r1 = b1.a1 (value) --> &a1->x[0]
ld    (r1, r0, 4), r2   # r2 = a->b1.a1->x[i]
ld    $v0, r3           # r3 = &v0
st    r2, (r3)          # v0 = a->b1.a1->x[i]

## C statement 2
S2:
ld    $i, r0            # r0 = &i
ld    (r0), r0          # r0 = i (value)
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a (value) --> &b1.a1
inca  r1                # r1 = r1 + 4 bytes
ld    (r1, r0, 4), r2   # r2 = a->b1.y[i]
ld    $v1, r3           # r3 = &v1
st    r2, (r3)          # v1 = a->b1.y[i]

## C statement 3
S3:
ld    $i, r0            # r0 = &i
ld    (r0), r0          # r0 = i (value)
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a (value) --> &b1.a1
ld    20(r1), r1        # r1 = r1 + 20 bytes
ld    (r1), r1          # r1 = &a2->x[0]
ld    (r1, r0, 4), r2   # r2 = a->b1.a2->x[i]
ld    $v2, r3           # r3 = &v2
st    r2, (r3)          # v2 = a->b1.a2->x[i]

## C statement 4
S4:
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a (value) --> &b1.a1
st    r1, 20(r1)        # b1.a2 = &b1.a1

## C statement 5
S5:
ld    $i, r0            # r0 = &i
ld    (r0), r0          # r0 = i (value)
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a (value) --> &b1.a1
ld    20(r1), r1        # r1 = r1 + 20 bytes
inca  r1                # r1 = r1 + 4 bytes
ld    (r1, r0, 4), r2   # r2 = a->b1.y[i]
ld    $v3, r3           # r3 = &v3
st    r2, (r3)          # v3 = a->b1.y[i]


halt


## Globals
.pos 0x2000
i:  .long 0
v0: .long 0
v1: .long 0
v2: .long 0
v3: .long 0
a:  .long d0                 # struct A


## Heap (these labels represent dynamic values and are thus not available to code)
.pos 0x3000
d0: .long d1                 # b1.a1
    .long 20                 # b1.y[0]
    .long 21                 # b1.y[1]
    .long 22                 # b1.y[2]
    .long 23                 # b1.y[3]
    .long d2                 # b1.a2
d2: .long d3                 # a2.b2
    .long 0                  
    .long 40                 # a2->x[0]
    .long 41                 # a2->x[1]
    .long 42                 # a2->x[2]
    .long 43                 # a2->x[3]
d1: .long 10                 # a1->x[0]
    .long 11                 # a1->x[1]
    .long 12                 # a1->x[2]
    .long 13                 # a1->x[3]
d3: .long 30                 # b2.y[0]
    .long 31                 # b2.y[1]
    .long 32                 # b2.y[2]
    .long 33                 # b2.y[3]
