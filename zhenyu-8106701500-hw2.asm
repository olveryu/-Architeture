.data

	array1:	.word 1, 2, 3, 4, 5, 6, 3, 8, 0, 10
	array2:	.word 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
	array3:	.word 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	a:		.word 10
	space:  .asciiz " "

.text

main:
	la $t1, array1		# load address of array1
	la $t2, array2		# load address of array2
	la $t3,	array3		# load address of array3
	la $t4, a 			# load address of a
	lw $t4, 0($t4)		# load content of length 10
	li $t0, 0			# counter of the array length

loop:
	slt $t7, $t0, $t4		# check if the counter less than 10
	beq $t7, 0, EXIT		# it is it not less than 10, go to EXIT
	lw $t5, 0($t1)			# read element from list1
	lw $t6, 0($t2)			# read element from list2
	slt $t7, $t5, $t6		# testing array1[i] < array2[2]
	beq $t7,1,setC			# if array[i] < array[2], go to setC

NEXT:
	lw $t8,0($t3)
	li $v0, 1 				# system call code for print integer
	addi $a0, $t8, 0		# address of integer to print
	syscall 				# print integer
	li $v0, 4
	la $a0, space			# print space
	syscall
	addi $t1, $t1, 4		# address of array1 move to the next index
	addi $t2, $t2, 4		# address of array2 move to the next index
	addi $t3, $t3, 4		# address of array3 move to the next index
	addi $t0, $t0, 1		# counter ++
	j loop					# loop back

setC:
	li $t8,0				# an 0 constant to use to set c[i] = 0
	sw $t8, 0($t3)			# save data in array 3
	j NEXT

EXIT:
	li $v0,10			# exit program
	syscall

