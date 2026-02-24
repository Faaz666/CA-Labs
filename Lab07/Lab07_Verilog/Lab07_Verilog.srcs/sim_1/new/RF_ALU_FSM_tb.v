`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2026 10:44:12 AM
// Design Name: 
// Module Name: RF_ALU_FSM_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RF_ALU_FSM_tb;

    reg clk=0;
    always #5 clk=~clk;
    reg rst;
    reg WriteEnable;
    reg [4:0] rs1, rs2, rd;
    reg [31:0] WriteData;
    wire [31:0] ReadData1, readData2;
    reg [3:0] ALUControl;
    wire [31:0] ALUResult;
    wire Zero;
    
    regfile RF(clk, rst, WriteEnable, rs1, rs2, rd, WriteData, ReadData1, readData2);
    ALU alu(ReadData1, readData2, ALUControl, ALUResult, Zero);
    
    reg [4:0] state;
    
    initial 
        begin
            rst = 1;
            WriteEnable = 0;
            rs1 = 0;
            rs2 = 0;
            rd  = 0;
            WriteData = 0;
            ALUControl = 0;
            state = 0;
            @(posedge clk);
            rst = 0;
        end
    
    always @(posedge clk) begin
    case(state)
    0: begin
        // write x1 = 10101010
        WriteEnable=1; rd=5'd1; WriteData=32'h10101010;
        state=1;
    end
    
    1: begin
        // write x2 = 01010101
        rd=5'd2; WriteData=32'h01010101;
        state=2;
    end
    
    2: begin
        // write x3 = 00000005
        rd=5'd3; WriteData=32'h00000005;
        state=3;
    end
    
    3: begin
        // READ x1,x2 then ADD and store in x4
        WriteEnable=0;
        rs1=5'd1; rs2=5'd2;
        ALUControl=4'b0000;
        state=4;
    end
    
    4: begin
        WriteEnable=1;
        rd=5'd4;
        WriteData=ALUResult;
        state=5;
    end
    
    5: begin
        // SUB to x5
        WriteEnable=0;
        rs1=5'd1; rs2=5'd2;
        ALUControl=4'b0001;
        state=6;
    end
    
    6: begin
        WriteEnable=1;
        rd=5'd5;
        WriteData=ALUResult;
        state=7;
    end
    
    7: begin
        // AND to x6
        rs1=5'd1; rs2=5'd2;
        WriteEnable=0;
        ALUControl=4'b0010;
        state=8;
    end
    
    8 : begin
        WriteEnable=1;
        rd=5'd6;
        WriteData=ALUResult;
        state=9;
    end
    
    9: begin
        // OR to x7
        rs1=5'd1; rs2=5'd2;
        WriteEnable=0;
        ALUControl=4'b0011;
        state=10;
    end
    
    10: begin
        WriteEnable=1;
        rd=5'd7;
        WriteData=ALUResult;
        state=11;
    end
    
    11: begin
        // XOR to x8
        rs1=5'd1; rs2=5'd2;
        WriteEnable=0;
        ALUControl=4'b0100;
        state=12;
    end
    
    12: begin
        WriteEnable=1;
        rd=5'd8;
        WriteData=ALUResult;
        state=13;
    end
    
    13: begin
        // SLL to x9
        rs1=5'd1; rs2=5'd3;
        WriteEnable=0;
        ALUControl=4'b0101;
        state=14;
    end
    
    14: begin
        WriteEnable=1;
        rd=5'd9;
        WriteData=ALUResult;
        state=15;
    end
    
    15: begin
        // SRL to x10
        rs1=5'd1; rs2=5'd3;
        WriteEnable=0;
        ALUControl=4'b0110;
        state=16;
    end
    
    16: begin
        WriteEnable=1;
        rd=5'd10;
        WriteData=ALUResult;
        state=17;
    end
    
    17: begin
        // BEQ test
        WriteEnable=0;
        rs1=5'd1; rs2=5'd1;
        ALUControl=4'b0001;
        state=18;
    end
    
    18: begin
    // WRITE flag x11 = 1 if Zero else 0
    WriteEnable = 1;
    rd = 5'd11;
    WriteData = (Zero ? 32'h1 : 32'h0);
    state = 19;
    end

    19: begin
        // RAW test: write x12 = CAFEBABE
        WriteEnable = 1;
        rd = 5'd12;
        WriteData = 32'hCAFEBABE;
        state = 20;
    end
    
    20: begin
        // RAW test: read x12 in NEXT cycle
        WriteEnable = 0;
        rs1 = 5'd12;
        rs2 = 5'd0;
        state = 21;
    end
    
    21: begin
        // DONE (stop changing signals)
        WriteEnable = 0;
        state = 21;
    end
    
    default: begin
        WriteEnable = 0;
        state = 21;
    end
    
    endcase
    end
    
endmodule
