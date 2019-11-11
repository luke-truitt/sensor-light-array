module division_ctrl(write, remainder);
	input[63:0] remainder;
	output write;
	
	not r(write, remainder[63]);
	
endmodule
