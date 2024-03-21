.globl main

.include "utils.asm"
#.include "diagonale_eff.asm"
.include "hello_world.asm"

.data

.text
main:
	#jal diagonale_eff
	jal hello_world
	j exit_ok