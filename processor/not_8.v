module not_8(out, in);

	input [7:0] in;
	output [7:0] out;
	
	not_4 not1(out[3:0], in[3:0]);
	not_4 not2(out[7:4], in[7:4]);
	
endmodule
