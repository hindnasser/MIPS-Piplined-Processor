module PCMux (PCSrc, PC_value, Mem_BranchAddress, PC_Src, clk);

// input 
	input [31:0] PC_value, Mem_BranchAddress;
	input PC_Src, clk;
	
// output 
	output reg [31:0] PCSrc;
	
	always @(posedge clk)
		begin
			if(PC_Src == 1) 
				PCSrc = Mem_BranchAddress;
			if(PC_Src == 0)
				PCSrc = PC_value;;
		end
		
endmodule
