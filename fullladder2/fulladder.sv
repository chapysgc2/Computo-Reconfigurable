module fulladder(input logic a,b,ci, output logic y,co);

			logic[1:0]aux;
			
		assign aux= a + b + ci;
		assign y = aux[0];
		assign co = aux[1];
endmodule