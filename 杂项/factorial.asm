.data
ans : .space 1600
tmpStr1 : .space 1600
tmpStr2 : .space 1600
					#n : $s0
					#ns : $s1
					
.macro scanf(%ans)
li $v0,5
syscall
addi %ans,$v0,0
.end_macro

.macro end
li $v0,10
syscall
.end_macro

.macro inputChar(%ans,%char,%index)
sb %ans,%char(%index)
.end_macro

.macro outputChar(%ans,%char,%index)
lb %ans,%char(%index)
.end_macro

.macro printChar(%index)
lb $a0,ans(%index)
li $v0, 1
syscall
.end_macro

.text
main:
scanf($s0)
li $a0,1
li $t5,10
jal factorial
jal printAns
end



factorial:
					#s7 === tmpStr2Index
					#s6 === tmpStr1Index
					#s5 === tmp1
					#s4 === shi
					#s3 === ge
					#s2 === wei
bgt $a0,$s0,if_index_greater_n

beq $a0,1 if_index_equals_1

#					else if(index > 0 ^&& index < 10)
blt $a0,10,if_index_less_10

###此处填写index > 9内容
#li $t5,10
div $a0,$t5
mfhi $s3
mflo $s4
li $s6,0
li $s7,0
loop_tmpStr1_1:
beq $s6,$s1,loop_tmpStr1_1_end
outputChar($t0,ans,$s6)
mul $s5,$t0,$s3
add $s5,$s5,$s2				# tmp1 = ans[tmpStr1index] * ge + wei
div $s5,$t5
mflo $s2
mfhi $s5
inputChar($s5,tmpStr1,$s6)
addi $s6,$s6,1
j loop_tmpStr1_1
loop_tmpStr1_1_end:
bne $s2,0,if_wei_not_0_3
j if_wei_not_0_3_end
if_wei_not_0_3:
inputChar($s2,tmpStr1,$s6)
addi $s6,$s6,1
li $s2,0
if_wei_not_0_3_end:			#tmpStr1 : wei !=0
#li $t0,0
#inputChar($s7,tmpStr2,$t0)
loop_tmpStr2_1:
beq $s7,$s1,loop_tmpStr2_1_end
outputChar($t0,ans,$s7)
mul $s5,$t0,$s4
add $s5,$s5,$s2
div $s5,$t5
mfhi $s5
mflo $s2
addi $t1,$s7,1
inputChar($s5,tmpStr2,$t1)
addi $s7,$s7,1
j loop_tmpStr2_1
loop_tmpStr2_1_end:
addi $s7,$s7,1
bne $s2,0,if_wei_not_0_4
j if_wei_not_0_4_end
if_wei_not_0_4:
inputChar($s2,tmpStr2,$s7)
addi $s7,$s7,1
li $s2,0
if_wei_not_0_4_end:
li $t0,0
loop_ts1_and_ts2:
bge $t0,$s6,loop_ts1_and_ts2_end
bge $t0,$s7,loop_ts1_and_ts2_end
outputChar($t1,tmpStr1,$t0)
outputChar($t2,tmpStr2,$t0)
add $s5,$t1,$t2
add $s5,$s5,$s2
div $s5,$t5
mfhi $s5
mflo $s2
inputChar($s5,ans,$t0)
addi $t0,$t0,1
j loop_ts1_and_ts2
loop_ts1_and_ts2_end:
bgt $s6,$s7,ts1_greater_ts2

loop_tmpStr1_less_tmpStr2:
beq $s6,$s7,loop_tmpStr1_less_tmpStr2_end
outputChar($t0,tmpStr2,$s6)
add $s5,$t0,$s2
div $s5,$t5
mfhi $s5
mflo $s2
inputChar($s5,ans,$s6)
addi,$s6,$s6,1
j loop_tmpStr1_less_tmpStr2
loop_tmpStr1_less_tmpStr2_end:
addi $s1,$s7,0			#ns = tmpStr2index;
j ts1_greater_ts2_end
ts1_greater_ts2:
loop_tmpStr1_greater_tmpStr2:
beq $s7,$s6,loop_tmpStr1_greater_tmpStr2_end
outputChar($t0,tmpStr1,$s7)
add $s5,$t0,$s2
div $s5,$t5
mfhi $s5
mflo $s2
inputChar($s5,ans,$t0)
addi $s7,$s7,1
j loop_tmpStr1_greater_tmpStr2
loop_tmpStr1_greater_tmpStr2_end:
addi $s1,$s6,0
ts1_greater_ts2_end:
bne $s2,0,if_wei_not_zero
j if_wei_not_zero_end
if_wei_not_zero:
inputChar($s2,ans,$s1)
addi $s1,$s1,1
li $s2,0
j if_wei_not_zero_end
if_wei_not_zero_end:

###end
j if_index_less_10_end
if_index_less_10:
###此处填写index < 10 内容
li $t8,0
loop_i_less_ns:
beq $t8,$s1,loop_i_less_ns_end
### tmp1 = (ans[i] - '0') * index + wei;
outputChar($t7,ans,$t8)
mul $s5,$t7,$a0
add $s5,$s5,$s2
###end
### wei = tmp1 / 10;
#div $s2,$s5,10
###end
### tmp1 %= 10;     tmp1 = $s5
#mul $t7,$s2,10
#sub $s5,$s5,$t7
div $s5,$t5
mflo $s2
mfhi $s5

### ans[i] = tmp1 + '0';
inputChar($s5,ans,$t8)
### end
addi $t8,$t8,1
j loop_i_less_ns
loop_i_less_ns_end:
### if(wei != 0)
bne $s2,0,if_wei_not_0_1
j if_index_less_10_end
if_wei_not_0_1:
inputChar($s2,ans,$s1)
li $s2,0
addi $s1,$s1,1
###end
###end
if_index_less_10_end:
subi $sp,$sp,4
sw $ra,0($sp)
addi $a0,$a0,1
jal factorial
lw $ra,0($sp)
addi $sp,$sp,4
jr $ra

j if_index_equals_1_end
if_index_equals_1:
li $t8,1
inputChar($t8,ans,$t7)
addi $s1,$s1,1
subi $sp,$sp,4
sw $ra,0($sp)
addi $a0,$a0,1
jal factorial
lw $ra,0($sp)
addi $sp,$sp,4
jr $ra
if_index_equals_1_end:

#j if_index_greater_n_end
if_index_greater_n:
jr $ra
##if_index_greater_n_end:
##jr $ra




printAns:
subi $t9,$s1,1
loop_for_print:
beq $t9,-1 loop_for_print_end
printChar($t9)
subi $t9,$t9,1
j loop_for_print
loop_for_print_end:
jr $ra
