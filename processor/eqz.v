module eqz(out, in);
	input [31:0] in;
	output out;
	
	wire n0, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31;
	
	not n_0(n0, in[0]);
	not n_1(n1, in[1]);
	not n_2(n2, in[2]);
	not n_3(n3, in[3]);
	not n_4(n4, in[4]);
	not n_5(n5, in[5]);
	not n_6(n6, in[6]);
	not n_7(n7, in[7]);
	not n_8(n8, in[8]);
	not n_9(n9, in[9]);
	not n_10(n10, in[10]);
	not n_11(n11, in[11]);
	not n_12(n12, in[12]);
	not n_13(n13, in[13]);
	not n_14(n14, in[14]);
	not n_15(n15, in[15]);
	not n_16(n16, in[16]);
	not n_17(n17, in[17]);
	not n_18(n18, in[18]);
	not n_19(n19, in[19]);
	not n_20(n20, in[20]);
	not n_21(n21, in[21]);
	not n_22(n22, in[22]);
	not n_23(n23, in[23]);
	not n_24(n24, in[24]);
	not n_25(n25, in[25]);
	not n_26(n26, in[26]);
	not n_27(n27, in[27]);
	not n_28(n28, in[28]);
	not n_29(n29, in[29]);
	not n_30(n30, in[30]);
	not n_31(n31, in[31]);
	
	and ans(out, n0, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31);
	
endmodule
