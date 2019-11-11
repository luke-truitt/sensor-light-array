module not_2(out, in);
	
	input [1:0] in;
	output [1:0] out;
	
	not not1(out[0], in[0]);
	not not2(out[1], in[1]);
	
endmodule
