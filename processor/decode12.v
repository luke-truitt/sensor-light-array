module decode12(out, in);

	input in;
	output [1:0] out;
	
	not no(out[0], in);
	assign out[1] = in;
	
endmodule
