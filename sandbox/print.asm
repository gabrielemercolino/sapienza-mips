.globl print_int

.data
int_code: .byte 1

.text
print_int:
  lb  $v0, int_code
  syscall
  jr  $ra
