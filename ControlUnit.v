module ControlUnit (FPLoadStore, Byte, RegDst, RegWrite, MemtoReg, Jump, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, BranchFPTrue, BranchFPFalse, ALUop, ALUSrc,
						  floatop, Issigned, double, OpCode, Stall, fmt, ft);
						  						  
// input
	input [5:0] OpCode;
	input Stall;
	input [4:0] fmt, ft;
	
// output	
	output reg RegDst, RegWrite, MemtoReg, Jump, JmpandLink, MemRead, MemWrite, BranchEqual, BranchnotEqual, ALUSrc, floatop, Issigned, double,
				  Byte, BranchFPFalse, BranchFPTrue, FPLoadStore;
	output reg [3:0] ALUop;

	initial 
		begin
			FPLoadStore <= 0;
			BranchFPFalse <= 0;
			BranchFPTrue <= 0;
			floatop <= 0;
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
			Byte <= 0;
			double <= 0;
			ALUop <= 4'h0;
		end
	
//check for the opCode in the instruction and assign the control signals
	always @ (*) begin
	
		if(Stall == 1)
			begin
				FPLoadStore <= 0;
				BranchFPFalse <= 0;
				BranchFPTrue <= 0;
				floatop <= 0;
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
				Byte <= 0;
				double <= 0;
				ALUop <= 4'h0;
			end
			
		else
			begin
				case(OpCode)
				
				default:
					begin
						floatop <= 0;
						RegDst <= 0; 
						double <= 0;
						RegWrite <= 0;
						FPLoadStore <= 0;
						MemtoReg <= 0;
						Jump <= 0;
						JmpandLink <= 0;
						MemRead <= 0;
						MemWrite <= 0;
						BranchEqual <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 0;
						Issigned <= 0;
						Byte <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'h0;
					end
					
				//load word
				6'h12:
					begin
						RegDst <= 0; 
						RegWrite <= 1;
						FPLoadStore <= 0;
						double <= 0;
						MemtoReg <= 1;
						Jump <= 0;
						JmpandLink <= 0;
						MemRead <= 1;
						MemWrite <= 0;
						BranchEqual <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 1;
						Issigned <= 1;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'h4;
					end
					
				//Load Upper Immediate
				6'hf:
					begin
						RegDst <= 0; 
						RegWrite <= 1;
						double <= 0;
						MemtoReg <= 0;
						Jump <= 0;
						JmpandLink <= 0;
						FPLoadStore <= 0;
						MemRead <= 0;
						MemWrite <= 0;
						BranchEqual <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 1; //extended imm
						Issigned <= 1;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'hb; //sll 16 for op2 
					end
					
				//Load Byte Unsigned
				6'h22:
					begin
						RegDst <= 0; 
						RegWrite <= 1;
						MemtoReg <= 1;
						Jump <= 0;
						JmpandLink <= 0;
						FPLoadStore <= 0;
						double <= 0;
						MemRead <= 1;
						MemWrite <= 0;
						BranchEqual <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 1;
						Issigned <= 1;
						Byte <= 1;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
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
						double <= 0;
						FPLoadStore <= 0;
						MemRead <= 0;
						MemWrite <= 1;
						BranchEqual <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 1;
						Issigned <= 1;
						Byte <= 1;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'h4;
					end
						
				//store word
				6'h2b:
					begin
						RegDst <= 0; 
						RegWrite <= 0;
						MemtoReg <= 0;
						Jump <= 0;
						JmpandLink <= 0;
						FPLoadStore <= 0;
						MemRead <= 0;
						MemWrite <= 1;
						BranchEqual <=0;
						double <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 1;
						Issigned <= 1;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
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
						FPLoadStore <= 0;
						MemRead <= 0;
						MemWrite <= 0;
						BranchEqual <= 0;
						double <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 0;
						Issigned <= 0;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
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
						FPLoadStore <= 0;
						double <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 1;
						Issigned <= 0;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'h4;
					end

				//andi
				6'hc:
					begin
						RegDst <= 0; 
						RegWrite <= 1;
						MemtoReg <= 0;
						Jump <= 0;
						JmpandLink <= 0;
						FPLoadStore <= 0;
						MemRead <= 0;
						MemWrite <= 0;
						BranchEqual <= 0;
						double <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 1;
						Issigned <= 0;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
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
						FPLoadStore <= 0;
						MemRead <= 0;
						MemWrite <= 0;
						double <= 0;
						BranchEqual <= 1;
						BranchnotEqual <= 0;
						ALUSrc <= 0;
						Issigned <= 1;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'h7; 
					end
					
				//Branch Not Equal
				6'h4:
					begin
						RegDst <= 0; 
						RegWrite <= 0;
						MemtoReg <= 0;
						FPLoadStore <= 0;
						Jump <= 0;
						JmpandLink <= 0;
						double <= 0;
						MemRead <= 0;
						MemWrite <= 0;
						BranchEqual <= 0;
						BranchnotEqual <= 1;
						ALUSrc <= 0;
						Issigned <= 1;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'h7;
					end
					
				//Jump and Link
				6'h7:
					begin
						RegDst <= 0; 
						RegWrite <= 1;
						MemtoReg <= 0;
						Jump <= 0;
						JmpandLink <= 1;
						FPLoadStore <= 0;
						MemRead <= 0;
						MemWrite <= 0;
						BranchEqual <= 0;
						double <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 0;
						Issigned <= 0;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'ha;
					end
						
				//Jump
				6'h2:
					begin
						RegDst <= 0; 
						RegWrite <= 0;
						MemtoReg <= 0;
						Jump <= 1;
						JmpandLink <= 0;
						FPLoadStore <= 0;
						MemRead <= 0;
						MemWrite <= 0;
						BranchEqual <= 0;
						double <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 0;
						Issigned <= 0;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'h0;
					end
						
				//Or immediate
				6'he:
					begin
						RegDst <= 0; 
						RegWrite <= 1;
						MemtoReg <= 0;
						Jump <= 0;
						JmpandLink <= 0;
						FPLoadStore <= 0;
						MemRead <= 0;
						MemWrite <= 0;
						BranchEqual <= 0;
						double <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 1;
						Issigned <= 0;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'h3;
					end
					
				// FR and FI instructions
				6'h11:
					begin
						case(fmt)
							default:
								begin
									floatop <= 0;
									RegDst <= 0; 
									RegWrite <= 0;
									MemtoReg <= 0;
									Jump <= 0;
									JmpandLink <= 0;
									FPLoadStore <= 0;
									MemRead <= 0;
									MemWrite <= 0;
									BranchEqual <= 0;
									BranchnotEqual <= 0;
									ALUSrc <= 0;
									Issigned <= 0;
									Byte <= 0;
									BranchFPFalse <= 0;
									BranchFPTrue <= 0;
									double <= 0;
									ALUop <= 4'h0;
								end
								
							// compare and add single
							5'h10:
								begin
									floatop <= 1;
									RegDst <= 1; 
									RegWrite <= 0;
									MemtoReg <= 0;
									FPLoadStore <= 0;
									Jump <= 0;
									JmpandLink <= 0;
									MemRead <= 0;
									MemWrite <= 0;
									BranchEqual <= 0;
									BranchnotEqual <= 0;
									ALUSrc <= 0;
									Issigned <= 0;
									Byte <= 0;
									BranchFPFalse <= 0;
									BranchFPTrue <= 0;
									double <= 0;
									ALUop <= 4'h2;
								end
									
							// compare and add double
							5'h11:
								begin
									floatop <= 1;
									RegDst <= 1; 
									RegWrite <= 0;
									MemtoReg <= 0;
									FPLoadStore <= 0;
									Jump <= 0;
									JmpandLink <= 0;
									MemRead <= 0;
									MemWrite <= 0;
									BranchEqual <= 0;
									BranchnotEqual <= 0;
									ALUSrc <= 0;
									Issigned <= 0;
									Byte <= 0;
									BranchFPFalse <= 0;
									BranchFPTrue <= 0;
									double <= 1;
									ALUop <= 4'h2;
								end
								
							//Branch FP on True and False
							5'h8:
								if(ft) // Branch on true
									begin
										RegDst <= 0; 
										RegWrite <= 0;
										MemtoReg <= 0;
										Jump <= 0;
										JmpandLink <= 0;
										FPLoadStore <= 0;
										MemRead <= 0;
										MemWrite <= 0;
										double <= 0;
										BranchEqual <= 0;
										BranchnotEqual <= 0;
										ALUSrc <= 0;
										Issigned <= 1;
										Byte <= 0;
										floatop <= 0;
										BranchFPFalse <= 0;
										BranchFPTrue <= 1;
										ALUop <= 4'h7; 
									end
									
								else // Branch on false
									begin
										RegDst <= 0; 
										RegWrite <= 0;
										MemtoReg <= 0;
										Jump <= 0;
										JmpandLink <= 0;
										FPLoadStore <= 0;
										MemRead <= 0;
										MemWrite <= 0;
										double <= 0;
										BranchEqual <= 0;
										BranchnotEqual <= 0;
										ALUSrc <= 0;
										Issigned <= 1;
										Byte <= 0;
										floatop <= 0;
										BranchFPFalse <= 1;
										BranchFPTrue <= 0;
										ALUop <= 4'h7; 
									end
						endcase
					end
					
				// FP load single
				6'h31:
					begin
						floatop <= 1;
						RegDst <= 0; 
						RegWrite <= 1;
						MemtoReg <= 1;
						Jump <= 0;
						double <= 0;
						FPLoadStore <= 1;
						JmpandLink <= 0;
						MemRead <= 1;
						MemWrite <= 0;
						BranchEqual <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 1;
						Issigned <= 1;
						Byte <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'h4;
					end
					
				// FP load double
				6'h35:
					begin
						floatop <= 1;
						RegDst <= 0; 
						RegWrite <= 1;
						MemtoReg <= 1;
						Jump <= 0;
						double <= 1;
						JmpandLink <= 0;
						FPLoadStore <= 1;
						MemRead <= 1;
						MemWrite <= 0;
						BranchEqual <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 1;
						Issigned <= 1;
						Byte <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'h4;
					end
					
				// FP store single 
				6'h39:
					begin
						RegDst <= 0; 
						RegWrite <= 0;
						MemtoReg <= 0;
						FPLoadStore <= 1;
						Jump <= 0;
						JmpandLink <= 0;
						MemRead <= 0;
						MemWrite <= 1;
						BranchEqual <=0;
						double <= 0;
						BranchnotEqual <= 0;
						ALUSrc <= 1;
						Issigned <= 1;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'h4;
					end
				
				// FP store double 
				6'h3d:
					begin
						RegDst <= 0; 
						RegWrite <= 0;
						MemtoReg <= 0;
						Jump <= 0;
						JmpandLink <= 0;
						FPLoadStore <= 1;
						MemRead <= 0;
						MemWrite <= 1;
						BranchEqual <=0;
						double <= 1;
						BranchnotEqual <= 0;
						ALUSrc <= 1;
						Issigned <= 1;
						Byte <= 0;
						floatop <= 0;
						BranchFPFalse <= 0;
						BranchFPTrue <= 0;
						ALUop <= 4'h4;
					end
				
					
				endcase 
			end
		end
endmodule
