module ZeroExtension (UnsignedImmediate, Immediate);

// input
	input [15:0] Immediate;
	
// output
	output [31:0] UnsignedImmediate;
	
	assign UnsignedImmediate [15:0] = Immediate [15:0];
	assign UnsignedImmediate [31:16] = 16'h0000;
 
endmodule


//module test;
//
//reg [16:0]in;
//wire [31:0] out;
//
//ZeroExtension ze(out, in);
//
//initial
//begin
//in<=16'b1111111111111111;
//#50 $display ( "out= %b",out);
//
//in<=89;
//#100 $display ("out = %b", out);
//
//end
//endmodule
