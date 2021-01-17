#Daeun Sarah Kim

  .data
    digit:
      .word 5, 3
    str1: .asciiz " combination "
    str2: .asciiz " is "

  .text
  .globl main

main:
  la $t0, digit
  lw $t1, 0($t0)    #t1=5(n)
  lw $t2, 4($t0)    #t2=3(k)

  #n!
  move $a0, $t1
  jal fac
  move $t3, $v0     #t3=n!

  #k!
  move $a0, $t2
  jal fac
  move $t4, $v0     #t4=k!

  #(n-k)!
  sub $a0, $t1, $t2 #a0=n-k
  jal fac
  move $t5, $v0     #t5=(n-k)!

  mul $t4, $t4, $t5 #t4=k!*(n-k)!
  div $t3, $t3, $t4  #t3= final result

  #print
  li $v0, 1
  move $a0, $t1
  syscall

  li $v0, 4
  la $a0, str1
  syscall

  li $v0, 1
  move $a0, $t2
  syscall

  li $v0, 4
  la $a0, str2
  syscall

  li $v0, 1
  move $a0, $t3
  syscall

  li $v0, 10
  syscall

fac:
  addi $sp, $sp, -4 #1 item
  sw $ra, 0($sp)
  li $v0, 1
  li $s0, 1
  jal Loop
Loop:
  beq $s0, $a0, ELSE
  mul $v0, $v0, $a0
  sub $a0, $a0, 1
  j Loop
ELSE:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
