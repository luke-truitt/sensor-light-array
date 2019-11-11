module multdiv(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY);
    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    // Your code here
	 
	 wire stop_mult, mult_exception, mult_ready;
	 wire stop_div, div_exception, div_ready;
	 wire [31:0] mult_result;
	 wire [31:0] div_result;
	 
	 assign stop_mult = ctrl_DIV;
	 assign stop_div = ctrl_MULT;
	 
	 multiplier mult (data_operandA, data_operandB, ctrl_MULT, stop_mult, clock, mult_result, mult_exception, mult_ready);
	 divider div (data_operandA, data_operandB, ctrl_DIV, stop_div, clock, div_result, div_exception, div_ready);
	 
	 assign data_resultRDY = mult_ready || div_ready;
	 assign data_result = mult_ready ? mult_result : div_result;
	 assign data_exception = mult_ready ? mult_exception : div_exception;
	 
endmodule

//module multdiv(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY);
//    input[31:0] data_operandA, data_operandB;
//    input ctrl_MULT, ctrl_DIV, clock;
//	 
//    output[31:0] data_result;
//    output data_exception, data_resultRDY;
//	 wire[31:0] product, quotient, remainder, result;
//	 wire clear, overflow, div_enable, mult_enable, dz, bz, ovf, mult_on, mult_rdy, div_rdy, data_rqst, data_ready;
//	 or clr(clear, ctrl_MULT, ctrl_DIV, data_resultRDY);
//	 and mult_clk(mult_on, clock, ctrl_MULT);
//	 or data_rq(data_rqst, ctrl_MULT, ctrl_DIV);
////	 and clk_and(en_clk, clock_enabled, clock);
//	 /// Multiplier
//    // Need 64-bit store for the product
//	 // Need adder for upper 32-bits of product and multiplicand
//	 // Need Shifter for Product
//	 // Need bottom two bits to pass into control to determine add or subtract or do nothing
//	 // Need to keep track of the number of shifts of the product so we only go through the multiplier
//	 // Need to handle OVF
//	 multiplier my_mult(product, overflow, mult_rdy, data_operandA, data_operandB, clock, clear);
//	 
//	 /// Divider
//	 divider my_div(quotient, div_rdy, remainder, data_operandA, data_operandB, clock, clear);
//	 
//	 mux_2 data_out(result, quotient, product, mult_enable);
//	 mux_2 data_rdy(data_ready, div_rdy, mult_rdy, mult_enable);
//	 eqz b_zero(bz, data_operandB);
//	 not div(div_enable, mult_enable);
//	 and div_zero(dz, bz, div_enable);
//	 and mult_ex(ovf, overflow, mult_enable);
//	 or ex(data_exception, dz, ovf);
//	 
//	 wire in_ready;
//	 assign in_ready = ~data_resultRDY && data_ready;
//
//	 register multdiv_reg(data_result, result, clock, 1'b0);
//	 flip_floppity_flop ff(mult_enable, 1'b1, mult_on, ctrl_DIV);
//	 flip_floppity_flop ff1(data_resultRDY, in_ready, clock, 1'b0);
//	 
//endmodule
