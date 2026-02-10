`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2026 12:21:10 PM
// Design Name: 
// Module Name: hex
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
    always @(posedge clk) begin
        if (rst) refresh <= 16'b0;
        else     refresh <= refresh + 1;
    end
    wire [1:0] sel = refresh[15:14];
    reg [3:0] digit;

    always @(*) begin
        an = 4'b1111;
        case(sel)
            2'b00: an = 4'b1110;
            2'b01: an = 4'b1101;
            2'b10: an = 4'b1011;
            2'b11: an = 4'b0111;
        endcase
    end

    always @(*) begin
        case(sel)
            2'b00: digit = counter[3:0];
            2'b01: digit = counter[7:4];
            2'b10: digit = counter[11:8];
            2'b11: digit = counter[15:12];
        endcase
    end

    always @(*) begin
        dp = 1'b1;
        case(digit)
            4'h0: seg = 7'b0000001;
            4'h1: seg = 7'b1001111;
            4'h2: seg = 7'b0010010;
            4'h3: seg = 7'b0000110;
            4'h4: seg = 7'b1001100;
            4'h5: seg = 7'b0100100;
            4'h6: seg = 7'b0100000;
            4'h7: seg = 7'b0001111;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0000100;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b1100000;
            4'hC: seg = 7'b0110001;
            4'hD: seg = 7'b1000010;
            4'hE: seg = 7'b0110000;
            4'hF: seg = 7'b0111000;
            default: seg = 7'b1111111;
        endcase
    end
endmodule

