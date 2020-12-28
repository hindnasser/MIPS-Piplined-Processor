module SignExtension (SignedImmediate, immediate);

// input 
	input [15:0] immediate;

// output 
	output reg [31:0] SignedImmediate;
	
	always @(*) begin
		SignedImmediate [15:0] <= immediate [15:0];
		
		if(immediate[15]==1)
			SignedImmediate [31:16] <= 16'hFFFF;
		else 
			SignedImmediate [31:16] <= 16'h0000;
	end
endmodule


