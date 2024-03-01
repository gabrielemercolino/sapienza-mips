# IMPORTANT:
# 	- set Settings/assemble all files in directory
#		- set Settings/initialize pc to mains
#		- if ".globl main" is set you can start from any file

.globl main

.data
HELLO: .asciiz "Hello world"

.text
print:
	li $v0, 4
	la $a0, HELLO
	syscall
	jr $ra

main:
	li $t1, 100
	add $t1, $t1, $t1
	jal kek
	jal print

exit:
	li $v0, 17
	li $a0, 0
	syscall