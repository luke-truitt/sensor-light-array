module adder_wrapper_64(s, c_out, x, y, addsub);

	input[63:0] x, y;
	input addsub;
	output[63:0] s, c_out;
	wire[63:0] ynot, as_mux_out;
	
	not_64 y_not(ynot, y);
	
	mux_2_64 addsub_mux(as_mux_out, y, ynot, addsub);
	
	sixtyfour_bit_cla adder(s, c_out, x, as_mux_out, addsub);
	
endmodule
