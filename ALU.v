module ALU (EXE_Result, EXE_Zero, Overflow, Op1, Op2, operation, shamt);

// input
	input [63:0] Op1, Op2;
	input [3:0] operation;
	input [4:0] shamt;
	//input clk;
	
// output
	output reg [63:0] EXE_Result;
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
				
			//shift left 16 for Op2
			4'hb:
				begin
					EXE_Result <= Op2 << 16;
					EXE_Zero <= 0;
					Overflow <= 0;
				end
				
			//Or 
			4'h3:
				begin
					EXE_Result <= Op1 | Op2;
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
					EXE_Result <= Op1 & Op2;
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
				
			//Shift left 
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
