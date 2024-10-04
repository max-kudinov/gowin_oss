module button (
    input  logic       clk_i,
    input  logic       rst_i,
    output logic [5:0] led_o
);

    logic [31:0] cnt;

    always_ff @(posedge clk_i)
        if (rst_i)
            cnt <= '0;
        else
            cnt <= cnt + 1'b1;

    assign led_o = cnt[27:22];

endmodule
