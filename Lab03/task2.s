li x10, 1 # g = 1
li x11, 2 # h = 2
li x12, 3 # i = 3
li x13, 4 # j = 4
li x2, 0x100

jal x1, arithmetic
    addi x11, x20, 0
    li x10, 1
    ecall
j end

arithmetic:
    addi x2, x2, -12
    add x18, x10, x11 # x18 = g + h
    add x19, x12, x13 # x19 = i + j
    sw x18, 0(x2) # store (g + h) to stack
    sw x19, 4(x2) # store (i + j) to stack
    sub x20, x18, x19 # x20 = (g + h) - (i + j)
    sw x20, 8(x2) # store result to stack
    lw x18, 0(x2) # load (g + h) from stack
    lw x19, 4(x2) # load (i + j) from stack
    lw x20, 8(x2) # load result from stack
    addi x2, x2, 12
    jalr x0, 0(x1)

end:
    j end