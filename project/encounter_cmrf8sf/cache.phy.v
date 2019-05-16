/*
###############################################################
#  Generated by:      Cadence Encounter 14.23-s044_1
#  OS:                Linux x86_64(Host ID cadpc04)
#  Generated on:      Tue May 14 16:42:10 2019
#  Design:            cacheBank
#  Command:           saveNetlist -phys -excludeLeafCell -excludeCellInst {FILL1TS FILL2TS FILL4TS FILL8TS FILL16TS FILL32TS FILL64TS} cache.phy.v
###############################################################
*/
//`include "globalVariables.v"
//`include "CacheMem.v"
module cacheBank (
	clk, 
	reset, 
	cacheDataIn_A, 
	cacheAddressIn_A, 
	memWrite_A, 
	cacheDataOut_A, 
	portA_writtenTo, 
	cacheDataIn_B, 
	cacheAddressIn_B, 
	memWrite_B, 
	cacheDataOut_B, 
	portB_writtenTo, 
	VDD, 
	VSS);
   input clk;
   input reset;
   input [31:0] cacheDataIn_A;
   input [7:0] cacheAddressIn_A;
   input memWrite_A;
   output [31:0] cacheDataOut_A;
   output portA_writtenTo;
   input [31:0] cacheDataIn_B;
   input [7:0] cacheAddressIn_B;
   input memWrite_B;
   output [31:0] cacheDataOut_B;
   output portB_writtenTo;
   inout VDD;
   inout VSS;

   // Internal wires
   wire clk__L1_N0;
   wire FE_UNCONNECTED_0;
   wire FE_UNCONNECTED_1;
   wire FE_UNCONNECTED_2;
   wire FE_UNCONNECTED_3;
   wire FE_UNCONNECTED_4;
   wire FE_UNCONNECTED_5;

   // Module instantiations
   CLKINVX16TS clk__L1_I0 (
	.Y(clk__L1_N0),
	.A(clk), 
	.VDD(VDD), 
	.VSS(VSS));
   CacheMem Memory (
	.WENB(memWrite_B),
	.WENA(memWrite_A),
	.QB(cacheDataOut_B),
	.QA(cacheDataOut_A),
	.DB(cacheDataIn_B),
	.DA(cacheDataIn_A),
	.CLKB(clk__L1_N0),
	.CLKA(clk__L1_N0),
	.CENB(reset),
	.CENA(reset),
	.AB({ FE_UNCONNECTED_5,
		FE_UNCONNECTED_4,
		FE_UNCONNECTED_3,
		cacheAddressIn_B }),
	.AA({ FE_UNCONNECTED_2,
		FE_UNCONNECTED_1,
		FE_UNCONNECTED_0,
		cacheAddressIn_A }), 
	.VDD(VDD), 
	.VSS(VSS));
endmodule

