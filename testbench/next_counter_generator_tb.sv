module next_counter_generator_tb;

    // Parameters
    parameter COUNTER_INIT = 5'b00000;

    // Signals
    reg [4:0] counter;
    reg [4:0] counter_load;
    reg counter_load_en;
    reg [1:0] count_state;
    wire [4:0] counter_n;

    // Instantiate the DUT
    next_counter_generator dut (
        .counter(counter),
        .counter_load(counter_load),
        .counter_load_en(counter_load_en),
        .count_state(count_state),
        .counter_n(counter_n)
    );


    initial begin
        // State default
        $display(" ----------------------------- State default--------------------");

        counter = 5'b00001;

        #10;
        $display("Input: counter = %b, counter_load = %b, counter_load_en-%b, count_state = %b, Output: counter_n = %b", counter, counter_load, counter_load_en, count_state, counter_n);

        // State COUNT_INIT
        counter_load_en = 0;
        count_state = 0;
        $display(" ----------------------------- State COUNT_INIT  ----------------------------- ");

        #10;
        $display("Input: counter = %b, counter_load = %b, counter_load_en-%b, count_state = %b, Output: counter_n = %b", counter, counter_load, counter_load_en, count_state, counter_n);


        $display(" ----------------------------- State COUNT_UP_EN  -----------------------------");

        counter = COUNTER_INIT;
        count_state = 2'b01;
        #10;
        $display("Initial counter: %b", counter);
        counter_load_en = 1'b0;
        #10;
        $display("Input: counter = %b, counter_load = %b, counter_load_en= %b, count_state = %b, Output: counter_n-%b", counter, counter_load, counter_load_en, count_state, counter_n);
        #10;
        $display("Counter after count up: %b", counter_n);


        $display(" ----------------------------- State COUNT_DOWN_EN  -----------------------------");

        counter = 5'b11111;
        count_state = 2'b10;
        #10;
        $display("Initial counter: %b", counter);

        counter_load_en = 1'b0;
        #10;
        $display("Input: counter = %b, counter_load = %b, counter_load_en = %b, count_state = %b, Output: counter_n = %b", counter, counter_load, counter_load_en, count_state, counter_n);
        #10;
        $display("Counter after count down: %b", counter_n);


        $display(" ----------------------------- Enable counter load  -----------------------------");

        counter_load = 5'b10101;
        count_state = 2'b11;
        #10;
        $display("Initial counter load: %b", counter_load);
        #10;
        $display("Counter after load: %b", counter_n);

        counter = 5'b11111;
        counter_load = 5'b10101;
        counter_load_en = 1'b1;
        count_state = 2'b10;
        #10;
        $display("Input: counter = %b, counter_load = %b, counter_load_en = %b, count_state = %b, Output: counter_n = %b", counter, counter_load, counter_load_en, count_state, counter_n);


        #10;
        $finish;
    end

endmodule

