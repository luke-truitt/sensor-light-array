module adder_wrapper(s, c_out, x, y, addsub);

	input[31:0] x, y;
	input addsub;
	output c_out;
	output[31:0] s;
	wire[31:0] ynot, as_mux_out;
	
	not_32 y_not(ynot, y);
	
	mux_2 addsub_mux(as_mux_out, y, ynot, addsub);
	
	thirtytwo_bit_cla adder(s, c_out, x, as_mux_out, addsub);

endmodule
