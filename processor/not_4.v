module not_4(out, in);
	input [3:0] in;
	output [3:0] out;
	
	not_2 not1(out[1:0], in[1:0]);
	not_2 not2(out[3:2], in[3:2]);
	
endmodule
