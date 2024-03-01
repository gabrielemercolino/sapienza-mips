.globl print_string

# print_string(string& v0)
print_string:
	move $a0, $v0
	li $v0, 4
	syscall
	jr $ra