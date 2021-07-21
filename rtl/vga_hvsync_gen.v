`timescale 1ns / 1ps

`ifndef HVSYNC_o_GENERATOR_H
`define HVSYNC_o_GENERATOR_H

/*
Video sync generator, used to drive a simulated CRT.
To use:
- Wire the hsync_ and vsync_o signals to top level outputs
- Add a 3-bit (or more) "rgb" output to the top level
*/

module vga_hvsync_gen(
  input                 clk_i,
  input                 reset_i,
  
  output reg            hsync_o, vsync_o,
  
  output                display_on_o,
  output reg [10:0]     hpos_o,
  output reg [9:0]      vpos_o
);

  // declarations for TV-simulator sync parameters
  // horizontal constants
parameter H_DISPLAY       = 1024; 
parameter H_BACK          =   80; 
parameter H_FRONT         =   48; 
parameter H_SYNC          =   32;
  // vertical constants
parameter V_DISPLAY       =  768;
parameter V_TOP           =   15;
parameter V_BOTTOM        =    3; 
parameter V_SYNC          =    4; 
  // derived constants
parameter H_SYNC_START    = H_DISPLAY + H_FRONT;
parameter H_SYNC_END      = H_DISPLAY + H_FRONT  + H_SYNC   - 1;
parameter H_MAX           = H_DISPLAY + H_BACK   + H_FRONT  + H_SYNC - 1;
parameter V_SYNC_START    = V_DISPLAY + V_BOTTOM;
parameter V_SYNC_END      = V_DISPLAY + V_BOTTOM + V_SYNC   - 1;
parameter V_MAX           = V_DISPLAY + V_TOP    + V_BOTTOM + V_SYNC - 1;

wire hmaxxed = (hpos_o == H_MAX) ;	
wire vmaxxed = (vpos_o == V_MAX) ;	
  
always @( posedge clk_i ) begin
  if( !reset_i ) begin 
    hsync_o <= 'b0;
    hpos_o  <= 'b0;
  end
  else begin
    hsync_o <= ( ( hpos_o >= H_SYNC_START ) && ( hpos_o <= H_SYNC_END ) );
    if( hmaxxed )
      hpos_o <= 0;
    else
      hpos_o <= hpos_o + 1;
  end
end

always @( posedge clk_i ) begin
  if( !reset_i ) begin
    vsync_o <= 'b0;      
    vpos_o  <= 'b0;
  end
  else begin
    vsync_o <= ( ( vpos_o >= V_SYNC_START ) && ( vpos_o <= V_SYNC_END ) );
    if( hmaxxed )
      if( vmaxxed )
        vpos_o <= 0;
      else
        vpos_o <= vpos_o + 1;
  end
end
  
// display_on_o is set when beam is in "safe" visible frame
assign display_on_o = ( hpos_o < H_DISPLAY ) && ( vpos_o < V_DISPLAY );

endmodule

`endif

