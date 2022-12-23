lui $t4, 0x4444
lui $t7, 1234
mult $t4,$t7
mfhi $t3
beq $t3,$0, label
lui $s4, 0x4444
lui $s3, 0xffff
label:
mfhi $t7
mult $s0,$s1
mfhi $t0
mtlo $t7