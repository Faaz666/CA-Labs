li x10, 0x100 # v[] = 0x100
li x11, 4 # k = 4
li x5, 42 # swap1 = 42
li x6, 84 # swap2 = 84
li x2, 0x200 # stack pointer
# jal x1, swap
#     li x10, 10
#     ecall
# j end

swap:
    addi x2, x2, -16
    sw x18, 0(x2)
    sw x19, 4(x2)
    slli x18, x11, 2 # x18 = k * 4 (word size)
    add x18, x10, x18 # x18 = address of v[k] 116
    sw x5, 0(x18) # v[k] = swap1 42
    lw x20, 0(x18) # temp = v[k] 42
    sw x20, 8(x2) # store temp to stack 42
    addi x19, x18, 4 # x19 = address of v[k+1] 120
    sw x6, 0(x19) # v[k+1] = swap2 84
    lw x21, 0(x19) # temp2 = v[k+1] 84
    sw x21, 12(x2) # store temp2 to stack 84
    lw x7, 12(x2) # load temp2 from stack 
    lw x8, 8(x2) # load temp from stack
    sw x7, 0(x18) # v[k] = temp2
    sw x8, 0(x19) # v[k+1] = temp 
    addi x2, x2, 16 # deallocate stack
    jalr x0, 0(x1)

end:
    j end