module instructionMemory#(
    parameter OPERAND_LENGTH = 31
    )(
    input  [OPERAND_LENGTH:0] instAddress,
    output reg [31:0] instruction
    );
    reg [7:0] memory [0:255];
    always @(*) begin
        instruction = {memory[instAddress+3], memory[instAddress+2], memory[instAddress+1], memory[instAddress]};
    end
    integer i;
    initial begin
    for (i=0;i<256;i=i+1) memory[i]=8'h00;
    // PC=0: addi x28, x0, 5
    memory[3]=8'h00; memory[2]=8'h50; memory[1]=8'h0E; memory[0]=8'h13;

    // PC=4: addi x2, x0, 511
    memory[7]=8'h1F; memory[6]=8'hF0; memory[5]=8'h01; memory[4]=8'h13;

    // PC=8: addi x5, x0, 768
    memory[11]=8'h30; memory[10]=8'h00; memory[9]=8'h02; memory[8]=8'h93;

    // PC=12: addi x6, x0, 512
    memory[15]=8'h20; memory[14]=8'h00; memory[13]=8'h03; memory[12]=8'h13;

    // PC=16: sw x28, 0(x5)
    memory[19]=8'h01; memory[18]=8'hC2; memory[17]=8'hA0; memory[16]=8'h23;

    // PC=20: sw x0, 0(x6)
    memory[23]=8'h00; memory[22]=8'h03; memory[21]=8'h20; memory[20]=8'h23;

    // PC=24: lw x11, 0(x5)
    memory[27]=8'h00; memory[26]=8'h02; memory[25]=8'hA5; memory[24]=8'h83;

    // PC=28: beq x11, x0, -28
    memory[31]=8'hFE; memory[30]=8'h05; memory[29]=8'h8E; memory[28]=8'hE3;

    // PC=32: add x10, x11, x0
    memory[35]=8'h00; memory[34]=8'h05; memory[33]=8'h85; memory[32]=8'h33;

    // PC=36: jal x1, 8
    memory[39]=8'h00; memory[38]=8'h80; memory[37]=8'h00; memory[36]=8'hEF;

    // PC=40: beq x0, x0, -20   (unconditional jump)
    memory[43]=8'hFE; memory[42]=8'h00; memory[41]=8'h06; memory[40]=8'hE3;

    // PC=44: addi x2, x2, -8   (push stack)
    memory[47]=8'hFF; memory[46]=8'h81; memory[45]=8'h01; memory[44]=8'h13;

    // PC=48: sw x1, 4(x2)      (save return address)
    memory[51]=8'h00; memory[50]=8'h11; memory[49]=8'h22; memory[48]=8'h23;

    // PC=52: sw x12, 0(x2)
    memory[55]=8'h00; memory[54]=8'hC1; memory[53]=8'h20; memory[52]=8'h23;

    // PC=56: add x12, x10, x0
    memory[59]=8'h00; memory[58]=8'h05; memory[57]=8'h06; memory[56]=8'h33;

    // PC=60: sw x12, 0(x6)
    memory[63]=8'h00; memory[62]=8'hC3; memory[61]=8'h20; memory[60]=8'h23;

    // PC=64: beq x12, x0, 24
    memory[67]=8'h00; memory[66]=8'h06; memory[65]=8'h0C; memory[64]=8'h63;

    // PC=68: addi x12, x12, -1
    memory[71]=8'hFF; memory[70]=8'hF6; memory[69]=8'h06; memory[68]=8'h13;

    // PC=72: addi x13, x0, 3
    memory[75]=8'h00; memory[74]=8'h30; memory[73]=8'h06; memory[72]=8'h93;

    // PC=76: addi x13, x13, -1
    memory[79]=8'hFF; memory[78]=8'hF6; memory[77]=8'h86; memory[76]=8'h93;

    // PC=80: bne x13, x0, -20
    memory[83]=8'hFE; memory[82]=8'h06; memory[81]=8'h9E; memory[80]=8'hE3;

    // PC=84: beq x0, x0, -24   (loop)
    memory[87]=8'hFE; memory[86]=8'h00; memory[85]=8'h04; memory[84]=8'hE3;

    // PC=88: sw x0, 0(x6)
    memory[91]=8'h00; memory[90]=8'h03; memory[89]=8'h20; memory[88]=8'h23;

    // PC=92: lw x12, 0(x2)
    memory[95]=8'h00; memory[94]=8'h01; memory[93]=8'h26; memory[92]=8'h03;

    // PC=96: lw x1, 4(x2)
    memory[99]=8'h00; memory[98]=8'h41; memory[97]=8'h20; memory[96]=8'h83;

    // PC=100: addi x2, x2, 8   (pop stack)
    memory[103]=8'h00; memory[102]=8'h81; memory[101]=8'h01; memory[100]=8'h13;

    // PC=104: jalr x0, 0(x1)   (return)
    memory[107]=8'h00; memory[106]=8'h00; memory[105]=8'h80; memory[104]=8'h67;

    // PC=108: jal x0, 0        (infinite loop)
    memory[111]=8'h00; memory[110]=8'h00; memory[109]=8'h00; memory[108]=8'h6F;
    end
endmodule
