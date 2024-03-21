.globl diagonale_eff

.data
vec: .word 192:400
DIM: .word 20

.text
diagonale_eff:
	la 		$t0, vec
	lw 		$t1, DIM
	mul 	$t3, $t1, $t1
	sll 	$t3, $t3, 2
	add 	$t3, $t3, $t0
	addi 	$t1, $t1, 1
	sll 	$t1, $t1, 2
	li 		$t2, 0

ciclo:
	bge		$t0, $t3, fine
	lw 		$t4, ($t0)
	add 	$t2, $t4, $t2
	add		$t0, $t0, $t1
	j ciclo

fine:
	move	$a0, $t2
	li		$v0, 1
	syscall
	jr $ra