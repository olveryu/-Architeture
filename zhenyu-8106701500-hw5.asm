.data
	array:	.word 6, 500, 1, 100, 24, 2, 78, 98, 123, 45
	n:		.word 10
	comma:  .asciiz ","

.text

main:
	la $t1, array			# load address of array1
	la $t2, n 				# load address of a
	lw $t3, 0($t2)			# load content of length 10
	li $t4, 0				# counter i
	li $t5, 1				# counter j
	li $t6, 4				# int 4 to use for subtraction and addition
	addi $t1, $t1, 4		# add address 4 so array start at 1

loop:
	slt $t0, $t4, $t3		# check i < n
	bne $t0, 0, loop2		# if i<n, go to loop2
	j print

loop2:
	sub $t0, $t3, $t4
	slt $t0, $t5, $t0		# check j < (n-i)
	bne $t0, 0, if			# if j < (n-i), go to if
	addi $t4, $t4, 1		# i++
	li $t5, 1				# reset j to 1
	la $t1, array			# load address of array1
	addi $t1, $t1, 4		# add address 4 so array start at 1
	j loop

if:
	lw $s2, 0($t1)			# get content of array[j]
	sub $t1, $t1, $t6		# get address of array[j-1]
	lw $s1, 0($t1)			# get content of array[j-1]
	add $t1, $t1, $t6		# get back to current position
	slt $t0, $s2, $s1 		# check array[j] < array[j-1]	
	bne $t0, 0, statement	# if array[j-1] > array[j], go to statement
	add $t1, $t1, $t6		# array address+4
	addi $t5, $t5, 1		# j++
	j loop2

statement:
	sub $t1, $t1, $t6		# get address of array[j-1]
	sw $s2, 0($t1)			# arr[j-1] = arr[j]
	add $t1, $t1, $t6		# get back to current position
	sw $s1, 0($t1)			# arr[j] = temp(which is the previous array[j-1])
	add $t1, $t1, $t6		# array address+4
	addi $t5, $t5, 1		# j++
	j loop2

print:
    li $s4, 0               # counter to print
    li $s5, 10              # length to print
    la $t1, array

for:
    slt $t0, $s4, $s5       # check s4 < s5
    bne $t0, 0, printArray  # if s4 < s5, go to printArray
    j end

printArray:
    lw $t7,0($t1)
    li $v0, 1               # system call code for print integer
    addi $a0, $t7, 0        # address of integer to print
    syscall                 # print integer
    li $v0, 4
    la $a0, comma           # print comma
    syscall
    addi $s4, $s4, 1        # counter++
    addi $t1, $t1, 4        # address+4
    j for


end:
	li $v0,10				# exit program
	syscall

