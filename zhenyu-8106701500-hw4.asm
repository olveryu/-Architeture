.data

	array1:	.float 1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 3.5, 8.5, 9.5, 10.5
	array2:	.float 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5
	array3:	.float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
	a:		.word 10
	newLine:  .asciiz "\n"

.text

main:
	la $t1, array1		# load address of array1
	la $t2, array2		# load address of array2
	la $t3,	array3		# load address of array3
	la $t4, a 			# load address of a
	lw $t4, 0($t4)		# load content of length 10
	li $t5, 0			# counter of the array length

loop:
	slt $t0, $t5, $t4		# check if the counter less than 10
	bne $t0, 0, statement	# it is it not less than length, go to statement
	j end

statement:
	lwc1 $f1, 0($t1)		# read element from array1
	lwc1 $f2, 0($t2)		# read element from array2
	add.s $f3, $f1, $f2 	# array1[i] + array2[i]
	swc1 $f3,0($t3)			# save element to array3[i]
	li $v0, 2 				# system call code for print integer
	mov.s $f12, $f3			# address of integer to print
	syscall 				# print integer
	addi $t1, $t1, 4		# array1 address+4
	addi $t2, $t2, 4		# array2 address+4
	addi $t5, $t5, 1		# counter++
	li $v0, 4
	la $a0, newLine			# print newLine
	syscall
	j loop

end:
	li $v0,10			# exit program
	syscall

