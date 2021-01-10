module ForwardingUnit (forwardOp1, forwardOp2, ID_EXE_Rs, ID_EXE_Rt, EXE_MEM_DstReg, EXE_MEM_RegWrite, MEM_WB_DstReg, MEM_WB_RegWrite);

//input
	input [4:0] ID_EXE_Rs, ID_EXE_Rt, EXE_MEM_DstReg, MEM_WB_DstReg;
	input EXE_MEM_RegWrite, MEM_WB_RegWrite;
	
//output
	output reg [1:0] forwardOp1, forwardOp2;
	
	initial
		begin
			forwardOp1 <= 2'b0;
			forwardOp2 <= 2'b0;
		end
	always @(*) begin
		
// ALU-ALU forwarding conditions for Op1
		if(EXE_MEM_RegWrite && (EXE_MEM_DstReg != 4'b0) &&(EXE_MEM_DstReg == ID_EXE_Rs)) begin
			forwardOp1 <= 2'b10; end
			
// MEM-ALU forwarding conditions for Op1			
		else if(MEM_WB_RegWrite && (MEM_WB_DstReg != 4'b0) &&
		~(EXE_MEM_RegWrite && (EXE_MEM_DstReg != 4'b0) &&(EXE_MEM_DstReg == ID_EXE_Rs))&& MEM_WB_DstReg == ID_EXE_Rs) begin
			forwardOp1 <= 2'b01; end
		
		else forwardOp1 <= 2'b00;
			
		
// ALU-ALU forwarding conditions for Op2
		if(EXE_MEM_RegWrite && (EXE_MEM_DstReg != 4'b0) &&(EXE_MEM_DstReg == ID_EXE_Rt)) begin
			forwardOp2 <= 2'b10;  end
			
// MEM-ALU forwarding conditions for Op2
		else if(MEM_WB_RegWrite && (MEM_WB_DstReg != 4'b0) &&
		~(EXE_MEM_RegWrite && (EXE_MEM_DstReg != 4'b0) &&(EXE_MEM_DstReg == ID_EXE_Rt)) && MEM_WB_DstReg == ID_EXE_Rt) begin
			forwardOp2 <= 2'b01;  end
			
		else forwardOp2 <= 2'b00;
			
	end

endmodule
