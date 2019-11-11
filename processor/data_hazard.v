module data_hazard(stall, fd, dx, xm, mw);

	input[31:0] fd, dx, xm, mw;
	output stall;
	
	wire[4:0] r1,r2,wm,wd,wx,dx_op,fd_op;
	wire dxload, fdstore, write_en_dx;
	
	
	wire[4:0] rzero; //r0
	assign rzero[4:0] = 5'b00000;
	
	assign wd[4:0] = dx[26:22];
	assign wx[4:0] = xm[26:22];
	assign wm[4:0] = mw[26:22];
	assign r1[4:0] = fd[21:17];
	assign r2[4:0] = fd[16:12];
	
	assign dx_op[4:0] = dx[31:27];
	assign fd_op[4:0] = fd[31:27];
	
	assign dxload = dx_op[4:0] == 5'b01000;
	assign fdstore = fd_op[4:0] == 5'b00111;
	reg_write_ctrl rwc(write_en_dx, dx[31:27], wd);
	// assign stall = (dxload && ((r1==wd)||((r2==wd)&&(fdstore)))) || (wm==r1 && r1!=rzero) || (wm==r2 && r2 != rzero) || (wd==r1 && r1!=rzero) || (wd==r2 && r2 != rzero) || (wx==r1 && r1 != rzero) || (wx==r2 && r2 != rzero);
	assign stall = (dxload && ((r1==wd)||((r2==wd)&&(~fdstore)))) && write_en_dx;
	
endmodule
