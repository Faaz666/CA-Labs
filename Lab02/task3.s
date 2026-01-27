addi x22, x0, 0 # i = 0
addi x23, x0, 0 # sum = 0
addi x5, x0, 10 #temp1 = 10 for checking loop end
addi x6, x0, 0 # newi = 0 computes newi = 4(i)
sw x21, 0x200(x0)

Loop1:
    beq x22, x5, Initialize
    sw x22, 0x200(x6)
    addi x6, x6, 4
    addi x22, x22, 1
    beq x0, x0, Loop1

Initialize:
    addi x22, x0, 0
    addi x6,  x0, 0

Loop2:
    beq x22, x5, end
    lw x28, 0x200(x6)
    add x23, x23, x28
    addi x22, x22, 1
    addi x6, x6, 4
    beq x0, x0, Loop2

end:
    j end