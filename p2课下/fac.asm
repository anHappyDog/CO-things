.data 
ans : .space 4100

.macro inputInt(%ans)
li $v0,5
syscall
addi %ans,$v0,0
.end_macro


.macro inputChar(%ans,%index)
sb %ans,ans(%index)
.end_macro

.macro outputChar(%ans,%index)
lb %ans,ans(%index)
.end_macro

.macro end
li $v0,10
syscall
.end_macro


.text
main:
inputInt($s0)			#s0 = n
li $s1,1				#s1 = digit 
sb $s1,ans
jal factorial
jal printAns
end

			#s5 = 10
factorial:
li $s2,2		#i
li $s5,10
loop_factorial_1:
bgt $s2,$s0,loop_factorial_1_end
li $s3,0		#nums
li $s4,0		#j
loop_factorial_2:
beq $s4,$s1,loop_factorial_3
outputChar($t0,$s4)
mul $t1,$t0,$s2
add $t1,$t1,$s3
div $t1,$s5
mflo $s3
mfhi $t0
inputChar($t0,$s4)
addi $s4,$s4,1
j loop_factorial_2
loop_factorial_3:
beq $s3,0,loop_factorial_3_end
div $s3,$s5
mflo $s3
mfhi $t0
inputChar($t0,$s1)
addi $s1,$s1,1
j loop_factorial_3
loop_factorial_3_end:
addi $s2,$s2,1
j loop_factorial_1
loop_factorial_1_end:
jr $ra





printAns:
subi $t0,$s1,1
li $v0,1
loop_printAns_1:
beq $t0,-1,loop_printAns_1_end
lb $a0,ans($t0)
syscall
subi $t0,$t0,1
j loop_printAns_1
loop_printAns_1_end:
jr $ra




