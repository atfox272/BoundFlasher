module decoder_under;

    // Parameters
    parameter IN_WIDTH = 5;

    // Signals
    reg [IN_WIDTH - 1:0] in;
    wire [2<<IN_WIDTH - 1:0] out;  // Adjust the width of the out wire to match the decoder_under output port

    // Instantiate the DUT
    decoder_under dut (
        .in(in),
        .out(out)
    );

    // Testbench behavior
    initial begin
        // Test case 1
        in = 11;
        #10;
        $display("Input: %d, Output: %b", in, out);
        #10;
        in = 31;
        #10;
        $display("Input: %d, Output: %b", in, out);
                
        #10;
        in = 35;
        $display("Input: 35, Output: %b",  out);

        $finish;
    end

endmodule