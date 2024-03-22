.globl main

.text
main:
	jal		big_immediate_load
	
	################################
	
	# salti di tipo branch	-> spiazzamento relativo							es: beq $s1, $s0, 3
	# salti assoluti 				-> indirizzo di destinazione assoluto	es: j	399372
	
	################################
	
# problema: le funzioni potrebbero sporcare registri usati
.data
before_func_str:	.asciiz "Before: "
after_func_str:		.asciiz "After: "
wo_stack_str:			.asciiz "W/o using stack:"
with_stack_str:		.asciiz "With stack:"
.text
	la		$a0, wo_stack_str
	jal		println_str
	
	li		$s0, 10

	# print(f"Before: {$a0}")
	la		$a0, before_func_str
	jal		print_str
	move	$a0, $s0
	jal		println_int
	
	jal		func	# $ra <- PC+4
	
	# print(f"After: {$a0}")
	la		$a0, after_func_str
	jal		print_str
	move	$a0, $s0
	jal 	println_int
	
# soluzione: il chiamante deve salvare i registri rilevanti prima di chiamare la funzione nello stack
	la		$a0, with_stack_str
	jal		println_str
	
	li		$s0, 10

	# Salvo nello stack
	sub		$sp, $sp, 4	# prima faccio spazio (4 byte = 1 word)
	sw		$s0, 0($sp)	# salvo la word
	
	# print(f"Before: {$a0}")
	la		$a0, before_func_str
	jal		print_str
	move	$a0, $s0
	jal		println_int
	
	jal		func	# $ra <- PC+4
	
	lw		$s0, 0($sp)	# ricarico la word
	add		$sp, $sp, 4	# ripristino lo spazio occupato
	
	# print(f"After: {$a0}")
	la		$a0, after_func_str
	jal		print_str
	move	$a0, $s0
	jal 	println_int
	jal		println
	
	jal 	foo
	jal		println
	
	li		$a0, 1
	li		$a1, 12
	li		$a2, 16
	li		$a3, 10
	jal 	averageOfSquareAbsAndSub
	move	$s0, $v0
.data
result_str:	.asciiz "Result: "
.text
	la		$a0, result_str
	jal		print_str
	move	$a0, $s0
	jal		println_int
	
	jal	exit_ok

# Funzioni
func:
	#...
	li	$s0, 0
	jr	$ra		# PC <- $ra

.data
foo_before_str: .asciiz "Chiamo bar"
foo_after_str: .asciiz "Esco da foo"
.text
foo:
	# se chiamo altre funzioni internamente devo salvare $ra
	sub		$sp, $sp, 4
	sw		$ra, 0($sp)
	
	la		$a0, foo_before_str
	jal 	println_str
	
	jal 	bar
	
	la		$a0, foo_after_str
	jal 	println_str
	
	# ripristino $ra
	lw		$ra, 0($sp)
	add		$sp, $sp, 4
	jr		$ra

.data
bar_str: .asciiz	"Dentro bar"
.text
bar:
	sub		$sp, $sp, 4
	sw		$ra, 0($sp)
	
	la		$a0, bar_str
	jal		println_str
	
	lw		$ra, 0($sp)
	add		$sp, $sp, 4
	jr		$ra
	
#####################################################

# f(x,y,z,w) = [ (|x|-|y|)^2 + (|w|-|z|)^2 ] / 2

# squareAndSub(x: int, y: int) -> int
# return (|$a0|-|$a1|)^2
squareAndSub:
	sub		$sp, $sp, 12
	sw		$ra, 0($sp)
	sw		$a0, 4($sp)
	sw		$a1, 8($sp)
	
	abs		$a0, $a0
	abs		$a1, $a1
	
	sub		$v0, $a0, $a1
	mul		$v0, $v0, $v0
	
	lw		$a1, 8($sp)
	lw		$a0, 4($sp)
	lw		$ra, 0($sp)
	add		$sp, $sp, 12
	jr		$ra

#	f($a0,$a1,$a2,$a3) -> int
# return [(|$a0|-|$a1|)^2 + (|$a2|-|$a3|)^2] / 2
averageOfSquareAbsAndSub:
	sub		$sp, $sp, 12
	sw		$ra, 0($sp)
	sw		$s0, 4($sp)
	sw		$s1, 8($sp)
	
	jal 	squareAndSub
	move	$s0, $v0
	
	move	$a0, $a2
	move	$a1, $a3
	jal 	squareAndSub
	move	$s1, $v0
	
	add		$v0, $s0, $s1
	srl		$v0, $v0, 2		# $v0 / 2
	
	lw		$s1, 8($sp)
	lw		$s0, 4($sp)
	lw		$ra, 0($sp)
	add		$sp, $sp, 12

	jr		$ra
