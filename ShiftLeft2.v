module ShiftLeft2 (BranchAdd, ID_EXE_ExtendedImm);

// input 
	input [31:0] ID_EXE_ExtendedImm;
	
// output 
	output reg [31:0] BranchAdd;
	
	always@ (*)
		BranchAdd <= ID_EXE_ExtendedImm << 2;
	
endmodule
