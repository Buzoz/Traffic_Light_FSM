`timescale 1ns / 1ps
module Change_detector(
                input logic         clk,
                input logic         rst,
                input logic[2:0]    in,
                output logic        change
    );
    
logic[2:0] in_pre;
    
    always_ff @(posedge clk) begin
        if(rst)
            in_pre<=0;
        else
            in_pre<=in;
           end
           
       
       assign change = (in!=in_pre);    
    
endmodule
