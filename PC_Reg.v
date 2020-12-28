module PC_Reg (PC, PCSrc);

// input
	input [31:0] PCSrc;
	
	
// output
	output reg [31:0] PC;
	
	always @(*)

		PC = PCSrc;
	
endmodule
