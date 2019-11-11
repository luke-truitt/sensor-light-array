module decode24(out, in);

	input [1:0] in;
	output [3:0] out;
	wire no_0, no_1;
	
	not no0(no_0, in[0]);
	not no1(no_1, in[1]);
	
	and and0(out[0], no_0, no_1);
	and and1(out[1], no_1, in[0]);
	and and2(out[2], in[1], no_0);
	and and3(out[3], in[1], in[0]);
	
endmodule
