module PCAdder (PCplus4, PC);

// input 
	input [31:0] PC;
	
// output
	output reg  [31:0] PCplus4;
	
	always @(*)
		PCplus4 <= PC + 4;
		
	
endmodule


