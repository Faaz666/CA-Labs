`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2026 11:21:47 AM
// Design Name: 
// Module Name: top_rf_alu
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


module top_rf_alu(
    input  wire       clk,
    input  wire       rst_btn,
    input  wire [3:0] switches,
    output wire [7:0] leds
);

wire WriteEnable;
wire [4:0] rs1, rs2, rd;
wire [31:0] WriteData;
wire [31:0] ReadData1, ReadData2;

wire [3:0] ALUControl;
wire [31:0] ALUResult;
wire Zero;

regfile RF(clk, rst_btn, WriteEnable, rs1, rs2, rd, WriteData, ReadData1, ReadData2);
ALU     alu(ReadData1, ReadData2, ALUControl, ALUResult, Zero);

RF_ALU_FSM fsm(
    .clk(clk),
    .rst(rst_btn),
    .switches(switches),
    .WriteEnable(WriteEnable),
    .rs1(rs1), .rs2(rs2), .rd(rd),
    .WriteData(WriteData),
    .ALUControl(ALUControl),
    .Zero(Zero),
    .ALUResult(ALUResult)
);

// LEDs: show something meaningful
assign leds[3:0] = ALUResult[3:0];
assign leds[7:4] = rd[3:0];

endmodule
