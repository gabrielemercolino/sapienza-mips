.globl es1

.text
es1:
  sub $sp, $sp, 4
  sw  $ra, 0($sp)
  
  jal sommaScacchiera

  lw  $ra, 0($sp)
  add $sp, $sp, 4
  jr $ra


# sommaScacchiera(short& matrice, short lato) -> (int, int)
# $a0 -> indirizzo base della matrice
# $a1 -> lunghezza lato
# $v0 -> somma pari-pari
# $v1 -> somma dispari-dispari
#
# ricordo che M[x, y] = $a0 + (LATO * x + y) * 2
sommaScacchiera:
  sub $sp, $sp, 4
  sw  $ra, 0($sp)

  li  $v0, 0
  li  $v1, 0



  lw  $ra, 0($sp)
  add $sp, $sp, 4
  jr  $ra
