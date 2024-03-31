module pulse_detect (
    input clk,      // Clock signal
    input rst_n,    // Reset signal (active low)
    input data_in,  // One-bit input signal
    output reg data_out // Output signal indicating the presence of pulses
);

// Declare states for pulse detection
parameter IDLE = 2'b00;
parameter PULSE_START = 2'b01;
parameter PULSE_END = 2'b10;

reg [1:0] state, next_state;

// State machine for pulse detection
always @ (posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        state <= IDLE;
        data_out <= 0;
    end else begin
        state <= next_state;
    end
end

always @* begin
    next_state = state;
    
    case(state)
        IDLE: begin
            if (data_in) begin
                next_state = PULSE_START;
            end
        end
        
        PULSE_START: begin
            if (~data_in) begin
                next_state = PULSE_END;
            end
        end

        PULSE_END: begin
            next_state = IDLE;
        end
    endcase
end

// Generate output data_out based on state
always @* begin
    case(state)
        IDLE: begin
            data_out = 0;
        end
        
        PULSE_START: begin
            data_out = 0;
        end

        PULSE_END: begin
            data_out = 1;
        end
    endcase
end

endmodule