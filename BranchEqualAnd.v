module BranchEqualAnd (BranchEqualResult, EXE_MEM_Zero, BranchEqual);

// input 
	input EXE_MEM_Zero, BranchEqual;
	
// output
	output reg BranchEqualResult;
	
	always @(*)
		BranchEqualResult <= EXE_MEM_Zero && BranchEqual;
	
endmodule
