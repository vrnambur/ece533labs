module DPWM (
	input [8:0] SW,
	input [3:0] LEDR,
	input CLOCK_50,
	
	output [3:0] GPIO_0
);

// Control Logic 
// DPWM_impl call

wire fs_clk;
wire [8:0] pwm_counter;
wire counter_reset;
reg high_side;
reg low_side;
wire pwm;


assign pwm = (fs_clk ^ low_side);


assign GPIO_0[1] = fs_clk;
assign GPIO_0[2] = low_side;
assign GPIO_0[0] = pwm;

clock_divider #( .WIDTH(9) ) (
	.clk(CLOCK_50),
	.reset(1'b0),
	.divisor('d500),
	
	.clk_out(fs_clk)
);

positive_counter #( .WIDTH(9) ) (
	.clk(CLOCK_50),
	.reset(counter_reset),
	.enable(1'b1),
	.count(pwm_counter)
);

assign counter_reset = low_side ~^ fs_clk;


always @(posedge CLOCK_50) begin
	if (pwm_counter == SW[8:0]) begin
		low_side = fs_clk;
	end
	else begin
		low_side = low_side;
	end
end

endmodule
