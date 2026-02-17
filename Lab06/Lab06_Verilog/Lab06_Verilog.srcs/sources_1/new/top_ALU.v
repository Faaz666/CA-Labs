`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2026 11:13:28 AM
// Design Name: 
// Module Name: top_ALU
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


module top_alu(input clk, input [15:0] switches, output [15:0] leds_out);
    wire [31:0] A = 32'b00000000000000000000000000001011;
    wire [31:0] B = 32'b00000000000000000000000000000010;
    wire [3:0] ALUControl = switches[3:0];
    wire [31:0] ALUResult;
    wire Zero;
    ALU alu0(.A(A), .B(B), .ALUControl(ALUControl), .ALUResult(ALUResult), .Zero(Zero));
    assign leds_out = ALUResult[15:0];
endmodule
