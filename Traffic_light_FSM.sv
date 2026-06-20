`timescale 1ns / 1ps
module Traffic_light_FSM(
        input logic clk,
        input logic rst,
        input logic walk,
        output logic green,
        output logic red,
        output logic flash,
        input logic timer_done
    );
    
localparam Green_State = 2'b00;
localparam Yellow_State = 2'b01;
localparam Red_State =   2'b10;
localparam Flash_State = 2'b11;

logic [1:0] state, state_next;

always_ff @(posedge clk) begin
    if(rst == 1)
        state <=Green_State;
    else
        state <= state_next;
end
    
    always_comb begin
    state_next = state;
    case(state)
        Green_State: begin
                         if(walk == 0) state_next =Green_State;
                         else
                         if(walk == 1) state_next=Yellow_State;
                     end
        Yellow_State: begin
                         if(timer_done == 0) state_next =Yellow_State;
                         else
                         if(timer_done == 1) state_next=Red_State;
                     end
       Red_State: begin
                         if(timer_done == 0) state_next =Red_State;
                         else
                         if(timer_done == 1) state_next=Flash_State;
                     end
     Flash_State: begin
                         if(timer_done == 0) state_next =Flash_State;
                         else
                         if(timer_done == 1) state_next=Green_State;
                     end  
       
       default: state_next = Green_State;
       
    endcase
end
    
    
    assign green= (state == Green_State) || (state == Yellow_State);
    assign red= (state == Yellow_State) || (state == Red_State)|| (state == Flash_State);
    assign flash= (state == Flash_State);
endmodule
