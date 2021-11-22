module ram ( 
    input logic clk,
    input logic we,
    input logic [5:0] adr,
    input logic [31:0] din,
    output logic [31:0] dout);

	pram mem(clk, we, adr, din, dout);
	 
endmodule