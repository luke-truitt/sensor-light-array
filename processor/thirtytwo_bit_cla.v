module thirtytwo_bit_cla(s, c_out, x, y, c_in);

	input [31:0] x, y;
	input c_in;
	output [31:0] s;
	output c_out;
	
	wire c8, c16, c24, c32;
	wire p0, g0, p1, g1, p2, g2, p3, g3;
	wire c_out0, c_out1, c_out2;
	wire pc0, pc1, pc2, pc3;
	wire pg10, pg210, pg3210;
	wire pg21, pg321;
	wire pg32;
	
	eight_bit_cla adder0(s[7:0], c_out0, p0, g0, x[7:0], y[7:0], c_in);
	eight_bit_cla adder1(s[15:8], c_out1, p1, g1, x[15:8], y[15:8], c8);
	eight_bit_cla adder2(s[23:16], c_out2, p2, g2, x[23:16], y[23:16], c16);
	eight_bit_cla adder3(s[31:24], c_out, p3, g3, x[31:24], y[31:24], c24);
	
	and pc_0(pc0, p0, c_in);
	and pc_1(pc1, p1, pc0);
	and pc_2(pc2, p2, pc1);
	and pc_3(pc3, p3, pc2);
	
	and pg_10(pg10, p1, g0);
	and pg_210(pg210, p2, pg10);
	and pg_3210(pg3210, p3, pg210);
	
	and pg_21(pg21, p2, g1);
	and pg_321(pg321, pg21, p3);
	
	and pg_32(pg32, p3, g2);
	
	or c_8(c8, g0, pc0);
	or c_16(c16, g1, pg10, pc1);
	or c_24(c24, g2, pg21, pg210, pc2);
	or c_32(c32, g3, pg32, pg321, pg3210, pc3);
	
	
endmodule
