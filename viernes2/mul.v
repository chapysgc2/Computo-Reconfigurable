module mul #(parameter n=8) (input logic [n-1:0] a, input logic[n-1:0] b,
					output logic [n*2-1:0] c);

	logic [n-1:0] aux, pder, res;

	logic [n:0] suma;
// multiplicando, j-multiplicador

integer i,j; 

	always_comb begin

	for (i=0;i<n;i-i+1) begin
		for (j=0; j<n; j = j+1) 
			aux[j] = a[j] & b[i]; //multiplicación

	suma = res[n-1:0]+aux; //se hace la suma

//se recorre

	pder={suma [0],pder [n-1:1]};
	res = {1'b0 , suma[n:1]};

	end
	
	c = { res[n-1:0],pder};
	
	end
	
endmodule 