module multiplier(mc, mp, start, reset, clk, prod, overflow, done);
	input [31:0] mc, mp;
	input start, reset, clk;
	
	output [31:0] prod;
	output overflow, done;

	reg [64:0] A, S, P;
	reg [5:0] count;
	wire P1, P0;
	assign P1 = P[1];
	assign P0 = P[0];
	
	wire [63:0] mc_extend, mp_extend;
	assign mc_extend = {mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31],
	                    mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31],
	                    mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31],
	                    mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc[31], mc};
	
	assign mp_extend = {mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31],
	                    mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31],
	                    mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31],
	                    mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp[31], mp};
	
	reg [63:0] real_prod;
	
	reg busy, done;
	
	initial begin
		busy = 0;
		done = 0;
		count = 0;
	end
	
	always @(posedge clk) begin
		if (reset && busy) begin
			busy = 0;
			count <= 0;
		end
		
		if (start) begin
			busy = 1;
			
			A[64:33] <= mc;
			A[32:0] <= 33'b0;
			
			S[64:33] <= -mc;
			S[32:0] <= 33'b0;
			
			P[64:33] <= 32'b0;
			P[32:1] <= mp;
			P[0] = 1'b0;
			
			real_prod <= mc_extend*mp_extend;
			
			count <= 6'b0;
		end else if (busy) begin
			case ({P1, P0})
				2'b0_1 : P <= (P + A) >>> 1;
				2'b1_0 : P <= (P + S) >>> 1;
				default: P <= P >>> 1;
			endcase
			count <= count + 1'b1;
		end
		
		if (done) begin
			done = 0;
		end
		
		if (count == 31) begin
			busy = 0;
			done = 1;
		end
		
	
		
	end
	
	wire n_overflow, o_overflow;
	
	nand (n_overflow, real_prod[31], real_prod[32], real_prod[33], real_prod[34], real_prod[35], real_prod[36], real_prod[37], real_prod[38], real_prod[39],
                     real_prod[40], real_prod[41], real_prod[42], real_prod[43], real_prod[44], real_prod[45], real_prod[46], real_prod[47],
							real_prod[48], real_prod[49], real_prod[50], real_prod[51], real_prod[52], real_prod[53], real_prod[54], real_prod[55],
							real_prod[56], real_prod[57], real_prod[58], real_prod[59], real_prod[60], real_prod[61], real_prod[62], real_prod[63]);
	
	or (o_overflow, real_prod[31], real_prod[32], real_prod[33], real_prod[34], real_prod[35], real_prod[36], real_prod[37], real_prod[38], real_prod[39],
                   real_prod[40], real_prod[41], real_prod[42], real_prod[43], real_prod[44], real_prod[45], real_prod[46], real_prod[47],
						 real_prod[48], real_prod[49], real_prod[50], real_prod[51], real_prod[52], real_prod[53], real_prod[54], real_prod[55],
						 real_prod[56], real_prod[57], real_prod[58], real_prod[59], real_prod[60], real_prod[61], real_prod[62], real_prod[63]);
	
	assign prod = P[32:1];
	and (overflow, n_overflow, o_overflow);
endmodule
//module multiplier(product, overflow, data_ready, multiplicand, multiplier, clock, clear);
//	input[31:0] multiplicand, multiplier;
//	input clock, clear;
//	wire nclock;
//	output[31:0] product;
//	output overflow, data_ready;
//	// Either shifted bits or multiplier depending on enable_multiplier signal.
//	wire[31:0] bottom_32_mux,top_32_mux, multiplicand_reg, multiplier_reg;
//	wire addsub, enable, addsub_fut, enable_fut, addsub_init, enable_init, ovf, md_neqz, mr_neqz, md_eqz, mr_eqz;
//	wire timeLeft, bottom_sel;
//	wire[31:0] shft_top, product_shift, adder_out, top_out, product_wire;
//	wire enableClock, booth_bit_out;
//	wire [5:0] count;
//	not clk(nclock, enableClock);
//	nand timeup(timeLeft, count[5], count[0]);
//	not left(data_ready, timeLeft);
//	and clk_time(enableClock, timeLeft, clock);
//	register multiplicand_register(multiplicand_reg, multiplicand, bottom_sel, clear);
//	register multiplier_register(multiplier_reg, multiplier, bottom_sel, clear);
//	mux_2 bottom_mux(bottom_32_mux, multiplier, product_shift, bottom_sel);
//	
//	mux_2 top_mux(top_32_mux, shft_top, adder_out, enable);
//	sra_1 sr_top(shft_top, top_out);
//	srb_1 sr_bottom(product_shift, product_wire, top_out[0]);
//	assign product = product_shift;
//	// Input is first the Multiplier, then nothing
//	// Output is answer, shift this right every two clock cylces
//	register bottom_32(product_wire, bottom_32_mux, enableClock, clear);
//	// Input is the output of the adder
//	// Output is one of the inputs to the adder
//	register top_32(top_out, top_32_mux, enableClock, clear);
//	// Get's the shifted out bit of bottom_32
//	// Output to booth bit control
//	flip_floppity_flop booth_bit(booth_bit_out, product_wire[0], clock, clear);
//	
//	// Inputs are Meultiplicand, CRTL, and Top_32 out
//	adder_wrapper adder(adder_out, c_out, shft_top, multiplicand_reg, addsub);
//	
//	// Outputs to determine when we release the output and stop shifting.
//	counter counter(count, enableClock, clear);
//	or not_zero(bottom_sel, count[0], count[1], count[2], count[3], count[4], count[5]);
//	mult_ovf check_ovf(ovf,shft_top, multiplicand_reg[31], multiplier_reg[31], product[31]);
//	eqz multiplicandEqz(md_eqz, multiplicand_reg);
//	eqz multiplierEqz(mr_eqz, multiplier_reg);
//	not mdn_eqz(md_neqz, md_eqz);
//	not mrn_eqz(mr_neqz, mr_eqz);
//	and ovf_verify(overflow, ovf, md_neqz, mr_neqz);
//	// Inputs are the last bit of bottom_32 and the booth bit
//	// Output is an add/sub and enable/disable to adder
//	booth_ctrl booth_bits(addsub, enable, product_wire[0], booth_bit_out);
//
//endmodule
