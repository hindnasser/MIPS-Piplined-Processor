module PC_Reg (PC, PCSrc, clk);

// input
	input [31:0] PCSrc;
	input clk;
	
	
// output
	output reg [31:0] PC;
	
	always @(posedge clk)

		PC <= PCSrc;
	
endmodule
