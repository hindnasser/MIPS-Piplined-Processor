module ALUcontrol (operation, opcode, funct);

// input 
	input [5:0] funct;
	input [3:0] opcode;
	
// output
	output reg [3:0] operation;
	
	always @(*)
		begin
			case(opcode)
			default:
				operation <= 0;
			
			4'h4:
				operation <= 4'h4;
			
			4'h2:
				begin
					case(funct)
					
						6'h20:
							operation <=4'h4;
						6'h24:
							operation <=4'h7;
						6'h25:
							operation <=4'h3;
						6'h14:
							operation <= 4'h5;
							endcase
		
		end
		endcase
		end
			
endmodule
