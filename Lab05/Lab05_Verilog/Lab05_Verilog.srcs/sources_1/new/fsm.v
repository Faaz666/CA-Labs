`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2026 11:45:18 AM
// Design Name: 
// Module Name: fsm
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

module fsm(input clk, input rst, input [15:0] switches, output reg [15:0] counter);
    reg state = 0;
    
    reg [26:0] div = 0;
    wire tick = (div == 27'd100000000);

    always @(posedge clk) begin
        if (rst)
            div <= 0;
        else if (tick)
            div <= 0;
        else
            div <= div + 1;
    end

    always @(posedge clk) begin
        if (rst) begin
            state   <= 0;
            counter <= 16'b0;
        end else begin
            if (state == 0) begin
                counter <= 16'b0;
                if (switches != 16'b0) begin
                    counter <= switches;
                    state   <= 1;
                end
            end else begin
                if (counter > 0) begin
                    if (tick)
                        counter <= counter - 1;
                end else
                    state <= 0;
            end
        end
    end
endmodule
