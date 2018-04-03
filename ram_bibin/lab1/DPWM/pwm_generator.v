module pwm_generator #(parameter RESOLUTION = 12) (
	input wire [RESOLUTION-1:0] counter_state
,	input wire [RESOLUTION-1:0] highD
,	input wire [RESOLUTION-1:0] frequency_select
,	input wire reset

,   output wire counter_threshold
,	output wire HPWM
,	output wire LPWM
,   output wire pwm_clk
);

// WIRES
wire [RESOLUTION-1:0] fs = frequency_select;
wire [RESOLUTION-1:0] highside_count;

//// Frequency Select Calculations
//wire [RESOLUTION-1:0] fs_inv;
//wire [RESOLUTION-1:0] fs;
//assign fs = {RESOLUTION{1'b1}} - frequency_select;
////assign fs     = (fs_inv == 0) ? 0 : fs_inv - 1;

// Duty Cycle Saturation Checking
wire [RESOLUTION-1:0] sat_highD = (highD > fs) ? fs : highD;

// PWM Sawtooth Threshold
assign counter_threshold = (fs == counter_state) | reset;

// PWM Generation Based on Sawtooth
assign HPWM    = (sat_highD > counter_state) & (~reset);
assign LPWM    = ~HPWM & (~reset);
assign pwm_clk = ((fs >> 1) > counter_state) & (~reset);

endmodule
