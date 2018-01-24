module sr_latch #(parameter WIDTH = 8)
(   input wire [WIDTH-1:0] s
,   input wire [WIDTH-1:0] r
,   input wire enable
,   input wire reset

,   output reg [WIDTH-1:0] q
,   output wire [WIDTH-1:0] qN
);

wire [WIDTH-1:0] set_trigger;
wire [WIDTH-1:0] reset_triggerN;


assign qN = ~q;

genvar I;
generate
for (I = 0; I < WIDTH; I=I+1) begin

    assign set_trigger[I]      = s[I] & enable & ~reset;
    assign reset_triggerN[I]    = ~((~s[I] & r[I]) | reset);

    always @(posedge set_trigger[I] or negedge reset_triggerN[I]) begin
        if (~reset_triggerN[I]) begin
            q[I] = 1'b0;
        end
        else if (set_trigger[I]) begin
            q[I] = 1'b1;
        end
    end
end
endgenerate

endmodule


