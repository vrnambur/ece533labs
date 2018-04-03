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
,	output wire pwm_clk
);

// REGISTERS
reg [RESOLUTION-1:0] clocked_dc;

reg [RESOLUTION-1:0] clocked_dt1;
reg [RESOLUTION-1:0] clocked_dt2;

//WIRES
wire HPWM;
wire LPWM;
//wire pwm_clk;

wire pwm;
wire cpwm;

wire [RESOLUTION-1:0] san_dc;
wire [RESOLUTION-1:0] san_fs;
wire [RESOLUTION-1:0] san_dt1;
wire [RESOLUTION-1:0] san_dt2;

wire [RESOLUTION-1:0] clocked_fs;

// MAIN CODE
always @(posedge pwm_clk) begin
    clocked_dc  <= san_dc;
    clocked_dt1 <= san_dt1;
    clocked_dt2 <= san_dt2;
end

input_sanitizer #( .RESOLUTION(RESOLUTION) ) CHECK_INPUTS (
	.dc(duty_cycle),
	.fs(fs),
	.dt1(deadtime1),
	.dt2(deadtime2),
	
	.san_dc(san_dc),
	.san_fs(clocked_fs),
	.san_dt1(san_dt1),
	.san_dt2(san_dt2)
);

// DPWM Counter
wire [RESOLUTION-1:0] counter_state;
wire counter_threshold;
positive_counter #( .WIDTH(RESOLUTION) ) DPWM_COUNTER (
	.clk(hf_clock),
	.reset(counter_threshold),
	.enable(1'b1),
	.count(counter_state)
);

pwm_generator #( .RESOLUTION(RESOLUTION) ) PWM_GEN (
	.counter_state(counter_state),
	.highD(clocked_dc),
	.frequency_select(clocked_fs),
	.reset(reset),
	
	.counter_threshold(counter_threshold),
	.HPWM(HPWM),
	.LPWM(LPWM),
	.pwm_clk(pwm_clk)
);

deadtime_generator #( .RESOLUTION(RESOLUTION) ) DT_GEN (
	.counter_state(counter_state),
	.duty_cycle(clocked_dc),
	.hs_deadtime(clocked_dt1),
	.ls_deadtime(clocked_dt2),
	.HPWM(HPWM),
	.LPWM(LPWM),
	.reset(reset),
	
	.pwm(pwm),
	.cpwm(cpwm)
);

assign c1 = pwm & enable;
assign c2 = cpwm & enable; 

endmodule
