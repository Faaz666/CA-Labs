`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2026 09:32:57 AM
// Design Name: 
// Module Name: regfile_tb
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


module regfile_tb;
  reg clk = 0;
  always #5 clk = ~clk;
  reg rst, WriteEnable;
  reg [4:0] rs1, rs2, rd;
  reg [31:0] WriteData;
  wire [31:0] ReadData1, readData2;
  regfile r0(clk, rst, WriteEnable, rs1, rs2, rd, WriteData, ReadData1, readData2);
  initial 
    begin
    rst = 1; WriteEnable = 0; rs1 = 0; rs2 = 0; rd = 0; WriteData = 0;
    
    //Write a value to a register (e.g., x5 = 0xDEADBEEF) with WriteEnable=1
    @(posedge clk);
    rst = 0;
    
    @(negedge clk);
    WriteEnable = 1;
    rd = 5'b00101;
    WriteData = 32'hDEADBEEF;

    // check on next clock that readData1 or readData2 returns the same when addressed
    @(posedge clk);
    @(negedge clk);
    rs1 = 5'd5;
        
    // Attempt to write to x0
    @(posedge clk);
    rd = 5'd0;
    WriteData = 32'hFFFFFFFF;
    
    // verify it remains zero.
    @(negedge clk); #1;
    rs1 = 5'd0;
    
    @(posedge clk);
    rd = 5'd10;
    WriteData = 32'h12345678;
    
    // Simultaneous two read ports
    @(negedge clk); #1;
    rs1 = 5'd5;
    rs2 = 5'd10;     
        
    // Overwrite a register
    @(posedge clk);
    rd = 5'd5;
    WriteData = 32'hAAAAAAAA;
    
    // verify old value is replaced.
    @(negedge clk); #1;
    rs1 = 5'd5;
    
    //Reset behavior
    rst = 1;
    @(posedge clk);
    rst = 0;
    #1;
    //check registers clear appropriately
    rs1 = 5'd5;
    rs2 = 5'd10;
  
  end

endmodule
