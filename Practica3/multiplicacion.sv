module multiplicacion(

	input logic [3:0] a,
	input logic [3:0] b,
	output logic [7:0] P);
	
	logic a0,b0,a1,b1,a2,b2,a3,b3,a4,b4,a5,b5,a6,b6,a7,b7,a8,b8,a9,b9,a10,b10,a11,b11;
	logic ca0,ca1,ca2,ca3,ca4,ca5,ca6,ca7,ca8,ca9,ca10;
	
	assign P[0]=a[0]&b[0];
	
	assign a0=a[1]&b[0];
	assign b0=a[0]&b[1];
	fulladder p0(a0,b0,0,P[1],ca0);
	
	assign a1=a[2]&b[0];
	assign b1=a[1]&b[1];
	fulladder p1(a1,b1,ca0,a2,ca1);
	assign b2=a[0]&b[2];
	fulladder p2(a2,b2,0,P[2],ca2);
	
	
	assign a3=a[3]&b[0];
	assign b3=a[2]&b[1];
	fulladder p3(a3,b3,ca1,a4,ca3);
	assign b4=a[1]&b[2];
	fulladder p4(a4,b4,ca2,a5,ca4);
	assign b5=a[0]&b[3];
	fulladder p5(a5,b5,0,P[3],ca5);
	
	
	assign a6= 0;
	assign b6=a[3]&b[1];
	fulladder p6(a6,b6,ca3,a7,a9);
	assign b7=a[2]&b[2];
	fulladder p7(a7,b7,ca4,a8,ca7);
	assign b8=a[1]&b[3];
	fulladder p8(a8,b8,ca5,P[4],ca8);
	
	
	
	assign b9=a[3]&b[2];
	fulladder p9(a9,b9,ca7,a10,a11);
	assign b10=a[2]&b[3];
	fulladder p10(a10,b10,ca8,P[5],ca10);
	

	
	assign b11=a[3]&b[3];
	fulladder p11(a11,b11,ca10,P[6],P[7]);
	
	endmodule