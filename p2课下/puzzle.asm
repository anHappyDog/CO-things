.data
puzzle : .space 250

#n = s0
#m = s1
#s1 = s2
#s2 = s3
#f1 = s4
#f2 = s5
#ans = s6


.macro end
li $v0,10
syscall
.end_macro

.macro inputInt(%ans)
li $v0,5
syscall
addi %ans,$v0,0
.end_macro

.macro outputInt(%ans)
li $v0,1
addi $a0,%ans,0
syscall
.end_macro

.macro getIndex(%ans,%x,%y)
mul %ans,%x,$s1
add %ans,%ans,%y
.end_macro

.macro inputPuzzle(%ans,%index)
sb %ans,puzzle(%index)
.end_macro

.macro outputPuzzle(%ans,%index)
lb %ans,puzzle(%index)
.end_macro
.text
main:
jal inputInfo
addi $a0,$s2,-1
addi $a1,$s3,-1
jal dfs
outputInt($s6)
end


inputInfo:
inputInt($s0)			#n
inputInt($s1)			#m
				#t0 = i, t1 = j
loop_inputInfo_1:
beq $t0,$s0,loop_inputInfo_1_end
loop_inputInfo_2:
beq $t1,$s1,loop_inputInfo_2_end
inputInt($t2)
getIndex($t3,$t0,$t1)
inputPuzzle($t2,$t3)
addi $t1,$t1,1
j loop_inputInfo_2
loop_inputInfo_2_end:
li $t1,0
addi $t0,$t0,1
j loop_inputInfo_1
loop_inputInfo_1_end:
inputInt($s2)
inputInt($s3)
inputInt($s4)
inputInt($s5)

jr $ra


dfs:
addi $t0,$a0,1
addi $t1,$a1,1
beq $t0,$s4 if_x_equals_f1
j if_x_equals_if_end
if_x_equals_f1:
beq $t1,$s5,if_y_equals_f2
j if_x_equals_if_end
if_y_equals_f2:
addi $s6,$s6,1
jr $ra
if_x_equals_if_end:
getIndex($t0,$a0,$a1)		#t0, x, y

bgt $a0,0,if_x_greater_0
j if_x_greater_0_end
if_x_greater_0:
subi $t1,$a0,1
getIndex($t2,$t1,$a1)
outputPuzzle($t3,$t2)
bne $t3,0,if_x_greater_0_end
li $t3,1
inputPuzzle($t3,$t0)
subi $sp,$sp,16
sw $ra, 0($sp)
sw $a0, 4($sp)
sw $a1, 8($sp)
sw $t0,12($sp)
subi $a0,$a0,1
jal dfs
lw $t0,12($sp)
lw $a1,	8($sp)
lw $a0, 4($sp)
lw $ra, 0($sp)
addi $sp,$sp,16
li $t3,0
inputPuzzle($t3,$t0)
if_x_greater_0_end:
bgt $a1,0,if_y_greater_0
j if_y_greater_0_end
if_y_greater_0:
subi $t1,$a1,1
getIndex($t2,$a0,$t1)
outputPuzzle($t3,$t2)
bne $t3,0,if_y_greater_0_end
li $t3,1
inputPuzzle($t3,$t0)
subi $sp,$sp,16
sw $ra, 0($sp)
sw $a0, 4($sp)
sw $a1, 8($sp)
sw $t0,12($sp)
subi $a1,$a1,1
jal dfs 
lw $t0,12($sp)
lw $a1,	8($sp)
lw $a0, 4($sp)
lw $ra, 0($sp)
addi $sp,$sp,16
li $t3,0
inputPuzzle($t3,$t0)
if_y_greater_0_end:
subi $t1,$s0,1
blt $a0,$t1,if_x_less_n
j if_x_less_n_end
if_x_less_n:
addi $t1,$a0,1
getIndex($t2,$t1,$a1)
outputPuzzle($t3,$t2)
nop
bne $t3,$zero,if_x_less_n_end
li $t3,1
inputPuzzle($t3,$t0)
subi $sp,$sp,16
sw $ra, 0($sp)
sw $a0, 4($sp)
sw $a1, 8($sp)
sw $t0,12($sp)
addi $a0,$a0,1
jal dfs 
lw $t0,12($sp)
lw $a1,	8($sp)
lw $a0, 4($sp)
lw $ra, 0($sp)
addi $sp,$sp,16
li $t3,0
inputPuzzle($t3,$t0)
if_x_less_n_end:

subi $t1,$s1,1
blt $a1,$t1,if_y_less_m
j if_y_less_m_end
if_y_less_m:
addi $t1,$a1,1
getIndex($t2,$a0,$t1)
outputPuzzle($t3,$t2)
bne $t3,0,if_y_less_m_end
li $t3,1
inputPuzzle($t3,$t0)
subi $sp,$sp,16
sw $ra, 0($sp)
sw $a0, 4($sp)
sw $a1, 8($sp)
sw $t0,12($sp)
addi $a1,$a1,1
jal dfs 
lw $t0,12($sp)
lw $a1,	8($sp)
lw $a0, 4($sp)
lw $ra, 0($sp)
addi $sp,$sp,16
li $t3,0
inputPuzzle($t3,$t0)
if_y_less_m_end:
jr $ra



















