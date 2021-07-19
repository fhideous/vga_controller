`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2021 16:26:39
// Design Name: 
// Module Name: d_ff_all_colors
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


module d_ff_all_colors(
        input             clk,
        input             reset,
        
        input wire [3:0]  d_r,
        input wire [3:0]  d_g,
        input wire [3:0]  d_b,
        
        output     [3:0]  q_r,
        output     [3:0]  q_g,
        output     [3:0]  q_b
    );
    
    wire    [3:0] r_tmp, b_tmp, g_tmp;
    
  d_ff_4 inst_d_ff_4_r
  (
  
  .clk(clk),   
  .reset(0),
  
  .D(d_r),
  
  .Q(r_tmp)
  );

  d_ff_4 ints_d_ff_4_g
  (
  
  .clk(clk),   
  .reset(0),
  
  .D(d_g),
  
  .Q(g_tmp)
  );

  d_ff_4 inst_d_ff_4_b
  (
  
  .clk(clk),   
  .reset(0),
  
  .D(d_b),
  
  .Q(b_tmp)
  );
   
   assign q_r = r_tmp;
   assign q_b = b_tmp;
   assign q_g = g_tmp;
    
endmodule
