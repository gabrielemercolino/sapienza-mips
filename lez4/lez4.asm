.globl main

.text
main:
li $s1, 1
li $s2, 3
add $8, $s1, $s2
# add $t0, $s1, $s2
sub $t1, $s1, $s2

addi $t2, $s2, 4

li $s2, 0x10010000 # indirizzo base RAM
sw $t2, ($s2)	# carica $t2 nella RAM
