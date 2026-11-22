
.data
str1: .asciiz "kien truc may tinh"
str2: .asciiz "mips"
str3: .asciiz ""
str4: .asciiz "a bc def"
str5: .asciiz "thanh ghi s phai duoc bao toan"

tests: .word str1, str2, str3, str4, str5

.text
.globl main

main:
    la   $a0, str5
    jal  reverse_words

    # In ky tu |
    li   $a0, 124
    li   $v0, 11
    syscall

    # In chuoi sau khi dao
    la   $a0, str5
    li   $v0, 4
    syscall

    # In ky tu |
    li   $a0, 124
    li   $v0, 11
    syscall

    # Ket thuc
    li   $v0, 10
    syscall



strlen:
    move $t0, $a0
    move $v0, $zero

len_loop:
    lbu  $t1, 0($t0)
    beq  $t1, $zero, len_done
    addiu $v0, $v0, 1
    addiu $t0, $t0, 1
    j    len_loop

len_done:
    jr   $ra



rev_range:
rev_loop:
    sltu $t0, $a0, $a1
    beq  $t0, $zero, rev_done

    lbu  $t1, 0($a0)
    lbu  $t2, 0($a1)

    sb   $t2, 0($a0)
    sb   $t1, 0($a1)

    addiu $a0, $a0, 1
    addiu $a1, $a1, -1
    j    rev_loop

rev_done:
    jr   $ra



reverse_words:
    addiu $sp, $sp, -16
    sw    $s2, 0($sp)
    sw    $s1, 4($sp)
    sw    $s0, 8($sp)
    sw    $ra, 12($sp)

    move  $s0, $a0

    
    jal   strlen

    
    beq   $v0, $zero, rw_done

    
    move  $a0, $s0
    addu  $a1, $s0, $v0
    addiu $a1, $a1, -1
    jal   rev_range

    
    move  $s1, $s0
    move  $s2, $s0

rw_scan:
    lbu   $t0, 0($s1)
    beq   $t0, $zero, rw_last

    li    $t1, 32
    beq   $t0, $t1, rw_space

    addiu $s1, $s1, 1
    j     rw_scan

rw_space:
    move  $a0, $s2
    addiu $a1, $s1, -1
    jal   rev_range

    addiu $s1, $s1, 1
    move  $s2, $s1
    j     rw_scan

rw_last:
    move  $a0, $s2
    addiu $a1, $s1, -1
    jal   rev_range

rw_done:
    lw    $s2, 0($sp)
    lw    $s1, 4($sp)
    lw    $s0, 8($sp)
    lw    $ra, 12($sp)
    addiu $sp, $sp, 16
    jr    $ra
