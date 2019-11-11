module wm_bypass(wm, xm, mw);

	input[31:0] xm, mw;
	output wm;
	wire[4:0] ra, rb, rw,sw,opcode;
	wire issw;
	reg_read_ctrl rrc(ra, rb, xm);
	
	assign sw[4:0] = 5'b00111;
	assign opcode[4:0] = xm[31:27];
	assign issw = sw[4:0] == opcode[4:0];
	assign rw[4:0] = mw[26:22];
	
	assign wm = (rb == rw) && issw;
	
endmodule
