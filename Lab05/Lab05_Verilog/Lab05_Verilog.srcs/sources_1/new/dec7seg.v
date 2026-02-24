`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2026 12:51:06 PM
// Design Name: 
// Module Name: dec7seg
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


module hex(input clk, input rst, input [15:0] counter, output reg [3:0] an, output reg [6:0] seg, output reg dp);
    reg [15:0] refresh;
    wire [1:0] sel;
    reg [3:0] digit;

    always @(posedge clk) begin
        if (rst) refresh <= 0;
        else refresh <= refresh + 1;
    end
    assign sel = refresh[15:14];
    integer value;
    integer d0, d1, d2, d3;

    always @(*) begin
        value = counter % 10000;
        d0 = value % 10; value = value / 10;
        d1 = value % 10; value = value / 10;
        d2 = value % 10; value = value / 10;
        d3 = value % 10;

        case(sel)
            2'b00: begin an = 4'b1110; digit = d0[3:0]; end
            2'b01: begin an = 4'b1101; digit = d1[3:0]; end
            2'b10: begin an = 4'b1011; digit = d2[3:0]; end
            2'b11: begin an = 4'b0111; digit = d3[3:0]; end
        endcase
    end

    always @(*) begin
        dp = 1'b1;
    end

    always @(*) begin
        case(digit)
            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;
            default: seg = 7'b1111111;
        endcase
    end
endmodule
