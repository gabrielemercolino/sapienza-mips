.globl main

.data
N:        .word 5
iter_str: .asciiz "iterativo: "
rec_str:  .asciiz "ricorsivo: "

.text
main:
  la    $a0, iter_str
  jal   print_str

  lw    $a0, N
  jal   fattoriale_iterativo
  
  move  $a0, $v0
  jal   println_int

  la    $a0, rec_str
  jal   print_str

  lw    $a0, N
  jal   fattoriale_ricorsivo

  move  $a0, $v0
  jal   println_int

  jal   exit_ok


# fattoriale_ricorsivo(int) -> int
fattoriale_ricorsivo:
  blez  $a0, BaseCase

RecursiveStep:
  sub   $sp, $sp, 8
  sw    $ra, 0($sp)
  sw    $a0, 4($sp)

  subi  $a0, $a0, 1
  jal   fattoriale_ricorsivo

  lw    $a0, 4($sp)
  lw    $ra, 0($sp)
  add   $sp, $sp, 8
  
  mul   $v0, $v0, $a0
  jr    $ra

BaseCase:
  li    $v0, 1
  jr    $ra

# fattoriale_iterativo(int) -> int
fattoriale_iterativo:
  li    $v0, 1

while:
  beq   $a0, $zero, end  
  mul   $v0, $v0, $a0
  subi  $a0, $a0, 1
  j     while

end:
  jr    $ra
