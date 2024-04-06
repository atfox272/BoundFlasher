module next_state_generator_tb;

    // Signals
    reg [2:0] main_state;
    reg [4:0] counter;
    reg flick;
    reg kickback_match;
    wire [2:0] main_state_n;
    wire [4:0] counter_load;
    wire counter_load_en;
    wire [1:0] count_state;

    // Instantiate the DUT
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

    // Testbench behavior
    initial begin
        // Test case 0: Initializate with flick = 0 => Output: FSM don't active
        $display("-----------------------------------------------------------------");
        $display("Test case 0: Initializate with flick = 0 => Output: FSM don't active");
        $display("-----------------------------------------------------------------");
        main_state = 3'b000;
     
        #10;
        $display("Main State: %b -> Next Main State: %b", main_state, main_state_n);
        $display("Counter Load: %b", counter_load);
        $display("Counter Load Enable: %b", counter_load_en);
        $display("Count State: %b", count_state);

        // Test case 1: Flick occurs in INIT_STATE -> Output: Count_state 01 (Count up)
                $display("-----------------------------------------------------------------");
        $display("Test case 1: Flick occurs in INIT_STATE -> Output: Count_state 01 (Count up)");
                $display("-----------------------------------------------------------------");
        main_state = 3'b000;
        flick = 1'b1;
        #10;
        $display("Main State: %b -> Next Main State: %b", main_state, main_state_n);
        $display("Counter Load: %b", counter_load);
        $display("Counter Load Enable: %b", counter_load_en);
        $display("Count State: %b", count_state);

        // Test case 2: Counter reaches 16 in ONLEDO_15_STATE -> Output: Count_state= 01 (Count up)
        $display("-----------------------------------------------------------------");
        $display("Test case 2: Counter reaches 16 in ONLEDO_15_STATE -> Output: Count_state= 01 (Count up)");
        $display("-----------------------------------------------------------------");
        main_state = 3'b001;
        counter = 5'b10000;
        flick = 1'b0;
        #10;
        $display("Main State: %b -> Next Main State: %b", main_state, main_state_n);
        $display("Counter Load: %b", counter_load);
        $display("Counter Load Enable: %b", counter_load_en);
        $display("Count State: %b", count_state);

        // Test case 3: Kickback occurs in OFFLED15_5_STATE
        $display("-----------------------------------------------------------------");
        $display("Test case 3: Kickback occurs in OFFLED15_5_STATE");
         $display("-----------------------------------------------------------------");
        main_state = 3'b010;
        kickback_match = 1'b1;
        #10;
        $display("Main State: %b -> Next Main State: %b", main_state, main_state_n);
        $display("Counter Load: %b", counter_load);
        $display("Counter Load Enable: %b", counter_load_en);
        $display("Count State: %b", count_state);

        // Test case 4: Counter reaches in OFFLED5_0_STATE
        $display("-----------------------------------------------------------------");
        $display("Test case 4: Counter reaches in OFFLED5_0_STATE");
         $display("-----------------------------------------------------------------");
        main_state = 3'b110;
        counter = 5'b00000;
        flick = 1'b0;
        kickback_match = 1'b0;
        #10;
        $display("Main State: %b -> Next Main State: %b", main_state, main_state_n);
        $display("Counter Load: %b", counter_load);
        $display("Counter Load Enable: %b", counter_load_en);
        $display("Count State: %b", count_state);

        // End simulation
        #10;
        $finish;
    end

endmodule
