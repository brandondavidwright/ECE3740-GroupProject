// David Carlson
// ECE3740 - Group Project
// Design #4 -- create a sequence generator/detector with 4 states/outputs based on two inputs (M0 and M1)
// Date April 18

module GroupProject (output [0:3] SIG, output SYNC, SEQ, input M0, M1, G0, clock);
	reg [0:3] w1;
	reg w2;

	assign SIG = w1;
	assign SYNC = w2;
	
	Detector(SEQ, clock, SYNC, SIG);
		
	always @ (posedge clock) begin: Generator
		w1 = 4'b0000;
		w2 <= 1'b0;
		if(G0) begin
			if(M0 == 0 && M1 == 0) begin
				w2 <= 1'b1;
				w1 <= 4'b1001;
			end//if
			if(M0 == 0 && M1 == 1) begin
				w2 <= 1'b1;
				w1 <= 4'b0110;
			end//if
			if(M0 == 1 && M1 == 0) begin
				w2 <= 1'b1;
				w1 <= 4'b1010;
			end//if
			if(M0 == 1 && M1 == 1) begin
				w2 <= 1'b1;
				w1 <= 4'b1111;
			end//if
		end//if
	end//Generator
endmodule


// Detector circuit that asserts SEQ when 0110 is detected at input
module Detector (output SEQ, input clock, SYNC, input [0:3] SIG);
	reg w1;
	assign SEQ = w1;
	always @ (posedge clock) begin: Detector
		if(SYNC == 1'b1 && SIG == 4'b0110) w1 <= 1'b1; else w1 <= 1'b0;
	end//Detector
endmodule