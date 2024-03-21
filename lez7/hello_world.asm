.globl hello_world

.data
hello: .asciiz "Hello world"

.text
hello_world:
	sub		$sp, $sp, 4
	sw		$ra, 0($sp)
	
	la 		$a0, hello
	jal 	println_str
	
	lw		$ra, 0($sp)
	add		$sp, $sp, 4
	jr 		$ra
