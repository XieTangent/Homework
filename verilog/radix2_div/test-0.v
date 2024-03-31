module radix2_div #(
  parameter DATAWIDTH = 8
) (
  input clk,
  input rstn,
  input en,
  input [DATAWIDTH-1:0] dividend,
  input [DATAWIDTH-1:0] divisor,
  output reg ready,
  output reg [DATAWIDTH-1:0] quotient,
  output reg [DATAWIDTH-1:0] remainder,
  output reg vld_out
);

  // State Definitions
  parameter IDLE = 2'b00;
  parameter SUB = 2'b01;
  parameter SHIFT = 2'b10;
  parameter DONE = 2'b11;

  // State Registers
  reg [1:0] current_state, next_state;

  // Data Registers
  reg [DATAWIDTH*2-1:0] dividend_e, divisor_e, quotient_e, remainder_e;
  reg [3:0] count;

  // Reset Logic
  always @(negedge rstn) begin
    if (~rstn) begin
      current_state <= IDLE;
      next_state <= IDLE;
      ready <= 1'b0;
      vld_out <= 1'b0;
      dividend_e <= 0;
      divisor_e <= 0;
      quotient_e <= 0;
      remainder_e <= 0;
      count <= 0;
      quotient <= 0;
      remainder <= 0;
    end
  end

  // State Transition and Data Computation
  always @(*) begin
    case (current_state)
      IDLE: begin
        ready <= 1'b1;
        if (en) begin
          next_state <= SUB;
          dividend_e <= {DATAWIDTH{dividend}};
          divisor_e <= {DATAWIDTH{divisor}};
        end else begin
          next_state <= IDLE;
          dividend_e <= 0;
          divisor_e <= 0;
        end
      end

      SUB: begin
        if (dividend_e >= divisor_e) begin
          dividend_e <= dividend_e - divisor_e;
          quotient_e <= {quotient_e[DATAWIDTH-1:1], 1'b1};
        end else begin
          quotient_e <= {quotient_e[DATAWIDTH-1:1], 1'b0};
        end
        count <= count + 1;
        if (count >= DATAWIDTH) begin
          next_state <= SHIFT;
        end else begin
          next_state <= SUB;
        end
      end

      SHIFT: begin
        count <= count + 1;
        if (count >= DATAWIDTH) begin
          next_state <= DONE;
          remainder_e <= dividend_e;
        end else begin
          dividend_e <= {dividend_e[DATAWIDTH-1:1], 1'b0};
          next_state <= SHIFT;
        end
      end

      DONE: begin
        vld_out <= 1'b1;
        ready <= 1'b0;
        next_state <= IDLE;
        quotient <= quotient_e[DATAWIDTH-1:0];
        remainder <= remainder_e[DATAWIDTH-1:0];
      end
    endcase
  end

  // State Transition
  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end
  end

endmodule