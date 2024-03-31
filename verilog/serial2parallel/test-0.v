module serial2parallel (
    input clk,              // Clock signal
    input rst_n,            // Reset signal (active low)
    input din_serial,       // Serial input data
    input din_valid,        // Validity signal for input data
    output reg [7:0] dout_parallel,  // Parallel output data (8 bits wide)
    output reg dout_valid             // Validity signal for the output data
);

reg [3:0] cnt;  // 4-bit counter to keep track of the number of input bits received

// Synchronous logic for series-parallel conversion
always @(posedge clk or negedge rst_n)
begin
    if (~rst_n) begin  // Reset condition
        cnt <= 4'b0;
        dout_valid <= 1'b0;
        dout_parallel <= 8'b0;
    end
    else begin
        if (din_valid) begin
            if (cnt < 4'd7) begin
                cnt <= cnt + 4'b1;
                dout_parallel <= {dout_parallel[6:0], din_serial};
            end
            else begin
                cnt <= 4'b0;
                dout_valid <= 1'b1;
                dout_parallel <= {dout_parallel[6:0], din_serial};
            end
        end
    end
end

endmodule