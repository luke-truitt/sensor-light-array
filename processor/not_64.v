module not_64(out, in);

	input [63:0] in;
	output [63:0] out;
	
	not_32 not1(out[31:0], in[31:0]);
	not_32 not2(out[63:32], in[63:32]);
	
endmodule
