`timescale 1ns / 1ps
module CLK_Delay(
        input logic clk,
        input logic rst,
        output logic clk_delay
    );
    
  logic[31:0] sig;  
    
    always_ff @(posedge clk) begin
        if(rst)
            sig <=0;
        else
            sig <= sig + 1;
    end
    
    assign clk_delay = sig[27];
    
endmodule
