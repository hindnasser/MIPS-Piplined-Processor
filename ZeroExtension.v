module ZeroExtension (UnsignedImmediate, Immediate);

// input
	input [15:0] Immediate;
	
// output
	output reg [31:0] UnsignedImmediate;
	
	always @(*)
		begin
			UnsignedImmediate [15:0] <= Immediate [15:0];
			UnsignedImmediate [31:16] <= 16'h0000;
		end
 
endmodule


