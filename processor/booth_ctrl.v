module booth_ctrl(addsub, enable, bit1, bit0);

	input bit1, bit0;
	output addsub, enable;
	
	wire nb1, nb0;
	
	not notb1(nb1, bit1);
	not notb0(nb0, bit0);
	
	// outputs 1 for sub
	
	and as(addsub, nb0, bit1);
	xor e(enable, bit1, bit0);
endmodule
