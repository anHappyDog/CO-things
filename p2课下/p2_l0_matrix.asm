.data
matrix1 : .space 256
matrix2 : .space 256
matrix3 : .space 256
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

.macro findLoc(%index1,%index2,%ans)
mul %ans,%index1,$s0
add %ans,%ans,%index2
sll %ans,%ans,2
.end_macro

.macro end 
li $v0,10
syscall
.end_macro
.macro printChar(%ans)
li $v0,4
la $a0,%ans
syscall
.end_macro

.text
inputInt($s0)			#n
la $a0,matrix1
jal inputMatrix		#matrix1 input
la $a0,matrix2
jal inputMatrix		#matrix2 input
jal calMatrix
jal printMatrix
end

printMatrix:
li $t8,0
li $t9,0
loop_oneO:
beq $t8,$s0,loop_oneO_end
loop_twoO:
beq $t9,$s0,loop_twoO_end
findLoc($t8,$t9,$t7)
lw $t6,matrix3($t7)
outputInt($t6)
printChar(sp)
addi $t9,$t9,1
j loop_twoO
loop_twoO_end:
addi $t8,$t8,1
li $t9,0
printChar(enter)
j loop_oneO
loop_oneO_end:
jr $ra

inputMatrix:
li $t8,0
li $t9,0
loop_one:
beq $t8,$s0,loop_one_end
loop_two:
beq $t9,$s0,loop_two_end
inputInt($t7)
findLoc($t8,$t9,$t6)
add $t5,$t6,$a0
sw $t7,($t5)
add $t9,$t9,1
j loop_two
loop_two_end:
addi $t8,$t8,1
li $t9,0
j loop_one
loop_one_end:
jr $ra


calMatrix:
li $t7,0
li $t8,0
li $t9,0
loop_one1:
beq $t7,$s0,loop_one1_end
loop_two1:
beq $t8,$s0,loop_two1_end
loop_three:
beq $t9,$s0,loop_three_end

findLoc($t7,$t9,$t6)			#t6 matrix1 index
findLoc($t9,$t8,$t5)
lw $t4 matrix1($t6)
lw $t3 matrix2($t5)
mul $t3,$t3,$t4
add $t2,$t2,$t3

addi $t9,$t9,1
j loop_three
loop_three_end:
li $t9,0
findLoc($t7,$t8,$t6)
sw $t2,matrix3($t6)
addi $t8,$t8,1
li $t2,0
j loop_two1
loop_two1_end:
addi $t7,$t7,1
li $t8,0
j loop_one1
loop_one1_end:
jr $ra




