`timescale 1ps/1ps
// Reference: http://www.referencedesigner.com/tutorials/verilogexamples/verilog_ex_07.php
module clock_divider #(parameter WIDTH = 2)
(   input wire clk
,   input wire reset
,   input wire [WIDTH:0] divisor

,   output wire clk_out
);
 
reg [WIDTH-1:0] pos_count, neg_count;
wire [WIDTH-1:0] r_nxt;
 
always @(posedge clk) begin
    if (reset) begin
        pos_count <= 0;
    end
    else if (pos_count == divisor-1) begin 
        pos_count <= 0;
    end
    else begin
        pos_count<= pos_count +1;
    end
end

always @(negedge clk) begin
    if (reset) begin
        neg_count <= 0;
    end 
    else if (neg_count == divisor-1) begin
        neg_count <= 0;
    end
    else begin
        neg_count<= neg_count+1;
    end
end
     
assign clk_out = ((pos_count > (divisor>>1)) | (neg_count > (divisor>>1))); 

endmodule
