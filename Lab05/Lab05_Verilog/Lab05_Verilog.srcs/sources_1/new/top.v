`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2026 12:08:14 PM
// Design Name: 
// Module Name: top
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

module top(input clk, input btnC, input [15:0] switches, output [3:0] an, output [6:0] seg, output dp);
    wire rst;
    debouncer deb0(.clk(clk), .pbin(btnC), .pbout(rst));
    wire [31:0] writeData = 32'b0;
    wire writeEnable = 1'b0;
    wire readEnable = 1'b0;
    wire [29:0] memAddress = 30'b0;
    wire [31:0] readData_sw;
    wire [15:0] leds_unused;
    switches sw(.clk(clk), .rst(rst), .writeData(writeData), .writeEnable(writeEnable), .readEnable(readEnable), .memAddress(memAddress), .readData(readData_sw), .leds(leds_unused));
    wire [31:0] readData_led;
    leds led(.clk(clk), .rst(rst), .btns(16'b0), .writeData(writeData), .writeEnable(writeEnable), .readEnable(readEnable), .memAddress(memAddress), .switches(switches), .readData(readData_led)); 
    wire [15:0] counter;
    fsm fsm0(.clk(clk), .rst(rst), .switches(switches), .counter(counter));
    hex hex0(.clk(clk), .rst(rst), .counter(counter), .an(an), .seg(seg), .dp(dp));
endmodule