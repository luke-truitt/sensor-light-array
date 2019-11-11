module sra_32(out, in, shft_amt);

	input [31:0] in;
	input [4:0] shft_amt;
	output [31:0] out;
	
	wire [31:0] shft16, shft8, shft4, shft2, shft1, out_16, out_8, out_4,  out_2, out_1;
	
	sra_16 shft_16(shft16, in);
	sra_8 shft_8(shft8, out_16);
	sra_4 shft_4(shft4, out_8);
	sra_2 shft_2(shft2, out_4);
	sra_1 shft_1(shft1, out_2);
	
	mux_2 sel_16(out_16, in, shft16, shft_amt[4]);
	mux_2 sel_8(out_8, out_16, shft8, shft_amt[3]);
	mux_2 sel_4(out_4, out_8, shft4, shft_amt[2]);
	mux_2 sel_2(out_2, out_4, shft2, shft_amt[1]);
	mux_2 sel_1(out, out_2, shft1, shft_amt[0]);
	
endmodule
