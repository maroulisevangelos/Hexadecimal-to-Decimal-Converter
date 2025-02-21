#	Computer Systems Organization
#	Winter Semester 2021-2022
#	1st Assignment
#
# 	Pseudocode by MARIA TOGANTZH (mst@aueb.gr)
#
# 	MIPS Code by Maroulis Evangelos, p3200101@aueb.gr, 3200101
# 	(Please note your name, e-mail and student id number)


	.text
	.globl main		

# ------------------- Read and Validate Data ------------------------------

main:
		lw $t4,counter		# counter = 4
		lw $t5,step			# step = 1
		la $a0, prompt		# print str  
		li $v0, 4			# "Enter a Hex: "
		syscall				# on screen
loop: 						#
		beqz $t4,exit_loop  # while counter != 0 do -- if(counter == 0) goto exit_loop
	
		li $v0,12			# Read hex character in $v0
		syscall
		move $v0,$v0
		
		
		
		beq $v0,'1',isHex	#
		beq $v0,'2',isHex	#
		beq $v0,'3',isHex	# 	if charakter is not ('0'..'9') and is not ('A'..'F') then
		beq $v0,'4',isHex	#
		beq $v0,'5',isHex	#
		beq $v0,'6',isHex	#
		beq $v0,'7',isHex	#
		beq $v0,'8',isHex	#			goto exit_on_error
		beq $v0,'9',isHex	#
		beq $v0,'0',isHex	#
		beq $v0,'A',isHex	#
		beq $v0,'B',isHex	#					else
		beq $v0,'C',isHex	#
		beq $v0,'D',isHex	#
		beq $v0,'E',isHex	#
		beq $v0,'F',isHex	#
		j exit_on_error		#					goto isHex
		
isHex:	
		sll $t1,$t1,8 	# 	shift left $t1
		or $t1,$v0,$t1	# 	pack $v0 to $t1 
		sub $t4,$t4,$t5	# 	counter = counter - 1
		
		j loop				# goto loop
		 
# ------------------- Calculate Decimal Number -----------------------------		

exit_loop:
		la $a0,gram			# 
		li $v0,4     		# print '\n'
		syscall				
		lw $t3,result		# result = 0
							#
		lw $t4,counter		# counter = 4
							#
		lw $t6,power		# power = 1
							# 
		lw $s1,mask			# $s1 = 255 (mask = 11111111)
							#
loop2:								# while counter != 0 do
		beq $t4,0,exit_loop2		# if (counter == 0) goto exit_loop2
		and $t2,$t1,$s1				# 	$t2 =  least significant byte from $t1 (unpack)
		srl $t1,$t1,8				# 	shift right $t1 
		beq $t2,'A',let				# 	if $t2 is letter A..F then 
		beq $t2,'B',let
		beq $t2,'C',let				 
		beq $t2,'D',let
		beq $t2,'E',let
		beq $t2,'F',let				 
		j notlet
let:    
		sub $t2,$t2,55	# 		$t2 = $t2 - 55
		j every			# 	else 
notlet:					
		sub $t2,$t2,48	#		$t2 = $t2 - 48
every:					#
		mul $t2,$t2,$t6	# 	$t2 = $t2 * power
		mul $t6,$t6,16	# 	power = power * 16
		sub $t4,$t4,$t5 # 	counter = counter - 1
		add $t3,$t3,$t2	# 	result = result + $t2
						#
		j loop2				# goto loop2

# ------------------- Print Results ------------------------------------		

exit_loop2:				
		move $a0,$t3	# print result
		li $v0,1		#
		syscall			#
		j exit			# goto exit
						#
exit_on_error:			#
	la $a0,gram			# 
	li $v0,4     		# print '\n'
	syscall	
	
	la $a0,error		#
	li $v0,4			#
	syscall				# print error message
						#
						#
						#
exit:					# 
	la $a0,gram			# print '\n'
	li $v0,4			#
	syscall				#
						#
	li $v0,10			# exit
	syscall				#	

	
	.data
	
error: 		.asciiz "Wrong Hex Number ..."
counter: 	.word 4
prompt:		.asciiz "Enter a Hex: " 
step:		.word 1
gram: 		.asciiz "\n"
result:		.word 0
power:      .word 1
mask:		.word 255