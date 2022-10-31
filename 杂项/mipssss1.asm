.data
tes : .space 11111
.text
ori $t0, $0, 4
bne $t0, $t1, next
nop
next:
sw $t0, 4($t1)