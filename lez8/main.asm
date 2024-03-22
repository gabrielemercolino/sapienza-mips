.globl main

.text
main:
	# Caricare in $t0 la costante 0x 0000 0000 1111 1111 0000 1001 0000 0000 -> 0x00FF0900
	# Carico i primi 16 bit
	lui 	$t0, 0x00FF
	# Carico ora la seconda parte
	ori		$t0, 0x0900
	
	move	$a0, $t0
	#jal print_int
	
	################################
	
	# salti di tipo branch -> spiazzamento relativo					es: beq $s1, $s0, 3
	# salti assoluti -> indirizzo di destinazione assoluto	es: j	399372
	
	################################
	li		$s0, 10
	jal	func	# $ra <- PC+4
	
	move	$a0, $s0
	jal println_int
	# problema: le funzioni potrebbero sporcare registri usati
	# soluzione: il chiamante deve salvare i registri rilevanti prima di chiamare la funzione nello stack
	
	li		$s0, 10
	
	# Salvo nello stack
	sub		$sp, $sp, 4	# prima faccio spazio (4 byte = 1 word)
	sw		$s0, 0($sp)	# salvo la word
	jal	func
	lw		$s0, 0($sp)	# ricarico la word
	add		$sp, $sp, 4	# ripristino lo spazio occupato
	
	move	$a0, $s0
	jal println_int
	
	jal foo
	
	li		$a0, 1
	li		$a1, 12
	li		$a2, 16
	li		$a3, 10
	jal averageOfSquareAbsAndSub
	
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
	jal println_str
	
	jal bar
	
	la		$a0, foo_after_str
	jal println_str
	
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
	
	jal squareAndSub
	move	$s0, $v0
	
	move	$a0, $a2
	move	$a1, $a3
	jal squareAndSub
	move	$s1, $v0
	
	add		$v0, $s0, $s1
	srl		$v0, $v0, 2		# $v0 / 2
	
	lw		$s1, 8($sp)
	lw		$s0, 4($sp)
	lw		$ra, 0($sp)
	add		$sp, $sp, 12

	jr		$ra