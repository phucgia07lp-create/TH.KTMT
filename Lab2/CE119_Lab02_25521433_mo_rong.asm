
        .data
arr:        .word 9, 6, 0, 1, 5, 8, 10, 5, 9, 1, 7, 6   # T1, n = 12
grade_tab:  .byte 0, 0, 0, 0, 1, 1, 1, 2, 2, 3, 3
hist:       .word 0, 0, 0, 0
 
        .text
main:
        la   $a0, arr
        li   $a1, 12
        la   $a2, grade_tab
        la   $a3, hist
        jal  histogram
        la   $a0, hist
        li   $a1, 4
        jal  draw_hist
        li   $v0, 10                
        syscall
 

histogram:
hist_loop:
        beq  $a1, $zero, hist_done
        lw   $t0, 0($a0)            
        addu $t1, $a2, $t0          
        lbu  $t2, 0($t1)            
        sll  $t2, $t2, 2            
        addu $t3, $a3, $t2          
        lw   $t4, 0($t3)
        addi $t4, $t4, 1
        sw   $t4, 0($t3)
        addi $a0, $a0, 4
        addi $a1, $a1, -1
        j    hist_loop
hist_done:
        jr   $ra
 

draw_hist:
        move $t0, $a0               
        move $t1, $a1               
        li   $t2, 0                 
dh_row:
        beq  $t2, $t1, dh_done
        li   $a0, 103               
        li   $v0, 11
        syscall
        move $a0, $t2
        li   $v0, 1
        syscall
        li   $a0, 58                
        li   $v0, 11
        syscall
        li   $a0, 32                
        li   $v0, 11
        syscall
        lw   $t3, 0($t0)            
dh_bar:
        beq  $t3, $zero, dh_endrow
        li   $a0, 124               
        li   $v0, 11
        syscall
        addi $t3, $t3, -1
        j    dh_bar
dh_endrow:
        li   $a0, 10
        li   $v0, 11
        syscall
        addi $t0, $t0, 4
        addi $t2, $t2, 1
        j    dh_row
dh_done:
        jr   $ra
