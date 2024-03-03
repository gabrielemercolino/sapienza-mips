.macro end_ok
	li $v0, 10
	syscall
.end_macro

.macro print_str (%str)
	li $v0, 4
	la $a0, %str
	syscall
.end_macro

.macro print_const_str (%const_str)
	.data
		myLabel: .asciiz %const_str
	.text
		li $v0, 4
		la $a0, myLabel
		syscall
.end_macro