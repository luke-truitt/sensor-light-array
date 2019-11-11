module and_64(out, in1, in2);
	
	input [63:0] in1, in2;
	output [63:0] out;
	
	and_32 and1(out[31:0], in1[31:0], in2[31:0]);
	and_32 and2(out[63:32], in1[63:32], in2[63:32]);
	
endmodule
	