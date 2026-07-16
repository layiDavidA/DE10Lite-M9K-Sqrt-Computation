module squareroot  (input Clock, Resetn, Start, input [7:0] InputVal, output Done, output [3:0] OutputSqrt);

wire Load, Borrow, Su; 
wire [7:0] Number; 
wire [4:0] IncAdder;
wire [7:0]Subtractor_;
wire InternalOut;





Subtractor uut0 (.Number(Number), .IncAdder(IncAdder),.SubtractNumber(Subtractor_),.Borrow( Borrow));

AdderT uut1 (.InternalOut(InternalOut),.clk(Clock), .Inc(Inc), .ResetN(Resetn), .IncAdder(IncAdder),.sqrtV(OutputSqrt));

Nblock uut2 (.clk(Clock), .Load(Load), .Su(Su),.subtractertoN(Subtractor_), .InitialValue(InputVal), .Number(Number));

sqrtFSM uut3 (.clk(Clock), .Borrow(Borrow), .St(Start), .ResetN(Resetn), .Inc(Inc), .Su(Su), .Load(Load), .Done(Done), .InternalOut(InternalOut));







 
endmodule 