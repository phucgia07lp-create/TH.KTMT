.data
    pitch:      .word 64, 64, 65, 67, 67, 65, 64, 62, 60, 60, 62, 64, 64, 62, 62
    duration:   .word 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 1, 4
    num_notes:  .word 15
    a:          .word 3     
    b:          .word 3     

.text
.globl main

main:
    la $s0, pitch        
    la $s1, duration     
    lw $s2, num_notes    
    li $s3, 0            
    li $s4, 0            
    
    lw $t0, b            
    li $t1, 10
    mul $t2, $t0, $t1    
    addi $s5, $t2, 150   
    
    li $v0, 30
    syscall
    move $s6, $a0        

loop:
    beq $s3, $s2, end_loop  
    sll $t3, $s3, 2      
    
    add $t4, $s0, $t3    
    lw $t5, 0($t4)       
    lw $t6, a            
    add $t5, $t5, $t6    
    
    add $t7, $s1, $t3    
    lw $t8, 0($t7)       
    mul $t8, $t8, $s5    
    add $s4, $s4, $t8    
    
    li $v0, 1            
    move $a0, $t5        
    syscall
    
    li $v0, 11           
    li $a0, 32
    syscall
    
    li $v0, 1            
    move $a0, $t8        
    syscall
    
    li $v0, 11           
    li $a0, 10
    syscall
    
    move $a0, $t5        
    move $a1, $t8        
    li $a2, 73             
    li $a3, 100          
    li $v0, 33            
    syscall
    
    addi $s3, $s3, 1
    j loop

end_loop:
    li $v0, 30
    syscall
    move $s7, $a0        
    
    sub $t9, $s7, $s6    
    li $v0, 11
    li $a0, 84   
    syscall
    li $v0, 11
    li $a0, 111  
    syscall
    li $v0, 11
    li $a0, 110  
    syscall
    li $v0, 11
    li $a0, 103  
    syscall
    li $v0, 11
    li $a0, 32   
    syscall
    li $v0, 11
    li $a0, 100  
    syscall
    li $v0, 11
    li $a0, 117  
    syscall
    li $v0, 11
    li $a0, 32   
    syscall
    li $v0, 11
    li $a0, 107  
    syscall
    li $v0, 11
    li $a0, 105  
    syscall
    li $v0, 11
    li $a0, 101  
    syscall
    li $v0, 11
    li $a0, 110  
    syscall
    li $v0, 11
    li $a0, 32   
    syscall
    li $v0, 11
    li $a0, 40   
    syscall
    li $v0, 11
    li $a0, 109  
    syscall
    li $v0, 11
    li $a0, 115  
    syscall
    li $v0, 11
    li $a0, 41   
    syscall
    li $v0, 11
    li $a0, 58   
    syscall
    li $v0, 11
    li $a0, 32   
    syscall
    
    li $v0, 1
    move $a0, $s4
    syscall
    
    li $v0, 11
    li $a0, 10   
    syscall
    
    li $v0, 11
    li $a0, 84   
    syscall
    li $v0, 11
    li $a0, 104  
    syscall
    li $v0, 11
    li $a0, 111  
    syscall
    li $v0, 11
    li $a0, 105  
    syscall
    li $v0, 11
    li $a0, 32   
    syscall
    li $v0, 11
    li $a0, 103  
    syscall
    li $v0, 11
    li $a0, 105  
    syscall
    li $v0, 11
    li $a0, 97   
    syscall
    li $v0, 11
    li $a0, 110  
    syscall
    li $v0, 11
    li $a0, 32   
    syscall
    li $v0, 11
    li $a0, 100  
    syscall
    li $v0, 11
    li $a0, 111  
    syscall
    li $v0, 11
    li $a0, 32   
    syscall
    li $v0, 11
    li $a0, 100  
    syscall
    li $v0, 11
    li $a0, 117  
    syscall
    li $v0, 11
    li $a0, 111  
    syscall
    li $v0, 11
    li $a0, 99   
    syscall
    li $v0, 11
    li $a0, 32   
    syscall
    li $v0, 11
    li $a0, 40   
    syscall
    li $v0, 11
    li $a0, 109  
    syscall
    li $v0, 11
    li $a0, 115  
    syscall
    li $v0, 11
    li $a0, 41   
    syscall
    li $v0, 11
    li $a0, 58   
    syscall
    li $v0, 11
    li $a0, 32   
    syscall
    
    li $v0, 1
    move $a0, $t9
    syscall
    
    li $v0, 10
    syscall
