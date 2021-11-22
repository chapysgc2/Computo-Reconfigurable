
module counter(input logic clk,

	input logic reset,

	output logic [3:0] q);

	logic [3:0] nextq;

	flopr qflop(clk, reset, nextq, q);

	adder inc(q, 4'b0001, nextq);

endmodule