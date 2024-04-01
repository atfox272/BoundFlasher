module bound_flasher(
        // Input
        input           clk,            // Source Clock
        input           rst_n,          // Negative Reset
        input           flick,          // Flick Signal
        // Output
        output [15:0]   led_state       // 16bit LED
);
        wire [4:0] counter;

        assign clk_div = clk;

        //system_clock_generator clk_gen(
        //      // Input
        //      .clk(clk),
        //      .rst_n(rst_n),
        //      // Output
        //      .clk_div(clk_div)
        //);
        system_control_block sys_ctl(
                // Input
                .clk(clk_div),
                .flick(flick),
                .rst_n(rst_n),
                // Output
                .counter(counter[4:0])
        );
        decoder_under
        #(
                .IN_WIDTH(32'd5)
        )
        decoder_under_5to32
        (
                // Input
                .in(counter[4:0]),
                // Output
                .out(led_state[15:0])

        );

endmodule
