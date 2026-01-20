    #Base addresses
    li x10, 0x100 #a(char array)
    li x11, 0x200 #b(short array)
    li x12, 0x300 #c(unsigned integer array)

    #adding dummy values to each array to show wroking
    # char array a = [1,2,3,4]
    li x5,1
    sb x5,0(x10)
    li x5,2
    sb x5,1(x10)
    li x5,3
    sb x5,2(x10)
    li x5,4
    sb x5,3(x10)

    # short array b = [10,20,30,40]
    li x5,10
    sh x5,0(x11)
    li x5,20
    sh x5,2(x11)
    li x5,30
    sh x5,4(x11)
    li x5,40
    sh x5,6(x11)
    # unsigned int array c = [0,0,0,0]
    sw x0,0(x12)
    sw x0,4(x12)
    sw x0,8(x12)
    sw x0,12(x12)

    #i=0
    lb x13, 0(x10) #a[0]
    lh x14, 0(x11) #b[0]
    add x15, x13, x14 #a[0]+b[0]
    sw x15, 0(x12) #c[0]

    #i=1
    lb x13, 1(x10)    # a[1]
    lh x14, 2(x11)    # b[1]
    add x15, x13, x14
    sw x15, 4(x12)    # c[1]


    #i=2
    lb x13, 2(x10) #a[2]
    lh x14, 4(x11) #b[2]
    add x15, x13, x14
    sw x15, 8(x12) #c[2]


    #i=3
    lb  x13, 3(x10) #a[3]
    lh  x14, 6(x11) #b[3]
    add x15, x13, x14
    sw  x15, 12(x12) #c[3]

end:
    j end
