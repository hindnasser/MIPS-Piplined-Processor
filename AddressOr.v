module AddressOr (PC_Src, BranchEqualResult, BranchnotEqualResult);

// input 
	input BranchEqualResult, BranchnotEqualResult;
	
// output
	output reg PC_Src;
	
	initial 
		begin
			PC_Src <= 0;
		end
	
	always @(*)
		begin
			PC_Src <= BranchEqualResult || BranchnotEqualResult;
		end
		
endmodule
