`timescale 1ns / 1ps

module d_ff_4 (
        input wire [3:0] D,
        input            clk,
        input            reset,
        output reg [3:0] Q
    );
    
    always  @( posedge clk ) 
      begin
        if ( reset ) 
            Q <= 'b0000;
        else
            Q <= D;
       end
        
endmodule
