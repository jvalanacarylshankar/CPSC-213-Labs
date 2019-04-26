ld $4, r0                # r0 = 4
ld $3, r1                # r1 = 3

loop: beq r0, end_loop   # goto end_loop if r0 == 0
      bgt r1, body       # goto body if r1 > 0
else: dec r0             # r0 = r0 - 1
      dec r1             # r1 = r1 - 1
      br loop            # goto loop
body: dec r1             # r1 = r1 - 1
      br else            # goto else

end_loop : ld $11, r2    # r2 = 11
           j foo         # goto foo
           inc r2        # r2 = r2 + 1 (shouldn't execute)

ping : ld $2, r4
       dec r4
       j 0(r6)

foo : dec r2             # r2 = r2 - 1
      gpc $6, r6
      j ping
      dec r2

halt
       