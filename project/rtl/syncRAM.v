`include "globalVariables.v"

module syncRAM( dataIn, dOut_0, dOut_1, dOut_2, dOut_3, writeAddr, readAddr_0, readAddr_1, readAddr_2, readAddr_3, writeEnable, readEnable, reset, port0_writtenTo, port1_writtenTo, port2_writtenTo, port3_writtenTo,isWritten, Clk);

     

// parameters for the width 

parameter ADR   = `CACHE_BANK_ADDRESS_WIDTH;

parameter DAT   = `DATA_WIDTH;

parameter DPTH  = `CACHE_BANK_LINES;

//ports
   input  [DAT-1:0]  dataIn;
   output reg [DAT-1:0] dOut_0;
   output reg [DAT-1:0] dOut_1;
   output reg [DAT-1:0] dOut_2;
   output reg [DAT-1:0] dOut_3;
   input [ADR-1:0] writeAddr;
   input [ADR-1:0] readAddr_0;
   input [ADR-1:0] readAddr_1;
   input [ADR-1:0] readAddr_2;
   input [ADR-1:0] readAddr_3;
   integer hit_bit; 
   integer Hit0;
   integer Hit1;
   integer Hit2;
   integer Hit3;
   output reg [DPTH-1:0] isWritten;
   input writeEnable;
   input readEnable;
   input reset;
   input Clk;
   output reg port0_writtenTo;
   output reg port1_writtenTo;
   output reg port2_writtenTo;
   output reg port3_writtenTo;
//internal variables

reg [DAT-1:0] SRAM [DPTH-1:0];
initial begin
isWritten = ~{DPTH{1'b0}};
end

always @ (posedge Clk)

begin

 	if (reset) begin
		isWritten = ~{DPTH{1'b0}};
 	end

 	else begin

	  	if (writeEnable == 1'b1 && readEnable == 1'b0) begin

	   		SRAM [writeAddr] = dataIn;
	   		hit_bit = writeAddr;
	   		isWritten[hit_bit] = 0;
		
	  	end

	  	else if (readEnable == 1'b1 && writeEnable == 1'b0) begin

			dOut_0 <= SRAM [readAddr_0];  
	   		dOut_1 <= SRAM [readAddr_1];
	   		dOut_2 <= SRAM [readAddr_2];  
	   		dOut_3 <= SRAM [readAddr_3]; 
	   		Hit0 = readAddr_0; 
	   		Hit1 = readAddr_1; 
	   		Hit2 = readAddr_2; 
	   		Hit3 = readAddr_3;
	   		port0_writtenTo <= isWritten[Hit0]; 
	   		port1_writtenTo <= isWritten[Hit1];
	   		port2_writtenTo <= isWritten[Hit2];
	   		port3_writtenTo <= isWritten[Hit3];
	  	end
  	end
end	
endmodule
