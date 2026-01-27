# To Run: setting x = 1 will give 10 + 8 = 18 in x21
addi x20, x0, 3

# Main code
addi x22, x0, 8 # b = 8
addi x23, x0, 10 # c = 10

addi x5, x0, 1 # temp1 = 1
addi x6, x0, 2 # temp2 = 2
addi x7, x0, 3 # temp3 = 3
addi x28, x0, 4 # temp4 = 4

beq x20, x5, case1
beq x20, x6, case2
beq x20, x7, case3
beq x20, x28, case4
beq x0, x0, default

# All Cases
case1:
    add x21, x22, x23
    beq x0, x0, end

case2:
    sub x21, x22, x23
    beq x0, x0, end

case3:
    mul x21, x22, x6
    beq x0, x0, end

case4:
    div x21, x22, x6
    beq x0, x0, end

default:
    addi x21, x0, 0

end:
    j end



