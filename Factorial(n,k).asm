#Κοσμάς Στυλιανός-Ιωάννης 3100080
#Κορωνιάς Αντώνης 3150075
				.data
msg1: 			.asciiz "Enter number of objects in the set (n): "
msg2: 			.asciiz "Enter number to be chosen (k): "
msg3:			.asciiz "C ("
msg4:			.asciiz ", "
msg5:			.asciiz ") = "
msg6:			.asciiz "Please enter n>=k >=0"

				.text
				.globl main		#run()
main:			li $v0,4
				la $a0,msg1		#print(msg1)
				syscall

				li $v0,5
				syscall
				move $t0,$v0	#$t0=n

				li $v0,4
				la $a0,msg2		#print(msg2)
				syscall

				li $v0,5
				syscall
				move $t1,$v0	#$t1=k

if:				blt $t0,$t1,else	
				bltz $t1,else

				la $a0,msg3
				li $v0,4
				syscall

				li $v0,1
				move $a0,$t0
				syscall

				la $a0,msg4
				li $v0,4
				syscall

				li $v0,1
				move $a0,$t1
				syscall

				li $v0,4
				la $a0,msg5
				syscall

				jal combinations
				j exit

else:			li $v0,4
				la $a0,msg6
				syscall	

combinations:	move $s0,$t0	#$s0=n
				move $s1,$t1	#s1=k
				li $t3,1		#$t3=i=1
				li $t4,1		#$t4=fuctorial_n=1

for:			bgt $t3,$s0,factorial_k	#i>n		
				mul $t4,$t4,$t3 #factorial_n*=i
				addi $t3,$t3,1	#i++
				j for
				

factorial_k:	li $t5,1		#$t5=factorial_k=1
				li $t3,1		#$t3=i=1
for2:			bgt $t3,$s1,factorial_n_k #i>k
				mul $t5,$t5,$t3	#factorial_k*=i
				addi $t3,$t3,1	#i++
				j for2
				
factorial_n_k:	li $t6,1		#$t6=factorial_n_k=1
				li $t3,1		#i=1
				sub $t7,$s0,$s1	#$t7=n-k
for3:			bgt $t3,$t7,return	#i>n-k
				mul $t6,$t6,$t3	#factorial_n_k*=i
				addi $t3,$t3,1	#i++
				j for3

return:			mul $t8,$t5,$t6 #factorial_k*factorial_n_k
				div $s2,$t4,$t8 #factorial_n/$t8
				move $a0,$s2	
				li $v0,1
				syscall			#print combinations(n,k)q
				jr $ra				

exit:			li $v0,10
				syscall		