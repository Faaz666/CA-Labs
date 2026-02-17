`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2026 10:59:59 AM
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb;

reg [31:0] A;
reg [31:0] B;
reg [3:0] ALUControl;
wire [31:0] ALUResult;
wire Zero;

ALU alusahab(A, B, ALUControl, ALUResult, Zero);

initial 
    begin
    // adding
    A = 10; B = 5; ALUControl = 4'b0000;
    #10;
    // subtracting
    A = 10; B = 5; ALUControl = 4'b0001;
    #10;
    // anding
    A = 10; B = 5; ALUControl = 4'b0010;
    #10;
    // oring
    A = 10; B = 5; ALUControl = 4'b0011;
    #10;
    // xoring
    A = 10; B = 5; ALUControl = 4'b0100;
    #10;
    // slling
    A = 10; B = 2; ALUControl = 4'b0101;
    #10;
    // srling
    A = 10; B = 2; ALUControl = 4'b0110;
    #10;
    end
endmodule
