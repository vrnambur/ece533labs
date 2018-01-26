`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2018 06:42:33 PM
// Design Name: 
// Module Name: DPWM
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


module DPWM #(parameter WIDTH=12) (
    input [WIDTH-1:0] d,
    input [WIDTH-1:0] fs,
    input hfclk,
    input reset,
    output pwm,
    output cpwm,
    output ct,
    output ct_bar,
    input [WIDTH-1:0] dt1,
    input [WIDTH-1:0] dt2
    );

 wire SET, RESET;
 wire [WIDTH-1:0] ctr1;
 wire [WIDTH-1:0] deadtime1; 
 reg dt1_en;
 reg dt2_en; 

 counter_Nbit #(.WIDTH(WIDTH)) counter_PWM_time_period (
            .en(1),
            .rst(reset | (ctr1==fs)),
            .clk(hfclk),
            .ctr(ctr1)
            );
            
 SR_latch PWM_generator(
                       .s(ctr1 == 0),
                        .r(d == ctr1),
                        .clk(hfclk),
                        .en(1),
                        .q(pwm),
                        .q_bar(cpwm)
                        );                      
                                                   
// always @(ctr1==dt1) dt1_en=1;
// always @ (ctr1==fs) dt1_en=0;

 always @(*)
 begin
    if (ctr1==dt1) dt1_en=1;
    if (ctr1==(fs>>1)+dt2) dt2_en=1;
    if (ctr1 == fs) begin
        dt1_en = 0;
        dt2_en = 0;
    end
 end
 
 assign ct = dt1_en & pwm;
 assign ct_bar = dt2_en & cpwm; 
 //always @ (ctr1==fs) dt1_en=0;
 //assign ct = dt1_en & pwm;
 
//always @(*) begin
//    if (ctr1 == dt1) dt1_en = 1;
//    else if (ctr1 == fs) dt1_en = 0;
//end
 
// always @ (ctr1==(fs>>1)+dt2) dt2_en=1;
// always @ (ctr1==fs) dt2_en=0;
 //assign ct_bar = dt2_en & cpwm;
 
// always @(*) begin
//    if (ctr1 == ((fs>>1)+dt2)) dt2_en = 1;
//    else if (ctr1==fs) dt2_en = 0;
// end
 
endmodule
