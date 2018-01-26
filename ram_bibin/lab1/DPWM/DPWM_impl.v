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

// REGISTERS
reg [RESOLUTION-1:0] clocked_dc;
reg [RESOLUTION-1:0] clocked_fs;
reg [RESOLUTION-1:0] clocked_dt1;
reg [RESOLUTION-1:0] clocked_dt2;

//WIRES
wire HPWM;
wire LPWM;
wire pwm_clk;

wire pwm;
wire cpwm;

wire [RESOLUTION-1:0] safe_dt1;
wire [RESOLUTION-1:0] safe_dt2;

// MAIN CODE
always @(posedge pwm_clk) begin
    clocked_dc  <= duty_cycle;
    clocked_fs  <= fs;
    clocked_dt1 <= deadtime1;
    clocked_dt2 <= deadtime2;
end

assign safe_dt1 = (clocked_dt1 < clocked_dc) ? clocked_dt1 : clocked_dc;
assign safe_dt2 = (clocked_dt2 < clocked_dc) ? clocked_dt2 : clocked_dc;

pwm_generator #( .RESOLUTION(RESOLUTION) ) PWM_GEN (
	.hf_clock(hf_clock),
	.highD(clocked_dc),
	.lowD(clocked_dc),
	.frequency_select(clocked_fs),
	.reset(reset),
	
	.HPWM(HPWM),
	.LPWM(LPWM),
	.pwm_clk(pwm_clk)
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
