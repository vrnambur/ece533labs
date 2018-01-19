`timescale 1ps/1ps

module DPWM_impl #( parameter FREQ=8, 
                    parameter DC=8,
                    parameter DT=8) 
(   input wire [DC-1:0] duty_cycle
,   input wire [FREQ-1:0] fs
,   input wire [DT-1:0] deadtime1
,   input wire [DT-1:0] deadtime2
,   input wire hf_clock
,   input wire reset
,   input wire enable

,   output wire c1
,   output wire c2
);



endmodule
