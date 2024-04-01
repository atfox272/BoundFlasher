// Block_name: Decoder
// Description: Assert output pins whose index is smaller than or equal to input's value
// Example:
//      Assume: IN_WIDTH = 2
//              in  = 2'b10
//      Result: out = 4'b0011
module decoder_under
#(
        // Input's width
        parameter IN_WIDTH = 5
)
(
        input   [IN_WIDTH - 1:0]        in,
        output  [2<<IN_WIDTH - 1:0]     out
);

generate
        for(genvar i = 0; i < 32; i = i + 1) begin
                assign out[i] = (i < in);

        end
endgenerate

endmodule


