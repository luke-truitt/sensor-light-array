module wx_bypass(wx_a, wx_b, dx, mw);

	input[31:0] dx, mw;
	output wx_a, wx_b;
	wire[4:0] ra, rb, rw;
	wire will_write;
	
	wire[4:0] rta, rstatus; //r31, r30
	assign rta[4:0] = 5'b11111;
	assign rstatus[4:0] = 5'b11110;
	 
	reg_write_ctrl regwritectrl(will_write, mw[31:27], mw[26:22]);
	reg_read_ctrl rrc(ra, rb, dx);
	
	wire jal; // JAL Command
	 assign jal = mw[31:27] == 5'b00011;
	 
	 wire setx; // SETX Command
	 assign setx = mw[31:27] == 5'b10101;
	 
	assign rw[4:0] = jal ? rta : setx ? rstatus : mw[26:22];
	
	assign wx_a = (ra == rw) && will_write;
	assign wx_b =  (rb == rw) && will_write;
	
endmodule
