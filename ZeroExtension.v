module ZeroExtension (UnsignedImmediate, Immediate);

// input
	input [15:0] Immediate;
	
// output
	output [31:0] UnsignedImmediate;
	
	assign UnsignedImmediate [15:0] = Immediate [15:0];
	assign UnsignedImmediate [31:16] = 16'h0000;
 
endmodule


