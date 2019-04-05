`include "globalVariables.v"




module cacheBank( 
	input clk,
	input reset,
	
	//Port A
	input [`DATA_WIDTH -1:0] cacheDataIn_A,
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_A,
	input memWrite_A,
	output reg [`DATA_WIDTH -1:0] cacheDataOut_A,
	output reg portA_writtenTo,
	
	//Port B
	input [`DATA_WIDTH -1:0] cacheDataIn_B,
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_B,
	input memWrite_B,
	output reg [`DATA_WIDTH -1:0] cacheDataOut_B
	output reg portB_writtenTo
	);


     

// parameters for the width 

parameter ADR   = `CACHE_BANK_ADDRESS_WIDTH;
parameter DAT   = `DATA_WIDTH;
parameter DPTH  = `CACHE_BANK_LINES;

//internal variables
integer hit_bit; 
integer Hit0;
integer Hit1;
integer Hit2;
integer Hit3;
reg [DPTH-1:0] isWritten;

reg [DAT-1:0] SRAM [DPTH-1:0];
initial begin
isWritten = ~{DPTH{1'b0}};
end

always @ (posedge clk)

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
