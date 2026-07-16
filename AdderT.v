module AdderT (input InternalOut, clk, Inc , ResetN, output reg [4:0] IncAdder, output wire [3:0] sqrtV);



always @ (posedge clk) begin
if (!ResetN)
IncAdder=1;

else if (InternalOut)
IncAdder=1;


else if(Inc)
IncAdder= IncAdder + 2;

end

assign sqrtV = IncAdder [4:1];

endmodule
