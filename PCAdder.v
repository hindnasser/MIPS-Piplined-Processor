module PCAdder (PCplus4, PC);

// input 
	input [31:0] PC;
	
// output
	output [31:0] PCplus4;
	
	assign PCplus4 = PC + 4;
	
	
endmodule


