module DstReg_MUX (EXE_DstReg, ID_EXE_Rt, ID_EXE_Rd, RegDst, clk);

// input 
	input [4:0] ID_EXE_Rd, ID_EXE_Rt;
	input RegDst, clk;
	
// output
	output reg EXE_DstReg;
	
	always @(posedge clk)
		begin
			if(RegDst == 0)
				EXE_DstReg = ID_EXE_Rt;
			else if (RegDst == 1)
				EXE_DstReg = ID_EXE_Rd;
		end
		
endmodule
