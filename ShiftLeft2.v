module ShiftLeft2 (BranchAdd, ID_EXE_ExtendedImm);

// input 
	input [31:0] ID_EXE_ExtendedImm;
	
// output 
	output [31:0] BranchAdd;
	
	assign BranchAdd = ID_EXE_ExtendedImm >> 2;
	
endmodule
