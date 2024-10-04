module leds_pmod (
    input  logic        clk_i,
    input  logic        rst_i,
    input  logic [3:0]  buttons,
    input  logic [3:0]  switches,
    output logic [15:0] pmod_leds_o,
    output logic [7:0 ] seven_seg_o
);

    logic [21:0] cnt;
    logic [7:0] seven_seg_cnt;
    logic [10:0] refresh_cnt;
    logic enable;
    logic switch;
    logic [3:0] digit;

    always_ff @(posedge clk_i)
        if (rst_i)
            seven_seg_cnt <= '0;
        else if (enable) begin
            if (switches[1])
                seven_seg_cnt <= seven_seg_cnt + 1'b1;
            else
                seven_seg_cnt <= seven_seg_cnt - 1'b1;
        end

    always_ff @(posedge clk_i)
        if (rst_i)
            refresh_cnt <= '0;
        else
            refresh_cnt <= refresh_cnt + 1'b1;

    always_ff @(posedge clk_i)
        if (rst_i)
            cnt <= '0;
        else
            cnt <= cnt + 1'b1;

    assign enable = cnt == 0;

    assign seven_seg_o[0] = switch;

    always_ff @(posedge clk_i)
        if (rst_i)
            pmod_leds_o     <= '0;
        else if (enable) begin
            if (switches[0])
                pmod_leds_o <= { pmod_leds_o[14:0], buttons[0] | pmod_leds_o[15] };
            else
                pmod_leds_o <= { buttons[0] | pmod_leds_o[0], pmod_leds_o[15:1] };
        end


    always @(posedge clk_i)
        if (rst_i)
            switch <= '0;
        else if (refresh_cnt == 0)
            switch <= ~ switch;

    always_comb begin
        digit = 4'(seven_seg_cnt >> switch * 4);

        case (digit)
            4'd0:  seven_seg_o[7:1] = 7'b1111110;
            4'd1:  seven_seg_o[7:1] = 7'b0110000;
            4'd2:  seven_seg_o[7:1] = 7'b1101101;
            4'd3:  seven_seg_o[7:1] = 7'b1111001;
            4'd4:  seven_seg_o[7:1] = 7'b0110011;
            4'd5:  seven_seg_o[7:1] = 7'b1011011;
            4'd6:  seven_seg_o[7:1] = 7'b1011111;
            4'd7:  seven_seg_o[7:1] = 7'b1110000;
            4'd8:  seven_seg_o[7:1] = 7'b1111111;
            4'd9:  seven_seg_o[7:1] = 7'b1111011;
            4'd10: seven_seg_o[7:1] = 7'b1110111;
            4'd11: seven_seg_o[7:1] = 7'b0011111;
            4'd12: seven_seg_o[7:1] = 7'b1001110;
            4'd13: seven_seg_o[7:1] = 7'b0111101;
            4'd14: seven_seg_o[7:1] = 7'b1001111;
            4'd15: seven_seg_o[7:1] = 7'b1000111;
        endcase

    end

endmodule
