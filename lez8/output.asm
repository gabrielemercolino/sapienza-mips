.globl print_int 	 print_float 	 print_double 	print_str   print_char
.globl println_int println_float println_double println_str println_char	println

.globl int_code    float_code    double_code    str_code    char_code

.data

int_code:			.byte 1	
float_code:		.byte	2
double_code:	.byte 3
str_code:			.byte	4
char_code:		.byte	11

.text

# $a0: int
print_int:
	lb	$v0, int_code
	syscall
	jr 	$ra

# $f12: float
print_float:
	lb	$v0, float_code
	syscall
	jr 	$ra

# $f12: double
print_double:
	lb	$v0, double_code
	syscall
	jr 	$ra

# $a0: &string
print_str:
	lb	$v0, str_code
	syscall
	jr 	$ra

# $a0: char
print_char:
	lb	$v0, char_code
	syscall
	jr 	$ra

############ println section

# $a0: int
println_int:
	sub	$sp, $sp, 4
	sw	$ra, 0($sp)
	
	jal print_int
	li	$a0, '\n'
	jal	print_char
	
	lw	$ra, 0($sp)
	add	$sp, $sp, 4
	jr 	$ra

# $f12: float
println_float:
	sub	$sp, $sp, 4
	sw	$ra, 0($sp)
	
	jal print_float
	li	$a0, '\n'
	jal	print_char
	
	lw	$ra, 0($sp)
	add	$sp, $sp, 4
	jr 	$ra

# $f12: double
println_double:
	sub	$sp, $sp, 4
	sw	$ra, 0($sp)
	
	jal print_double
	li	$a0, '\n'
	jal	print_char
	
	lw	$ra, 0($sp)
	add	$sp, $sp, 4
	jr 	$ra

# $a0: &string
println_str:
	sub	$sp, $sp, 4
	sw	$ra, 0($sp)
	
	jal print_str
	li	$a0, '\n'
	jal	print_char
	
	lw	$ra, 0($sp)
	add	$sp, $sp, 4
	jr 	$ra

# $a0: char
println_char:
	sub	$sp, $sp, 4
	sw	$ra, 0($sp)
	
	jal print_char
	li	$a0, '\n'
	jal	print_char
	
	lw	$ra, 0($sp)
	add	$sp, $sp, 4
	jr 	$ra

println:
	sub	$sp, $sp, 4
	sw	$ra, 0($sp)
	
	li	$a0, '\n'
	jal	print_char
	
	lw	$ra, 0($sp)
	add	$sp, $sp, 4
	jr 	$ra
