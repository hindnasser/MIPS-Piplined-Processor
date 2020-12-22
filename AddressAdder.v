module AddressAdder (EXE_BranchAddress, PCplus4, BranchAdd);

// input
	input [31:0] PCplus4, BranchAdd;

// output
	output [31:0] EXE_BranchAddress;
	
	assign EXE_BranchAddress = PCplus4 + BranchAdd;


endmodule
