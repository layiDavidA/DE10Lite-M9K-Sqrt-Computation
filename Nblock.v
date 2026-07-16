module Nblock( input clk, Load, Su,input [7:0] subtractertoN, input [7:0] InitialValue, output reg [7:0] Number);

always @ ( posedge clk) begin
if (Load==1)
Number = InitialValue;
else if (Su)
Number= subtractertoN;


end
endmodule
