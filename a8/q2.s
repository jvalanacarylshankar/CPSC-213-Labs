.pos 0x0
                 ld   $0x1028, r5         #r5 = 0x1028 = stackBottom 
                 ld   $0xfffffff4, r0     #r0 = -12
                 add  r0, r5              #r5 = r5 + r0 (allocating space on stack for arguments)
                 ld   $0x200, r0          #r0 = &a[0]   
                 ld   0x0(r0), r0         #r0 = a[0]
                 st   r0, 0x0(r5)         #a0 = a[0]            
                 ld   $0x204, r0          #r0 = &a[1]             
                 ld   0x0(r0), r0         #r0 = &a[1]            
                 st   r0, 0x4(r5)         #a1 = a[1]            
                 ld   $0x208, r0          #r0 = &a[2]   
                 ld   0x0(r0), r0         #r0 = &a[2]   
                 st   r0, 0x8(r5)         #a2 = a[2]   
                 gpc  $6, r6              #r6 = return address         
                 j    0x300          	#jump to instruction 0x300                   
                 ld   $0x20c, r1          #r0 = &a[3]   
                 st   r0, 0x0(r1)         #a[3] = r0   
                 halt                     
.pos 0x200
                 .long 0x00000000          #a[0]    
                 .long 0x00000000          #a[1]
                 .long 0x00000000          #a[2]
                 .long 0x00000000          #a[3]
.pos 0x300
                 ld   0x0(r5), r0         #r0 = a0
                 ld   0x4(r5), r1         #r1 = a1
                 ld   0x8(r5), r2         #r2 = a2
                 ld   $0xfffffff6, r3     #r3 = -10
                 add  r3, r0              #r0 = r0 - 10
                 mov  r0, r3              #r3 = r0 - 10
                 not  r3                  #r3 = ~r3
                 inc  r3                  #r3 = r3 + 1
                 bgt  r3, L6              #goto L6 if r3 < 10
                 mov  r0, r3              #r3 = r0 - 10
                 ld   $0xfffffff8, r4     #r4 = -8
                 add  r4, r3              #r3 = r0 - 18
                 bgt  r3, L6              #goto L6 if r3 > 18
                 ld   $0x400, r3          #r3 = 0x400
                 j    *(r3, r0, 4)        #goto Jumptable[r0 - 10]
.pos 0x330
                 add  r1, r2              #r2 = r2 + r1
                 br   L7                  #goto L7
                 not  r2                  #r2 = ~r2
                 inc  r2                  #r2 = r2 + 1
                 add  r1, r2              #r2 = r1 - r2
                 br   L7                  #goto L7
                 not  r2                  #r2 = ~r2
                 inc  r2                  #r2 = r2 + 1
                 add  r1, r2              #r2 = r1 - r2           
                 bgt  r2, L0              #goto L0 if (r1 - r2) > 0
                 ld   $0x0, r2            #r2 = 0 
                 br   L1                  #goto L1
L0:              ld   $0x1, r2            #r2 = 1
L1:              br   L7                  #goto L7
                 not  r1                  #r1 = ~r1
                 inc  r1                  #r1 = r1 + 1
                 add  r2, r1              #r1 = r2 - r1
                 bgt  r1, L2              #goto L2 if (r2 - r1) > 0
                 ld   $0x0, r2            #r2 = 0
                 br   L3                  #goto L3
L2:              ld   $0x1, r2            #r2 = 1
L3:              br   L7                  #goto L7
                 not  r2                  #r2 = ~r2
                 inc  r2                  #r2 = r2 + 1
                 add  r1, r2              #r2 = r1 - r2
                 beq  r2, L4              #goto L4 if (r1 - r2) == 0
                 ld   $0x0, r2            #r2 = 0
                 br   L5                  #goto L5
L4:              ld   $0x1, r2            #r2 = 1
L5:              br   L7                  #goto L7
L6:              ld   $0x0, r2            #r2 = 0
                 br   L7                  #goto L7
L7:              mov  r2, r0              #r0 = r2
                 j    0x0(r6)             #goto return address
.pos 0x400
                 .long 0x00000330           #case 0    -----> Jumptable
                 .long 0x00000384           #default 
                 .long 0x00000334           #case 2
                 .long 0x00000384           #default
                 .long 0x0000033c           #case 4
                 .long 0x00000384           #default
                 .long 0x00000354           #case 6
                 .long 0x00000384           #default
                 .long 0x0000036c           #case 8
.pos 0x1000
                 .long 0x00000000            #stackTop
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000            #a0
                 .long 0x00000000            #a1
                 .long 0x00000000            #stackBottom (a2)
