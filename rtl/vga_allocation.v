
module vga_allocation(
  input          clk,         
  
  output         vga_hs, vga_vs,	       
  output [3:0]   vga_r, vga_g, vga_b	
  );
  
  wire           display_on;	           
  wire   [10:0]  hpos;               	
  wire   [9:0]   vpos;                	
 
  wire           clk_hvsync;
  wire           pll_locked;
  wire           reset;      

vga_hvsync_gen inst_vga_hvsync_gen
(
  .clk_i        (clk_hvsync      ),
  .reset_i      (reset_vga_alloc ),
  
  .hsync_o      (vga_hs          ),
  .vsync_o      (vga_vs          ),
    
  .display_on_o (display_on      ),
  .hpos_o       (hpos            ),
  .vpos_o       (vpos            )
);
  
clk_hvsync inst_clk_hvsync
(
  .clk_out1     (clk_hvsync      ),   
  .locked       (pll_locked      ),
  
  .clk_in1      (clk             )
);

assign reset_vga_alloc = pll_locked;

reg [6:0]       cnt;
wire            tic;

always @( posedge clk_hvsync) begin
  if ( !reset_vga_alloc )
    cnt <= 'b0;
  else begin
    if ( ( cnt == 'd127 ) || ( !display_on ) )
      cnt <= 'b0;
    else if ( display_on )
      cnt <= cnt + 'b1;
  end 
 end 

assign    tic = ( cnt == 'd127 ) ;

reg [2:0] n_segment;

always @( posedge clk_hvsync) begin
  if ( !reset_vga_alloc )
    n_segment <= 'b0;
  else begin
    if ( tic && display_on)
      n_segment <= n_segment + 'b1;
    else if ( !display_on ) 
      n_segment <= 'b0;
  end 
end 

reg  r_reg, g_reg, b_reg;

always @( posedge clk_hvsync ) begin
  if ( !reset_vga_alloc ) begin
    r_reg <= 'b1;
    g_reg <= 'b1;
    b_reg <= 'b1;
  end
  else begin
    r_reg <= n_segment[2];
    g_reg <= n_segment[1];
    b_reg <= n_segment[0];
  end
end

assign vga_r[2:0]  =  'b111;
assign vga_g[2:0]  =  'b111; 
assign vga_b[2:0]  =  'b111;

assign vga_r[3]   =   r_reg;
assign vga_b[3]   =   b_reg;
assign vga_g[3]   =   g_reg;
 
endmodule




