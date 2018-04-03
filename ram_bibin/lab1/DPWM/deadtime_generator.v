module deadtime_generator #(parameter RESOLUTION = 12) 
(	input wire [RESOLUTION-1:0] counter_state
,   input wire [RESOLUTION-1:0] duty_cycle
,	input wire [RESOLUTION-1:0] hs_deadtime
,	input wire [RESOLUTION-1:0] ls_deadtime
,	input wire HPWM
,	input wire LPWM
,	input wire reset

,	output wire pwm
,	output wire cpwm
);

//WIRES
//wire [RESOLUTION-1:0] hs_dt_counter;
wire [RESOLUTION-1:0] ls_dt_counter;
wire deadtime_hs_mask = counter_state >= hs_deadtime;
wire deadtime_ls_mask = counter_state >= (ls_deadtime + duty_cycle);

// Apply Deadtime Masks
assign pwm  = (HPWM & deadtime_hs_mask) & (~reset);
assign cpwm = (LPWM & deadtime_ls_mask) & (~reset);

endmodule

