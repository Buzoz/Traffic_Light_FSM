`timescale 1ns / 1ps
module TB();

logic clk;   
logic rst;   
logic walk;  
logic green;
logic red;  
logic blue;  


Traffic_Light DUT (
.clk(clk),  
.rst(rst),
.walk(walk),
.green(green),
.red(red),
.blue(blue)
);

    
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

    initial begin
            walk=0;
            rst=1;
            
        #10 rst=0;
        #10 walk=1;
        #10 walk=0;
      
    repeat(20) @(posedge clk);
    
             walk=1;
         #10 walk=0;
                
     repeat(20) @(posedge clk);
    
    $stop;
     
    end


endmodule
