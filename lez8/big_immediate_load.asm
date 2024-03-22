.globl big_immediate_load

.data

big_immediate_load_str:	.asciiz "$t0: "

.text
big_immediate_load:
	sub		$sp, $sp, 4
	sw		$ra, 0($sp)

	# Caricare in $t0 la costante 0x 0000 0000 1111 1111 0000 1001 0000 0000 -> 0x00FF0900
	# Carico i primi 16 bit
	lui 	$t0, 0x00FF
	# Carico ora la seconda parte
	ori		$t0, 0x0900
	
	la		$a0, big_immediate_load_str
	jal		print_str
	
	move	$a0, $t0
	jal 	println_int
	jal		println			# just to separate the output
	
	lw		$ra, 0($sp)
	add		$sp, $sp, 4
	jr		$ra
