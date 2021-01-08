module ALUcontrol ( EXE_R_memtoReg, EXE_ReadfromMem, EXE_WritetoMem, operation, opcode, funct);

// input 
	input [5:0] funct;
	input [3:0] opcode; 
	
// output
	output reg [4:0] operation;
	output reg EXE_ReadfromMem, EXE_WritetoMem, EXE_R_memtoReg;
	
	always @(*)
		begin
			case(opcode)
			default:
				begin
					operation <= 0;
					EXE_ReadfromMem <= 0;
					EXE_WritetoMem <= 0;
					EXE_R_memtoReg <= 0;
				end
				
			// Jump and Link
			4'h7:
				begin
					operation <= 5'h16;
					EXE_ReadfromMem <= 0;
					EXE_WritetoMem <= 0;
					EXE_R_memtoReg <= 0;
				end
				
			// load upper Imm.
			4'hb:
				begin
					operation <= 5'h1;
					EXE_ReadfromMem <= 0;
					EXE_WritetoMem <= 0;
					EXE_R_memtoReg <= 0;
				end
				
			// load word, load byte unsigned, store byte, store word, addi
			4'h4:
				begin
					operation <= 5'h3;
					EXE_ReadfromMem <= 0;
					EXE_WritetoMem <= 0;
					EXE_R_memtoReg <= 0;
				end
				
			// andi
			4'h5:
				begin
					operation <= 5'h4;
					EXE_ReadfromMem <= 0;
					EXE_WritetoMem <= 0;
					EXE_R_memtoReg <= 0;
				end
				
			// beq, bnq 
			4'h7:
				begin
					operation <= 5'h5;
					EXE_ReadfromMem <= 0;
					EXE_WritetoMem <= 0;
					EXE_R_memtoReg <= 0;
				end
				
			// Ori
			4'h3:
				begin
					operation <= 5'h2;
					EXE_ReadfromMem <= 0;
					EXE_WritetoMem <= 0;
					EXE_R_memtoReg <= 0;
				end
				
			4'h2:
				begin
					case(funct)
						default:
							begin
								operation <= 0;
								EXE_ReadfromMem <= 0;
								EXE_WritetoMem <= 0;
								EXE_R_memtoReg <= 0;
							end
						
						// add
						6'h20:
							begin
								operation <=5'h3;
								EXE_ReadfromMem <= 0;
								EXE_WritetoMem <= 0;
								EXE_R_memtoReg <= 0;
							end
							
						// sub
						6'h24:
							begin
								operation <=5'h5;
								EXE_ReadfromMem <= 0;
								EXE_WritetoMem <= 0;
								EXE_R_memtoReg <= 0;
							end
							
						// Or
						6'h25:
							begin
								operation <=5'h2;
								EXE_ReadfromMem <= 0;
								EXE_WritetoMem <= 0;
								EXE_R_memtoReg <= 0;
							end
							
						// and
						6'h14:
							begin
								operation <= 5'h4;
								EXE_ReadfromMem <= 0;
								EXE_WritetoMem <= 0;
								EXE_R_memtoReg <= 0;
							end
							
						// jr
						6'h8:
							begin
								EXE_ReadfromMem <= 0;
								EXE_WritetoMem <= 0;
								operation <= 5'hb;
								EXE_R_memtoReg <= 0;
							end
						
						// load new word
						6'h21:
							begin
								operation <= 5'h3;
								EXE_ReadfromMem <= 1;
								EXE_WritetoMem <= 0;
								EXE_R_memtoReg <= 1;
							end
						
						// Nor	
						6'h27:
							begin
								operation <= 5'ha;
								EXE_ReadfromMem <= 0;
								EXE_WritetoMem <= 0;
								EXE_R_memtoReg <= 0;
							end
							
						// set less than
						6'h2a:
							begin
								EXE_ReadfromMem <= 0;
								EXE_WritetoMem <= 0;
								operation <= 5'h8;
								EXE_R_memtoReg <= 0;
							end
							
						// set less than unsigned
						6'h2b:
							begin
								operation <= 5'h9;
								EXE_ReadfromMem <= 0;
								EXE_WritetoMem <= 0;
								EXE_R_memtoReg <= 0;
							end
							
						// Shift left 
						6'h00:
							begin
								operation <= 5'h6;
								EXE_ReadfromMem <= 0;
								EXE_WritetoMem <= 0;
								EXE_R_memtoReg <= 0;
							end
						
						//Shift right
						6'h02:
							begin
								operation <= 5'h7;
								EXE_ReadfromMem <= 0;
								EXE_WritetoMem <= 0;
								EXE_R_memtoReg <= 0;
							end
							
						// store word new
						6'h13:
							begin
								operation <= 5'h3;
								EXE_ReadfromMem <= 0;
								EXE_WritetoMem <= 1;
								EXE_R_memtoReg <= 0;
							end						
					endcase
			end
		endcase
		end		
endmodule
