`timescale 1ns / 1ps
module alu (
    input [3:0] a,          // First 4-bit input
    input [3:0] b,          // Second 4-bit input
    input [2:0] s,     // 3-bit operation code
    output reg [7:0] result, // 4-bit result
    output reg carry // Carry flag
);// Internal signal for carry
    reg [7:0] temp_result; // 5-bit to capture carry
    always @(*) begin
        // Default values
        result = 4'b0;
        carry = 1'b0;
        case (s)
            3'b000: begin
                temp_result = a + b;
                result = temp_result[3:0];
                carry = temp_result[4];
            end
            3'b001: begin
                temp_result = a - b;
                result = temp_result[3:0];
                carry = temp_result[4];
            end
            3'b010: begin
                temp_result = a*b;
                result=temp_result[7:0];
                end
            3'b011: result = a & b;
            3'b100:  result = a | b;
            3'b101: result = a ^ b;
            default: result = 4'b0; // Default case
        endcase
    end
endmodule


//testbench for simulation
`timescale 1ns / 1ps

module alu_tb;

    // Inputs
    reg [3:0] a, b;
    reg [2:0] s;

    // Outputs
    wire [7:0] result;
    wire carry;

    // Instantiate the ALU
    alu uut (
        .a(a),
        .b(b),
        .s(s),
        .result(result),
        .carry(carry)
    );

    initial begin
        $display("Time\tA\tB\tS\tResult\tCarry");
        $monitor("%0t\t%0d\t%0d\t%b\t%0d\t%b", $time, a, b, s, result, carry);

        // Test 1: Addition (3'b000)
        a = 4'd7; b = 4'd9; s = 3'b000;
        #10;

        // Test 2: Subtraction (3'b001)
        a = 4'd10; b = 4'd4; s = 3'b001;
        #10;

        // Test 3: Multiplication (3'b010)
        a = 4'd3; b = 4'd5; s = 3'b010;
        #10;

        // Test 4: AND (3'b011)
        a = 4'b1100; b = 4'b1010; s = 3'b011;
        #10;

        // Test 5: OR (3'b100)
        a = 4'b1100; b = 4'b1010; s = 3'b100;
        #10;

        // Test 6: XOR (3'b101)
        a = 4'b1100; b = 4'b1010; s = 3'b101;
        #10;

        // Test 7: Default case (invalid operation code)
        a = 4'd1; b = 4'd2; s = 3'b111;
        #10;

        $finish;
    end

endmodule
