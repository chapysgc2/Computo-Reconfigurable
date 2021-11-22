module mux4_8(input logic [7:0] d0, d1, d2, d3,

		input logic [1:0] s,

		output logic [7:0] y);

	logic [7:0] low, hi;

	mux2 lowmux(d0, d1, s[0], low);

	mux2 himux(d2, d3, s[0], hi);

	mux2 outmux(low, hi, s[1], y);

endmodule