`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2026 11:23:26 AM
// Design Name: 
// Module Name: RF_ALU_FSM
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


module RF_ALU_FSM(
    input  wire       clk,
    input  wire       rst,
    input  wire [3:0] switches,   // optional, not used in minimal demo
    output reg        WriteEnable,
    output reg [4:0]  rs1,
    output reg [4:0]  rs2,
    output reg [4:0]  rd,
    output reg [31:0] WriteData,
    output reg [3:0]  ALUControl,
    input  wire       Zero,       // from ALU
    input  wire [31:0] ALUResult   // from ALU
);

    reg [4:0] state;

    // State encoding (same flow as your TB)
    localparam S_WR_X1   = 5'd0,
               S_WR_X2   = 5'd1,
               S_WR_X3   = 5'd2,
               S_SET_ADD = 5'd3,
               S_WR_ADD  = 5'd4,
               S_SET_SUB = 5'd5,
               S_WR_SUB  = 5'd6,
               S_SET_AND = 5'd7,
               S_WR_AND  = 5'd8,
               S_SET_OR  = 5'd9,
               S_WR_OR   = 5'd10,
               S_SET_XOR = 5'd11,
               S_WR_XOR  = 5'd12,
               S_SET_SLL = 5'd13,
               S_WR_SLL  = 5'd14,
               S_SET_SRL = 5'd15,
               S_WR_SRL  = 5'd16,
               S_SET_BEQ = 5'd17,
               S_WR_FLAG = 5'd18,
               S_WR_RAW  = 5'd19,
               S_RD_RAW  = 5'd20,
               S_DONE    = 5'd21;

    always @(posedge clk) begin
        if (rst) begin
            state <= S_WR_X1;

            // safe defaults
            WriteEnable <= 1'b0;
            rs1 <= 5'd0; rs2 <= 5'd0; rd <= 5'd0;
            WriteData <= 32'd0;
            ALUControl <= 4'd0;
        end else begin
            case (state)

                S_WR_X1: begin
                    WriteEnable <= 1'b1; rd <= 5'd1; WriteData <= 32'h10101010;
                    state <= S_WR_X2;
                end

                S_WR_X2: begin
                    WriteEnable <= 1'b1; rd <= 5'd2; WriteData <= 32'h01010101;
                    state <= S_WR_X3;
                end

                S_WR_X3: begin
                    WriteEnable <= 1'b1; rd <= 5'd3; WriteData <= 32'h00000005;
                    state <= S_SET_ADD;
                end

                S_SET_ADD: begin
                    WriteEnable <= 1'b0;
                    rs1 <= 5'd1; rs2 <= 5'd2; ALUControl <= 4'b0000; // ADD
                    state <= S_WR_ADD;
                end
                S_WR_ADD: begin
                    WriteEnable <= 1'b1; rd <= 5'd4; WriteData <= ALUResult;
                    state <= S_SET_SUB;
                end

                S_SET_SUB: begin
                    WriteEnable <= 1'b0;
                    rs1 <= 5'd1; rs2 <= 5'd2; ALUControl <= 4'b0001; // SUB
                    state <= S_WR_SUB;
                end
                S_WR_SUB: begin
                    WriteEnable <= 1'b1; rd <= 5'd5; WriteData <= ALUResult;
                    state <= S_SET_AND;
                end

                S_SET_AND: begin
                    WriteEnable <= 1'b0;
                    rs1 <= 5'd1; rs2 <= 5'd2; ALUControl <= 4'b0010; // AND
                    state <= S_WR_AND;
                end
                S_WR_AND: begin
                    WriteEnable <= 1'b1; rd <= 5'd6; WriteData <= ALUResult;
                    state <= S_SET_OR;
                end

                S_SET_OR: begin
                    WriteEnable <= 1'b0;
                    rs1 <= 5'd1; rs2 <= 5'd2; ALUControl <= 4'b0011; // OR
                    state <= S_WR_OR;
                end
                S_WR_OR: begin
                    WriteEnable <= 1'b1; rd <= 5'd7; WriteData <= ALUResult;
                    state <= S_SET_XOR;
                end

                S_SET_XOR: begin
                    WriteEnable <= 1'b0;
                    rs1 <= 5'd1; rs2 <= 5'd2; ALUControl <= 4'b0100; // XOR
                    state <= S_WR_XOR;
                end
                S_WR_XOR: begin
                    WriteEnable <= 1'b1; rd <= 5'd8; WriteData <= ALUResult;
                    state <= S_SET_SLL;
                end

                S_SET_SLL: begin
                    WriteEnable <= 1'b0;
                    rs1 <= 5'd1; rs2 <= 5'd3; ALUControl <= 4'b0101; // SLL by x3
                    state <= S_WR_SLL;
                end
                S_WR_SLL: begin
                    WriteEnable <= 1'b1; rd <= 5'd9; WriteData <= ALUResult;
                    state <= S_SET_SRL;
                end

                S_SET_SRL: begin
                    WriteEnable <= 1'b0;
                    rs1 <= 5'd1; rs2 <= 5'd3; ALUControl <= 4'b0110; // SRL by x3
                    state <= S_WR_SRL;
                end
                S_WR_SRL: begin
                    WriteEnable <= 1'b1; rd <= 5'd10; WriteData <= ALUResult;
                    state <= S_SET_BEQ;
                end

                S_SET_BEQ: begin
                    WriteEnable <= 1'b0;
                    rs1 <= 5'd1; rs2 <= 5'd1; ALUControl <= 4'b0001; // SUB for BEQ
                    state <= S_WR_FLAG;
                end

                S_WR_FLAG: begin
                    WriteEnable <= 1'b1; rd <= 5'd11; WriteData <= (Zero ? 32'h1 : 32'h0);
                    state <= S_WR_RAW;
                end

                S_WR_RAW: begin
                    WriteEnable <= 1'b1; rd <= 5'd12; WriteData <= 32'hCAFEBABE;
                    state <= S_RD_RAW;
                end

                S_RD_RAW: begin
                    WriteEnable <= 1'b0;
                    rs1 <= 5'd12; rs2 <= 5'd0; // read-after-write next cycle
                    state <= S_DONE;
                end

                default: begin
                    WriteEnable <= 1'b0;
                    state <= S_DONE;
                end

            endcase
        end
    end

endmodule
