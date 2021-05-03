`timescale 1ns/1ns

module Carry_Skip_Adder_tb();

	reg [7:0] a;
	reg [7:0] b;
	reg cin;
	reg clk;
	
	wire [7:0] y;
	wire cout;
	
	Carry_Skip_Adder DUT (a, b, cin, y, cout);
	
	initial begin //Reset state
		clk <= 0;
		a <= 8'd0;
		b <= 8'd0;
		cin <= 1;
	end
	
	always begin
		clk <= ~clk;
		#5
		a <= 8'd15;
		b <= 8'd64;
	end
	
endmodule
