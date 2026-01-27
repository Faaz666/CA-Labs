addi x7, x0, 0 # i = 0
addi x5, x0, 2 # a = 2
addi x6, x0, 4 # b = 4

main:
    beq  x7, x5, end
    addi x29, x0, 0 # j = 0
    slli x27, x7, 4 # x27 = i * 16
    add  x28, x10, x27 # x28 = base + 16*i

nested:
    beq  x29, x6, increment
    add  x30, x7, x29
    sw   x30, 0(x28)
    addi x28, x28, 4
    addi x29, x29, 1
    beq  x0,  x0, nested

increment:
    addi x7, x7, 1
    beq  x0, x0, main

end:
    j end
