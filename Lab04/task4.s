li x10, 2
li x11, 5
jal x1, power
j exit

power:
    addi sp, sp, -8
    sw x1, 0(sp)
    sw x10, 4(sp)
    beq x11, x0, base
    addi x11, x11, -1
    jal x1, power
    lw x5, 4(sp)
    lw x1, 0(sp)
    addi sp, sp, 8
    mul x10, x10, x5
    jalr x0, 0(x1)
    
base:
    li x10, 1
    lw x1, 0(sp)
    addi sp, sp, 8
    jalr x0, 0(x1)

exit:
    j exit