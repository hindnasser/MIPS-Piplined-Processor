module Top (PC_value);

// input
	input [31:0] PC_value;
   
// clock
	wire clk;
	clock c(clk);

	
// wires 

	// IF Stage
	wire [31:0] instruction,PCplus4, Mem_BranchAddress, PCSrc;
   wire PC_Src;
	reg [31:0] program_counter; 
	
	//IF_ID_Register
	wire [4:0] IF_ID_Rs, IF_ID_Rt, IF_ID_Rd, IF_ID_Shamt;
	wire [5:0] IF_ID_Func, IF_ID_Opcode;
	wire [15:0] IF_ID_Immediate;
	wire [25:0] IF_ID_Address;
	wire [31:0] IF_ID_PCplus4;
	
	// ID Stage
	wire [31:0] SignedImmediate, UnsignedImmediate, ReadData1, ReadData2, ExtendedImm;					
	wire RegDst, RegWrite, MemtoReg, Jump, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUSrc, floatop, Issigned;
	wire [3:0] ALUop;
	
	// ID_EXE_Register
	wire ID_EXE_RegDst, ID_EXE_RegWrite, ID_EXE_MemtoReg, ID_EXE_JmpandLink, ID_EXE_MemRead, ID_EXE_MemWrite, ID_EXE_BranchEqual, ID_EXE_BranchnotEqual,
		  ID_EXE_ALUSrc;
	wire [3:0] ID_EXE_ALUop;
	wire [5:0] ID_EXE_Func;
	wire [31:0] ID_EXE_PCplus4, ID_EXE_Rs, ID_EXE_Rt, ID_EXE_ExtendedImm;
	wire [4:0] ID_EXE_Shamt, ID_EXE_Rd, ID_EXE_RtReg, ID_EXE_RsReg; 
	
	// EXE Stage
	wire [31:0] ALUOut_EXEC, Op2Src, Op1, Op2, BranchAdd, EXE_BranchAddress;
	wire EXE_Zero, Overflow;
	wire [1:0] forwardOp1, forwardOp2;
	wire [4:0] EXE_DstReg, operation;
	
	
	// EXE_MEM_Register
	wire [31:0] EXE_MEM_Result, EXE_MEM_BranchAddress, EXE_MEM_Rt; 
	wire EXE_MEM_Zero, EXE_MEM_BranchEqual, EXE_MEM_BranchnotEqual, EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite; 
	wire [4:0] EXE_MEM_DstReg;
	
	// MEM Stage
	wire [31:0] MEM_Result;
	wire BranchEqualResult, BranchnotEqualResult;
	
	// MEM_ WB_Register
	wire [31:0] MEM_WB_MemData, MEM_WB_ALUData;
	wire [4:0] MEM_WB_Rd, MEM_WB_DstReg;
	wire MEM_WB_MemtoReg, MEM_WB_RegWrite;
	
	// WB Stage
	wire [31:0] WB_Data;
	
// IF Stage
	
	initial 
			begin
			// constant initialization
				program_counter <= 300;
			end
		
	always @ (posedge clk)
		begin
			program_counter <= PCSrc;
		end
   
	PC_MUX pcmux (PCSrc, PCplus4, Mem_BranchAddress, 0);
	//PC_Reg pcreg (program_counter, PCSrc, clk);
	PCAdder pcadd (PCplus4 , program_counter);
	instructionMemory imem (instruction, program_counter);
	
	
// IF_ID_Register
	IF_ID_Register ifidr (IF_ID_Rs, IF_ID_Rt, IF_ID_Rd, IF_ID_Opcode, IF_ID_Shamt, IF_ID_Func, IF_ID_Immediate,
								 IF_ID_Address, IF_ID_PCplus4, instruction, PCplus4, clk); 
	
// ID Stage
	ControlUnit cu (RegDst, RegWrite, MemtoReg, Jump, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUop, ALUSrc, floatop, Issigned, IF_ID_Opcode);
	SignExtension se (SignedImmediate, IF_ID_Immediate);
	ZeroExtension ze (UnsignedImmediate, IF_ID_Immediate);
	Ext_MUX extmux (ExtendedImm, SignedImmediate, UnsignedImmediate, Issigned);
	RegisterFile regFile (ReadData1, ReadData2, clk, IF_ID_Rs, IF_ID_Rt, MEM_WB_DstReg, WB_Data, MEM_WB_RegWrite);//here
	// floating register file
	// Rs_MUX
	// Rs_MUX rsmux (ID_Rs, ReadData1, FPReadData1, floatop, clk);
	// Rt_MUx
	// Rt_MUX rtmux (ID_Rt, ReadData2, FPReadData2, floatop, clk);
	
// ID_EXE_Register
	ID_EXE_Register idexer (ID_EXE_Func, ID_EXE_PCplus4, ID_EXE_Rs, ID_EXE_Rt, ID_EXE_Rd, ID_EXE_RtReg, ID_EXE_RsReg, ID_EXE_ExtendedImm, ID_EXE_Shamt, ID_EXE_RegDst,
									ID_EXE_RegWrite, ID_EXE_MemtoReg, ID_EXE_JmpandLink, ID_EXE_MemRead, ID_EXE_MemWrite, ID_EXE_BranchEqual, ID_EXE_BranchnotEqual, 
									ID_EXE_ALUop, ID_EXE_ALUSrc, IF_ID_Shamt, IF_ID_Func, IF_ID_PCplus4, IF_ID_Rs, IF_ID_Rt, ReadData1, ReadData2, IF_ID_Rd, ExtendedImm,
									RegDst, RegWrite, MemtoReg, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUop, ALUSrc, clk);
									// change ReadData1 and ReadData2 to ID_Rs and ID_Rt after adding floating point registerFile
									
									
// EXE Stage
	Op2Src_MUX op2srcmux (Op2Src, ID_EXE_Rt, ID_EXE_ExtendedImm, ID_EXE_ALUSrc);
	ForOp1_MUX forop1mux (Op1, ID_EXE_Rs, WB_Data, EXE_MEM_Result, forwardOp1);
	ForOp2_MUX forop2mux (Op2, Op2Src, WB_Data, EXE_MEM_Result, forwardOp2);
	DstReg_MUX dstregmux (EXE_DstReg, ID_EXE_RtReg, ID_EXE_Rd, ID_EXE_RegDst);

	AddressAdder addadd (EXE_BranchAddress, ID_EXE_PCplus4, BranchAdd);
	ALUcontrol aluc (operation, ID_EXE_ALUop, ID_EXE_Func);
	ALU alu (ALUOut_EXEC, EXE_Zero, Overflow, Op1, Op2, ID_EXE_ALUop, ID_EXE_Shamt);//here/////////ID_EXE_ALUSrc change
	// change nmber to operation after adding the alu control
	ForwardingUnit forunit (forwardOp1, forwardOp2, ID_EXE_RsReg, ID_EXE_RtReg, EXE_MEM_DstReg, EXE_MEM_RegWrite, MEM_WB_DstReg, MEM_WB_RegWrite);
	// alu controlUnitd
	
  
// EXE_MEM_Register
	EXE_MEM_Register exememr(EXE_MEM_Result, EXE_MEM_BranchAddress, EXE_MEM_DstReg, EXE_MEM_Zero, EXE_MEM_Rt, EXE_MEM_BranchEqual, EXE_MEM_BranchnotEqual,
								    EXE_MEM_MemRead, EXE_MEM_MemWrite, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, EXE_BranchAddress, ALUOut_EXEC, EXE_DstReg, ID_EXE_Rt,
								    EXE_Zero, ID_EXE_BranchEqual, ID_EXE_BranchnotEqual, ID_EXE_MemRead, ID_EXE_MemWrite, ID_EXE_MemtoReg, ID_EXE_RegWrite, clk);

// MEM Stage
	DataMemory DMem(MEM_Result, EXE_MEM_Result, EXE_MEM_Rt, EXE_MEM_MemRead, EXE_MEM_MemWrite, clk);
	BranchEqualAnd beand (BranchEqualResult, EXE_MEM_Zero, EXE_MEM_BranchEqual);
	BranchnotEqualAnd bneand(BranchnotEqualResult, EXE_MEM_Zero, EXE_MEM_BranchnotEqual);
	AddressOr addor (PC_Src, BranchEqualResult, BranchnotEqualResult);
	
// MEM_WB_Register
	MEM_WB_Register memwbreg (MEM_WB_MemData, MEM_WB_ALUData, MEM_WB_DstReg, MEM_WB_MemtoReg, MEM_WB_RegWrite, MEM_Result, EXE_MEM_Result,
						           EXE_MEM_DstReg, EXE_MEM_MemtoReg, EXE_MEM_RegWrite, clk);
   	
// WB Stage
	WB_MUX wbmux (WB_Data, MEM_WB_MemData, MEM_WB_ALUData, MEM_WB_MemtoReg);
	
endmodule

//module tst_2; 
//	reg [31:0] PC_VALUE_;		  
//	reg [31:0] cycle;
//	Top top(PC_VALUE_);
//	initial begin
//		PC_VALUE_ <= 200;	  
//		cycle <= 1;
//	end				   
//	always @(posedge top.clk) begin	
//
//	if (cycle == 12)
//	begin
//		$display("cycle: %d" , cycle);
//		$display("PC: %d", top.program_counter);	
//		$display ("IN, %h", top.instruction );
//		$display("ALUOut_EXEC: %d" , top.ALUOut_EXEC);
//		$display("$s1: %d" , top.regFile.registers_i[19], " The correct value is 5");
//		$display("$s2: %d" , top.regFile.registers_i[20], " The correct value is 10");		
//		$display("$s3: %d" , top.regFile.registers_i[21], " The correct value is 3");		
//		$display("$s4: %d" , top.regFile.registers_i[22], " The correct value is 2");
//		$display("$s5: %d" , top.regFile.registers_i[23], " The correct value is 15");
//		$display("$s6: %d" , top.regFile.registers_i[24], " The correct value is -2  *** Check reporesentation");	
//		$display("$s6: %d" , top.MEM_WB_ALUData, " Teck reporesentation");
//		$display("$s6: %d" , top.Op1, " Teck reporesentation");
//		$display("$s6: %d" , top.Op2, " Teck reporesentation");
//		$display("$s6: %d" , top.ID_EXE_ALUSrc, " Teck reporesentation");
//		$display("$s6: %d" , top.ReadData1, " Teck reporesentation");
//		$display("$s6: %d" , top.ReadData2, " Teck reporesentation");
//		
//		
//		end
//			cycle = cycle + 1;
//		
//		
//	end
//endmodule
//module tst_1; 
//	reg [31:0]PC_VALUE_;		  
//	reg [31:0] cycle;
//	Top top(PC_VALUE_);
//	initial begin
//		PC_VALUE_ <= 100;	  
//		cycle <= 1;
//	end				   
//	always @(posedge top.clk) begin	
//	
//	if (cycle == 14)
//	begin
//		$display("cycle: %d" , cycle);
//		$display("PC: %d",top.program_counter);				   
//		$display("ALUOut_EXEC: %d" , top.ALUOut_EXEC);
//		$display("$t0: %d" , top.regFile.registers_i[8], " The correct value is 4");
//		$display("$t1: %d" , top.regFile.registers_i[9], " The correct value is 8");		
//		$display("$t2: %d" , top.regFile.registers_i[10], " The correct value is 12");		
//		$display("$t3: %d" , top.regFile.registers_i[11], " The correct value is 16");
//		$display("$t4: %d" , top.regFile.registers_i[12], " The correct value is 20");
//		$display("$t5: %d" , top.regFile.registers_i[13], " The correct value is 24");
//		$display("$t6: %d" , top.regFile.registers_i[14], " The correct value is 28");
//		$display("$t7: %d" , top.regFile.registers_i[15], " The correct value is 32");
//				
//		
//		end
//		
//		
//	cycle = cycle + 1;
//		
//	end
//endmodule
module arethmatic1; 
	reg [31:0]PC_VALUE_;		  
	reg [31:0] cycle;
	Top top(PC_VALUE_);
	initial begin
		PC_VALUE_ <= 300;	  
		cycle <= 1;
	end				   
	always @(posedge top.clk) begin	
	
	if (cycle == 12)
	begin
		$display("cycle: %d" , cycle);
		$display("PC: %d",top.program_counter);				   
		$display("ALUOut_EXEC: %d" , top.ALUOut_EXEC);
		$display("$s1: %d" , top.regFile.registers_i[19], " The correct value is 15");
		$display("$s2: %d" , top.regFile.registers_i[20], " The correct value is 10");		
		$display("$s3: %d" , top.regFile.registers_i[21], " The correct value is 3");		
		$display("$s4: %d" , top.regFile.registers_i[22], " The correct value is 2");
		$display("$s5: %d" , top.regFile.registers_i[23], " The correct value is 10");
		$display("$s6: %d" , top.regFile.registers_i[24], " The correct value is 11");
		
		
		end
		
		
	cycle = cycle + 1;
		
	end
endmodule
//module tst_6; 
//	reg [31:0]PC_VALUE_;		  
//	reg [31:0] cycle;
//	Top top(PC_VALUE_);
//	initial begin
//		PC_VALUE_ <= 600;	  
//		cycle <= 1;
//	end				   
//	always @(posedge top.clk) begin	
//if (cycle== 9)	
//begin
//		$display("cycle: %d" , cycle);
//		$display("PC: %d",top.program_counter);				   
//		$display("ALUOut_EXEC: %d" , top.ALUOut_EXEC);
//		$display("$s1: %d" , top.regFile.registers_i[19], " The correct value is 15");
//		$display("$s2: %d" , top.regFile.registers_i[20], " The correct value is 10");		
//		$display("$s3: %d" , top.regFile.registers_i[21], " The correct value is 3");		
//		$display("$s4: %d" , top.regFile.registers_i[22], " The correct value is 25");
//		$display("$s5: %d" , top.regFile.registers_i[23], " The correct value is 28");
//				
//		end
//		cycle = cycle + 1;
//	end
//endmodule
