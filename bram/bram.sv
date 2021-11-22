module bram #(parameter N = 6, M = 32) (
    input logic clk,
    input logic we,
    input logic [N-1:0] adr,
    inout tri [M-1:0] data);

    logic [M-1:0] mem[2**N-1:0];
	 
    always @(posedge clk)
        if (we) mem[adr] <= data;
    assign data = we ? 'z : mem[adr];
	 
endmodule