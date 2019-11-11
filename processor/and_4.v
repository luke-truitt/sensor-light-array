module and_4(out, in1, in2);

	input [3:0] in1, in2;
	output [3:0] out;
	
	and_2 and1(out[1:0], in1[1:0], in2[1:0]);
	and_2 and2(out[3:2], in1[3:2], in2[3:2]);
	
endmodule
