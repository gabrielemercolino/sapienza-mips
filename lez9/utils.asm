.globl exit_ok exit

.data

exit_ok_code:   .byte 10
exit_with_code: .byte 17

.text
exit_ok:
	lb	$v0, exit_ok_code
	syscall

exit:
  lb  $v0, exit_with_code
  syscall
