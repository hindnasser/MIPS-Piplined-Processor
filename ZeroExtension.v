module ZeroExtension (UnsignedImmediate, Immediate);

// input
	input [15:0] Immediate;
	
// output
	output reg [63:0] UnsignedImmediate;
	
	always @(*)
		begin
			UnsignedImmediate [15:0] <= Immediate [15:0];
			UnsignedImmediate [63:16] <= 48'h0000;
		end
 
endmodule


