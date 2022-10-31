
li $v0, 5
syscall
addi $s0, $v0, 0
li $a0, 0
la $a0, ($s0)
li $v0, 1
syscall
li $v0, 10
syscall