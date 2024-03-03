# IMPORTANT:
#		- set Settings->initialize pc to main\
#		- start from this file
#		- otherwise you can run this from the cli with `mars-mips sm nc test.asm`

.globl main

.include "macros.asm"

.data
HELLO: .asciiz "Hello world\n"

.text
main:
	print_str (HELLO)
	print_const_str ("Pazzesco\n")

exit:
	li $v0, 17	# exit with code
	li $a0, 0		# 0 = no error
	syscall
