`include "globalVariables.v"

module syncRAM( dataIn, dOut_0, dOut_1, dOut_2, dOut_3, WA, RA_0, RA_1, RA_2, RA_3, CS, WE, RD, Clk);

     

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
   input [ADR-1:0] WA;
   input [ADR-1:0] RA_0;
   input [ADR-1:0] RA_1;
   input [ADR-1:0] RA_2;
   input [ADR-1:0] RA_3;
   input CS;
   input WE;
   input RD;
   input Clk;
   
//internal variables

reg [DAT-1:0] SRAM [DPTH-1:0];


always @ (posedge Clk)

begin

 if (CS == 1'b1) begin

  if (WE == 1'b1 && RD == 1'b0) begin

   SRAM [WA] = dataIn;

  end

  else if (RD == 1'b1 && WE == 1'b0) begin

   dOut_0 = SRAM [RA_0];  
   dOut_1 = SRAM [RA_1];
   dOut_2 = SRAM [RA_2];  
   dOut_3 = SRAM [RA_3]; 

  end

  else;

 end

 else;

end

endmodule
