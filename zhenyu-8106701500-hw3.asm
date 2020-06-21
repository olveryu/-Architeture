.data

	array:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
	length: .word 20
	prompt: .asciiz "Enter the number to linear search: "
	result: .asciiz "the search element is in the index: "
	tips:	.asciiz "\n(-1 means can not find the element)"

.text

main:
	la $t1, array 			# load address of array in t1
	la $t2, length 			# load address of length 
	lw $t2 0($t2)			# load content of length in t2
	li $t3, 0				# counter of the array length in t3
	li $t4, -1				# index of the number after linear search

	# prompt user input		
	li $v0, 4
	la $a0, prompt
	syscall

	# get user's input
	li $v0, 5
	syscall

	# store input
	move $t5, $v0

for:
	slt $t0, $t3, $t2		# check if the counter less than length
	bne $t0, $zero, if		# if it is not less then the length, go to if
	j end					# else end

if:
	lw $t6, 0($t1)			# load content of array in s6
	beq $t5, $t6, statement	# if it match the number that user input, go to statement
	addi $t1, $t1, 4		# address of array increment
	addi $t3, $t3, 1		# counter++
	j for					# go back for loop

statement:
	move $t4, $t3
	addi $t1, $t1, 4		# address of array increment
	addi $t3, $t3, 1		# counter++
	j for					# go back for loop

end:
	li $v0, 4
	la $a0, result			# print result
	syscall
	li $v0, 1
	move $a0, $t4			# print index
	syscall
	li $v0, 4
	la $a0, tips			# print tips
	syscall
	li	$v0, 10
	syscall

