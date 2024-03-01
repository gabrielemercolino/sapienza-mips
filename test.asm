# IMPORTANT:
# 	- set Settings->assemble all files in directory
#		- set Settings->initialize pc to main
#		- if ".globl main" is set you can start from any file

.globl main

.data
HELLO: .asciiz "Hello world\n"

.text
main:
	# print_string(string& v0)
	la $v0, HELLO
	jal print_string

exit:
	li $v0, 17	# exit with code
	li $a0, 0		# 0 = no error
	syscall
