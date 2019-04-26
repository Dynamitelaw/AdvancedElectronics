
`include "globalVariables.v"
`include "cacheBank_new.v"
`timescale 1ns / 1ps
`define SD #1000

module test_cacheBank;


 // Inputs
   	reg reset;
   	reg clk;

	//PortA	
	reg [`DATA_WIDTH -1:0] cacheDataIn_A;
	reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_A;
	reg memWrite_A;

	//PortB		
	reg [`DATA_WIDTH -1:0] cacheDataIn_B;
	reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_B;
	reg memWrite_B;

 // Outputs
	//PortA
	wire [`DATA_WIDTH -1:0] cacheDataOut_A;
	wire portA_writtenTo;

	//PortB	
	wire [`DATA_WIDTH -1:0] cacheDataOut_B;
	wire portB_writtenTo;


 // Instantiate the Unit Under Test (UUT)

 cacheBank uut (
		.cacheDataIn_A(cacheDataIn_A),
		.cacheAddressIn_A(cacheAddressIn_A), 
		.memWrite_A(memWrite_A),
		.cacheDataOut_A(cacheDataOut_A),
		.portA_writtenTo(portA_writtenTo),
		.cacheDataIn_B(cacheDataIn_B),
		.cacheAddressIn_B(cacheAddressIn_B), 
		.memWrite_B(memWrite_B),
		.cacheDataOut_B(cacheDataOut_B),
		.portB_writtenTo(portB_writtenTo),
		.reset(reset),  
		.clk(clk)
);


 initial begin

  // Initialize Inputs

	cacheDataIn_A  = 8'h0;	
	cacheAddressIn_A = 8'h0;
	memWrite_A = 8'h0;
	cacheDataIn_B  = 8'h0;
	cacheAddressIn_B = 8'h0;
	memWrite_B = 8'h0;
	clk  = 1'b0;
	reset = 1'b1;

	


  // wait 100 ns for global reset to finish

  	#40;

       

  // Add stimulus here
	
  	cacheDataIn_A  = 8'h2;
  	cacheAddressIn_A = 8'h4;
  	memWrite_A  = 1'b0;
	memWrite_B = 1'b1;
	reset = 1'b0;
    
  	#20;
	
	cacheDataIn_B  = 8'h3;
  	cacheAddressIn_B  = 8'h6;
	memWrite_A  = 1'b1;
	memWrite_B  = 1'b0;
  	
	#20;	
	
  	cacheDataIn_A  = 8'h4;
  	cacheAddressIn_A  = 8'h7;	
	memWrite_A  = 1'b0;
	memWrite_B  = 1'b1;

  	#20;

  	cacheDataIn_B  = 8'h1;
  	cacheAddressIn_B  = 8'h2;
	memWrite_A  = 1'b1;
	memWrite_B  = 1'b0;

	#20;
	cacheAddressIn_A = 8'h4; 
	cacheAddressIn_B = 8'h1;
  	memWrite_A  = 1'b1;
	memWrite_B  = 1'b1;
	
	#20
	$stop;
 end

   

 always #10 clk = ~clk;

 

endmodule
