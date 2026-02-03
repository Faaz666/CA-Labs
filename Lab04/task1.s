addi x5, x0, 10 # n = 10
addi x6, x0, 1  # sum = 1

loop:
    mul x6, x6, x5
    addi x5, x5, -1
    bne x5, x0, loop

end:
    j end