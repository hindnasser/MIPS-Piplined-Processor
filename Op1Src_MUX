module Op1Src_MUX (Op1Src, ID_EXE_Rs, ID_EXE_PCplus4, ID_EXE_JmpandLink);

// input 
	input [31:0] ID_EXE_PCplus4, ID_EXE_Rs;
	input ID_EXE_JmpandLink;
//	clk;
	
// output 
	output reg [31:0] Op1Src;
	
	
	always @(*)
		begin
			if(ID_EXE_JmpandLink == 0)
				Op1Src <= ID_EXE_Rs;
			if (ID_EXE_JmpandLink == 1)
				Op1Src <= ID_EXE_PCplus4;
		end
		
endmodule
