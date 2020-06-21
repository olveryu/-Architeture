print:
    li $s4, 0               # counter to print
    li $s5, 10              # length to print
    li $s6, 40
    sub $t1, $t1, $s6

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
