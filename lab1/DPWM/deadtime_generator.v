module deadtime_generator #(parameter RESOLUTION = 12) 
(	input wire hf_clock
,	input wire [RESOLUTION-1:0] hs_deadtime
,	input wire [RESOLUTION-1:0] ls_deadtime
,	input wire HPWM
,	input wire LPWM

,	output wire pwm
,	output wire cpwm
);

//WIRES
wire [RESOLUTION-1:0] hs_dt_counter;
wire [RESOLUTION-1:0] ls_dt_counter;
wire deadtime_hs_mask = hs_dt_counter > hs_deadtime;
wire deadtime_ls_mask = ls_dt_counter > ls_deadtime;

positive_counter #( .WIDTH(RESOLUTION) ) HS_DT_CTR (
	.clk(hf_clock),
	.reset(HPWM),
	.enable(1'b1),
	.count(hs_dt_counter)
);

positive_counter #( .WIDTH(RESOLUTION) ) LS_DT_CTR (
	.clk(hf_clock),
	.reset(LPWM),
	.enable(1'b1),
	.count(ls_dt_counter)
);

assign pwm  = HPWM & deadtime_hs_mask;
assign cpwm = LPWM & deadtime_ls_mask;

endmodule

