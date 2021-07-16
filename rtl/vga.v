
/*
A simple test pattern using the hvsync_generator module.
*/

module vga(

  input         clk, reset,         	// clock and reset signals (input)
  
  output        VGA_HS, VGA_VS,	        // H/V sync signals (output)
  output [3:0]  VGA_G, VGA_R, VGA_B	// RGB output (BGR order)

  );
  
  wire          display_on;	            // display_on signal 
  wire   [9:0]  hpos;               	// 9-bit horizontal position
  wire   [9:0]  vpos;                	// 9-bit vertical position
 
  wire           clk_25;
  wire           locked;
  // Include the H-V Sync Generator module and
  // wire it to inputs, outputs, and wires.
  hvsync inst_hvsync
  (
    .clk(clk_25),
    .reset(!locked),
    
    .hsync(VGA_HS),
    .vsync(VGA_VS),
    
    .display_on(display_on),
    .hpos(hpos),
    .vpos(vpos)
  );
  
  
  clk_25 inst_clk_25
  (
  .clk_out1(clk_25),   
  .locked(locked),
  
  .clk_in1(clk)
  );

  
  localparam COLOR_I    = 5;
  localparam COLOR_R    = 30;
  
  reg [2:0]  pix        = 3'b111;
  
  always @( posedge clk_25)
    begin
      if ( ( hpos < 640 ) && ( vpos < 480 ) ) 
        begin 
          if ( ( hpos % 'd80 == 0 ) )
                pix <= pix - 3'b001;
        end
    end
  
  // Assign each color bit to individual wires.

  assign VGA_R[2:0]  =  'b111 ;
  assign VGA_G[2:0]  =  'b111 ; 
  assign VGA_B[2:0]  =  'b111 ;
  
  assign VGA_R[3] = pix[2];
  assign VGA_G[3] = pix[1];
  assign VGA_B[3] = pix[0];
  
  

  // Concatenation operator merges the red, green, and blue signals
  // into a single 3-bit vector, which is assigned to the 'rgb'
  // output. The IDE expects this value in BGR order.
 // assign rgb = {b,g,r};

endmodule





