module BranchnotEqualAnd (BranchnotEqualResult, EXE_MEM_Zero, BranchnotEqual);

// input 
	input EXE_MEM_Zero, BranchnotEqual;
	
// output
	output BranchnotEqualResult;
	
	assign BranchnotEqualResult = ~(EXE_MEM_Zero) & BranchnotEqual;
	
endmodule
