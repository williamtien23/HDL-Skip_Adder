
module Carry_Skip_Adder (

	input wire [7:0] A,
	input	wire [7:0] B,
	input wire Cin,
	output wire [7:0] Y,
	output wire Cout
	
);
	
	wire [1:0] carry_chain;
	wire [1:0] skip_carry;
	
	Full_Adder_Group 	G1_Adder (A[3:0], B[3:0], Cin, Y[3:0], carry_chain[0]);
	Skip_Logic 			G1_Skip_Logic (A[3:0], B[3:0], Cin, carry_chain[0], skip_carry[0]);
	
	Full_Adder_Group 	G2_Adder (A[7:4], B[7:4], skip_carry[0], Y[7:4], carry_chain[1]);
	Skip_Logic 			G2_Skip_Logic (A[7:4], B[7:4], skip_carry[0], carry_chain[1], Cout);
	
	
endmodule 

module Skip_Logic (
	
	input wire [3:0] A,
	input wire [3:0] B,
	input wire C0, C1,
	output wire Cout
	
);
	
	reg sel;
	
	Mux_2x1 Mux ({C0,C1}, sel, Cout);
		
	always @ (*) begin
		sel = (A[0] ^ B[0]) && (A[1] ^ B[1]) && (A[2] ^ B[2]) && (A[3] ^ B[3]); 
	end
	
endmodule


module Mux_2x1 (

	input wire [1:0] In,
	input wire Sel,
	output reg Out
	
);

	always @ (*) begin
		Out = Sel ? In[1] : In[0];
	end

endmodule

module Full_Adder_Group (

	input wire [3:0] A,
	input wire [3:0] B,
	input wire Cin,
	output reg [3:0] Y,
	output reg Cout
	
);

	wire [3:0] carry_chain;
	
	assign carry_chain[0] = Cin;
	assign carry_chain[3:1] = (A[2:0] & B[2:0]) | (A[2:0] & carry_chain[2:0]) | (B[2:0] & carry_chain[2:0]);
	
	always @ (*) begin
		Y = A ^ B ^ carry_chain;
		Cout = (A[3] & B[3]) | (A[3] & carry_chain[3]) | (B[3] & carry_chain[3]);
	end

endmodule
