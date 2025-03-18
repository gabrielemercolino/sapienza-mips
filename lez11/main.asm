.globl main

.data
MATRICE:  .half 5, 6, 4, 8, 2, 5, 2, 6, 1, 9, 8, 4, 7, 3, 2, 2  # matrice 4x4
LATO:     .half 4

.text
main:
  la  $a0, MATRICE
  lh  $a1, LATO
  jal es1

  move  $s0, $v0
  move  $s1, $v1

  # stampa pari-pari
  move  $a0, $s0
  jal   print_int

  # stampa accapo
  li    $a0, '\n'
  jal   print_char

  # stampa dispari-dispari
  move  $a0, $s1
  jal   print_int

  j   exit_ok

