module p3(input logic [15:0] DIN,
	input logic Resetn, 
	input logic Clock, 
	input logic Run,
	output logic Done,
	output logic [1:0] Tstep_Q,
	output logic [8:0] 	IR,
	output logic[15:0] BusWires,R0,R1,Aout,G16);
	
	logic Clear,IRin,Ain,Gin,DINout,AddSub,Gout,AddSin;
	logic[2:0] I;
	logic[1:0] upCont;
	logic[7:0] Yreg,Xreg,R6out;
	logic[7:0] RXin;
	logic[15:0] R2,R3,R4,R5,R6,R7,AddSubo;
	
	//assign Clear = ...
	assign Clear = Done ? Resetn : !Resetn;
	upcount Tstep (Clear, Clock, Tstep_Q);
	assign I = IR[8:6];
	dec3to8 decX (IR[5:3], 1'b1, Xreg);
	dec3to8 decY (IR[2:0], 1'b1, Yreg);
	
	
	always @(Tstep_Q or I or Xreg or Yreg)
	begin
	//... specify initial values
		Done=1'b0;
		Ain=1'b0;
		Gin=1'b0;
		AddSub=1'b0;
		DINout=1'b0;
		R6out=8'b00000000;
		RXin=8'b00000000;
		Gout=1'b0;
		IRin = 1'b0;
		case (Tstep_Q)
			2'b00: // store DIN in IR in time step 0
			begin
				if(Run == 1)
						IRin = 1'b1;
					DINout = 1'b1;	
			end
			2'b01: //define signals in time step 1
				case (I)
					3'b000:	begin
									R6out=Yreg;
									RXin=Xreg;
									Done=1'b1;
								end
					3'b001:	begin
									DINout=1'b1;
									RXin=Xreg;
									Done=1'b1;
								end
					3'b010:	begin
									R6out=Xreg;
									Ain=1'b1;
								end
					3'b011:	begin
									R6out=Xreg;
									Gin=1'b1;
									AddSub=1'b1;
								end			
				endcase
			2'b11: //define signals in time step 3
				case (I)
					3'b010:	begin
									Gout=1'b1;
									RXin=Xreg;
									Done=1'b1;
								end 
					3'b011:	begin
									Gout=1'b1;
									RXin=Xreg;
									Done=1'b1;
								end
				endcase
		endcase
	end
	//... instantiate other registers and the adder/subtracter unit
	regn #(9) reg_IR (DIN[15:7],IRin,Clock,IR[8:0]);
	
	regn reg_0 (BusWires, RXin[0], Clock, R0);
	regn reg_1 (BusWires, RXin[1], Clock, R1);
	regn reg_2 (BusWires, RXin[2], Clock, R2);
	regn reg_3 (BusWires, RXin[3], Clock, R3);
	regn reg_4 (BusWires, RXin[4], Clock, R4);
	regn reg_5 (BusWires, RXin[5], Clock, R5);
	regn reg_6 (BusWires, RXin[6], Clock, R6);
	regn reg_7 (BusWires, RXin[7], Clock, R7);
	
	regn reg_A (BusWires, Ain, Clock, Aout);
	
	AddSub SR(Aout,BusWires,AddSub,AddSubo);
	
	regn reg_G (AddSubo, Gin, Clock, G16);
	
	multip(DIN,DINout,Gout,R6out,G16,R0,R1,R2,R3,R4,R5,R6,R7,BusWires);
	
endmodule