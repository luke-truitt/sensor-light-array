module mux_4(out, in0, in1, in2, in3, select);

	input [1:0] select;
	input [31:0] in0, in1, in2, in3;
	output [31:0] out;
	wire [31:0] w1, w2;
	mux_2 first_top(w1, in0, in1, select[0]);
	mux_2 first_bottom(w2, in2, in3, select[0]);
	mux_2 second(out, w1, w2, select[1]);
	
endmodule
