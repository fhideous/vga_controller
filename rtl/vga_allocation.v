
/*
A simple test pattern using the hvsync_generator module.
*/

module vga(
  input         clk,         
  
  output        VGA_HS, VGA_VS,	       
  output [3:0]  VGA_G, VGA_R, VGA_B	
  );
  
  wire   [3:0]  r, g, b; 
  
  wire          display_on;	           
  wire   [9:0]  hpos;               	
  wire   [9:0]  vpos;                	
 
  wire           clk_25;
  wire           locked;

  vga_hvsync_gen inst_vga_hvsync_gen
  (
    .clk        (clk_25        ),
    .reset      (locked        ),
    
    .hsync      (VGA_HS        ),
    .vsync      (VGA_VS        ),
    
    .display_on (display_on    ),
    .hpos       (hpos          ),
    .vpos       (vpos          )
  );
  
  
  clk_25 inst_clk_25
  (
  .clk_out1     (clk_25         ),   
  .locked       (locked         ),
  
  .clk_in1      (clk            )
  );

  reg [2:0]  pix        = 3'b000;
  
  always @( posedge clk_25)
    begin
      if( ( hpos < 640 ) && ( vpos < 480 ) ) 
        begin 
          if( hpos % 'd80 == 0 )
            pix <= pix - 3'b001;
         end
     end

  assign r[2:0]  =  'b111 ;
  assign g[2:0]  =  'b111 ; 
  assign b[2:0]  =  'b111 ;
  
  assign r[3]    =  pix[2];
  assign g[3]    =  pix[1];
  assign b[3]    =  pix[0];
  

  d_ff_all_colors inst_d_ff_all_colors
   (
     .clk       (clk_25     ),  
     .reset     (0          ), 
     
     .d_r       (r          ),
     .d_g       (g          ),
     .d_b       (b          ),

     .q_r       (VGA_R      ),
     .q_g       (VGA_G      ),
     .q_b       (VGA_B      )
   );

 
endmodule




