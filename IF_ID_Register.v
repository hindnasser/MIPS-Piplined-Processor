module IF_ID_Register(IF_ID_Rs, IF_ID_Rt, IF_ID_Rd, IF_ID_Opcode, IF_ID_Shamt, IF_ID_Func, IF_ID_Immediate,
							 IF_ID_Address, IF_ID_PCplus4, IF_ID_Fd, IF_ID_Fs, IF_ID_Ft, IF_ID_fmt, instruction, PCplus4, clk, IF_ID_Write);
//input
	input [31:0] instruction, PCplus4;
	input clk, IF_ID_Write;
		
//output
	output reg [4:0] IF_ID_Rs, IF_ID_Rt, IF_ID_Rd, IF_ID_Shamt, IF_ID_Fd, IF_ID_Fs, IF_ID_Ft, IF_ID_fmt;
	output reg [5:0] IF_ID_Func, IF_ID_Opcode;
	output reg [15:0] IF_ID_Immediate;
	output reg [25:0] IF_ID_Address;
	output reg [31:0] IF_ID_PCplus4;
	
	always @(posedge clk)
		begin
			if(IF_ID_Write == 1)
				begin
					IF_ID_Rs <= instruction[25:21];
					IF_ID_Rt <= instruction [20:16];
					IF_ID_Rd <= instruction [15:11];
					IF_ID_Shamt <= instruction [10:6];
					IF_ID_Func <= instruction [5:0];
					IF_ID_Opcode <= instruction [31:26];
					IF_ID_Immediate <= instruction [15:0];
					IF_ID_Address <= instruction [25:0];
					IF_ID_PCplus4 <= PCplus4;
					IF_ID_Fd <= instruction [10:6];
					IF_ID_Ft <= instruction [20:16];
					IF_ID_Fs <= instruction [15:11];
					IF_ID_fmt <= instruction [25:21];
				end
			
			else 
				begin
					IF_ID_Rs <= 0;
					IF_ID_Rt <= 0;
					IF_ID_Rd <= 0;
					IF_ID_Shamt <= 0;
					IF_ID_Func <= 0;
					IF_ID_Opcode <= 0;
					IF_ID_Immediate <= 0;
					IF_ID_Address <= 0;
					IF_ID_PCplus4 <= 0;
					IF_ID_Fd <= 0;
					IF_ID_Ft <= 0;
					IF_ID_Fs <= 0;
					IF_ID_fmt <= 0;
				end
		end
endmodule
