li x2, 0x200 # stack pointer
li x10, 0x300 # x10 = address of x 
li x11, 0x400 # x11 = address of y

# Store "Hello" in memory at y
li x5, 72 # 'H'
sb x5, 0(x11)
li x5, 101 # 'e'
sb x5, 1(x11)
li x5, 108 # 'l'
sb x5, 2(x11)
li x5, 108 # 'l'
sb x5, 3(x11)
li x5, 111 # 'o'
sb x5, 4(x11)
li x5, 0 # '\0'
sb x5, 5(x11)

jal x1, strcpy
    li x10, 10
    ecall
j end

strcpy:
    addi x2, x2, -4    # adjust stack
    sw x19, 0(x2)      # save x19
    
    li x19, 0          # i = 0
    
L1:
    add x5, x11, x19   # x5 = address of y[i]
    lb x6, 0(x5)       # x6 = y[i]
    add x7, x10, x19   # x7 = address of x[i]
    sb x6, 0(x7)       # x[i] = y[i]
    beq x6, x0, L2     # if y[i] == '\0' exit loop
    addi x19, x19, 1   # i++
    j L1               # repeat loop
    
L2:
    lw x19, 0(x2)      # restore x19
    addi x2, x2, 4     # restore stack
    jalr x0, 0(x1)     # return

end:
    j end
