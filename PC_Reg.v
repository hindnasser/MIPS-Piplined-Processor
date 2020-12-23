module PC_Reg (PCOut, PCIn);

// input
	input [31:0] PCIn;
	
// output
	output [31:0] PCOut;
	
	assign PCOut = PCIn;
	
endmodule
