`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2018 07:45:58 PM
// Design Name: 
// Module Name: SR_latch
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


module SR_latch(
    input wire s,
    input wire r,
    input wire clk,
    input wire en,
    output reg q,
    output wire q_bar
    );
    
    //wire en_clk = clk & en;
        
    assign q_bar = ~q;
always @(*)
begin
    if (s==1) q <= 1;
    else if(r==1) q <= 0;
    else q<=q;
end 
    
endmodule
