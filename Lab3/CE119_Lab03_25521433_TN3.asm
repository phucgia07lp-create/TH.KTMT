
.data
n:   .word 20
msg: .asciiz "F(n) = "

.text
.globl main

main:
    lw   $a0, n
    jal  fib_rec

    move $s0, $v0

    li   $v0, 4
    la   $a0, msg
    syscall

    move $a0, $s0
    li   $v0, 1
    syscall

    li   $v0, 10
    syscall



fib_rec:
    addiu $sp, $sp, -12
    sw    $ra, 8($sp)
    sw    $s0, 4($sp)
    sw    $s1, 0($sp)

    move  $s0, $a0

    # Truong hop co so: n < 2
    slti  $t0, $s0, 2
    bne   $t0, $zero, fib_base

    # Tinh F(n-1)
    addiu $a0, $s0, -1
    jal   fib_rec

    move  $s1, $v0

    # Tinh F(n-2)
    addiu $a0, $s0, -2
    jal   fib_rec

    # F(n) = F(n-1) + F(n-2)
    addu  $v0, $s1, $v0
    j     fib_end

fib_base:
    move  $v0, $s0

fib_end:
    lw    $s1, 0($sp)
    lw    $s0, 4($sp)
    lw    $ra, 8($sp)
    addiu $sp, $sp, 12
    jr    $ra



fib_iter:
    move $v0, $zero
    li   $t0, 1
    move $t1, $zero

fi_loop:
    slt   $t2, $t1, $a0
    beq   $t2, $zero, fi_done
    addu  $t3, $v0, $t0
    move  $v0, $t0
    move  $t0, $t3
    addiu $t1, $t1, 1
    j     fi_loop

fi_done:
    jr    $ra
