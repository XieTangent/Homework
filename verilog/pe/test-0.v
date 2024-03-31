module pe (
    input clk,      // Clock signal
    input rst,      // Reset signal
    input [31:0] a, // Input operand A
    input [31:0] b, // Input operand B
    output reg [31:0] c // Output accumulated result
);

reg [31:0] product; // Variable to store the product of a and b

// Multiplication and Accumulation process
always @(posedge clk or posedge rst)
begin
    if (rst) begin
        c <= 0; // Reset condition
    end
    else begin
        product <= a * b; // Calculate the product
        c <= c + product; // Accumulate the result
    end
end

endmodule