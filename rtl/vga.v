
/*
A simple test pattern using the hvsync_generator module.
*/

module vga(clk, reset, VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B);

  input         clk, reset;         	// clock and reset signals (input)
  
  output        VGA_HS, VGA_VS;	        // H/V sync signals (output)
  output [3:0]  VGA_G, VGA_R, VGA_B;	// RGB output (BGR order)
  
  wire          display_on;	            // display_on signal 
  wire   [9:0]  hpos;               	// 9-bit horizontal position
  wire   [9:0]  vpos;                	// 9-bit vertical position
 
  wire           clk_130;
  wire           locked;
  // Include the H-V Sync Generator module and
  // wire it to inputs, outputs, and wires.
  hvsync(
    .clk(clk_130),
    .reset(!locked),
    
    .hsync(VGA_HS),
    .vsync(VGA_VS),
    
    .display_on(display_on),
    .hpos(hpos),
    .vpos(vpos)
  );
  
  
    clk_wiz
  (
  // Clock out ports  
  .clk_out1(clk_130),
  // Status and control signals               
  .locked(locked),
 // Clock in ports
  .clk_in1(clk)
  );

  
  localparam COLOR_I = 5;
  localparam COLOR_R= 30;
  
  // Assign each color bit to individual wires.
  assign VGA_R[3] = display_on && (       ( vpos & COLOR_R == 0 ) ||
                                          ( vpos & COLOR_R == 0 )      )  && 0 ;
  
  assign VGA_G[3] =  display_on &&    hpos[COLOR_I] ;
  assign VGA_B[3] =  display_on && ( !hpos[COLOR_I] ) ;

  assign VGA_R[2:0] = 'b0;
  assign VGA_G[2:0] = 'b0;
  assign VGA_B[2:0] = 'b0;
  

  // Concatenation operator merges the red, green, and blue signals
  // into a single 3-bit vector, which is assigned to the 'rgb'
  // output. The IDE expects this value in BGR order.
 // assign rgb = {b,g,r};

endmodule





