module flopr(input logic clk,
	input logic reset,

	input logic [11:0] d,

	output logic [11:0] q);

	always_ff@(posedge clk)

		if (reset)

			q <= 12'b0;

		else

			q<= d;

endmodule