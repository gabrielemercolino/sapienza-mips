.globl main

.include "print.asm"

.data
MATRIX: .word 1, 2, 3, 
              4, 5, 6, 
              7, 8, 9
N:      .word 3
.text

main:
  la  $a0, MATRIX
  lw  $a1, N
  li  $a2, 0
  li  $a3, 1

  jal sum_diagonal

  move $s0, $v0

  li  $a2, 1
  li  $a3, 0

  jal sum_diagonal

  add   $s0, $s0, $v0
  move  $a0, $s0
  jal   print_int

  j exit

exit:
  li  $v0, 10
  syscall

# a0 starting address of MATRIX
# a1 MATRIX length
# a2 0 if main diagonal, 1 otherwise
# a3 0 if don't include center element (if present), 1 otherwise
# sum_diagonal(int32* a0, int32 a1, boolean a2, boolean a3)
sum_diagonal:
  subi  $sp, $sp, 20   # space for params and $ra
  sw    $a0, 16($sp)
  sw    $a1, 12($sp)
  sw    $a2, 8($sp)
  sw    $a3, 4($sp)
  sw    $ra, 0($sp)

  move  $v0, $a1  # use $s0 to store the row length
  sll   $v0, $v0, 2

  # check if we want the center element
  bnez  $a3, no_center_skip
  # if we want to skip then we need to find it with N x N / 2
  mul   $a3, $a1, $a1
  srl   $a3, $a3, 1
  # remember that they are words 
  sll   $a3, $a3, 2
  add   $a3, $a3, $a0
  j     center_end
  no_center_skip:
  # if we want the center element we still need to set the element to skip
  # but we can set it to an address out of range
  and  $a3, $a3, $zero
  center_end:

  # we calculate the end of the MATRIX with N x N
  mul   $a1, $a1, $a1
  sll   $a1, $a1, 2
  add   $a1, $a0, $a1 # add the base address
  # check if we want the main diagonal
  beqz  $a2, limit_end
  # if we want the secondary diagonal the limit is the first elementof the last row
  # still it is ok to just set the limit to the previous latest element and it will still work
  sub   $a1, $a1, 4
  limit_end:

  # calculate the leap factor
  bnez $a2, leap_secondary
  # if in main diagonal the leap factor is N + 1
  move  $a2, $v0
  addi  $a2, $a2, 4
  j leap_end
  leap_secondary:
  # if in secondary diagonal leap factor is N - 1
  move  $a2, $v0
  subi  $a2, $a2, 4
  leap_end:

  # ensure the starting value is set to 0
  move  $v0, $zero
  
  jal   sum_diagonal_rec

  lw    $a0, 16($sp)
  lw    $a1, 12($sp)
  lw    $a2, 8($sp)
  lw    $a3, 4($sp)
  lw    $ra, 0($sp)
  addi  $sp, $sp, 20

  jr    $ra

# $a0 starting address (or current)
# $a1 limit address
# $a2 offset for next element
# $a3 address to skip
sum_diagonal_rec:
  subi  $sp, $sp, 8
  sw    $a0, 4($sp)
  sw    $ra, 0($sp)

  bge   $a0, $a1, base_case
  # if we are inside the MATRIX we check if it is the element to skip
  beq   $a0, $a3, recursive_step
  lw    $t0, ($a0)
  add   $v0, $v0, $t0
  
  recursive_step:
  add   $a0, $a0, $a2
  jal   sum_diagonal_rec

  base_case:
  lw    $a0, 4($sp)
  lw    $ra, 0($sp)
  addi  $sp, $sp, 8

  jr    $ra
