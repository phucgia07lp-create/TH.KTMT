

        .data
n:      .word 20
msg:    .asciiz "F(n) = "

        .text
        .globl main
main:
        la    $a0, msg
        li    $v0, 4
        syscall                 # in "F(n) = "
        lw    $a0, n            # $a0 = n
        jal   fib_opt            # $v0 = F(n)
        move  $a0, $v0
        li    $v0, 1
        syscall                 # in F(n)
        li    $v0, 10
        syscall


fib_opt:
        slti  $t0, $a0, 2
        beq   $t0, $zero, fo_rec
        move  $v0, $a0          # truong hop co so: tra ve ngay, khong cap khung
        jr    $ra
fo_rec:
        addi  $sp, $sp, -12     # mo dau: chi cap khung khi n >= 2
        sw    $ra, 8($sp)
        sw    $s0, 4($sp)
        sw    $s1, 0($sp)
        move  $s0, $a0
        addi  $a0, $s0, -1
        jal   fib_opt           # v0 = F(n-1)
        move  $s1, $v0
        addi  $a0, $s0, -2
        jal   fib_opt           # v0 = F(n-2)
        addu  $v0, $s1, $v0
        lw    $s1, 0($sp)       # ket thuc
        lw    $s0, 4($sp)
        lw    $ra, 8($sp)
        addi  $sp, $sp, 12
        jr    $ra


fib_iter:
        move  $v0, $zero        # a = F(0)
        li    $t0, 1            # b = F(1)
        move  $t1, $zero        # i = 0
fi_loop:
        slt   $t2, $t1, $a0
        beq   $t2, $zero, fi_done
        addu  $t3, $v0, $t0     # a + b
        move  $v0, $t0
        move  $t0, $t3
        addiu $t1, $t1, 1
        j     fi_loop
fi_done:
        jr    $ra
