.data
gia:    .word 1600, 1660, 1950, 2500, 2850, 3000
cap:    .word 50, 50, 100, 100, 100, 9999
a:      .word 3
nhacE:  .asciiz "Nhap so kWh (0..9999): "
loi:    .asciiz "Gia tri khong hop le, nhap lai.\n"
kq1:    .asciiz "Tien dien: "
kq2:    .asciiz " dong\n"

.text
.globl main
main:
nhap:
    li    $v0, 4
    la    $a0, nhacE
    syscall
    li    $v0, 5
    syscall
    move  $s0, $v0
    sltiu $t0, $s0, 10000
    bne   $t0, $zero, hople
    li    $v0, 4
    la    $a0, loi
    syscall
    j     nhap

hople:
    lw    $t3, a
    li    $t0, 20
    mul   $s1, $t3, $t0
    li    $s2, 0
    la    $t4, cap
    la    $t5, gia

loop:
    lw    $t8, 0($t4)
    lw    $t1, 0($t5)
    add   $t1, $t1, $s1
    ble   $s0, $t8, last
    mul   $t2, $t8, $t1
    add   $s2, $s2, $t2
    sub   $s0, $s0, $t8
    addi  $t4, $t4, 4
    addi  $t5, $t5, 4
    j     loop

last:
    mul   $t2, $s0, $t1
    add   $s2, $s2, $t2

    li    $v0, 4
    la    $a0, kq1
    syscall
    li    $v0, 1
    move  $a0, $s2
    syscall
    li    $v0, 4
    la    $a0, kq2
    syscall
    li    $v0, 10
    syscall