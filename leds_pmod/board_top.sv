module board_top (
    input  logic        clk_i,
    input  logic        rst_n_i,
    input  logic [3:0 ] buttons_inv_i,
    input  logic [3:0 ] switches_inv_i,
    output logic [15:0] pmod_leds_inv_o,
    output logic [7:0 ] seven_seg_inv_o
);

    logic        rst;
    logic [15:0] pmod_leds;
    logic [3:0 ] buttons;
    logic [3:0 ] switches;
    logic [7:0 ] seven_seg;

    assign rst             = ~ rst_n_i;
    assign pmod_leds_inv_o = ~ pmod_leds;
    assign buttons         = ~ buttons_inv_i;
    assign switches        = ~ switches_inv_i;
    assign seven_seg_inv_o = ~ seven_seg;

    leds_pmod i_leds_pmod (
        .clk_i       ( clk_i     ),
        .rst_i       ( rst       ),
        .buttons     ( buttons   ),
        .switches    ( switches  ),
        .pmod_leds_o ( pmod_leds ),
        .seven_seg_o ( seven_seg )
    );

endmodule
