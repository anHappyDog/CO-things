.data
symbol : .space 28
array : .space 28
#n = s0

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

.macro inputArray(%index,%arr,%ans)
sb %ans,%arr(%index)
.end_macro

.macro getArray(%index,%arr,%ans)
lb %ans,%arr(%index)
.end_macro


.text
main:
inputInt($s0) 			#scanf("%d",&n);
li $a0,0
jal FullArray
end

FullArray:
bge $a0,$s0,if_index_greater_n
li $t0,0
loop_i_n_one:
beq $t0,$s0,loop_i_n_one_end
addi $t1,$t0,1
inputArray($a0,array,$t1)
li $t1,1
inputArray($t0,symbol,$t1)
subi $sp,$sp,8
sw $ra,0($sp)
sw $a0,4($sp)
jal FullArray
lw $a0,4($sp)
lw $ra,0($sp)
addi $sp,$sp,8
li $t1,0
inputArray($t0,symbol,$t1)
addi $t0,$t0,1
j loop_i_n_one
loop_i_n_one_end:
jr $ra
if_index_greater_n:
li $t0,0
loop_i_n_two:
beq $t0,0

jr $ra




























