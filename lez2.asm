.data
result_str: .asciiz "result: "

.text
main:
	li $s1, 1
	li $s2, 3
	add $s3, $s1, $s2
	
	li $v0, 4
	la $a0, result_str
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall