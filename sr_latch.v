module sr_latch
(   input wire s
,   input wire r
,   input wire enable
,   input wire reset

,   output reg q
,   output wire qN
);

assign qN = ~q;

// Behavioural Description of an SR Latch
always @(*) begin

    if (reset) begin
        q <= 0;
    end
    else begin
        if (enable) begin
            if (s) begin
                q <= 1;
            end
            else if (r) begin
                q <= 0;
            end
        end
    end
    
end

endmodule


