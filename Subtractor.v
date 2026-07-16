module Subtractor (input [7:0] Number, input [4:0] IncAdder, output [7:0] SubtractNumber, output Borrow);

assign {Borrow, SubtractNumber}= Number - IncAdder;




endmodule
