module next_counter_generator_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    logic [2:0] main_state;
    logic [4:0] counter;
    logic flick;
    logic kickback_match;
    logic [2:0] main_state_n;
    logic [4:0] counter_load;
    logic counter_load_en;
    logic [1:0] count_state;

    // Instantiate the module under test
    next_state_generator dut (
        .main_state(main_state),
        .counter(counter),
        .flick(flick),
        .kickback_match(kickback_match),
        .main_state_n(main_state_n),
        .counter_load(counter_load),
        .counter_load_en(counter_load_en),
        .count_state(count_state)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) begin
        $tick();
    end

    // Stimulus
    initial begin
        // Initialize inputs
        main_state = 3'b000;
        counter = 5'b00000;
        flick = 1'b0;
        kickback_match = 1'b0;

        // Apply stimulus
        #20 flick = 1'b1;
        #50 kickback_match = 1'b1;
        #50 kickback_match = 1'b0;

        // Add more stimulus as needed

        // End simulation
        #100 $finish;
    end

   // Display outputs
    always @(posedge $tick) begin
        $display("main_state_n = %b, counter_load = %b, counter_load_en = %b, count_state = %b",
                 main_state_n, counter_load, counter_load_en, count_state);
    end

endmodule
