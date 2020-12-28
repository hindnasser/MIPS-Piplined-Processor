module DstReg_MUX (EXE_DstReg, ID_EXE_Rt, ID_EXE_Rd, ID_EXE_RegDst);

// input 
	input [4:0] ID_EXE_Rd, ID_EXE_Rt;
	input ID_EXE_RegDst;
	
// output
	output reg [4:0] EXE_DstReg;
	
	always @(*)
		begin
			if(ID_EXE_RegDst == 0)
				EXE_DstReg <= ID_EXE_Rt;
			else if (ID_EXE_RegDst == 1)
				EXE_DstReg <= ID_EXE_Rd;
		end
		
endmodule
