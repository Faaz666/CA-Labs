`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2026 11:40:11 AM
// Design Name: 
// Module Name: tb_task2
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


module tb_fsm;
    reg clk;
    reg rst;
    reg [15:0] switches;
    wire [15:0] counter;
    fsm faaz(.clk(clk), .rst(rst), .switches(switches), .counter(counter));
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rst = 1;
        switches = 0;
        #20 rst = 0;
        #20 switches = 16'd5;
        #200;
        switches = 16'd10;
        #100;
        rst = 1;
        #20 rst = 0;
        switches = 16'd3;
        #200;
        $finish;
    end
endmodule

