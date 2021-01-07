module BranchnotEqualAnd (BranchnotEqualResult, EXE_Zero, BranchnotEqual);

// input 
	input EXE_Zero, BranchnotEqual;
	
// output
	output reg BranchnotEqualResult;
	
	always @(*)
		BranchnotEqualResult <= (~(EXE_Zero)) && BranchnotEqual;
	
endmodule
