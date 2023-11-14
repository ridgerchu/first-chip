`default_nettype none
module rnn (
    input wire [7:0] current,
    input wire clk,
    input wire rst_n,
    output reg [7:0] out
);
    reg [7:0] state = 8'd0; // init
    reg [7:0] beta[7:0];  // declare beta
    reg [7:0] state_mult_beta;
    reg [7:0] next_state; // init next state

    initial begin
        // init beta
        beta[0] = 8'b00000001;
        beta[1] = 8'b00000010;
        beta[2] = 8'b00000100;
        beta[3] = 8'b00001000;
        beta[4] = 8'b00010000;
        beta[5] = 8'b00100000;
        beta[6] = 8'b01100000;
        beta[7] = 8'b11000000;
    end

    // calculate state and beta
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= 0;
        end else begin
            state <= next_state;
        end
    end

    // calcuate next state's input
    always @(state or current) begin
        state_mult_beta = 0;
        for (int i = 0; i < 8; i = i + 1) begin
            state_mult_beta = state_mult_beta + state[i] * beta[i];
        end
        next_state = state_mult_beta + current; // update next status.
        out = next_state;
    end

endmodule
