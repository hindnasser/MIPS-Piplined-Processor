module AddressOr (PC_Src, BranchEqualResult, BranchnotEqualResult);

// input 
	input BranchEqualResult, BranchnotEqualResult;
	
// output
	output PC_Src;
	
	assign PC_Src = BranchEqualResult || BranchnotEqualResult;
	
endmodule
