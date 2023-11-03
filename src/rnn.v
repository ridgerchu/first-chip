

`default_nettype none
module rnn (
    input wire [7:0] current,
    input wire clk,
    input wire rst_n,
    output reg [7:0] out
);
    reg [7:0] threshold;
    reg [7:0] beta[7:0];  // Define beta as a matrix
    reg [7:0] state_mult_beta;

    initial begin
        // Initialize beta
        beta[0] = 8'b00000001;
        beta[1] = 8'b00000010;
        beta[2] = 8'b00000100;
        beta[3] = 8'b00001000;
        beta[4] = 8'b00010000;
        beta[5] = 8'b00100000;
        beta[6] = 8'b01000000;
        beta[7] = 8'b10000000;
    end

    // calculate state and beta

    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 0;
        end else begin:
            state <= next_state;
    
    state_mult_beta = 0;
    for(int i=0; i<8; i=i+1) begin
        state_mult_beta = state_mult_beta + state[i] * beta[i];
    end

    assign next_state = state_mult_beta + current

    end
end


endmodule