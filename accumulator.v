module accumulator #(parameter N = 8)(
    input clk, reset,
    input load_input,
    input [N-1:0] input_data,
    input clear_acc,
    output reg [N-1:0] sum_out,
    output reg done
);
    reg [N-1:0] operand_A;
    reg [N-1:0] operand_B;
    reg [N:0] temp_sum_bits;
    reg [3:0] bit_index;
    reg cin_bit;
    reg is_adding;
    reg sum_ready;  

    wire a_bit = operand_A[bit_index];
    wire b_bit = operand_B[bit_index];
    wire sum_out_bit, cout_bit;

    adder u1 (.a_bit(a_bit), .b_bit(b_bit), .cin(cin_bit), .sum(sum_out_bit), .cout(cout_bit));

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            operand_A <= 0;
            operand_B <= 0;
            temp_sum_bits <= 0;
            bit_index <= 0;
            cin_bit <= 0;
            is_adding <= 0;
            sum_ready <= 0;
            sum_out <= 0;
            done <= 0;
        end else begin
            done <= 0;

            if (clear_acc) begin
                operand_A <= 0;
                operand_B <= 0;
                temp_sum_bits <= 0;
                bit_index <= 0;
                cin_bit <= 0;
                is_adding <= 0;
                sum_ready <= 0;
                sum_out <= 0;
            end 
            else if (load_input) begin
                operand_A <= input_data;
                operand_B <= sum_out;
                temp_sum_bits <= 0;
                bit_index <= 0;
                cin_bit <= 0;
                is_adding <= 1;
                sum_ready <= 0;
            end 
            else if (is_adding) begin
                temp_sum_bits[bit_index] <= sum_out_bit;
                cin_bit <= cout_bit;

                if (bit_index == N-1) begin
                    temp_sum_bits[N] <= cout_bit;
                    is_adding <= 0;
                    sum_ready <= 1;  
                end 
                else begin
                    bit_index <= bit_index + 1;
                end
            end 
            else if (sum_ready) begin
                sum_out <= temp_sum_bits[N-1:0];  
                done <= 1;
                sum_ready <= 0;
            end
        end
    end
endmodule
