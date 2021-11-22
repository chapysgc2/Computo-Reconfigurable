module modulos(input logic clk,
	input logic reset,
	input logic set,
	input logic [3:0] d,
	output logic [3:0] q);

	always_ff @(posedge clk)
		if (reset)
			q <= 0;
		else
			q <= d;

	always @(set)
		if (set)
			q <= 1;
endmodule
