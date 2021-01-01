module inpMUX (PCactual, PCplus4, PC_value, first);

input [31:0] PCplus4, PC_value;
input first;

output reg [31:0] PCactual;

always @ (*)
begin
if(first == 0)
PCactual = PC_value;
else if (first == 1)
PCactual = PCplus4;

end
endmodule
