`timescale 1ns / 1ps

module clk_divider #(
    parameter DIVISOR = 25_000_000
)(
    input clk_in,
    input rst,
    output reg clk_out
);

    reg [24:0] counter;

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == DIVISOR - 1) begin
                counter <= 0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule
