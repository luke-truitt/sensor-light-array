module eight_bit_cla(s, c_out, p_out, g_out, x_in, y_in, c_in);
	input c_in;
	input [7:0] x_in, y_in;
	output [7:0] s;
	output c_out, g_out, p_out;
	wire c1, c2, c3, c4, c5, c6, c7, p0, p1, p2, p3, p4, p5, p6, p7, g0, g1, g2, g3, g4, g5, g6, g7;
	wire pg76543210, pg6543210, pg543210, pg43210, pg3210, pg210, pg10;
	wire pg7654321, pg654321, pg54321, pg4321, pg321, pg21;
	wire pg765432, pg65432, pg5432, pg432, pg32;
	wire pg76543, pg6543, pg543, pg43;
	wire pg7654, pg654, pg54;
	wire pg765, pg65;
	wire pg76;
	wire pc0, pc1, pc2, pc3, pc4, pc5, pc6, pc7;
	
	xor sum_0(s[0], c_in, y_in[0], x_in[0]);
	xor sum_1(s[1], c1, y_in[1], x_in[1]);
	xor sum_2(s[2], c2, y_in[2], x_in[2]);
	xor sum_3(s[3], c3, y_in[3], x_in[3]);
	xor sum_4(s[4], c4, y_in[4], x_in[4]);
	xor sum_5(s[5], c5, y_in[5], x_in[5]);
	xor sum_6(s[6], c6, y_in[6], x_in[6]);
	xor sum_7(s[7], c7, y_in[7], x_in[7]);
	
	or p_0(p0, y_in[0], x_in[0]);
	or p_1(p1, y_in[1], x_in[1]);
	or p_2(p2, y_in[2], x_in[2]);
	or p_3(p3, y_in[3], x_in[3]);
	or p_4(p4, y_in[4], x_in[4]);
	or p_5(p5, y_in[5], x_in[5]);
	or p_6(p6, y_in[6], x_in[6]);
	or p_7(p7, y_in[7], x_in[7]);
	
	and g_0(g0, y_in[0], x_in[0]);
	and g_1(g1, y_in[1], x_in[1]);
	and g_2(g2, y_in[2], x_in[2]);
	and g_3(g3, y_in[3], x_in[3]);
	and g_4(g4, y_in[4], x_in[4]);
	and g_5(g5, y_in[5], x_in[5]);
	and g_6(g6, y_in[6], x_in[6]);
	and g_7(g7, y_in[7], x_in[7]);
	
	and pc_0(pc0, p0, c_in);
	and pc_1(pc1, pc0, p1);
	and pc_2(pc2, pc1, p2);
	and pc_3(pc3, pc2, p3);
	and pc_4(pc4, pc3, p4);
	and pc_5(pc5, pc4, p5);
	and pc_6(pc6, pc5, p6);
	and pc_7(pc7, pc6, p7);
	
	and pg_10(pg10, p1, g0);
	and pg_210(pg210, pg10, p2);
	and pg_3210(pg3210, pg210, p3);
	and pg_43210(pg43210, pg3210, p4);
	and pg_543210(pg543210, pg43210, p5);
	and pg_6543210(pg6543210, pg543210, p6);
	and pg_76543210(pg76543210, pg6543210, p7);
	
	and pg_21(pg21, p2, g1);
	and pg_321(pg321, pg21, p3);
	and pg_4321(pg4321, pg321, p4);
	and pg_54321(pg54321, pg4321, p5);
	and pg_654321(pg654321, pg54321, p6);
	and pg_7654321(pg7654321, pg654321, p7);
	
	and pg_32(pg32, p3, g2);
	and pg_432(pg432, p4, pg32);
	and pg_5432(pg5432, p5, pg432);
	and pg_65432(pg65432, p6, pg5432);
	and pg_765432(pg765432, p7, pg65432);
	
	and pg_43(pg43, p4, g3);
	and pg_543(pg543, pg43, p5);
	and pg_6543(pg6543, pg543, p6);
	and pg_76543(pg76543, pg6543, p7);
	
	and pg_54(pg54, p5, g4);
	and pg_654(pg654, pg54, p6);
	and pg_7654(pg7654, pg654, p7);
	
	and pg_65(pg65, p6, g5);
	and pg_765(pg765, p7, pg65);
	
	and pg_76(pg76, p7, g6);
	
	or c_1(c1, g0, pc0);
	or c_2(c2, g1, pg10, pc1);
	or c_3(c3, g2, pg21, pg210, pc2);
	or c_4(c4, g3, pg32, pg321, pg3210, pc3);
	or c_5(c5, g4, pg43, pg432, pg4321, pg43210, pc4);
	or c_6(c6, g5, pg54, pg543, pg5432, pg54321, pg543210, pc5);
	or c_7(c7, g6, pg65, pg654, pg6543, pg65432, pg654321, pg6543210, pc6);
	or cout(c_out, g7, pg76, pg765, pg7654, pg76543, pg765432, pg7654321, pg76543210, pc7);
	and pout(p_out, p7, p6, p5, p4, p3, p2, p1, p0);
	or gout(g_out, g7, pg76, pg765, pg7654, pg76543, pg765432, pg7654321, pg76543210);
	
endmodule
