`timescale 1ps/1ps

module DPWM_impl #(parameter RESOLUTION = 12) 
(   input wire [RESOLUTION-1:0] duty_cycle
,   input wire [RESOLUTION-1:0] fs          // (2^(RESOLUTION) - fs) hf_clk periods per output PWM period 
,   input wire [RESOLUTION-1:0] deadtime1
,   input wire [RESOLUTION-1:0] deadtime2
,   input wire hf_clock
,   input wire reset
,   input wire enable

,   output wire c1
,   output wire c2
);

//WIRES
wire HPWM;
wire LPWM;

wire pwm;
wire cpwm;

wire [RESOLUTION-1:0] safe_dt1;
wire [RESOLUTION-1:0] safe_dt2;

assign safe_dt1 = (deadtime1 < duty_cycle) ? deadtime1 : duty_cycle;
assign safe_dt2 = (deadtime2 < duty_cycle) ? deadtime2 : duty_cycle;

pwm_generator #( .RESOLUTION(RESOLUTION) ) PWM_GEN (
	.hf_clock(hf_clock),
	.highD(duty_cycle),
	.lowD(duty_cycle),
	.frequency_select(fs),
	.reset(reset),
	
	.HPWM(HPWM),
	.LPWM(LPWM)
);

deadtime_generator #( .RESOLUTION(RESOLUTION) ) DT_GEN (
	.hf_clock(hf_clock),
	.hs_deadtime(safe_dt1),
	.ls_deadtime(safe_dt2),
	.HPWM(HPWM),
	.LPWM(LPWM),
	.reset(reset),
	
	.pwm(pwm),
	.cpwm(cpwm)
);

assign c1 = pwm & enable;
assign c2 = cpwm & enable; 

endmodule
