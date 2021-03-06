module multip(input logic [15:0] DIN, 
	input logic DINout,
	input logic Gout,
	input logic [7:0] R,
	input logic [15:0] G,
	input logic [15:0] R0,R1,R2,R3,R4,R5,R6,R7,
	output logic [15:0] Bus);
					
	always @(R or Bus) begin 
		case(R)
			8'b10000000: Bus = R7;
			8'b01000000: Bus = R6;
			8'b00100000: Bus = R5;
			8'b00010000: Bus = R4;
			8'b00001000: Bus = R3;
			8'b00000100: Bus = R2;
			8'b00000010: Bus = R1;
			8'b00000001: Bus = R0;
		endcase
		if(Gout == 1)
			Bus= G;
			
		if(DINout == 1)
			Bus=DIN;
	end

endmodule