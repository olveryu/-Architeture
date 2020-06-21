.data

	array1:	.word 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
	array2:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 4
	array3:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	a:		.word 10
	comma:  .asciiz ","
	leftB:	.asciiz "{"
	rightB:	.asciiz "}"

.text

main:
	la $t1, array1		# load address of array1
	la $t2, array2		# load address of array2
	la $t3,	array3		# load address of array3
	la $t4, a 			# load address of a
	lw $t4, 0($t4)		# load content of length 10
	li $t0, 0			# counter of the array length
	li $v0, 4
	la $a0, leftB		# print left bracket
	syscall

	loop:
		lw $t5, 0($t1)		# read element from list1
		lw $t6, 0($t2)		# read element from list2
		sub $t7, $t5, $t6	# subtrate array1 and array2
		sw $t7, 0($t3)		# save data in array 3
		li $v0, 1 			# system call code for print integer
		addi $a0, $t7, 0	# address of integer to print
		syscall 			# print integer
		li $v0, 4
		la $a0, comma		# print comma
		syscall
		addi $t1, $t1, 4	# address of array1 move to the next index
		addi $t2, $t2, 4	# address of array2 move to the next index
		addi $t3, $t3, 4	# address of array3 move to the next index
		addi $t0, $t0, 1	# counter ++
		blt $t0,$t4,loop	# check if the counter less than 10, else loop

	li $v0, 4
	la $a0, rightB		# print right bracket
	syscall
	li $v0,10			# exit program
	syscall

