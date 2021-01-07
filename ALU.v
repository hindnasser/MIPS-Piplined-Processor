module ALU (EXE_Result, EXE_Zero, Overflow, Op1, Op2, operation, shamt);

// input
	input [63:0] Op1, Op2;
	//note that Op1 takes : rs
	//	    Op2 takes : immediate , rt
	input [4:0] operation;
	input [4:0] shamt;
	//input clk;
	
// output
	output reg [63:0] EXE_Result;
	output reg EXE_Zero, Overflow;
	
// intermediate stages
	reg [63:0] mantissa1,mantissa2;
  	real first,second;

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
			5'h1:
				begin
					EXE_Result <= Op2 << 16;
					EXE_Zero <= 0;
					Overflow <= 0;
				end
				
			//Or 
			5'h2:
				begin
					EXE_Result <= Op1 | Op2;
					EXE_Zero <= 0;
					Overflow <= 0;
				end
				
			//signed addition
			5'h3:
				begin
					EXE_Result <= Op1 + Op2;
					EXE_Zero <= 0;
				   // To detect overflow
					if (Op1[31] == Op2[31] && EXE_Result[31] == Op1[31]) 
							Overflow <= 0;
							
					else Overflow <= 1;
				end
				
			//and 
			5'h4:
				begin
					EXE_Result <= Op1 & Op2;
					EXE_Zero <= 0;
					Overflow <= 0;
				end				
				
			//Signed Subtract
			5'h5:
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
				
			//Shift left logical
			5'h6:
				begin
					EXE_Result <= Op2 << shamt;
					EXE_Zero <= 0;
					Overflow <= 0;
				end
			
			//Shift right logical
			5'h7:
				begin
					EXE_Result <= Op2 >> shamt;
					EXE_Zero <= 0;
					Overflow <=0;
				end
				
			//Set less than
			5'h8:
				begin
					if($signed (Op1) < $signed (Op2)) EXE_Result <= 1;
					else EXE_Result <= 0; 
					EXE_Zero <= 0;
					Overflow <=0;
				end
				
			//Set less than unsigned
			5'h9:
				begin
					if( Op1 < Op2) EXE_Result <= 1;
					else EXE_Result <= 0;
					EXE_Zero <= 0;
					Overflow <=0;
				end
				
			//Nor
			5'ha:
				begin
					EXE_Result <= ~(Op1 | Op2);
					EXE_Zero <= 0;
					Overflow <=0;
				end
				
			//Passing rt for Jr
			5'hb:
				begin
					EXE_Result <= Op2;
					EXE_Zero <= 0;
					Overflow <=0;
				end
			
			//FP Add single
			5'hc:
				begin
					if(Op1[31]^Op2[31])//different signs
					begin
						if(Op1[30:23] > Op2[30:23])//Op1's exp is larger
						begin
							mantissa1 = {1'b1,Op1[22:0]};
							mantissa2 = {1'b1,Op2[22:0]}>>(Op1[30:23]-Op2[30:23]);
							mantissa1 = mantissa1 - mantissa2;
							EXE_Result[31] = Op1[31];
							EXE_Result[30:23] = Op1[30:23];
							while(!mantissa1[23])
							begin
								mantissa1 = mantissa1<<1;
								EXE_Result[30:23] = EXE_Result[30:23]-1;
							end
							EXE_Result[22:0] <= mantissa1;
						end
						else
						begin
							mantissa1 = {1'b1,Op1[22:0]}>>(Op2[30:23]-Op1[30:23]);
							mantissa2 = {1'b1,Op2[22:0]};
							mantissa1 = mantissa2 - mantissa1;
							EXE_Result[31] = Op2[31];
							EXE_Result[30:23] = Op2[30:23];
							while(!mantissa1[23])
							begin
								mantissa1 = mantissa1<<1;
								EXE_Result[30:23] = EXE_Result[30:23]-1;
							end
							EXE_Result[22:0] <= mantissa1;
						end
					end
					else//same sign
					begin
						if(Op1[30:23] > Op2[30:23])//Op1's exp is larger
						begin 
							mantissa1 = {1'b1,Op1[22:0]};
							mantissa2 = {1'b1,Op2[22:0]}>>(Op1[30:23]-Op2[30:23]);
							mantissa1 = mantissa1 + mantissa2;
							// mantissa1[24] means overflow
							EXE_Result[22:0] <= mantissa1>>mantissa1[24];
							EXE_Result[30:23] <= Op1[30:23]+mantissa1[24];
							EXE_Result[31] <= Op1[31];

						end
						else
						begin
							mantissa1 = {1'b1,Op1[22:0]}>>(Op2[30:23]-Op1[30:23]);
							mantissa2 = {1'b1,Op2[22:0]};
							mantissa1 = mantissa1 + mantissa2;
							// mantissa1[24] means overflow
							EXE_Result[22:0] <= mantissa1>>mantissa1[24];
							EXE_Result[30:23] <= Op2[30:23]+mantissa1[24];
							EXE_Result[31] <= Op1[31];
						end
					end
				end	

			//FP Add double
			5'hd:
				begin
					if(Op1[63]^Op2[63])//different signs
					begin
						if(Op1[63:52] > Op2[63:52])//Op1's exp is larger
						begin
							mantissa1 = {1'b1,Op1[51:0]};
							mantissa2 = {1'b1,Op2[51:0]}>>(Op1[63:52]-Op2[63:52]);
							mantissa1 = mantissa1 - mantissa2;
							EXE_Result[63] = Op1[63];
							EXE_Result[63:52] = Op1[63:52];
							while(!mantissa1[52])
							begin
								mantissa1 = mantissa1<<1;
								EXE_Result[63:52] = EXE_Result[63:52]-1;
							end
							EXE_Result[51:0] <= mantissa1;
						end
						else
						begin
							mantissa1 = {1'b1,Op1[51:0]}>>(Op2[63:52]-Op1[63:52]);
							mantissa2 = {1'b1,Op2[51:0]};
							mantissa1 = mantissa2 - mantissa1;
							EXE_Result[63] = Op2[63];
							EXE_Result[63:52] = Op2[63:52];
							while(!mantissa1[52])
							begin
								mantissa1 = mantissa1<<1;
								EXE_Result[63:52] = EXE_Result[63:52]-1;
							end
							EXE_Result[51:0] <= mantissa1;
						end
					end
					else//same sign
					begin
						if(Op1[63:52] > Op2[63:52])//Op1's exp is larger
						begin 
							mantissa1 = {1'b1,Op1[51:0]};
							mantissa2 = {1'b1,Op2[51:0]}>>(Op1[63:52]-Op2[63:52]);
							mantissa1 = mantissa1 + mantissa2;
							// mantissa1[24] means overflow
							EXE_Result[51:0] <= mantissa1>>mantissa1[24];
							EXE_Result[63:52] <= Op1[63:52]+mantissa1[24];
							EXE_Result[63] <= Op1[63];

						end
						else
						begin
							mantissa1 = {1'b1,Op1[51:0]}>>(Op2[63:52]-Op1[63:52]);
							mantissa2 = {1'b1,Op2[51:0]};
							mantissa1 = mantissa1 + mantissa2;
							// mantissa1[24] means overflow
							EXE_Result[51:0] <= mantissa1>>mantissa1[24];
							EXE_Result[63:52] <= Op2[63:52]+mantissa1[24];
							EXE_Result[63] <= Op1[63];
						end
					end
				end	

			//Shift Right Arith
			5'he:
				begin
					EXE_Result <= Op2 >>> shamt;
					EXE_Zero <= 0;
					Overflow <= 0;
				end

			//Multiply
			5'hf:
				begin
					EXE_Result = Op1[31:0]*Op2[31:0];
					EXE_Zero <= (EXE_Result==0);
					Overflow <= 0;
				end

			//Divide 
			5'h10:
				begin
					EXE_Result[31:0]  = $signed(Op1[31:0])/$signed(Op2[31:0]);
					EXE_Result[63:32] = $signed(Op1[31:0])%$signed(Op2[31:0]);
					EXE_Zero <= (EXE_Result==0);
					Overflow <= 0;
				end
		endcase
		
	end
		
endmodule
