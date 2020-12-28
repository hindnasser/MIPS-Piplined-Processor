//Add the floating point controls

module ControlUnit (RegDst, RegWrite, MemtoReg, Jump, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUop, ALUSrc, floatop, Issigned, OpCode);
//input
	input [5:0] OpCode;
	
//output	
	output reg RegDst, RegWrite, MemtoReg, Jump, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUSrc, floatop, Issigned;
	output reg [3:0] ALUop;

	
//check for the opCode in the instruction and assign the control signals
	always @ (OpCode) begin
		case(OpCode)
		
		default:
			begin
				RegDst <= 0; 
				RegWrite <= 0;
				MemtoReg <= 0;
				Jump <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 0;
				Issigned <= 0;
				ALUop <= 4'h0;
			end
			
		//Flush
		6'h0:
			begin
			   RegDst <= 0; 
				RegWrite <= 0;
				MemtoReg <= 0;
				Jump <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 0;
				Issigned <= 0;
				ALUop <= 4'h0;
			end
			
		//load word
		6'h12:
			begin
			   RegDst <= 0; 
				RegWrite <= 1;
				MemtoReg <= 1;
				Jump <= 0;
				JmpandLink <= 0;
				MemRead <= 1;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 1;
				Issigned <= 1;
				ALUop <= 4'h4;
			end
			
		//Load Upper Immediate
		6'hf:
			begin
				RegDst <= 0; 
				RegWrite <= 1;
				MemtoReg <= 0;
				Jump <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 1; //extended
				Issigned <= 0;
				ALUop <= 4'b1011; //sll 16 for op2 
			end
			
		//Load Byte Unsigned
		6'h22:
			begin
				RegDst <= 0; 
				RegWrite <= 1;
				MemtoReg <= 1;
				Jump <= 0;
				JmpandLink <= 0;
				MemRead <= 1;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 1;
				Issigned <= 1;
				ALUop <= 4'h4;
			end
			
		//Store Byte
		6'h28:
			begin
				RegDst <= 0; 
				RegWrite <= 0;
				MemtoReg <= 0;
				Jump <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 1;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 1;
				Issigned <= 1;
				ALUop <= 4'h4;
			end
				
		//store word
		6'h2b:
			begin
				RegDst <= 0; 
				RegWrite <= 0;
				MemtoReg <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 1;
				BranchEqual <=0;
				BranchnotEqual <= 0;
				ALUSrc <= 1;
				Issigned <= 1;
				ALUop <= 4'h4;
			end
			
		//R instructions
		6'h3:
			begin
				RegDst <= 1; 
				RegWrite <= 1;
				MemtoReg <= 0;
				Jump <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 0;
				Issigned <= 0;
				ALUop <= 4'h2;
			end
			
		//addi
		6'h9:
			begin
				RegDst <= 0; 
				RegWrite <= 1;
				MemtoReg <= 0;
				Jump <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 1;
				Issigned <= 0;
				ALUop <= 4'h4;
			end
		
//		//addiu
//		6'h8:
//			begin
//				RegDst <= 0; 
//				RegWrite <= 1;
//				MemtoReg <= 0;
//				Jump <= 0;
//				JmpandLink <= 0;
//				MemRead <= 0;
//				MemWrite <= 0;
//				BranchEqual <= 0;
//				BranchnotEqual <= 0;
//				ALUSrc <= 1;
//				Issigned <= 0;
//				ALUop <= 4'h0;
//			end

		//andi
		6'hc:
			begin
				RegDst <= 0; 
				RegWrite <= 1;
				MemtoReg <= 0;
				Jump <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 1;
				Issigned <= 0;
				ALUop <= 4'h5;
			end
		
		//branch on equal
		6'h5:
			begin
				RegDst <= 0; 
				RegWrite <= 0;
				MemtoReg <= 0;
				Jump <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 1;
				BranchnotEqual <= 0;
				ALUSrc <= 0;
				Issigned <= 0;
				ALUop <= 4'h7; // signed sub
			end
			
		//Branch Not Equal
		6'h4:
			begin
				RegDst <= 0; 
				RegWrite <= 0;
				MemtoReg <= 0;
				Jump <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 1;
				ALUSrc <= 0;
				Issigned <= 0;
				ALUop <= 4'h7;
			end
			
		//Jump and Link
		6'h7:
			begin
				RegDst <= 0; 
				RegWrite <= 0;
				MemtoReg <= 0;
				Jump <= 0;
				JmpandLink <= 1;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 0;
				Issigned <= 0;
				ALUop <= 4'h4;
			end
				
		//Jump
		6'h2:
			begin
				RegDst <= 0; 
				RegWrite <= 0;
				MemtoReg <= 0;
				Jump <= 1;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 0;
				Issigned <= 0;
				ALUop <= 4'h4;
			end
				
		//Or immediate
		6'he:
			begin
				RegDst <= 0; 
				RegWrite <= 1;
				MemtoReg <= 0;
				Jump <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 1;
				Issigned <= 0;
				ALUop <= 4'h3;
			end
			
		endcase end
endmodule
