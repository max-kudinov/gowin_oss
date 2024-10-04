module top (
    input  logic       clk,
    input  logic       rst_n,
    output logic [5:0] led_inv
);

    logic       rst;
    logic [5:0] led;

    assign rst     = ~ rst_n;
    assign led_inv = ~ led;

    button i_btn (
        .clk_i (clk),
        .rst_i (rst),
        .led_o (led)
    );

endmodule
