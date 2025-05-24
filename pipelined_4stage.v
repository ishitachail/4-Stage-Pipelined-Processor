`timescale 1ns / 1ps
`include "define.v"

module pipelined_4stage(clk, rst, aluout);

input clk;										
input rst;
output [`DSIZE-1:0] aluout;

wire [`ISIZE-1:0]inst_addr;
wire [`ISIZE-1:0] inst_out;
wire [`ISIZE-1:0] inst_in;


datapath_mux DP(
	.clk(clk),
	.rst(rst),
	.inst(inst_out),
	.WB_aluout(aluout)
);

PC1 pc(
	.clk(clk),
	.rst(rst),
	.currPC(inst_addr),
	.nextPC(inst_addr)
);

memory MEM( 
	.clk(clk), 
	.rst(rst), 
	.wen(0), 
	.addr(inst_addr), 
	.data_in(), 
	.fileid(0), 
	.data_out(inst_out)
);

IF_ID_stage IIS(
	.clk(clk),
	.rst(rst), 
	.instout(inst_out), 
	.instin(inst_in)
);

 
endmodule


