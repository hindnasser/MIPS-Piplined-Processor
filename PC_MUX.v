module PC_MUX (PCSrc, PC_value, Mem_BranchAddress, PC_Src);

// input 
	input [31:0] PC_value, Mem_BranchAddress;
	input PC_Src;
	//clk;
	
// output 
	output reg [31:0] PCSrc;
	
	always @(*)
		begin
			if(PC_Src == 1) 
				PCSrc = Mem_BranchAddress;
			if(PC_Src == 0)
				PCSrc = PC_value;
		end
		
endmodule
