module mx_bypass(mx_a, mx_b, dx, xm);

	input[31:0] dx, xm;
	output mx_a, mx_b;
	wire[4:0] ra, rb, wx;
	wire will_write;
	wire[4:0] rta, rstatus; //r31, r30
	 assign rta[4:0] = 5'b11111;
	 assign rstatus[4:0] = 5'b11110;
	reg_write_ctrl regwritectrl(will_write, xm[31:27], xm[26:22]);
	reg_read_ctrl rrc(ra, rb, dx);
	wire jal; // JAL Command
	 assign jal = xm[31:27] == 5'b00011;
	 
	 wire setx; // SETX Command
	 assign setx = xm[31:27] == 5'b10101;
	 
	 wire lw; // LW Command
	 assign lw = xm[31:27] == 5'b01000;
	assign wx[4:0] = jal ? rta : setx ? rstatus : xm[26:22];
	
	assign mx_a = (ra == wx) && will_write && ~lw;
	// Only if the ins. coming in is using it (ALU)
	assign mx_b = (rb == wx) && will_write && ~lw;

endmodule
