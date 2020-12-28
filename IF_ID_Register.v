module IF_ID_Register(IF_ID_Rs, IF_ID_Rt, IF_ID_Rd, IF_ID_Opcode, IF_ID_Shamt, IF_ID_Func, IF_ID_Immediate,
	    IF_ID_Address, IF_ID_PCplus4Out, instructionIn, PCplus4);
//input
	input [31:0] instructionIn, PCplus4;
	//input clk;
		
//output
	output reg [4:0] IF_ID_Rs, IF_ID_Rt, IF_ID_Rd, IF_ID_Shamt;
	output reg [5:0] IF_ID_Func, IF_ID_Opcode;
	output reg [15:0] IF_ID_Immediate;
	output reg [25:0] IF_ID_Address;
	output reg [31:0] IF_ID_PCplus4Out;
	
	always @(*) 
		begin
			IF_ID_Rs = instructionIn[25:21];
			IF_ID_Rt = instructionIn [20:16];
			IF_ID_Rd = instructionIn [15:11];
			IF_ID_Shamt = instructionIn [10:6];
			IF_ID_Func = instructionIn [5:0];
			IF_ID_Opcode = instructionIn [31:26];
			IF_ID_Immediate = instructionIn [15:0];
			IF_ID_Address = instructionIn [25:0];
			IF_ID_PCplus4Out = PCplus4;
		end
	
endmodule
