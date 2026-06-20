`timescale 1ns / 1ps
module Countdown_Timer(
                input logic         clk,
                input logic         rst,
                input logic         load,
                input logic[3:0]    timer_value,
                output logic        timer_done
    );
    
    logic[3:0] count;
    
    always_ff @(posedge clk) begin 
        if (rst)
            count<=4'b1111;
            else
            if(load)
                count<=timer_value;
                else
                    if(count>0)
                    count<=count-1;
    
    end
    
    assign timer_done=(count==4'b0000);
    
endmodule
