module traffic_light (
    input rst_n,
    input clk,
    input pass_request,
    output [7:0] clock,
    output reg red, yellow, green
);

    parameter idle = 2'b00;
    parameter s1_red = 2'b01;
    parameter s2_yellow = 2'b10;
    parameter s3_green = 2'b11;

    reg [7:0] cnt;
    reg [1:0] state;
    reg p_red, p_yellow, p_green;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 10;
            state <= idle;
            p_red <= 1'b0;
            p_yellow <= 1'b0;
            p_green <= 1'b0;
        end else begin
            case(state)
                idle: begin
                    state <= s1_red;
                end
                s1_red: begin
                    if (cnt == 3) begin
                        state <= s3_green;
                    end
                end
                s2_yellow: begin
                    if (cnt == 3) begin
                        state <= s1_red;
                    end
                end
                s3_green: begin
                    if (cnt == 3) begin
                        state <= s2_yellow;
                    end
                end
            endcase
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 10;
        end else begin
            if (pass_request && p_green) begin
                cnt <= 10;
            end else if (!p_green && p_green) begin
                cnt <= 60;
            end else if (!p_yellow && p_yellow) begin
                cnt <= 5;
            end else if (!p_red && p_red) begin
                cnt <= 10;
            end else begin
                if (cnt > 0) begin
                    cnt <= cnt - 1;
                end
            end
        end
    end

    assign clock = cnt;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            red <= 1'b0;
            yellow <= 1'b0;
            green <= 1'b0;
        end else begin
            case(state)
                idle: begin
                    red <= 1'b0;
                    yellow <= 1'b0;
                    green <= 1'b0;
                end
                s1_red: begin
                    red <= 1'b1;
                    yellow <= 1'b0;
                    green <= 1'b0;
                end
                s2_yellow: begin
                    red <= 1'b0;
                    yellow <= 1'b1;
                    green <= 1'b0;
                end
                s3_green: begin
                    red <= 1'b0;
                    yellow <= 1'b0;
                    green <= 1'b1;
                end
            endcase
        end
    end

endmodule