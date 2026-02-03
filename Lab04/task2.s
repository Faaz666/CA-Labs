li x5, 10
jal x6, faaz
li x10, 1
ecall

exit:
    j exit

faaz:
    addi sp, sp, -8
    sw x6, 4(sp)
    sw x5, 0(sp)
    addi x7, x5, -1
    blt x7, x0, base_case
    addi x5, x5, -1
    jal x6, faaz
    lw x28, 0(sp)
    add x5, x5, x28
    lw x6, 4(sp)
    addi sp, sp, 8
    jalr x0, 0(x6)

base_case:
    li x5, 0
    lw x6, 4(sp)
    addi sp, sp, 8
    jalr x0, 0(x6)