.data
str : .space 20


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

.macro inputChar(%ans)
li $v0,12
syscall
sb $v0,str(%ans)
addi %ans,%ans,1
.end_macro

.macro inputEnter()
li $v0,12
syscall
.end_macro

.macro isCharEqual(%is,%ans,%all) 
lb $t6,str(%ans)
sub $t8,%all,%ans
subi $t8,$t8,1
lb $t7 str($t8)
seq %is,$t6,$t7
.end_macro

.macro end
li $v0,10
syscall
.end_macro

.text
inputInt($s0)
li $t0,0
loop:
beq $t0,$s0,loop_end
inputChar($t0)
#inputEnter()
j loop
loop_end:
li $t1,1
li $t0,0
div $s1,$s0,2
loop_two:
beq $t1,$0,loop_two_end
beq $t0,$s1,loop_two_end
isCharEqual($t1,$t0,$s0)
addi $t0,$t0,1
j loop_two
loop_two_end:
outputInt($t1)

