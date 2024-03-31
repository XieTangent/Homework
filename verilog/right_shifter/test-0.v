module right_shifter (
    input clk,
    input d,
    output reg [7:0] q
);

    always @(posedge clk) begin
        q <= {q[6:0], d}; // Shift q register to the right by 1 bit and insert new input bit at MSB
    end

endmodule