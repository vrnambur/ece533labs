`timescale 1ps/1ps

module DPWM_impl #(parameter RESOLUTION = 12) 
(   input wire [RESOLUTION-1:0] duty_cycle
,   input wire [(RESOLUTION/2)-1:0] fs
,   input wire [RESOLUTION-1:0] deadtime1
,   input wire [RESOLUTION-1:0] deadtime2
,   input wire hf_clock
,   input wire reset
,   input wire enable

,   output wire c1
,   output wire c2
);

pwm

endmodule
