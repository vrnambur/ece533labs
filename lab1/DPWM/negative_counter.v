`timescale 1ps/1ps

module negative_counter #(parameter WIDTH = 8)
(   input wire clk
,   input wire reset
,   input wire enable

,   output wire [WIDTH-1:0] count
);

//--- REGISTERS
reg [WIDTH-1:0] state;

//--- WIRES
wire e_clk;

//--- MAIN CODE

assign count = state;
assign e_clk = enable & clk;

always @(posedge e_clk) begin
    if (reset) begin
        state = {WIDTH{1'b1}};
    end
    else begin
        state = state - 1;
    end
end

endmodule

