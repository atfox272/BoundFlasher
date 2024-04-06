module kickback_match_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg flick;
    reg [4:0] counter;
    wire kickback_match;

    // Instantiate the DUT
    kickback_match_generator dut (
        .flick(flick),
        .counter(counter),
        .kickback_match(kickback_match)
    );

    // Clock generation
    reg clk;
    always #((CLK_PERIOD / 2)) clk = ~clk;

    // Testbench behavior
    initial begin
        // Initial values
        flick = 1'b0;
        #20;
        $display("time = %d   , flick = %b, counter = %d, kickback_match = %d", $time, flick, counter, kickback_match);
        #20;
        $display("time = %d   , flick = %b, counter = %d, kickback_match = %d", $time, flick, counter, kickback_match);
        #20;
        $display("time = %d   , flick = %b, counter = %d, kickback_match = %d", $time, flick, counter, kickback_match);
        #20;
        flick = 1'b1;
         #20;
        $display("time = %d   , flick = %b, counter = %d, kickback_match = %d", $time, flick, counter, kickback_match);
         #20;
        $display("time = %d   , flick = %b, counter = %d, kickback_match = %d", $time, flick, counter, kickback_match);
        #200;
        end
    endmodule


