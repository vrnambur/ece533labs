`timescale 1ps/1ps

module comparator_Nbit #(parameter WIDTH = 8)
	(   input wire [WIDTH-1:0] a,
	    input wire [WIDTH-1:0] b,
	    output wire c  
	);
	assign c = a == b;
	
//	reg [WIDTH-1:0] state;

//	always @(*)
//	 	begin
//	   		if (a==b)
//		    	c = 1;
//			else
//		    	c = 0;
//		end

endmodule
