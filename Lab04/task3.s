# Allocate 32 bytes on stack for 8 integers 
addi sp, sp, -32 
# [5,2,9,1,7,3,8,4] 
li x8, 5 
sw x8, 0(sp) 
li x8, 2 
sw x8, 4(sp) 
li x8, 9 
sw x8, 8(sp) 
li x8, 1 
sw x8, 12(sp) 
li x8, 7 
sw x8, 16(sp) 
li x8, 3 
sw x8, 20(sp) 
li x8, 8 
sw x8, 24(sp) 
li x8, 4 
sw x8, 28(sp)

mv x12, sp # base address 
li x13, 8 # length 
jal x1, bubble 
addi sp, sp, 32 # restore stack 
li x17, 10 
ecall 

# Bubble Sort 
bubble: 
    addi x6, x13, -1 # x6 = n-1 outer loop counter 
    outer: 
    beq x6, x0, exit # if passes finished, exit
    mv x7, x0 # j = 0

inner: 
    slli x28, x7, 2 # offset = j*4 
    add x29, x12, x28 
    lw x30, 0(x29) # a[j] 
    lw x31, 4(x29) # a[j+1] 
    ble x30, x31, noswap 
    sw x31, 0(x29) # swap 
    sw x30, 4(x29) 

noswap: 
    addi x7, x7, 1 
    blt x7, x6, inner # while j < n-1-i 
    addi x6, x6, -1 
    j outer 

exit:
    j exit