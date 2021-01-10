module ORa (result, op1, op2);

// input
	input op1, op2;
	
// output
	output reg result;
	
	initial
		result <= 0;
	
	always @(*)
		result <= op1 || op2;
		
endmodule
