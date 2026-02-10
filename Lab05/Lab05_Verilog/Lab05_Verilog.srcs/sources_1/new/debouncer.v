module debouncer(
    input clk,
    input pbin,
    output reg pbout
);
    reg [19:0] cnt = 0;
    reg sync = 0;
    always @(posedge clk) begin
        sync <= pbin;
        if (sync != pbout) begin
            cnt <= cnt + 1;
            if (cnt == 20'hFFFFF) begin
                pbout <= sync;
                cnt <= 0;
            end
        end else begin
            cnt <= 0;
        end
    end
endmodule
