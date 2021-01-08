module SignExtension (SignedImmediate, immediate);

// input 
	input [15:0] immediate;

// output 
	output reg [63:0] SignedImmediate;
	
	always @(*) begin
		SignedImmediate [15:0] <= immediate [15:0];
		
		if(immediate[15]==1)
			SignedImmediate [63:16] <= 48'hFFFF;
		else 
			SignedImmediate [63:16] <= 48'h0000;
	end
endmodule


