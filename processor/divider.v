module divider (dividend, divisor, start, reset, clk, quotient, exception, done);
	input [31:0] dividend, divisor;
	input start, reset, clk;
	
	output [31:0] quotient;
	output exception, done;
	
	reg [31:0] Q, quotient;
   reg [63:0] dividend_copy, divisor_copy, diff;
   wire [31:0] remainder = dividend_copy[31:0];

   reg [5:0] count;
	
	reg busy, done, exception;
	reg dividend_neg, divisor_neg;
	
	wire divisor_zero = ~(divisor[0 ] || divisor[1 ] || divisor[2 ] || divisor[3 ] ||
	                      divisor[4 ] || divisor[5 ] || divisor[6 ] || divisor[7 ] ||
								 divisor[8 ] || divisor[9 ] || divisor[10] || divisor[11] ||
								 divisor[12] || divisor[13] || divisor[14] || divisor[15] ||
								 divisor[16] || divisor[17] || divisor[18] || divisor[19] ||
								 divisor[20] || divisor[21] || divisor[22] || divisor[23] ||
								 divisor[24] || divisor[25] || divisor[26] || divisor[27] ||
								 divisor[28] || divisor[29] || divisor[30] || divisor[31]);

   initial begin 
		count = 32;
		busy = 0;
		done = 0;
		exception = 0;
		divisor_neg = 0;
		dividend_neg = 0;
	end

	always @(posedge clk) begin
		if (reset && busy) begin
			busy = 0;
			count = 32;
		end
	
		if (done) begin
			count = 32;
			done = 0;
			exception = 0;
		end
	
		if (start) begin
			if (divisor_zero) begin
				busy = 1;
				count = 2;
				exception = 1;
			end else begin
				busy = 1;
				count = 6'd32;
				Q = 64'b0;
				
				if (dividend[31]) begin
					dividend_copy = {32'b0, -dividend};
					dividend_neg = 1;
				end else begin
					dividend_copy = {32'b0, dividend};
					dividend_neg = 0;
				end
				
				if (divisor[31]) begin
					divisor_copy = {1'b0, -divisor, 31'b0};
					divisor_neg = 1;
				end else begin
					divisor_copy = {1'b0, divisor, 31'b0};
					divisor_neg = 0;
				end
			end
     end else if (busy) begin
        diff = dividend_copy - divisor_copy;
        Q = {Q[30:0], ~diff[63] };
		  if (divisor_neg ^ dividend_neg) begin
				quotient = -Q;
			end else begin
				quotient = Q;
			end
        divisor_copy = {1'b0, divisor_copy[63:1] };
        if (!diff[63]) dividend_copy = diff;
        count = count - 1;
     end
	  
	  if (count == 0) begin
			busy = 0;
			divisor_neg = 0;
			dividend_neg = 0;
			done = 1;
		end
	end
	
endmodule
//module divider(quotient, data_ready, remainder, dividend, divisor, clock, clear);
//
//	input[31:0] divisor, dividend;
//	input clock, clear;
//	wire nclock, out, bottom_sel;
//	output[31:0] quotient, remainder;
//	output data_ready;
//	// Either shifted bits or multiplier depending on enable_multiplier signal.
//	wire[63:0] r_addsub, r_in, div_in, padded_dividend, padded_divisor, pos_padded_dividend, neg_padded_dividend, neg_padded_divisor, pos_padded_divisor;
//	wire[63:0] r_64, divisor_out, q_in, shft_div, r_sub;
//	wire[31:0] neg_divisor, neg_dividend, quotient_out, neg_quotient, z;
//	wire timeLeft, divisor_neg, dividend_neg, qnegq;
//	wire enableClock;
//	wire [5:0] count;
//	not clk(nclock, enableClock);
//	nand timeup(timeLeft, count[1], count[5]);
//	not left(data_ready, timeLeft);
//	and clk_time(enableClock, timeLeft, clock);
//	assign z = 32'b00000000000000000000000000000000;
//	
//	adder_wrapper divisorneg(neg_divisor, div_c_out, z, divisor, 1'b1);
//	adder_wrapper dividendneg(neg_dividend, div_c_out_2, z, dividend, 1'b1);
//	
//	assign pos_padded_divisor[63:32] = divisor[31:0];
//	assign pos_padded_divisor[31:0] = 32'b00000000000000000000000000000000;
//	assign pos_padded_dividend[63:32] = 32'b00000000000000000000000000000000;
//	assign pos_padded_dividend[31:0] = dividend[31:0];
//	
//	assign padded_dividend = dividend[31] ? neg_padded_dividend : pos_padded_dividend;
//	assign padded_divisor = divisor[31] ? neg_padded_divisor : pos_padded_divisor;
//	
//	assign neg_padded_divisor[63:32] = neg_divisor[31:0];
//	assign neg_padded_divisor[31:0] = 32'b00000000000000000000000000000000;
//	assign neg_padded_dividend[63:32] = 32'b00000000000000000000000000000000;
//	assign neg_padded_dividend[31:0] = neg_dividend[31:0];
//	division_ctrl div_ctrl(out, r_sub);
//	    
//	mux_2_64 remainder_mux(r_addsub, r_64, r_sub, out);
//	
//	mux_2_64 dividend_mux(r_in, padded_dividend, r_addsub, bottom_sel);
//	
//	mux_2_64 divisor_mux(div_in, padded_divisor, shft_div, bottom_sel);
//
//	sra_1_64 shft_divisor(shft_div, divisor_out);
//	slq sq(q_in, quotient_out, out);
//	reg_64 divisor_reg(divisor_out, div_in, enableClock, clear);
//	// Input is the output of the adder
//	// Output is one of the inputs to the adder
//	reg_64 remainder_reg(r_64, r_in, enableClock, clear);
//	
//	register quotient_reg(quotient_out, q_in, enableClock, clear);
//	flip_floppity_flop neg_divisor_ff(divisor_neg, divisor[31], bottom_sel, clear);
//	flip_floppity_flop neg_dividend_ff(dividend_neg, dividend[31], bottom_sel, clear);
//	adder_wrapper_64 adder(r_sub, c_out, r_64, divisor_out, 1'b1);
//	
//	// Outputs to determine when we release the output and stop shifting.
//	counter counter(count, enableClock, clear);
//	or not_zero(bottom_sel, count[0], count[1], count[2], count[3], count[4], count[5]);
//	
//	adder_wrapper qneg(neg_quotient, q_c_out, z, quotient_out, 1'b1);
//	xor qisneg(qnegq, divisor_neg, dividend_neg);
//	assign quotient = qnegq ? neg_quotient : quotient_out;
//	assign remainder = r_64[31:0];
//endmodule
