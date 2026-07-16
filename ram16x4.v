//16x8
module ram_16x4(input clk, input [4:0] addr, input mwr, input [7:0] mdi, output reg [7:0] mdo);

reg [7:0] memory [15:0] /* synthesis ramstyle = "M9K" ram_init_file = "lab4part2.mif"*/;
always @ (posedge clk) begin
if (mwr) memory[addr] <= mdi; //write mem
mdo <= memory[addr]; // read mem
end
endmodule