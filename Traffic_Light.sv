`timescale 1ns / 1ps
module Traffic_Light(
            input logic clk,
            input logic rst,
            input logic walk,
            output logic green,
            output logic red,
            output logic blue
    );
    
 logic timer_done;
 logic flash;
 logic[3:0] timer_value;
 logic[2:0] grf;
 logic change;
 
    Traffic_light_FSM FSMo (
                .clk(clk),
                .rst(rst),
                .walk(walk),
                .green(green),
                .red(red),
                .flash(flash),
                .timer_done(timer_done)     
    );
    assign grf={green,red,flash};
    
    ROM rom0(
                .in(grf),
                .out(timer_value)
                
    );
    Change_detector change_det0(
    
                .in(grf),
                .change(change),
                .clk(clk),
                .rst(rst)
    );
    
    Countdown_Timer timer0(
                .clk(clk),
                .rst(rst),
                .timer_value(timer_value),
                .load(change),
                .timer_done(timer_done)
    );
    MUX mux0(
                .in0(~green),
                .in1(clk),
                .sel(flash),
                .out(blue)
                
    );
    
endmodule
