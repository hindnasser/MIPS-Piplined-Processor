module Top (PC_value);

// input
	input [31:0] PC_value;

// IF Stage
	wire [31:0] instruction, PCplus4, PCplus4Out, instructionOut;
	wire clk;

	PCAdder pc1 (PCplus4, PC_value, 4);
	instructionMemory imem (instruction, PC_value);
	IF_ID_Register ifidr (instructionOut, PCplus4Out, instruction, clk, PCplus4); 
	
// ID Stage
	wire [31:0] Address, SignedImmediate, UnsignedImmediate, ShiftedLeft2;
	
	SignExtension se (SignedImmediate, instruction[15:0]);
	ZeroExtension ze (UnsignedImmediate, instruction[15:0]);
	ShiftLeft2 sl (ShiftedLeft2, SignedImmediate);
	AddressAdder aa (Address, PCplus4, ShiftedLeft2);
	
	//Branch address adder
	// sign extension
	//zero extensoin
	//register file
	// floating register file
	// ID/EXE register




endmodule
