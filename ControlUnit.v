module ControlUnit (RegDst, RegWrite, MemtoReg, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUop, ALUSrc, OpCode);
//input
	input [5:0] OpCode;

//output	
	output reg RegDst, RegWrite, MemtoReg, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUSrc;
	output reg[3:0] ALUop;

//check for the opCode in the instruction and assign the control signals
	always @ (*) begin
		case(OpCode)
		
		//Flush
		6'h0:
			begin
			   RegDst <= 0; 
				RegWrite <= 0;
				MemtoReg <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 0;
				ALUop <= 4'h0;
			end
			
		//load 
		6'h12:
			begin
			   RegDst <= 0; 
				RegWrite <= 1;
				MemtoReg <= 1;
				JmpandLink <= 0;
				MemRead <= 1;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 1;
				ALUop <= 4'h0;
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
				ALUop <= 4'h0;
			end
			
		//R instructions
		6'h3:
			begin
				RegDst <= 1; 
				RegWrite <= 1;
				MemtoReg <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 0;
				ALUop <= 4'h2;
			end
			
		//addi
		6'h9:
			begin
				RegDst <= 0; 
				RegWrite <= 1;
				MemtoReg <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 1;
				ALUop <= 4'h0;
			end
		
		//addu
		6'h8:
			begin
				RegDst <= 0; 
				RegWrite <= 1;
				MemtoReg <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 1;
				ALUop <= 4'h1;
			end

		//andi
		6'hc:
			begin
				RegDst <= 0; 
				RegWrite <= 1;
				MemtoReg <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 0;
				ALUSrc <= 0;
				ALUop <= 4'h3;
			end
		
		//branch on equal
		6'h5:
			begin
				RegDst <= 0; 
				RegWrite <= 0;
				MemtoReg <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 1;
				BranchnotEqual <= 0;
				ALUSrc <= 0;
				ALUop <= 4'h4;
			end
			
		//Branch Not Equal
		6'h4:
			begin
				RegDst <= 0; 
				RegWrite <= 0;
				MemtoReg <= 0;
				JmpandLink <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				BranchEqual <= 0;
				BranchnotEqual <= 1;
				ALUSrc <= 0;
				ALUop <= 4'h5;
			end
		endcase
		end
endmodule
