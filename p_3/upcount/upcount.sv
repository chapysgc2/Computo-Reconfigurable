module upcount(input logic Clear, Clock,
	output logic [1:0] Q);
	//reg [1:0] Q;
	always @(posedge Clock)
		if (Clear)
			Q <= 2'b0;
		else
			Q <= Q + 1'b1;
endmodule