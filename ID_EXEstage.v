`include "define.v"

module ID_EXE_stage (
	clk,  rst, aluop_in, alusrc_in, rdata1_in, rdata2_in, inst_in, wregdst_in,
	aluop_out, alusrc_out, rdata1_out, rdata2_out, inst_out, wregdst_out
);

// inputs
input clk, rst, alusrc_in;
input [2:0] aluop_in;
input [`DSIZE-1:0] rdata1_in;
input [`DSIZE-1:0] rdata2_in;
input [`ISIZE-1:0] inst_in;
input [`ASIZE-1:0] wregdst_in;

// outputs

output reg alusrc_out;
output reg[2:0] aluop_out;
output reg [`DSIZE-1:0] rdata1_out;
output reg [`DSIZE-1:0] rdata2_out;
output reg [`ISIZE-1:0] inst_out;
output reg [`ASIZE-1:0] wregdst_out;

//Here we need not take write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.

always @(posedge clk)
  begin
    if(rst)
      begin
	aluop_out <= 0; 
	alusrc_out <= 0; 
	rdata1_out <= 0; 
	rdata2_out <= 0; 
	inst_out <= 0;
	wregdst_out <= 0;
      end
    else
      begin
        aluop_out <= aluop_in; 
	alusrc_out <= alusrc_in; 
	rdata1_out <= rdata1_in; 
	rdata2_out <= rdata2_in; 
	inst_out <= inst_in;
	wregdst_out <= wregdst_in;
      end
  end

endmodule


