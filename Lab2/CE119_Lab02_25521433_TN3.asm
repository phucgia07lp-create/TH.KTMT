
        .data
bt1:   .asciiz "(a+b)*[c-{d/e}]"
bt2:   .asciiz "f(x[i]{j}))"
bt3:   .asciiz "{[(])}"
bt4:   .asciiz "((a)"
bt5:   .asciiz ""
bt6:   .asciiz "no brackets here"
bt7:   .asciiz "]"
bt8:   .asciiz "([)]"
btP:   .asciiz "([{([{}])}])"            # chuoi ca nhan, k = 6
bt_tab: .word bt1, bt2, bt3, bt4, bt5, bt6, bt7, bt8, btP
msg_case: .asciiz "case "
msg_c1:   .asciiz ": ("
msg_c2:   .asciiz ", "
msg_c3:   .asciiz ")\n"
 
        .text
main:
        li   $s7, 8              
bt_loop:
        li   $t0, 9
        beq  $s7, $t0, bt_done
        sll  $t1, $s7, 2
        la   $t2, bt_tab
        addu $t2, $t2, $t1
        lw   $a0, 0($t2)
        jal  check_brackets
        move $s0, $v0
        move $s1, $v1
        la   $a0, msg_case          
        li   $v0, 4
        syscall
        addi $a0, $s7, 1
        li   $v0, 1
        syscall
        la   $a0, msg_c1
        li   $v0, 4
        syscall
        move $a0, $s0
        li   $v0, 1
        syscall
        la   $a0, msg_c2
        li   $v0, 4
        syscall
        move $a0, $s1
        li   $v0, 1
        syscall
        la   $a0, msg_c3
        li   $v0, 4
        syscall
        addi $s7, $s7, 1
        j    bt_loop
bt_done:
        li   $v0, 10
        syscall
 

check_brackets:
        move $t9, $sp               
        li   $t2, 0                 
cb_loop:
        lbu  $t1, 0($a0)            
        beq  $t1, $zero, cb_end
        addi $t2, $t2, 1
        addi $a0, $a0, 1
        li   $t0, 40                
        beq  $t1, $t0, cb_push
        li   $t0, 91                
        beq  $t1, $t0, cb_push
        li   $t0, 123               
        beq  $t1, $t0, cb_push
        li   $t0, 41                
        beq  $t1, $t0, cb_close
        li   $t0, 93                
        beq  $t1, $t0, cb_close
        li   $t0, 125               
        beq  $t1, $t0, cb_close
        j    cb_loop                
cb_push:
        addi $sp, $sp, -4
        sw   $t1, 0($sp)
        j    cb_loop
cb_close:
        beq  $sp, $t9, cb_err2      
        lw   $t3, 0($sp)            
        addi $sp, $sp, 4
        li   $t4, 40                
        li   $t0, 41
        beq  $t1, $t0, cb_cmp
        li   $t4, 91                
        li   $t0, 93
        beq  $t1, $t0, cb_cmp
        li   $t4, 123               
cb_cmp:
        bne  $t3, $t4, cb_err1
        j    cb_loop
cb_end:
        beq  $sp, $t9, cb_ok
        addi $v0, $t2, 1            
        li   $v1, 3
        j    cb_exit
cb_ok:
        li   $v0, 0
        li   $v1, 0
        j    cb_exit
cb_err1:
        move $v0, $t2
        li   $v1, 1
        j    cb_exit
cb_err2:
        move $v0, $t2
        li   $v1, 2
cb_exit:
        move $sp, $t9               
        jr   $ra
 
