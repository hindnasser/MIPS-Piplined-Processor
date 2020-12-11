module ID_EXE_Register (func, PCplus4Out, ReadReg1Out, ReadReg2Out, SignExtendedValueOut, RegDstOut, RegWriteOut, MemtoRegOut, 
                        JmpandLinkOut, MemReadOut, MemWriteOut, BranchEqualOut, BranchnotEqualOut, flush, funcIn, PCplus4In, 
								ReadReg1In, ReadReg2In, SignExtendedValueIn, RegDstIn, RegWriteIn, MemtoRegIn, JmpandLinkIn, MemReadIn, 
								MemWriteIn, BranchEqualIn, BranchnotEqualIn, clk);
//input
	input flush, RegDstIn, RegWriteIn, MemtoRegIn, JmpandLinkIn, MemReadIn, MemWriteIn, BranchEqualIn, BranchnotEqualIn, clk;
	input [31:0] ReadReg1In, ReadReg2In, SignExtendedValueIn, PCplus4In, funcIn;
	
//output
	output reg func, RegDstOut, RegWriteOut, MemtoRegOut, JmpandLinkOut, MemReadOut, MemWriteOut, BranchEqualOut, BranchnotEqualOut;
	output reg [31:0] PCplus4Out, ReadReg1Out, ReadReg2Out, SignExtendedValueOut;
	
	
	always @(posedge clk) 
		begin
			if(flush == 1)
				begin
					
				end
		end
		
endmodule
