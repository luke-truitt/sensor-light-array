module mux_8(out, in0, in1, in2, in3, in4, in5, in6, in7, select);
	
	input [2:0] select;
	input [31:0] in0, in1, in2, in3, in4, in5, in6, in7;
	output [31:0] out;
	wire [31:0] w1, w2;
	mux_4 first_top(w1, in0, in1, in2, in3, select[1:0]);
	mux_4 first_bottom(w2, in4, in5, in6, in7, select[1:0]);
	mux_2 second(out, w1, w2, select[2]);
	
endmodule
