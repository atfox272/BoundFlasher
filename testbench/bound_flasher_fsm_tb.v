module bound_flasher_fsm_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg clk;
    reg rst_n;
    reg [2:0] main_state_n;
    wire [2:0] main_state;

    // Instantiate the DUT
    bound_flasher_fsm dut (
        .clk(clk),
        .rst_n(rst_n),
        .main_state_n(main_state_n),
        .main_state(main_state)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) clk = ~clk;

    // Initial values
    initial begin
        #10;
        clk = 0;
        rst_n = 1;
        main_state_n = 3'b001; // Example initial value for main_state_n
        $display("Initializate clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);

        // Test case 1
        #5;

        rst_n = 0;

        $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
        #5;

        $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
        #5;
        $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
        #5;
        rst_n = 1;
        $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
        #5;

        $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
              #5;
        $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
              #5;

        $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
        #5;
                $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
              #5;
              rst_n = 0;
                      $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
              #5;

        $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
        #5;
        rst_n = 1;
                $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
              #5;
        rst_n = 0;
        $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
                #5;
                $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
              #5;

        $display("clk = %b, rst_n = %b, main_state_n = %b, main_state = %b", clk, rst_n, main_state_n, main_state);
        // End simulation
        #1000; // Simulation time
        $finish;
    end

endmodule
