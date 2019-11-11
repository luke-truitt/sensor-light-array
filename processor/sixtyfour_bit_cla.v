module sixtyfour_bit_cla(s, c_out, x, y, c_in);

	input [63:0] x, y;
	input c_in;
	output [63:0] s;
	output c_out;
	
	wire c32, c64;
	wire c_out0;
	
	thirtytwo_bit_cla adder0(s[31:0], c_out0, x[31:0], y[31:0], c_in);
	thirtytwo_bit_cla adder1(s[63:32], c_out, x[63:32], y[63:32], c_out0);

endmodule
