.data
matrix1 : .space 400
matrix2 : .space 400
matrix3 : .space 400
sp : .asciiz " "
enter : .asciiz "\n"

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

.macro end
li $v0,10
syscall
.end_macro

.macro findLoc(%index1,%index2,%all1,%ans)
mul %ans,%index1,%all1
add %ans,%ans,%index2
sll %ans,%ans,2
.end_macro

.macro printChar(%ans)
li $v0,4
la $a0,%ans
syscall
.end_macro

.text
inputInt($s0)			#m1 
inputInt($s1)			#n1
inputInt($s2)			#m2
inputInt($s3)			#n2
sub $s4,$s0,$s2			#m1 - m2 + 1
addi $s4,$s4,1
sub $s5,$s1,$s3			#n1 - n2 + 1
addi $s5,$s5,1
addi $a0,$s0,0
addi $a1,$s1,0
la $a2,matrix1			
jal inputMatrix
addi $a0,$s2,0
addi $a1,$s3,0
la $a2,matrix2
jal inputMatrix
jal calMatrix
jal printMatrix
end


inputMatrix:			#a0,行，a1,列,#a2，矩阵名
li $t8,0
li $t9,0
loop_one1:
beq $t8,$a0,loop_one1_end
loop_two1:
beq $t9,$a1,loop_two1_end
inputInt($t7)
findLoc($t8,$t9,$a1,$t6)
add $t5,$a2,$t6
sw $t7,($t5)
addi $t9,$t9,1
j loop_two1
loop_two1_end:
li $t9,0
addi $t8,$t8,1
j loop_one1
loop_one1_end:
jr $ra

calMatrix:			#t5，做下标, t4 做总加 ,t2,t3求矩阵元素
li $t6,0
li $t7,0
li $t8,0
li $t9,0
loop_one2:
beq $t6,$s4,loop_one2_end
loop_two2:
beq $t7,$s5,loop_two2_end
loop_three2:
beq $t8,$s2,loop_three2_end
loop_four2:
beq $t9,$s3,loop_four2_end
add $s6,$t6,$t8
add $s7,$t7,$t9
findLoc($s6,$s7,$s1,$t5)
lw $t4,matrix1($t5)
findLoc($t8,$t9,$s3,$t5)
lw $t3,matrix2($t5)
mul $t4,$t4,$t3
add $t2,$t2,$t4

addi $t9,$t9,1
j loop_four2
loop_four2_end:

li $t9,0
addi $t8,$t8,1
j loop_three2
loop_three2_end:
findLoc($t6,$t7,$s5,$t5)
sw $t2,matrix3($t5)
li $t2,0
li $t8,0
addi $t7,$t7,1
j loop_two2
loop_two2_end:
li $t7,0
addi $t6,$t6,1
j loop_one2
loop_one2_end:
jr $ra

printMatrix:
li $t8,0
li $t9,0
loop_one3:
beq $t8,$s4,loop_one3_end
loop_two3:
beq $t9,$s5,loop_two3_end
findLoc($t8,$t9,$s5,$t7)
lw $t6,matrix3($t7)
outputInt($t6)
printChar(sp)
addi $t9,$t9,1
j loop_two3
loop_two3_end:
printChar(enter)
li $t9,0
addi $t8,$t8,1
j loop_one3
loop_one3_end:
jr $ra


