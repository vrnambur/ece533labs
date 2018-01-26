`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/21/2018 06:20:41 PM
// Design Name: 
// Module Name: tb
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


module tb(

    );
    
    reg [11:0] DC;
    reg [11:0] FS;
    reg [11:0] DT1;
    reg [11:0] DT2;
    reg clock;
    reg reset;
    reg enable;
    
    wire c1;
    wire c2;
    
    
    initial begin 
        clock = 0;
        DC = 0;
        FS = 4095;
        DT1 = 0; // adding 1 cycle extra here
        DT2 = 0; // adding 2 cycles extra here
        reset = 1;
        enable = 0;
        
        #40 reset = 0;
        #40 enable = 1;
        //#400000 DC = 3072;
    end
    
    always #400 DC = DC + 100;
    always #5 clock = !clock;
    
    DPWM_impl #(12) DUT (
        .duty_cycle(DC),
        .fs(FS),
        .deadtime1(DT1),
        .deadtime2(DT2),
        .hf_clock(clock),
        .reset(reset),
        .enable(enable),
    
        .c1(c1),
        .c2(c2)
    );
    
endmodule
