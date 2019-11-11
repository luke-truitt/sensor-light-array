module and_2(out, in1, in2);
	
	input [1:0] in1, in2;
	output [1:0] out;
	
	and and1(out[0], in1[0], in2[0]);
	and and2(out[1], in1[1], in2[1]);
	
endmodule	
	