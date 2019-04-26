.pos 0x0
                 ld   $sb, r5		#r[5] = &sb
                 inca r5			#r5++
                 gpc  $6, r6    	#r6 = return address         
                 j    0x300          	#jump to instruction 0x300  
                 halt                     
.pos 0x100
                 .long 0x00001000         
.pos 0x200
                 ld   0x0(r5), r0    	#r0 = argument_1     
                 ld   0x4(r5), r1   	#r1 = argument_2     
                 ld   $0x100, r2     	#r2 = 0x100     
                 ld   0x0(r2), r2   	#r2 = *(0x100) =0x00001000       
                 ld   (r2, r1, 4), r3	#r3=*((0x1000)+argument_2)     
                 add  r3, r0      	#r0 = r0 + r3        
                 st   r0, (r2, r1, 4)	#*((0x1000)+argument_2)=r0          
                 j    0x0(r6)       	#jump to return address      
.pos 0x300
                 ld   $0xfffffff4, r0    	#r0 = -12 
                 add  r0, r5              	#allocate stack frame
                 st   r6, 0x8(r5)         	#store return address
                 ld   $0x1, r0            	#r0 = 1
                 st   r0, 0x0(r5)         	#local_variable_1 = 1
                 ld   $0x2, r0            	#r0 = 2
                 st   r0, 0x4(r5)     	#local_variable_2 = 2
                 ld   $0xfffffff8, r0     	#r0 = -8
                 add  r0, r5             	#allocate more space 
                 ld   $0x3, r0            	#r0 = 3
                 st   r0, 0x0(r5)         	#store argument_1 = 3
                 ld   $0x4, r0            	#r0 = 4
                 st   r0, 0x4(r5)         	#store argument_2 = 4
                 gpc  $6, r6              	#r6 = return address    
                 j    0x200			#jump to 0x200
                 ld   $0x8, r0          	#r0 = 8  
                 add  r0, r5              	#deallocate stack bit
                 ld   0x0(r5), r1         	#r1 =local_variable_1
                 ld   0x4(r5), r2         	#r2 =local_variable_2
                 ld   $0xfffffff8, r0     	#r0 =-8 
                 add  r0, r5              	#allocate stack space
                 st   r1, 0x0(r5)       	#store argument_1 = 1 
                 st   r2, 0x4(r5)         	#store argument_2 = 2
                 gpc  $6, r6              	#r6 = return address   
                 j    0x200			#jump to 0x200
                 ld   $0x8, r0            	#r0 = 8
                 add  r0, r5             	#deallocate stack bit 
                 ld   0x8(r5), r6         	#load return address
                 ld   $0xc, r0            	#r0 = 12
                 add  r0, r5              	#deallocate stack bit
                 j    0x0(r6)            	#jump to return addr. 
.pos 0x1000
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0
