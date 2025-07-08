module input_rom (
    input clk,
    input [7:0] addr,    
    output [7:0] data_out
);

    wire [7:0] dout;

    blk_mem_gen_0 rom_inst (
        .clka(clk),
        .ena(1'b1),
        .addra(addr),
        .douta(dout),
        .wea(1'b0)
    );

    assign data_out = dout;

endmodule
