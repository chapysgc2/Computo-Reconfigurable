module proc (input logic [15:0] DIN,

	input logic Resetn,
	input logic lock,

	input logic Run,

	output logic Done,

	output logic [15:0] BusWires);

//Variables

//Entradas y salidas (A,G,R.Multiplexor, Ir y addsub) 

	logic DINout, AddSub, Ain, Gin, Gout, Clear;

	logic [1:0] Tstep_Q;
	logic [1:3] I;
	logic [1:9] IR;
	logic [9:0] Multi;
	logic [7:0] Rin, Rout;
	logic [7:0] Xreg, Yreg; 
	logic [15:0] result;
	logic [15:0] G,A;
	logic [15:0] R0, R1,R2, R3, R4, RS, R6, R7;





	assign Clear = Done || ~ Resetn;
	upcount Tstep (Clear, Clock, Tstep_Q);

	assign I = IR [1:3];

	dec3to8 decx (IR[4:6], 1'b1, Xreg);
	dec3to8 decy (IR[7:9], 1'b1, Yreg);

	always @(Tstep_Q or I or Xreg or Yreg)

	begin 
	//valores Iniciales

	Ain = 1'b0;
	Gin = 1'b0;
	Gout = 1'b0; 
	IRin = 1'b0;
	DINout = 1'b0; 
	AddSub = 1'b0;
	Done = 1'b0;
	Rin [7:0] = 8'b00000000;
	Rout [7:0] = 8'b00000000;

	case (Tstep_Q) 
		2'b00: // Step 0

		begin

			IRin = 1'b1;

	end

	2'b01: //Step 1

		case (I)

			3'b000:

				begin
				
					Rout= Yreg;
					Rin = Xreg;
					Done = 1'b0;
				end
				
			3'b001:

				begin

					DINout = 1'b1;

					Rin = Xreg;

					Done = 1'b1;

				end

			3'b010:

				begin

					Rout= Xreg;
	
					Ain = 1'b1;

				end

			3'b011:

				begin

					Rout = Xreg;

					Ain = 1'b1;
				end
			default:
				Done = 1'b1;

		endcase
		
	2'b10: //step 2

		case(I)
			3'b010:

				begin

					Rout= Yreg;

					Gin = 1'b1;
					AddSub = 1'b1;

				end

			3'b011:
			
				begin

					Rout = Yreg;
					Gin = 1'b1;

					AddSub = 1'b1;

				end
				
			default: Done = 1'b1;

	endcase

	2'b11: //Step 3

		case (I)

			3'b010:

				begin

					Gout = 1'b1;

					Rin = Xreg;

					Done = 1'b1;

				end

			3'b011:

				begin

					Gout = 1'b1;
					Rin = Xreg;
					Done = 1'b1;
				end

			default: Done = 1'b1;

		endcase

		default: Done = 1'b1;

	endcase

end

//Registros

regn reg_0 (Buswires, Rin[0], Clock, R0);

regn reg_1 (Buswires, Rin[1], Clock, R1);

regn reg_2 (Buswires, Rin[2], clock, R2);

regn reg_3 (Buswires, Rin[3], Clock, R3);

regn reg_4 (Buswires, Rin[4], Clock, R4);

regn reg_5 (Buswires, Rin[5], Clock, R5);
regn reg_6 (Buswires, Rin[6], Clock, R6);

regn reg_7 (Buswires, Rin[7], Clock, R7);

regn #(9) reg_IR (DIN [15:7], IRin, Clock, IR);

regn reg_A (BusWires, Ain, Clock, A);
regn reg_G (result, Gin, Clock, G);

//AddSub

addsub sum (~AddSub, A, BusWires, result);

//bus

always @ (Multi or Rout or Gout or DINout) 
	begin

	Multi [0] = DINout;
	Multi [1] = Gout;
	Multi [9:2] = Rout;

	
	case (Multi)

		10'b0000000001: BusWires = DIN;
		10'b0000000010: BusWires = G;
		10'b0000000100: BusWires = R0;
		10'b0000001000: BusWires = R1;
		10'b0000010000: BusWires = R2;
		10'b0000100000: BusWires = R3;
		10'b0001000000: BusWires = R4; 
		10'b0010000000: BusWires = R5;
		10'b0100000000: BusWires = R6;
		10'b1000000000: BusWires = R7;
		default: BusWires = DIN;

	endcase

end

endmodule