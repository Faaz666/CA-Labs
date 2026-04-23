`timescale 1ns / 1ps

module fpga_top(
    input clk,
    input btnC,
    input [15:0] sw,
    output [15:0] led,
    output [6:0] seg,
    output [3:0] an
);

    wire rst;
    wire slow_clk;
    wire [15:0] led_out;

    reg rst_sync1, rst_sync2;
    always @(posedge clk) begin
        rst_sync1 <= btnC;
        rst_sync2 <= rst_sync1;
    end
    assign rst = rst_sync2;

    clk_divider #(
        .DIVISOR(12_500_000) 
    ) clk_div (
        .clk_in(clk),
        .rst(rst),
        .clk_out(slow_clk)
    );

    TopLevelProcessor processor(
        .clk(slow_clk),
        .rst(rst),
        .switches(sw),
        .LEDs(led_out)
    );

    assign led = led_out;

    seven_seg_display ssd(
        .clk(clk),
        .rst(rst),
        .value(led_out),
        .seg(seg),
        .an(an)
    );

endmodule
