`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2018 08:56:44 PM
// Design Name: 
// Module Name: sr_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sr_tb(

    );
    
    reg s, r, enable, reset;
    wire q, qN;
    
    initial begin
        s = 0;
        r = 0;
        enable = 0;
        reset = 1;
        
        #40 reset = 0;
        #40 enable = 1;
        #40 s = 1;
        #40 s = 0;
        #40 r = 1;
        #40 r = 0;
        #40 s = 1;
        #40 reset = 1;
        #40 reset = 0;
        #40 r = 1;
        #40 s = 0;
        #40 r = 0;
        #20 enable = 0;
        #20 s = 1;
        #20 s = 0;
        #20 r = 1;
        #20 r = 0;
        #20 s = 1;
        #20 reset = 1;
        #20 reset = 0;
        #20 r = 1;
        #20 s = 0;
        #20 r = 0;
        #20 s = 1;
        #20 enable = 1;
    end
    
    sr_latch #(1) SR
    (   .s(s)
    ,   .r(r)
    ,   .enable(enable)
    ,   .reset(reset)
    
    ,   .q(q)
    ,   .qN(qN)
    );
endmodule
