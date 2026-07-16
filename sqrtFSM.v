module sqrtFSM ( input clk, Borrow, St, ResetN, output reg Inc, output reg Su, output reg Load, output reg Done, output reg InternalOut


);

reg [1:0] state;
reg [1:0] nextstate;

localparam S0 =3'd0;
localparam S1 =3'd1;
localparam S2 =3'd2;

always @(posedge clk or negedge ResetN)
begin
if(!ResetN) begin
state <= S0;
end else begin 
state <= nextstate;
end
end

always @ (St,Borrow,state)



case(state)


S0: begin
Done=0;
InternalOut=0;
if (St) begin
Load=1;

nextstate= S1;
end  else begin 
Load=0;
nextstate = S0;
end
end

S1: begin
if (!Borrow) begin
Load=0;
Su=1;
Inc=1;
nextstate = S1;
end else if (Borrow) begin
Inc=0;
Load=0;
Su=0;
nextstate = S2;
end
end

S2: begin
if (!St) begin
InternalOut=1;
nextstate = S0;
end else begin
Done=1;
nextstate=S2;

end
end



default:nextstate = S0;

endcase
 

endmodule


