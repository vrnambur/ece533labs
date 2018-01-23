module DPWM #(parameter RESOLUTION = 12) (
	input [17:0] SW			// Selection Bits
//,	input [RESOLUTION-1:0] SW	// Value Bits
,	input [3:0] KEY
,	input [3:0] LEDR
,	input CLOCK_50
	
,	output [3:0] GPIO_0
);

// TODO: PLL - 200 MHz
wire pll_clock;
assign pll_clock = CLOCK_50;

reg [1:0] selector;

reg [RESOLUTION-1:0] DC_value;
reg [RESOLUTION-1:0] FS_value;
reg [RESOLUTION-1:0] DT1_value;
reg [RESOLUTION-1:0] DT2_value;

always @(posedge pll_clock) begin
	selector = SW[17:16];

	case (selector) 
		2'b00: DC_value = SW[RESOLUTION-1:0];
		2'b01: FS_value = SW[RESOLUTION-1:0];
		2'b10: DT1_value = SW[RESOLUTION-1:0];
		2'b11: DT2_value = SW[RESOLUTION-1:0];
		default: DC_value = SW[RESOLUTION-1:0];
	endcase 

end

DPWM_impl #( .RESOLUTION(RESOLUTION) ) DPWM_IMPL (
	.duty_cycle(DC_value),
	.fs(FS_value),
	.deadtime1(DT1_value),
	.deadtime2(DT2_value),
	.hf_clock(clock_50),
	.reset(KEY[0]),
	.enable(~KEY[1]),
	
	.c1(GPIO_0[0]),
	.c2(GPIO_0[1])
);

assign GPIO_0[2] = CLOCK_50;
assign GPIO_0[3] = pll_clock;

endmodule
