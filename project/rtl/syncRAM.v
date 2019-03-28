`include "globalVariables.v"

module syncRAM( dataIn, dOut_0, dOut_1, dOut_2, dOut_3, writeAddr, readAddr_0, readAddr_1, readAddr_2, readAddr_3, chipSelect, writeEnable, readEnable, Clk);

     

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
   input chipSelect;
   input writeEnable;
   input readEnable;
   input Clk;
   
//internal variables

reg [DAT-1:0] SRAM [DPTH-1:0];


always @ (posedge Clk)

begin

 if (chipSelect == 1'b1) begin

  if (writeEnable == 1'b1 && readEnable == 1'b0) begin

   SRAM [writeAddr] = dataIn;

  end

  else if (readEnable == 1'b1 && writeEnable == 1'b0) begin

   dOut_0 = SRAM [readAddr_0];  
   dOut_1 = SRAM [readAddr_1];
   dOut_2 = SRAM [readAddr_2];  
   dOut_3 = SRAM [readAddr_3]; 

  end

  else;

 end

 else;

end

endmodule
