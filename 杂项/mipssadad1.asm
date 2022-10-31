ori $a0, $0, 1
ori $a1, $0, 10
ori $a2, $0, 20
loop:
addi $a0, $a0, 1
addi $a2, $a2, -2
bne $a0, $a1, loop
nop
li $v0, 10
syscall