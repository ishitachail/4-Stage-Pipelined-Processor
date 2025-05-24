`include"define.v"
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////////
//// Company: NTU
//// Engineer: Dr. Smitha K G
////////////////////////////////////////////////////////////////////////////////////
//4stage

module datapath_mux (
	// inputs
	clk,
	rst,
	inst,

	//outputs
	//aluout
	WB_aluout
);

// inputs
input		  clk;
input		  rst;
input  [`ISIZE-1:0] inst;

// outputs
output  [`DSIZE-1:0] WB_aluout;

wire [`ISIZE-1:0] inst_out;
wire [2:0]	aluop_in;
wire [2:0]	aluop_out;
wire alusrc_in;
wire alusrc_out;
wire regDST;
wire wen;
wire [`DSIZE-1:0] rdata1_in;
wire [`DSIZE-1:0] rdata2_in;
wire [`DSIZE-1:0] rdata1_out;
wire [`DSIZE-1:0] rdata2_out;
wire [`DSIZE-1:0] wdata_out;
wire [`ASIZE-1:0] waddr_out;
wire [`DSIZE-1:0] aluout;
wire [`ASIZE-1:0] WB_muxout;

wire [`DSIZE-1:0]rdata2_imm=alusrc_out ? {16'b0,inst_out[15:0]} : rdata2_out;//Multiplexer to select the immediate value or rdata2 based on alusrc.
//when alusrc is 1 then connect immediate data to output else connect rdata2 to output

wire [`ASIZE-1:0]waddr_regDST=regDST ? inst[15:11] : inst[20:16];//Multiplexer to select the inst[15:11] or inst[20:16] as the waddr based on regDST.
//when regDST is 1 then connect inst[15:11] to output else connect inst[20:16] to output

//Here you need to instantiate the control , Alu , regfile and the delay registers. 
control CO (
    .inst_cntrl(inst[31:26]),
    .wen_cntrl(wen),
    .alusrc_cntrl(alusrc_in),
    .regdst_cntrl(regDST),
    .aluop_cntrl(aluop_in)
);

regfile RFO (
    .clk(clk),
    .rst(rst),
    .wen(wen),
    .raddr1(inst[25:21]),
    .raddr2(inst[20:16]),
    .waddr(WB_muxout),
    .wdata(WB_aluout),
    .rdata1(rdata1_in),
    .rdata2(rdata2_in)
);

ID_EXE_stage IXS(
    .clk(clk),  
    .rst(rst), 
    .aluop_in(aluop_in), 
    .alusrc_in(alusrc_in), 
    .rdata1_in(rdata1_in), 
    .rdata2_in(rdata2_in),
    .inst_in(inst),
    .wregdst_in(waddr_regDST),
    .aluop_out(aluop_out),
    .alusrc_out(alusrc_out), 
    .rdata1_out(rdata1_out), 
    .rdata2_out(rdata2_out), 
    .inst_out(inst_out),
    .wregdst_out(waddr_out)
);

alu ALU0 (
    .a(rdata1_out),
    .b(rdata2_imm),
    .op(aluop_out),
    .out(aluout)
);

//aluin, aluout,muxin, muxout 
EXE_WBstage EWS(
	.clk(clk),
	.rst(rst),
	.aluin(aluout),
	.aluout(WB_aluout),
	.muxin(waddr_out),
	.muxout(WB_muxout)	
);

endmodule // end of datapath module

