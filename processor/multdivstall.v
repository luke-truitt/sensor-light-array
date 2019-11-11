module multdivstall(stall, mult, div, ready);

	input mult, div, ready;
	output stall;
	wire md;
	assign md = mult || div;
	
	flip_floppity_flop my_ff(stall, 1'b1, md, ready);

endmodule
