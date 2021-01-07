module ALUcontrol (operation, opcode, funct);

// input 
	input [5:0] funct;
	input [3:0] opcode;
	
// output
	output reg [4:0] operation;
	
	always @(*)
		begin
			case(opcode)
			default:
				operation <= 0;
			
			// load upper Imm.
			4'hb:
				operation <= 5'h1;
				
			// load word, load byte unsigned, store byte, store word, addi
			4'h4:
				operation <= 5'h3;
				
			// andi
			4'h5:
				operation <= 5'h4;
			
			// beq, bnq, 
			4'h7:
				operation <= 5'h5;
			
			// Ori
			4'h3:
				operation <= 5'h2;
			
			4'h2:
				begin
					case(funct)
					
						// add
						6'h20:
							operation <=5'h3;
							
						// sub
						6'h24:
							operation <=5'h5;
						
						// Or
						6'h25:
							operation <=5'h2;
							
						// and
						6'h14:
							operation <= 5'h4;
							
						// jr
						6'h8:
							operation <= 5'hb;
						
						// load new word
						6'h21:
							operation <= 5'h3;
						
						// Nor	
						6'h27:
							operation <= 5'ha;
							
						// set less than
						6'h2a:
							operation <= 5'h8;
							
						// set less than unsigned
						6'h2b:
							operation <= 5'h9;
							
						// Shift left 
						6'h00:
							operation <= 5'h6;
						
						//Shift right
						6'h02:
							operation <= 5'h7;
							
						// store word new
						6'h13:
							operation <= 5'h3;					
						
					endcase
			end
		endcase
		end		
endmodule
