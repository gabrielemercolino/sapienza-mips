.globl hello_world

.data
hello: .asciiz "Hello world\n"

.text
hello_world:
	la 		$a0, hello
	li 		$v0, 4
	syscall
	jr $ra