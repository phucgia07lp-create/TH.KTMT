
        .data
arr:        .word 9, 6, 0, 1, 5, 8, 10, 5, 9, 1, 7, 6   # T1, n = 12
n:          .word 12

grade_tab:  .byte 0, 0, 0, 0, 1, 1, 1, 2, 2, 3, 3
hist:       .word 0, 0, 0, 0
msg_min:    .asciiz "min="
msg_max:    .asciiz " max="
 
        .text
main:
        la   $s0, arr
        la   $t0, n
        lw   $s1, 0($t0)
        move $a0, $s0
        move $a1, $s1
        jal  stats
        move $s2, $v0               
        move $s3, $v1               
        move $a0, $s0
        move $a1, $s1
        la   $a2, grade_tab
        la   $a3, hist
        jal  histogram
 
        la   $a0, msg_min           
        li   $v0, 4
        syscall
        move $a0, $s2
        li   $v0, 1
        syscall
        la   $a0, msg_max
        li   $v0, 4
        syscall
        move $a0, $s3
        li   $v0, 1
        syscall
        li   $a0, 10
        li   $v0, 11
        syscall
 
        la   $s5, hist              
        li   $s4, 0
gl_loop:
        li   $a0, 103               
        li   $v0, 11
        syscall
        move $a0, $s4
        li   $v0, 1
        syscall
        li   $a0, 61             
        li   $v0, 11
        syscall
        lw   $a0, 0($s5)
        li   $v0, 1
        syscall
        addi $s5, $s5, 4
        addi $s4, $s4, 1
        li   $t0, 4
        beq  $s4, $t0, gl_done
        li   $a0, 32                
        li   $v0, 11
        syscall
        j    gl_loop
gl_done:
        li   $a0, 10
        li   $v0, 11
        syscall
        li   $v0, 10                
        syscall
 

stats:
        lw   $v0, 0($a0)            
        move $v1, $v0
        addi $a0, $a0, 4
        addi $a1, $a1, -1
stats_loop:
        beq  $a1, $zero, stats_done
        lw   $t0, 0($a0)
        slt  $t1, $t0, $v0          
        beq  $t1, $zero, stats_chkmax
        move $v0, $t0
stats_chkmax:
        slt  $t1, $v1, $t0          
        beq  $t1, $zero, stats_next
        move $v1, $t0
stats_next:
        addi $a0, $a0, 4
        addi $a1, $a1, -1
        j    stats_loop
stats_done:
        jr   $ra
 
------------------------------------------------------------------
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
