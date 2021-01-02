module ALU (EXE_Result, EXE_Zero, Overflow, Op1, Op2, operation, shamt);

// input
	input [31:0] Op1, Op2;
	input [3:0] operation;
	input [4:0] shamt;
	//input clk;
	
// output
	output reg [31:0] EXE_Result;
	output reg EXE_Zero, Overflow;
	
// cases

	always @ (*) begin
		case (operation)

			// no Operation 
			default:
				begin
						EXE_Result <= 0;
						EXE_Zero <= 0;
						Overflow <= 0;
					end
				
			//shift lift 16 for Op2
			4'hb:
				begin
					EXE_Result <= Op2 << 16;
					EXE_Zero <= 0;
					Overflow <= 0;
				end
				
			//Or 
			4'h3:
				begin
					EXE_Result[31] <= Op1[31] || Op2[31];
					EXE_Result[30] <= Op1[30] || Op2[30];
					EXE_Result[29] <= Op1[29] || Op2[29];
					EXE_Result[28] <= Op1[28] || Op2[28];
					EXE_Result[27] <= Op1[27] || Op2[27];
					EXE_Result[26] <= Op1[26] || Op2[26];
				   EXE_Result[25] <= Op1[25] || Op2[25];
					EXE_Result[24] <= Op1[24] || Op2[24];
					EXE_Result[23] <= Op1[23] || Op2[23];
					EXE_Result[22] <= Op1[22] || Op2[22];
					EXE_Result[21] <= Op1[21] || Op2[21];
					EXE_Result[20] <= Op1[20] || Op2[20];
					EXE_Result[19] <= Op1[19] || Op2[19];
					EXE_Result[18] <= Op1[18] || Op2[18];
					EXE_Result[17] <= Op1[17] || Op2[17];
					EXE_Result[16] <= Op1[16] || Op2[16];
					EXE_Result[15] <= Op1[15] || Op2[15];
					EXE_Result[14] <= Op1[14] || Op2[14];
					EXE_Result[13] <= Op1[13] || Op2[13];
					EXE_Result[12] <= Op1[12] || Op2[12];
					EXE_Result[11] <= Op1[11] || Op2[11];
					EXE_Result[10] <= Op1[10] || Op2[10];
					EXE_Result[9] <= Op1[9] || Op2[9];
					EXE_Result[8] <= Op1[8] || Op2[8];
					EXE_Result[7] <= Op1[7] || Op2[7];
					EXE_Result[6] <= Op1[6] || Op2[6];
					EXE_Result[5] <= Op1[5] || Op2[5];
					EXE_Result[4] <= Op1[4] || Op2[4];
					EXE_Result[3] <= Op1[3] || Op2[3];
					EXE_Result[2] <= Op1[2] || Op2[2];
					EXE_Result[1] <= Op1[1] || Op2[1];
					EXE_Result[0] <= Op1[0] || Op2[0];
					EXE_Zero <= 0;
					Overflow <= 0;
				end
				
			//signed addition
			4'h4:
				begin
					EXE_Result <= Op1 + Op2;
					EXE_Zero <= 0;
				   // To detect overflow
					if (Op1[31] == Op2[31] && EXE_Result[31] == Op1[31]) 
							Overflow <= 0;
							
					else Overflow <= 1;
				end
				
			//and 
			4'h5:
				begin
					EXE_Result[31] <= Op1[31] && Op2[31];
					EXE_Result[30] <= Op1[30] && Op2[30];
					EXE_Result[29] <= Op1[29] && Op2[29];
					EXE_Result[28] <= Op1[28] && Op2[28];
					EXE_Result[27] <= Op1[27] && Op2[27];
					EXE_Result[26] <= Op1[26] && Op2[26];
				   EXE_Result[25] <= Op1[25] && Op2[25];
					EXE_Result[24] <= Op1[24] && Op2[24];
					EXE_Result[23] <= Op1[23] && Op2[23];
					EXE_Result[22] <= Op1[22] && Op2[22];
					EXE_Result[21] <= Op1[21] && Op2[21];
					EXE_Result[20] <= Op1[20] && Op2[20];
					EXE_Result[19] <= Op1[19] && Op2[19];
					EXE_Result[18] <= Op1[18] && Op2[18];
					EXE_Result[17] <= Op1[17] && Op2[17];
					EXE_Result[16] <= Op1[16] && Op2[16];
					EXE_Result[15] <= Op1[15] && Op2[15];
					EXE_Result[14] <= Op1[14] && Op2[14];
					EXE_Result[13] <= Op1[13] && Op2[13];
					EXE_Result[12] <= Op1[12] && Op2[12];
					EXE_Result[11] <= Op1[11] && Op2[11];
					EXE_Result[10] <= Op1[10] && Op2[10];
					EXE_Result[9] <= Op1[9] && Op2[9];
					EXE_Result[8] <= Op1[8] && Op2[8];
					EXE_Result[7] <= Op1[7] && Op2[7];
					EXE_Result[6] <= Op1[6] && Op2[6];
					EXE_Result[5] <= Op1[5] && Op2[5];
					EXE_Result[4] <= Op1[4] && Op2[4];
					EXE_Result[3] <= Op1[3] && Op2[3];
					EXE_Result[2] <= Op1[2] && Op2[2];
					EXE_Result[1] <= Op1[1] && Op2[1];
					EXE_Result[0] <= Op1[0] && Op2[0];
					EXE_Zero <= 0;
					Overflow <= 0;
				end				
				
			//Signed Subtract
			4'h7:
				begin
					EXE_Result <= Op2 - Op1;
					
					//to detect overflow
					if(Op2[31] != Op1[31] && EXE_Result[31]== Op1[31])
						Overflow <= 1;
						
					else 
						Overflow <= 0;
					
					//to detect the EXE_Zero bit
					if(EXE_Result == 32'h0 && Overflow == 0)
						EXE_Zero <= 1;
						
					else 
						EXE_Zero <= 0;
					
				end
				
			//Shift lift 
			4'h8:
				begin
					EXE_Result <= Op2 << shamt;
					EXE_Zero <= 0;
					Overflow <= 0;
				end
			
			//Shift right
			4'h9:
				begin
					EXE_Result <= Op2 >> shamt;
					EXE_Zero <= 0;
					Overflow <=0;
				end
				
			//Set less than
			4'hc:
				begin
					if($signed (Op1) < $signed (Op2)) EXE_Result <= 1;
					else EXE_Result <= 0; 
					EXE_Zero <= 0;
					Overflow <=0;
				end
				
			//Set less than unsigned
			4'hd:
				begin
					if( Op1 < Op2) EXE_Result <= 1;
					else EXE_Result <= 0;
					EXE_Zero <= 0;
					Overflow <=0;
				end
				
			//Nor
			4'he:
				begin
					EXE_Result <= ~(Op1 | Op2);
					EXE_Zero <= 0;
					Overflow <=0;
				end
				
			//Passing rt for Jr
			4'hf:
				begin
					EXE_Result <= Op2;
					EXE_Zero <= 0;
					Overflow <=0;
				end
							
		endcase
		
	end
		
endmodule
