module clock_divider #(parameter DIV_FACTOR = 100000)(
    input clk_in,
    input reset,
    output reg clk_out
);
    reg [31:0] count;

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            count <= 0;
            clk_out <= 0;
        end else begin
            if (count == (DIV_FACTOR/2 - 1)) begin
                clk_out <= ~clk_out;
                count <= 0;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule