module ALU (Result, Zero, Overflow, Op1, Op2, operation, shamt, clk);

// input
	input [31:0] Op1, Op2;
	input [3:0] operation;
	input [4:0] shamt;
	input clk;
	
// output
	output reg [31:0] Result;
	output reg Zero, Overflow;
	
// cases

	always @ (posedge clk) begin
		case (operation)

			// unsigned addition 
			4'h0:
				begin
					Result <= Op1 + Op2;
					Zero <= 0;
					Overflow <= 0;
				end
				
			//shift lift 16 for Op2
			4'h11:
				begin
					Result <= Op2 << 16;
					Zero <= 0;
					Overflow <= 0;
				end
				
			//Or 
			4'h3:
				begin
					Result <= Op1 | Op2;
					Zero <= 0;
					Overflow <= 0;
				end
				
			//signed addition
			4'h4:
				begin
					Result <= Op1 + Op2;
					Zero <= 0;
				   // To detect overflow
					if (Op1[31] == Op2[31] && Result[31] == Op1[31]) 
							Overflow <= 0;
							
					else Overflow <= 1;
				end
				
			//and 
			4'h5:
				begin
					Result <= Op1 & Op2;
					Zero <= 0;
					Overflow <= 0;
				end
				
			//Unsigned Subtract
			4'h6:
				begin
					Result <= Op2 - Op1;
					//to detect the zero value
					if(Result == 32'h0)
						Zero <= 1;
						
					else Zero <= 0;
					Overflow <= 0;
				end
				
				
			//Signed Subtract
			4'h7:
				begin
					Result <= Op2 - Op1;
					
					//to detect overflow
					if(Op2[31] != Op1[31] && Result[31]== Op1[31])
						Overflow <= 1;
						
					else Overflow <= 0;
					
					//to detect the zero bit
					if(Result == 32'h0 && Overflow == 0)
						Zero <= 1;
						
					else Zero <= 0;
				end
				
			//Shift lift 
			4'h8:
				begin
					Result <= Op2 << shamt;
					Zero <= 0;
					Overflow <= 0;
				end
			
			//Shift right
			4'h9:
				begin
					Result <= Op2 >> shamt;
					Zero <= 0;
					Overflow <=0;
				end
				
			//Set less than
			4'h12:
				begin
					if($signed (Op1) < $signed (Op2)) Result <= 1;
					else Result <= 0; 
					Zero <= 0;
					Overflow <=0;
				end
				
			//Set less than unsigned
			4'h13:
				begin
					if( Op1 < Op2) Result <= 1;
					else Result <= 0;
					Zero <= 0;
					Overflow <=0;
				end
				
			//Nor
			4'h14:
				begin
					Result <= ~(Op1 | Op2);
					Zero <= 0;
					Overflow <=0;
				end
				
			//Passing rt for Jr
			4'h15:
				begin
					Result <= Op2;
					Zero <= 0;
					Overflow <=0;
				end
							
		endcase
		
	end
		
endmodule
