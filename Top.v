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
	wire [4:0] IF_ID_Rs, IF_ID_Rt, IF_ID_Rd, IF_ID_Shamt, IF_ID_fmt, IF_ID_Fd, IF_ID_Fs, IF_ID_Ft;
	wire [5:0] IF_ID_Func, IF_ID_Opcode;
	wire [15:0] IF_ID_Immediate;
	wire [25:0] IF_ID_Address;
	wire [31:0] IF_ID_PCplus4;
	
	// ID Stage
	wire [63:0] FPReadData1, FPReadData2, ReadData1, ReadData2, SignedImmediate, UnsignedImmediate, ExtendedImm, ID_TregData, ID_SregData;
	wire [31:0] JumpShiftedAddress, JumpAddress, Ra;					
	wire Byte, RegDst, RegWrite, MemtoReg, Jump, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUSrc, floatop, Issigned, Stall,
		  PC_Write, IF_ID_Write, BranchFPFalse, BranchFPTrue, double;
	wire [3:0] ALUop;
	
	// ID_EXE_Register
	wire ID_EXE_Byte, ID_EXE_RegDst, ID_EXE_RegWrite, ID_EXE_MemtoReg, ID_EXE_JmpandLink, ID_EXE_MemRead, ID_EXE_MemWrite, ID_EXE_BranchEqual, ID_EXE_BranchnotEqual,
		  ID_EXE_ALUSrc, ID_EXE_BranchFPTrue, ID_EXE_BranchFPFalse, ID_EXE_double;
	wire [3:0] ID_EXE_ALUop;
	wire [5:0] ID_EXE_Func;
	wire [63:0] ID_EXE_SregData, ID_EXE_TregData, ID_EXE_ExtendedImm, ID_EXE_PCplus4;
	wire [4:0] ID_EXE_Shamt, ID_EXE_Rd, ID_EXE_RtReg, ID_EXE_RsReg, ID_EXE_Fd, ID_EXE_Ft, ID_EXE_fmt; 
	
	// EXE Stage
	wire [63:0] ALUOut_EXEC, Op2Src, Op1Src, Op1, Op2;
	wire [31:0] BranchAdd;
	wire EXE_Zero, Overflow, EXE_ReadfromMem, EXE_WritetoMem, EXE_R_memtoReg, CompareOp, EXE_LoHiWrite, EXE_LoRead, EXE_HiRead, BranchFP, EqualSignal, BnE, BE;
	wire [1:0] forwardOp1, forwardOp2;
	wire [4:0] EXE_DstReg, EXE_FP_DstReg;
	wire [4:0] operation;
	
	reg FPCond;
	initial
		FPCond <= 0;
	
	
	// EXE_MEM_Register
	wire [63:0] EXE_MEM_Result, EXE_MEM_Treg; 
	wire EXE_MEM_JmpandLink, EXE_MEM_Byte, EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, MEM_memWrite, MEM_memRead,
		  EXE_MEM_R_memtoReg, EXE_MEM_ReadfromMem, EXE_MEM_WritetoMem, EXE_MEM_LoHiWrite, EXE_MEM_LoRead, EXE_MEM_HiRead, EXE_MEM_double; 
	wire [4:0] EXE_MEM_DstReg, EXE_MEM_FP_DstReg;
	
	// MEM Stage
	wire [63:0] MEM_Result, MEM_Data, Lo_ReadData, Hi_ReadData;
	wire BranchEqualResult, BranchnotEqualResult, MEM_R_memtoReg;
	
	// MEM_ WB_Register
	wire [63:0] MEM_WB_MemData, MEM_WB_ALUData;
	wire [4:0]  MEM_WB_DstReg, MEM_WB_FP_DstReg;
	wire MEM_WB_JmpandLink, MEM_WB_MemtoReg, MEM_WB_RegWrite, MEM_WB_R_memtoReg, MEM_WB_LoHiWrite;
	reg [31:0] Lo, Hi;
	initial 
		begin
			Lo <= 0;
			Hi <= 0;
		end
		
	
	// WB Stage
	wire [63:0] WB_Data;
	wire WB_memtoReg, RW;
	
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
   
	IsJr isjr (isJr, IF_ID_Func, IF_ID_Opcode);
	PC_MUX Jr_PCMux (PCSrc, PCplus4, Ra, isJr); 
	PC_MUX Branch_PCMux (PCSrc1, PCSrc, EXE_BranchAddress, PC_Src); 
	PC_MUX Jump_PCMux (PCSrc2, PCSrc1, JumpAddress, Jump);
	PCAdder pcadd (PCplus4 , program_counter);
	instructionMemory imem (instruction, program_counter);
	
	
// IF_ID_Register
	IF_ID_Register ifidr (IF_ID_Rs, IF_ID_Rt, IF_ID_Rd, IF_ID_Opcode, IF_ID_Shamt, IF_ID_Func, IF_ID_Immediate,
								 IF_ID_Address, IF_ID_PCplus4, IF_ID_Fd, IF_ID_Fs, IF_ID_Ft, IF_ID_fmt, instruction, PCplus4, clk, IF_ID_Write); 
	
// ID Stage
	ControlUnit cu (Byte, RegDst, RegWrite, MemtoReg, Jump, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, BranchFPTrue, BranchFPFalse, ALUop, ALUSrc,
						 floatop, Issigned, double, IF_ID_Opcode, Stall);
	SignExtension se (SignedImmediate, IF_ID_Immediate);
	ZeroExtension ze (UnsignedImmediate, IF_ID_Immediate);
	Ext_MUX extmux (ExtendedImm, SignedImmediate, UnsignedImmediate, Issigned);
	
	RegisterFile regFile (ReadData1, ReadData2, clk, IF_ID_Rs, IF_ID_Rt, MEM_WB_DstReg, WB_Data, RW, MEM_WB_JmpandLink);
	FP_RegisterFile FPRegisterFile (FPReadData1, FPReadData2, clk, IF_ID_fmt, IF_ID_Fs, IF_ID_Ft, MEM_WB_FP_DstReg, WB_Data, floatop); 
	
	readData_Mux Sreg_Mux (ID_SregData, ReadData1, FPReadData1, floatop);
	readData_Mux Treg_Mux (ID_TregData, ReadData2, FPReadData2, floatop);
	
	HazardDetectionUnit hd (Stall, PC_Write, IF_ID_Write, IF_ID_Rs, IF_ID_Rt, ID_EXE_MemRead, ID_EXE_RtReg, PC_Src, Jump, JmpandLink, isJr);
	
	ShiftLeft2 shiftleftjump (JumpShiftedAddress, IF_ID_Address);
	Jumpj jump (JumpAddress, JumpShiftedAddress, IF_ID_PCplus4);
	assign Ra = ReadData2[31:0];
	
	
// ID_EXE_Register
	ID_EXE_Register idexer (ID_EXE_Fd, ID_EXE_Ft, ID_EXE_fmt, ID_EXE_Func, ID_EXE_PCplus4, ID_EXE_SregData, ID_EXE_TregData, ID_EXE_Rd, ID_EXE_RtReg, ID_EXE_RsReg, ID_EXE_ExtendedImm, ID_EXE_Shamt, ID_EXE_RegDst,
									ID_EXE_RegWrite, ID_EXE_MemtoReg, ID_EXE_JmpandLink, ID_EXE_MemRead, ID_EXE_MemWrite, ID_EXE_BranchEqual, ID_EXE_BranchnotEqual, ID_EXE_BranchFPTrue,  
									ID_EXE_BranchFPFalse, ID_EXE_ALUop, ID_EXE_ALUSrc, ID_EXE_Byte, ID_EXE_double, double, Byte, IF_ID_Shamt, IF_ID_Func, IF_ID_PCplus4, IF_ID_Rs, IF_ID_Rt, ID_SregData, ID_TregData, 
									IF_ID_Rd, IF_ID_Fd, IF_ID_Ft, IF_ID_fmt, ExtendedImm, RegDst, RegWrite, MemtoReg, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, BranchFPTrue, BranchFPFalse, 
									ALUop, ALUSrc, clk);
																	
									
// EXE Stage
	OpSrc_MUX Op2Src_Mux (Op2Src, ID_EXE_TregData, ID_EXE_ExtendedImm, ID_EXE_ALUSrc);
	OpSrc_MUX Op1Src_Mux (Op1Src, ID_EXE_SregData, ID_EXE_PCplus4, ID_EXE_JmpandLink);
	
	Forward_Mux ForOp1_MUX (Op1, Op1Src, WB_Data, EXE_MEM_Result, forwardOp1);
	Forward_Mux ForOp2_MUX (Op2, Op2Src, WB_Data, EXE_MEM_Result, forwardOp2);
	
	DstRegMUX DstReg_Mux (EXE_DstReg, ID_EXE_RtReg, ID_EXE_Rd, ID_EXE_RegDst);
	DstRegMUX FPDstReg_Mux (EXE_FP_DstReg, ID_EXE_Ft, ID_EXE_Fd, ID_EXE_RegDst);
	
	ShiftLeft2 shiftleftbranch (BranchAdd, ID_EXE_ExtendedImm[31:0]);
	AddressAdder addadd (EXE_BranchAddress, ID_EXE_PCplus4[31:0], BranchAdd);
	
	ALUcontrol ALUControl (EXE_LoHiWrite, EXE_LoRead, EXE_HiRead, CompareOp, EXE_R_memtoReg, EXE_ReadfromMem, EXE_WritetoMem, operation, ID_EXE_ALUop, ID_EXE_Func,
								  ID_EXE_double);
	ALU alu (ALUOut_EXEC, EXE_Zero, Overflow, Op1, Op2, operation, ID_EXE_Shamt);
	
	always @(EXE_Zero,CompareOp)
		begin
			if(CompareOp == 1)
				FPCond <= EXE_Zero;
		end
	
	ForwardingUnit forwardingUnit (forwardOp1, forwardOp2, ID_EXE_RsReg, ID_EXE_RtReg, EXE_MEM_DstReg, EXE_MEM_RegWrite, MEM_WB_DstReg, MEM_WB_RegWrite);
	
	ORa FP_Branch (BranchFP, ID_EXE_BranchFPTrue, ID_EXE_BranchFPFalse);
	BranchSignal_Mux BS_Mux1 (EqualSignal, EXE_Zero, FPCond, BranchFP);
	
	ORa BranchEqualOr (BE, ID_EXE_BranchFPTrue, ID_EXE_BranchEqual);
	ORa BranchnotEqualOr (BnE, ID_EXE_BranchFPFalse, ID_EXE_BranchnotEqual);
	
	BranchEqualAnd branEqualAnd (BranchEqualResult, EqualSignal, BE);
	BranchnotEqualAnd branchnotEqualAnd(BranchnotEqualResult, EXE_Zero, BnE);
	AddressOr addressOr (PC_Src, BranchEqualResult, BranchnotEqualResult);
	
		
  
// EXE_MEM_Register
	EXE_MEM_Register exememr(EXE_MEM_LoHiWrite, EXE_MEM_LoRead, EXE_MEM_HiRead, EXE_MEM_R_memtoReg, EXE_MEM_ReadfromMem, EXE_MEM_WritetoMem, EXE_MEM_Result, EXE_MEM_DstReg,
									 EXE_MEM_FP_DstReg, EXE_MEM_Treg, EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, 
									 EXE_MEM_Byte, EXE_MEM_JmpandLink, EXE_MEM_double, ID_EXE_double, ID_EXE_JmpandLink, ID_EXE_Byte, ALUOut_EXEC, EXE_DstReg, EXE_FP_DstReg, ID_EXE_TregData,
									 ID_EXE_MemRead, ID_EXE_MemWrite, ID_EXE_MemtoReg, ID_EXE_RegWrite, EXE_ReadfromMem, EXE_WritetoMem, EXE_R_memtoReg, EXE_LoHiWrite,
									 EXE_LoRead, EXE_HiRead, clk);
									 

// MEM Stage
	ORa MemWriteOr (MEM_memWrite, EXE_MEM_MemWrite, EXE_MEM_WritetoMem);
	ORa MemReadOr (MEM_memRead, EXE_MEM_MemRead, EXE_MEM_ReadfromMem);
	
	
	always @(*)
		begin
			if(EXE_MEM_LoHiWrite)
				begin
					Lo <= EXE_MEM_Treg[31:0];
					Hi <= EXE_MEM_Treg[63:32];
				end
		end
		
	MemData_Mux MemData_Mux (MEM_Data, {32'b0,Lo}, {32'b0,Hi}, MEM_Result, EXE_MEM_LoRead, EXE_MEM_HiRead, MEM_memWrite);
	
	DataMemory DMem(MEM_Result, EXE_MEM_Result, EXE_MEM_Treg, MEM_memRead, MEM_memWrite, EXE_MEM_Byte, EXE_MEM_double, clk);
	
// MEM_WB_Register
	MEM_WB_Register memwbreg (MEM_WB_R_memtoReg, MEM_WB_MemData, MEM_WB_ALUData, MEM_WB_DstReg, MEM_WB_FP_DstReg, MEM_WB_MemtoReg, MEM_WB_RegWrite,
									  MEM_WB_JmpandLink, MEM_WB_LoHiWrite, EXE_MEM_LoHiWrite, EXE_MEM_JmpandLink, MEM_Data, EXE_MEM_Result, EXE_MEM_DstReg, 
									  EXE_MEM_FP_DstReg, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, EXE_MEM_R_memtoReg, clk);
   	
// WB Stage
	ORa MemtoRegOr (WB_memtoReg, MEM_WB_MemtoReg, MEM_WB_R_memtoReg);
	regWriteAnd RegWriteAnd(RW, MEM_WB_LoHiWrite, MEM_WB_RegWrite);
	
	WB_MUX WB_Mux (WB_Data, MEM_WB_MemData, MEM_WB_ALUData, WB_memtoReg);
	
endmodule

module tst_6; 
	reg [31:0]PC_VALUE_;		  
	reg [31:0] cycle;
	Top top(PC_VALUE_);
	initial begin
		PC_VALUE_ <= 600;	  
		cycle <= 1;
	end				   
	always @(posedge top.clk) begin	
if (cycle== 11)	
begin
		$display("cycle: %d" , cycle);
		$display("PC: %d",top.program_counter);				   
		$display("ALUOut_EXEC: %d" , top.ALUOut_EXEC);
		$display("$s1: %d" , top.regFile.registers_i[19], " The correct value is 15");
		$display("$s2: %d" , top.regFile.registers_i[20], " The correct value is 10");		
		$display("$s3: %d" , top.regFile.registers_i[21], " The correct value is 3");		
		$display("$s4: %d" , top.regFile.registers_i[22], " The correct value is 25");
		$display("$s5: %d" , top.regFile.registers_i[23], " The correct value is 28");	
		
		$finish;
		end
		cycle = cycle + 1;
	end
endmodule
