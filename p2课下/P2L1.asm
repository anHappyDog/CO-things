.data
symbol : .space 28
array : .space 28
sp : .asciiz " "
enter : .asciiz "\n"

 .macro end
 li $v0,10
 syscall
 .end_macro
 
 .macro outputInt(%ans)
 li $v0,1
 addi $a0,%ans,0
 syscall
 .end_macro
 
 
 .macro inputInt(%ans) 
 li $v0,5
 syscall
 addi %ans,$v0,0
 .end_macro
 
.macro outputSpace
la $a0,sp
li $v0,4
syscall
.end_macro

.macro outputEnter
la $a0,enter
li $v0,4
syscall
.end_macro

.macro outputSymbol(%loc,%ans)
sll $t9,%loc,2
lw %ans,symbol($t9)
.end_macro

.macro inputSymbol(%loc,%ans)
sll $t9,%loc,2
sw %ans,symbol($t9)
.end_macro

.macro inputArray(%index,%ans)
sll $t9,%index,2
sw %ans,array($t9)
.end_macro

.macro outputArray(%ans)
li $v0,1
sll $t9,%ans,2
lw $a0,array($t9)
syscall
addi %ans,%ans,1
.end_macro

.text
main:
inputInt($s0)			#scanf("%d",&n);
jal FullArray			#FullArray(0);
end				#return 0;
      
FullArray:
bge $a0,$s0,if_one		#if(index >= n)
li $t0,0
loop_two:
beq $t0,$s0,loop_two_end
outputSymbol($t0,$t1)		#t1 = symbol[i]
bne $t1,0,if_two
addi $t2,$t0,1
inputArray($a0,$t2)
li $t2,1
inputSymbol($t0,$t2)

subi $sp,$sp,12
sw $ra,0($sp)
sw $t0,4($sp)
sw $a0,8($sp)
addi $a0,$a0,1
jal FullArray

lw $a0,8($sp)
lw $t0,4($sp)
lw $ra,0($sp)
addi $sp,$sp,12

li $t2,0
inputSymbol($t0,$t2)
if_two:
addi $t0,$t0,1
j loop_two
loop_two_end:
j if_one_end
if_one:
li $t0,0
loop_one:
beq $t0,$s0,loop_one_end
outputArray($t0)		#printf("%d ",array[i]); i++
outputSpace
j loop_one
loop_one_end:
outputEnter			#printf("\n");
j if_one_end
if_one_end:
jr $ra





   
   
   
   
   
   
   
   
   
   
   
   
   
   