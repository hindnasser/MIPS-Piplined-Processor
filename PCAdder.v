module PCAdder (PCplus4, PC_value, four);

// input 
	input [31:0] PC_value;
	input [2:0] four;
	
// output
	output [31:0] PCplus4;
	
	assign PCplus4 = PC_value + 4;
	
	
endmodule


