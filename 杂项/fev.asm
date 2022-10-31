#ì³²¨ÄÇÆõ
.data
febona : .space 1000

.macro inputInt(%ans)
li $v0,5
syscall
addi %ans,%v0,0
.end_macro

.macro outputInt(%ans)
li $v0,1
addi $v0,%ans,0
syscall
.end_macro


.text
main:
inputInt($s0)






feb:





