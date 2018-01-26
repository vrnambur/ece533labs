module input_sanitizer #( parameter RESOLUTION = 12 ) (
	input wire [RESOLUTION-1:0] dc
,	input wire [RESOLUTION-1:0] fs
,	input wire [RESOLUTION-1:0] dt1
,	input wire [RESOLUTION-1:0] dt2

,	output wire [RESOLUTION-1:0] san_dc
,	output wire [RESOLUTION-1:0] san_fs
,	output wire [RESOLUTION-1:0] san_dt1
,	output wire [RESOLUTION-1:0] san_dt2
);

// WIRES
wire [RESOLUTION-1:0] fs_inv;

// MAIN CODE

// Frequency Select Sanitization
assign fs_inv = {RESOLUTION{1'b1}} - fs;
assign san_fs = (fs_inv < 2) ? 2 : fs_inv;

// Duty Cycle Sanitization
assign san_dc = (dc > san_fs) ? san_fs : dc;

// Deadtime1 Sanitization
assign san_dt1 = (dt1 > san_dc) ? san_dc : dt1;

// Deadtime2 Sanitization
assign san_dt2 = (dt2 > (san_fs - san_dc)) ? (san_fs - san_dc) : dt2;

endmodule
