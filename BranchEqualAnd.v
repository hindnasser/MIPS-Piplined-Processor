module BranchEqualAnd (BranchEqualResult, EXE_MEM_Zero, BranchEqual);

// input 
	input EXE_MEM_Zero, BranchEqual;
	
// output
	output BranchEqualResult;
	
	assign BranchEqualResult = EXE_MEM_Zero & BranchEqual;
	
endmodule
