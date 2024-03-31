module width_8to16 (
    input clk,
    input rst_n,
    input valid_in,
    input [7:0] data_in,
    output reg valid_out,
    output reg [15:0] data_out
);

reg [7:0] data_reg;
reg [7:0] data_lock;
reg flag;

always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_out <= 16'h0000;
        valid_out <= 0;
        data_lock <= 8'h00;
        flag <= 0;
    end else begin
        if (valid_in) begin
            if (!flag) begin
                // Store the first data temporarily
                data_lock <= data_in;
                flag <= 1;
            end else begin
                // Concatenate the stored data and new data to form 16-bit output
                data_out <= {data_lock, data_in};
                valid_out <= 1;
                flag <= 0;
            end
        end
    end
end

endmodule