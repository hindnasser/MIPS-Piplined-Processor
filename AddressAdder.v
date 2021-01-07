module AddressAdder (EXE_BranchAddress, PCplus4, BranchAdd);

// input
	input [31:0] PCplus4, BranchAdd;

// output
	output reg [31:0] EXE_BranchAddress;
	
	always@(*)
		EXE_BranchAddress <= PCplus4 + BranchAdd;


endmodule
