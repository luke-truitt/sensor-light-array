module tflipflop(out, clock, clear);
	
	input clock, clear;
	output out;
	wire qnot;
	
	flip_floppity_flop mydff(out, qnot, clock, clear);
	
	not n(qnot, out);
	
	
endmodule
