`include "define.v"

module EXE_WBstage (
	clk,  rst, aluin, aluout,
	muxin, muxout             
);

input clk, rst;
input [`DSIZE-1:0]aluin;
input [`ASIZE-1:0]muxin;
output reg[`ASIZE-1:0]muxout;
output reg [`DSIZE-1:0]aluout;

always @(posedge clk)
  begin
    if(rst)
      begin
	aluout <= 0;
	muxout <= 0;
      end
    else
      begin
        aluout <= aluin;
	muxout <= muxin;
      end
  end


endmodule
