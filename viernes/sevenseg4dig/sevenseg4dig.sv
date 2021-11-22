module sevenseg4dig(input logic clk,

	input logic reset,

	output logic [6:0] disp);

	logic [3:0] d;
	counter conta(clk,reset,d);
	
	sevenseg decod(d,disp);
	
endmodule