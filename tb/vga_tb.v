`timescale 1ns / 1ps

module vga_tb;

    reg          clk;
    reg          reset;

    wire         VGA_HS;
    wire         VGA_VS;
    wire  [3:0]  VGA_G;    
    wire  [3:0]  VGA_B;    
    wire  [3:0]  VGA_R;
    
    localparam CLK_SEMIPERIOD = 5;
    
    vga uut
    (
            .clk(clk),
        
            .VGA_HS(VGA_HS),
            .VGA_VS(VGA_VS),
                        
            .VGA_R(VGA_R),
            .VGA_B(VGA_B),
            .VGA_G(VGA_G)
    );
  
    
    initial begin 
      clk = 'b0;
      forever begin
           #CLK_SEMIPERIOD clk = ~clk;
      end
     end

   initial begin 
     reset = 'b0;
     #500;
     reset = 'b1;
   end



endmodule
