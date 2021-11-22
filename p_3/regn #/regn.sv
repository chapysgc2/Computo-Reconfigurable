module regn # (parameter n = 16)(
	input logic [n-1:0] R,
	input logic Rin, Clock,
	output logic [n-1:0] Q);
	
	always @(posedge Clock)
		if (Rin)
			Q <= R;
endmodule