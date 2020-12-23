module PCMux (PC, PCplus4, Mem_BranchAddress, PC_Src, clk);

// input 
	input [31:0] PCplus4, Mem_BranchAddress;
	input PC_Src, clk;
	
// output 
	output reg [31:0] PC;
	
	always @(posedge clk)
		begin
			if(PC_Src == 1) 
				PC = Mem_BranchAddress;
			if(PC_Src == 0)
				PC = PCplus4;;
		end
		
endmodule
