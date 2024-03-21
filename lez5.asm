.globl main

.data
vettore: .word 10, 20, 12, 9
result: .word 0 

.text
main:
	#jal esercizio1
	lw $a0, vettore + 0
	lw $a1, vettore + 4
	lw $a2, vettore + 8
	lw $a3, vettore + 12
	jal max
	sw $v0, result
	j exit

# max(a, b, c, d : int) -> int
max:
	# $a0 = a
	# $a1 = b
	# $a2 = c
	# $a3 = d
	
	# max = a
	move $v0, $a0
	# if(b<max) max = b;
	check_b:
	slt $t0, $v0, $a1
	beq $t0, $zero, check_c
	move $v0, $a1
	# if(c<max) max = c;
	check_c:
	slt $t0, $v0, $a2
	beq $t0, $zero, check_d
	move $v0, $a2
	# if(d<max) max = d;
	check_d:
	slt $t0, $v0, $a3
	beq $t0, $zero, end
	move $v0, $a3
	# return max;
	end:
	jr $ra

exit: