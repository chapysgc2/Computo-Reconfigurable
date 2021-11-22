module AddSub(input logic [15:0] Aout, BusWires,
		input logic AddSub,
		output logic [15:0] AddSubo);
		always_comb begin
			if (AddSub)
				AddSubo = Aout - BusWires;
			else
				AddSubo = Aout + BusWires;
		end	
endmodule 