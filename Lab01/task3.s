li x1,5 #a=5
addi x2,x0,0 #b=0+0
addi x1,x2,32 #a=b+32
add x4,x1,x2 #temp1=a+b
addi x6,x4,-5 #d=temp1 - 5
sub x4,x1,x6 #temp1=a-d
sub x3,x2,x1 # temp2=b-a
add x5,x4,x3 #temp3=temp1+temp2
add x7,x5,x6 #e=temp3+d
add x7,x7,x1
add x7,x7,x2
add x7,x7,x6

end:
    j end