module counter_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns
    parameter COUNTER_INIT = 5'b00000; // Initial value for the counter

    // Signals
    reg clk;
    reg rst_n;
    reg [4:0] counter_n;
    wire [4:0] counter;

    // Instantiate the DUT
    counter dut (
        .clk(clk),
        .rst_n(rst_n),
        .counter_n(counter_n),
        .counter(counter)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) clk = ~clk;

    // Initial values
    initial begin
        #10;
        clk = 0;
        rst_n = 1;
        counter_n = COUNTER_INIT; // Example initial value for counter_n
        $display("Initializate clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);

        // Test case 1
        #5;

        rst_n = 0;

        $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
        #5;

        $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
        #5;
        $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
        #5;
        rst_n = 1;
        $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
        #5;

        $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
              #5;
        $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
              #5;

        $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
        #5;
                $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
              #5;
              rst_n = 0;
                      $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
              #5;

        $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
        #5;
        rst_n = 1;
                $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
              #5;
        rst_n = 0;
        $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
                #5;
                $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
              #5;

        $display("clk = %b, rst_n = %b, counter_n = %b, counter = %b", clk, rst_n, counter_n, counter);
        // End simulation
        #1000; // Simulation time
        $finish;
    end

endmodule

