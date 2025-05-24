`include "define.v"

module IF_ID_stage (
	clk,  rst, instout, instin
);


input clk, rst;
input [`ISIZE - 1:0]instout;
output reg [`ISIZE - 1:0]instin;

always @(posedge clk)
  begin
    if(rst)
      begin
	instin <= 0;
      end
    else
      begin
        instin = instout;
      end
  end


endmodule


