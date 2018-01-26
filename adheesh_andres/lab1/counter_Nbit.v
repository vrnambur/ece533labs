`timescale 1ps/1ps

module counter_Nbit #(parameter WIDTH = 8)
	(   input wire en,
		input wire rst,
		input wire clk,
		output wire [WIDTH-1:0] ctr
	);
	
	reg [WIDTH-1:0] state;

	assign ctr = state;
    always @(posedge en) state=0;
    
	always @(posedge en & clk)
	 	begin
	   		if (rst)
		    	state = 0;
			else
		    	state = state + 1;
		end

endmodule
