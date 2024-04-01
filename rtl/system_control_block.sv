odule system_control_block(
        // Input
        input                   clk,
        input                   flick,
        input                   rst_n,
        // Output 
        output logic    [4:0]   counter
);

logic   [2:0]   main_state;     // reg
logic   [2:0]   main_state_n;   // wire
logic   [4:0]   counter_n;      // wire
logic   [4:0]   counter_load;   // wire
logic           counter_load_en;// wire


logic   [1:0]   count_state;       // Counting state: 0-Disable || 1-Up || 2-Down
logic           kickback_match; // wire

next_state_generator next_state_generator(
	// Input
	.main_state(main_state),
	.counter(counter),
	.kickback_match(kickback_match),
	// Output
	.main_state_n(main_state_n),
	.counter_load(counter_load),
	.counter_load_en(counter_load_en),
	.count_state(count_state)
);
next_counter_generator next_counter_generator(
	// Input
	.counter(counter),
	.counter_load(counter_load),
	.counter_load_en(counter_load_en),
	.count_state(count_state),
	// Output
	.counter_n(counter_n)	
);

kickback_match_generator kickback_match_generator(
	// Input
	.flick(flick),
	.counter(counter),
	// Output 
	.kickback_match(kickback_match)
);

bound_flasher_fsm bound_flasher_fsm (
	// Input
	.clk(clk),
	.main_state_n(main_state_n),
	// Output
	.main_state(main_state)
);

counter counter (
	// Input 
	.clk(clk),
	.counter_n(counter_n),
	// Output
	.counter(counter)
);

endmodule
