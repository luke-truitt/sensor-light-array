module decode38(out, in);

	input [2:0] in;
	output [7:0] out;
	wire no_0, no_1, no_2;
	
	not no0(no_0, in[0]);
	not no1(no_1, in[1]);
	not no2(no_2, in[2]);
	
	and and0(out[0], no_0, no_1, no_2);
	and and1(out[1], no_2, no_1, in[0]);
	and and2(out[2], no_2, in[1], no_0);
	and and3(out[3], no_2, in[1], in[0]);
	and and4(out[4], in[2], no_0, no_1);
	and and5(out[5], in[2], no_1, in[0]);
	and and6(out[6], in[2], in[1], no_0);
	and and7(out[7], in[2], in[1], in[0]);
	
endmodule
