module PC_MUX (PCSrc, PCplus4, Mem_BranchAddress, PC_Src);

// input 
	input [31:0] PCplus4, Mem_BranchAddress;
	input PC_Src;
	//clk;
	
// output 
	output reg [31:0] PCSrc;
		
		
	always @(*)
		begin
			if(PC_Src == 1) 
				PCSrc = Mem_BranchAddress;
		   else
				PCSrc = PCplus4;
		end
		
endmodule
