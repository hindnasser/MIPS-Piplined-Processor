module OpSrc_MUX (OpSrc, Op1, Op2, ALUSrc);

// input 
	input [63:0] Op2, Op1;
	input ALUSrc;
//	clk;
	
// output 
	output reg [63:0] OpSrc;
	
	
	always @(*)
		begin
			if(ALUSrc == 0)
				OpSrc <= Op1;
			else
				OpSrc <= Op2;
		end
		
endmodule
