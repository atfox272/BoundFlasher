module bound_flasher_testbench;

reg             clk;
reg             rst_n;
reg             flick;

wire [15:0]     led_state;

bound_flasher uut(
        // Input
        .clk(clk),
        .rst_n(rst_n),
        .flick(flick),
        // Output
        .led_state(led_state)
);

initial begin
        clk <= 1'b0;
        rst_n <= 1'b0;
        flick <= 1'b0;

        #10;
        rst_n <= 1'b1;

        #1000;
        $finish;
end

initial begin
        forever #1 clk <= ~clk;
end

initial begin
        $recordfile ("waves");
        $recordvars ("depth=0", bound_flasher_testbench);
end

initial begin
        #15;
        flick <= 1'b1;

        #7;
        flick <= 1'b0;

        #15;
        flick <= 1'b1;

        #10; flick <= 1'b0;
end

endmodule
