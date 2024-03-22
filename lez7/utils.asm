.globl exit_ok

.data

ok_code: .byte 10

.text
exit_ok:
	li	$v0, ok_code
	syscall

