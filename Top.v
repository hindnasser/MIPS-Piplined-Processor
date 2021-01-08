module Top (PC_value);

// input
	input [31:0] PC_value;
   
// clock
	wire clk;
	clock c(clk);

	
// wires 

	// IF Stage
	wire [31:0] instruction,PCplus4, EXE_BranchAddress, PCSrc, PCSrc2, PCSrc1;
   wire PC_Src, isJr;
	reg [31:0] program_counter; 
	
	//IF_ID_Register
	wire [4:0] IF_ID_Rs, IF_ID_Rt, IF_ID_Rd, IF_ID_Shamt;
	wire [5:0] IF_ID_Func, IF_ID_Opcode;
	wire [15:0] IF_ID_Immediate;
	wire [25:0] IF_ID_Address;
	wire [31:0] IF_ID_PCplus4;
	
	// ID Stage
	wire [31:0] SignedImmediate, UnsignedImmediate, ReadData1, ReadData2, ExtendedImm, JumpShiftedAddress, JumpAddress, Ra;					
	wire Byte, RegDst, RegWrite, MemtoReg, Jump, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUSrc, floatop, Issigned, Stall, PC_Write, IF_ID_Write;
	wire [3:0] ALUop;
	
	// ID_EXE_Register
	wire ID_EXE_Byte, ID_EXE_RegDst, ID_EXE_RegWrite, ID_EXE_MemtoReg, ID_EXE_JmpandLink, ID_EXE_MemRead, ID_EXE_MemWrite, ID_EXE_BranchEqual, ID_EXE_BranchnotEqual,
		  ID_EXE_ALUSrc;
	wire [3:0] ID_EXE_ALUop;
	wire [5:0] ID_EXE_Func;
	wire [31:0] ID_EXE_PCplus4, ID_EXE_Rs, ID_EXE_Rt, ID_EXE_ExtendedImm;
	wire [4:0] ID_EXE_Shamt, ID_EXE_Rd, ID_EXE_RtReg, ID_EXE_RsReg; 
	
	// EXE Stage
	wire [31:0] ALUOut_EXEC, Op2Src, Op1Src, Op1, Op2, BranchAdd;
	wire EXE_Zero, Overflow, EXE_ReadfromMem, EXE_WritetoMem, EXE_R_memtoReg;
	wire [1:0] forwardOp1, forwardOp2;
	wire [4:0] EXE_DstReg;
	wire [4:0] operation;
	
	
	// EXE_MEM_Register
	wire [31:0] EXE_MEM_Result, EXE_MEM_BranchAddress, EXE_MEM_Rt; 
	wire EXE_MEM_JmpandLink, EXE_MEM_Byte, EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, MEM_memWrite, MEM_memRead, EXE_MEM_R_memtoReg, EXE_MEM_ReadfromMem, EXE_MEM_WritetoMem; 
	wire [4:0] EXE_MEM_DstReg;
	
	// MEM Stage
	wire [31:0] MEM_Result;
	wire BranchEqualResult, BranchnotEqualResult, MEM_R_memtoReg;
	
	// MEM_ WB_Register
	wire [31:0] MEM_WB_MemData, MEM_WB_ALUData;
	wire [4:0]  MEM_WB_DstReg;
	wire MEM_WB_JmpandLink, MEM_WB_MemtoReg, MEM_WB_RegWrite, MEM_WB_R_memtoReg;
	
	// WB Stage
	wire [31:0] WB_Data;
	wire WB_memtoReg;
	
// IF Stage

	reg start;
	initial
		start <= 1;
	
	always @ (posedge clk)
		begin
			if(start)
				begin
					program_counter <= PC_value;
					start <= 0;
				end
				
			else if(PC_Write == 1 && !start)
				program_counter <= PCSrc2;
		end
   
	IsJr isjr (isJr, IF_ID_Func);
	PC_MUX Jr_PCMux (PCSrc, PCplus4, Ra, isJr); 
	PC_MUX Branch_PCMux (PCSrc1, PCSrc, EXE_BranchAddress, PC_Src); 
	PC_MUX Jump_PCMux (PCSrc2, JumpAddress, PCSrc1, Jump);
	PCAdder pcadd (PCplus4 , program_counter);
	instructionMemory imem (instruction, program_counter);
	
	
// IF_ID_Register
	IF_ID_Register ifidr (IF_ID_Rs, IF_ID_Rt, IF_ID_Rd, IF_ID_Opcode, IF_ID_Shamt, IF_ID_Func, IF_ID_Immediate,
								 IF_ID_Address, IF_ID_PCplus4, instruction, PCplus4, clk, IF_ID_Write); 
	
// ID Stage
	ControlUnit cu (Byte, RegDst, RegWrite, MemtoReg, Jump, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUop, ALUSrc, floatop, Issigned, IF_ID_Opcode, Stall);
	SignExtension se (SignedImmediate, IF_ID_Immediate);
	ZeroExtension ze (UnsignedImmediate, IF_ID_Immediate);
	Ext_MUX extmux (ExtendedImm, SignedImmediate, UnsignedImmediate, Issigned);
	RegisterFile regFile (ReadData1, ReadData2, clk, IF_ID_Rs, IF_ID_Rt, MEM_WB_DstReg, WB_Data, MEM_WB_RegWrite, MEM_WB_JmpandLink);//here
	HazardDetectionUnit hd (Stall, PC_Write, IF_ID_Write, IF_ID_Rs, IF_ID_Rt, ID_EXE_MemRead, ID_EXE_RtReg, PC_Src, Jump, JmpandLink, isJr);
	
	ShiftLeft2 shiftleftjump (JumpShiftedAddress, IF_ID_Address);
	Jumpj jump (JumpAddress, JumpShiftedAddress, IF_ID_PCplus4);
	assign Ra = ReadData2;
	
	
// ID_EXE_Register
	ID_EXE_Register idexer (ID_EXE_Func, ID_EXE_PCplus4, ID_EXE_Rs, ID_EXE_Rt, ID_EXE_Rd, ID_EXE_RtReg, ID_EXE_RsReg, ID_EXE_ExtendedImm, ID_EXE_Shamt, ID_EXE_RegDst,
									ID_EXE_RegWrite, ID_EXE_MemtoReg, ID_EXE_JmpandLink, ID_EXE_MemRead, ID_EXE_MemWrite, ID_EXE_BranchEqual, ID_EXE_BranchnotEqual, 
									ID_EXE_ALUop, ID_EXE_ALUSrc, ID_EXE_Byte, Byte, IF_ID_Shamt, IF_ID_Func, IF_ID_PCplus4, IF_ID_Rs, IF_ID_Rt, ReadData1, ReadData2, IF_ID_Rd, ExtendedImm,
									RegDst, RegWrite, MemtoReg, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUop, ALUSrc, clk);
									// change ReadData1 and ReadData2 to ID_Rs and ID_Rt after adding floating point registerFile
									
									
// EXE Stage
	Op2Src_MUX op2srcmux (Op2Src, ID_EXE_Rt, ID_EXE_ExtendedImm, ID_EXE_ALUSrc);
	Op1Src_MUX op1srcmux (Op1Src, ID_EXE_Rs, ID_EXE_PCplus4, ID_EXE_JmpandLink);
	ForOp1_MUX forop1mux (Op1, Op1Src, WB_Data, EXE_MEM_Result, forwardOp1);
	ForOp2_MUX forop2mux (Op2, Op2Src, WB_Data, EXE_MEM_Result, forwardOp2);
	DstReg_MUX dstregmux (EXE_DstReg, ID_EXE_RtReg, ID_EXE_Rd, ID_EXE_RegDst);

	ShiftLeft2 shiftleftbranch (BranchAdd, ID_EXE_ExtendedImm);
	AddressAdder addadd (EXE_BranchAddress, ID_EXE_PCplus4, BranchAdd);
	ALUcontrol aluc ( EXE_R_memtoReg, EXE_ReadfromMem, EXE_WritetoMem, operation, ID_EXE_ALUop, ID_EXE_Func);
	ALU alu (ALUOut_EXEC, EXE_Zero, Overflow, Op1, Op2, operation, ID_EXE_Shamt);
	ForwardingUnit forunit (forwardOp1, forwardOp2, ID_EXE_RsReg, ID_EXE_RtReg, EXE_MEM_DstReg, EXE_MEM_RegWrite, MEM_WB_DstReg, MEM_WB_RegWrite);
	BranchEqualAnd beand (BranchEqualResult, EXE_Zero, ID_EXE_BranchEqual);
	BranchnotEqualAnd bneand(BranchnotEqualResult, EXE_Zero, ID_EXE_BranchnotEqual);
	AddressOr addor (PC_Src, BranchEqualResult, BranchnotEqualResult);
	
  
// EXE_MEM_Register
	EXE_MEM_Register exememr(EXE_MEM_R_memtoReg, EXE_MEM_ReadfromMem, EXE_MEM_WritetoMem, EXE_MEM_Result, EXE_MEM_DstReg, EXE_MEM_Rt, EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, 
									 EXE_MEM_Byte, EXE_MEM_JmpandLink, ID_EXE_JmpandLink, ID_EXE_Byte, ALUOut_EXEC, EXE_DstReg, ID_EXE_Rt, ID_EXE_MemRead, ID_EXE_MemWrite, ID_EXE_MemtoReg, ID_EXE_RegWrite, EXE_ReadfromMem, EXE_WritetoMem, EXE_R_memtoReg, clk);

// MEM Stage
	ORa MemWriteOr (MEM_memWrite, EXE_MEM_MemWrite, EXE_MEM_WritetoMem);
	ORa MemReadOr (MEM_memRead, EXE_MEM_MemRead, EXE_MEM_ReadfromMem);
	DataMemory DMem(MEM_Result, EXE_MEM_Result, EXE_MEM_Rt, MEM_memRead, MEM_memWrite, EXE_MEM_Byte, clk);
	
// MEM_WB_Register
	MEM_WB_Register memwbreg (MEM_WB_R_memtoReg, MEM_WB_MemData, MEM_WB_ALUData, MEM_WB_DstReg, MEM_WB_MemtoReg, MEM_WB_RegWrite, MEM_WB_JmpandLink, EXE_MEM_JmpandLink, MEM_Result, EXE_MEM_Result,
						           EXE_MEM_DstReg, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, MEM_R_memtoReg, clk);
   	
// WB Stage
	ORa MemtoRegOr (WB_memtoReg, MEM_WB_MemtoReg, MEM_WB_R_memtoReg);
	WB_MUX wbmux (WB_Data, MEM_WB_MemData, MEM_WB_ALUData, WB_memtoReg);
	
endmodule





