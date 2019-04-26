ld $n, r5
ld (r5), r5
ld $s, r0
ld (r0), r0 
gpc $6, r6
j avg_grade_per_student
dec r5

iterate_avg : beq r5, body
              ld $24, r7
              add r7, r0
              gpc $6, r6
              j avg_grade_per_student
              dec r5
              br iterate_avg

avg_grade_per_student: ld 4(r0), r1	#r1 = s[1] (each grade belonging to student)
                       ld 8(r0), r2	#r2 = s[2] 
                       ld 12(r0), r3	#r3 = s[3]
                       ld 16(r0), r4	#r4 = s[4]
                       ld $0, r7
                       add r1, r7	#r7 = r7 + s[1]
                       add r2, r7	#r7 = r7 + s[2]
                       add r3, r7	#r7 = r7 + s[3]
                       add r4, r7	#r7 = r7 + s[4]
                       shr $2, r7	#r7 = r7 >> 2 (r7/2^2)
                       st r7, 20(r0)	#store average grade
                       j (r6)	

body: ld $n, r5		#r5 = number of students
      ld (r5), r5
      dec r5		#r5 = r5 - 1
      j sort		#jump to sort

sort_body: ld $s, r0	#r0 = &s 
           ld (r0), r0	#r0 = s[0]
           ld $24, r7	#r7 = 24
           add r7, r0	#r0 = r0 + 24
           ld $1, r3	#r3 = 1

inc      : mov r5, r4			#r4 = r5
           not r4			#r4 = ~r4
           inc r4			#r4 + 1 (obtain negative value)
           add r3, r4			#r4 = r4 + r3
           bgt r4, end_inner_loop	#branch to inner sort loop
           
           ld 20(r0), r1		#r1 = avg of student
           ld $-4, r7			#r7 = -4
           mov r0, r6			#r6 = r0
           add r7, r6			#r6 = r6 + r7
           ld (r6), r2			#r2 = (r6)
           not r2			#r2 = ~r2
           inc r2			#r2 = r2 + 1
           add r1, r2			#r2 = r2 + r1 (greater than condition)
           not r2			#r2 = ~r2
           inc r2         		#r2 = r2 + 1
           bgt r2, swap			#if(r2 > 0), swap
           
out_of_if: ld $24, r7			#go to next element in list of students
           add r7, r0
           inc r3
           j inc
           

end_inner_loop: dec r5			#r5 = r5 - 1
                j sort			#jump to sort
      
sort: bgt r5, sort_body			#if(r5 > 0), sort_body

next: gpc $6, r6			
      j median				#jump to median

swap: ld (r0), r1			#swap student number
      ld $-24, r7
      mov r0, r6
      add r7, r6
      ld (r6), r2
      st r2, (r0)
      st r1, (r6)

      ld 4(r0), r1			#swap grade 0
      ld $-20, r7
      mov r0, r6
      add r7, r6
      ld (r6), r2
      st r2, 4(r0)
      st r1, (r6)

      ld 8(r0), r1			#swap grade 1
      ld $-16, r7
      mov r0, r6
      add r7, r6
      ld (r6), r2
      st r2, 8(r0)
      st r1, (r6)

      ld 12(r0), r1			#swap grade 2
      ld $-12, r7
      mov r0, r6
      add r7, r6
      ld (r6), r2
      st r2, 12(r0)
      st r1, (r6)

      ld 16(r0), r1			#swap grade 3
      ld $-8, r7
      mov r0, r6
      add r7, r6
      ld (r6), r2
      st r2, 16(r0)
      st r1, (r6)

      ld 20(r0), r1			#swap average grade
      ld $-4, r7
      mov r0, r6
      add r7, r6
      ld (r6), r2
      st r2, 20(r0)
      st r1, (r6)

      j out_of_if			#jump to out_of_if 

median: ld $1, r1			#r1 = 1
        ld $n, r5			#r5 = number of students
        ld (r5), r5
        mov r5, r2			#r2 = r5
        add r1, r2			#r2 = r2 + 1
        shr $1, r2			#r2 = r2/2
        ld $24, r3			#r3 = 24
        ld $0, r4			#r4 = 0
        dec r2				
cond:   beq r2, get			#if(r2 = 0), get
        add r3, r4			#r4 = r4 + r3
        dec r2
        br cond				#branch to cond

get: ld $s, r0				#r0 = &s
     ld (r0), r0			#r0 = s[0]
     add r0, r4				#r4 = r4 + r0
     ld (r4), r4			#r4 = (r4)
     ld $m, r5				#r5 = median
     st r4, (r5)			#r4 = (r5)

end: halt


.pos 0x1000
n: 
 .long 3    # number of student

.pos 0x2000
m:  
 .long 0    # median

.pos 0x3000
s: 
 .long base # address of the array

.pos 0x4000
base: 
 .long 1234 # student ID		#student data
 .long 80   # grade 0
 .long 60   # grade 1
 .long 78   # grade 2
 .long 90   # grade 3
 .long 0    # computed average
s2:
 .long 2056 # student ID
 .long 60   # grade 0
 .long 50   # grade 1
 .long 98   # grade 2
 .long 90   # grade 3
 .long 0    # computed average
s3:
 .long 1010 # student ID
 .long 20   # grade 0
 .long 30   # grade 1
 .long 98   # grade 2
 .long 90   # grade 3
 .long 0    # computed average