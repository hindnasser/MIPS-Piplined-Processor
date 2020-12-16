module Top (PC_value);

// input
	input [31:0] PC_value;
   
// clock
	wire clk;
	clock c(clk);
	
// IF Stage
	wire [31:0] instruction, PCplus4, PCplus4OutIF, instructionOut;

	PCAdder pc1 (PCplus4, PC_value, 4);
	instructionMemory imem (instruction, PC_value);
	
// IF_ID_Register
	IF_ID_Register ifidr (instructionOut, PCplus4OutIF, instruction, clk, PCplus4); 
	
// ID Stage
	wire [31:0] Address, SignedImmediate, UnsignedImmediate, ShiftedLeft2, ReadData1, ReadData2, WriteData, 
					PCplus4OutID, ReadReg1Out, ReadReg2Out, SignExtendedValueOut,reg1,reg2,reg3;
					
	wire RegDst, RegWrite, MemtoReg, Jump, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUop, ALUSrc, floatop, Issigned, MemtoRegOut,
		  RegDstOut, RegWriteOut, JmpandLinkOut, MemReadOut, MemWriteOut, BranchEqualOut, BranchnotEqualOut;
		  
	wire [5:0] func;
	
	ControlUnit cu (RegDst, RegWrite, MemtoReg, Jump, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUop, ALUSrc, floatop, Issigned, instructionOut[31:26]);
	SignExtension se (SignedImmediate, instruction[15:0]);
	ZeroExtension ze (UnsignedImmediate, instruction[15:0]);
	ShiftLeft2 sl (ShiftedLeft2, SignedImmediate);
	AddressAdder aa (Address, PCplus4, ShiftedLeft2);
	wire [31:0] Result;
	assign WriteData = Result;
	regFile rf (reg1,reg2,reg3,ReadData1, ReadData2, clk, instructionOut[25:21], instructionOut[20:16], 5'h6, WriteData, RegWrite);//here
	//Branch address adder
	// sign extension
	//zero extensoin
	//register file
	// floating register file
	//controlunit
	
// ID_EXE_Register
	ID_EXE_Register idexer (func, PCplus4OutID, ReadReg1Out, ReadReg2Out, SignExtendedValueOut, RegDstOut, RegWriteOut, MemtoRegOut, 
                        JmpandLinkOut, MemReadOut, MemWriteOut, BranchEqualOut, BranchnotEqualOut, 0, instructionOut[5:0], PCplus4OutIF, 
								instructionOut[25:21], instructionOut[20:16], SignedImmediate, RegDst, RegWrite, MemtoReg, JmpandLink, MemRead, 
								MemWrite, BranchEqual, BranchnotEqual, clk);
								
// EXE Stage
	
	wire Zero, Overflow;
	ALU alu (Result, Zero, Overflow, ReadData1, ReadData2, 4, 5'b0, clk);//here
	
// EXE_MEM_Register


// MEM Stage

// WB Stage
	
endmodule

module test;
	reg [31:0]PC_VALUE_;		  
	reg [31:0] cycle;
	Top top(PC_VALUE_);
	initial begin
		PC_VALUE_ <= 108;	  
		cycle <= 1;
	end				   
	always @(posedge top.clk) begin	
	
	if (cycle == 5)
	begin
		$display("cycle: %d" , cycle);
		$display("PC: %d",top.PCplus4);				   
		$display("ALUOut_EXEC: %d" , top.Result);
		$display("R[S0]: %d" , top.reg1, " The correct value is 4");
		$display("R[S1]: %d" , top.reg2, " The correct value is 8");		
		$display("R[S2]: %d" , top.reg3, " The correct value is 12");		
//		$display("R[S3]: %d" , top.regFile.registers_i[3], " The correct value is 16");
//		$display("R[S4]: %d" , top.regFile.registers_i[4], " The correct value is 20");
//		$display("R[S5]: %d" , top.regFile.registers_i[5], " The correct value is 24");
//		$display("R[S6]: %d" , top.regFile.registers_i[6], " The correct value is 28");
//		$display("R[S7]: %d" , top.regFile.registers_i[7], " The correct value is 32");
//		$display("R[S8]: %d" , top.regFile.registers_i[8], " The correct value is 36");
//		$display("R[S9]: %d" , top.regFile.registers_i[9], " The correct value is 40");
	
		
		
		end
		
		
	cycle = cycle + 1;
		
	end
endmodule
