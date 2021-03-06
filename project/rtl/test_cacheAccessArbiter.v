`include "globalVariables.v"
`include "cacheAccessArbiter.v"
`include "syncRAM.v"


`timescale 1ns/1ns
`define SD #1000
`define HALF_CLOCK_PERIOD #5

module cacheArbiter_testbench;
	reg reset = 0;
	reg clk = 0;

	reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_NORTH = 0;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH = 0;
	reg memRead_NORTH = 0;
	reg memWrite_NORTH = 0;
	reg [`DATA_WIDTH -1:0] dataIn_NORTH = 0;

	wire readReady_NORTH;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_NORTH;

	//reg from South Port
	reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_SOUTH = 0;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH = 0;
	reg memRead_SOUTH = 0;
	reg memWrite_SOUTH = 0;
	reg [`DATA_WIDTH -1:0] dataIn_SOUTH = 0;
	
	wire readReady_SOUTH;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_SOUTH;

	//reg from East Port
	reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_EAST = 0;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST = 0;
	reg memRead_EAST = 0;
	reg memWrite_EAST = 0;
	reg [`DATA_WIDTH -1:0] dataIn_EAST = 0;
	
	wire readReady_EAST;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_EAST;
	
	//reg from West Port
	reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_WEST = 0;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST = 0;
	reg memRead_WEST = 0;
	reg memWrite_WEST = 0;
	reg [`DATA_WIDTH -1:0] dataIn_WEST = 0;
	
	wire readReady_WEST;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_WEST;
	

	wire [`DATA_WIDTH -1:0] cacheDataIn_A;
	wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_A;
	wire [`DATA_WIDTH -1:0] cacheDataOut_A;
	wire memWrite_A;

	wire [`DATA_WIDTH -1:0] cacheDataIn_B;
	wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_B;
	wire [`DATA_WIDTH -1:0] cacheDataOut_B;
	wire memWrite_B;


	cacheAccessArbiter test1(
		.reset(reset),
		.clk(clk),

		. cacheAddressIn_NORTH(cacheAddressIn_NORTH),
		. requesterAddressIn_NORTH(requesterAddressIn_NORTH),
		. memRead_NORTH(memRead_NORTH),
		. memWrite_NORTH(memWrite_NORTH),
		. dataIn_NORTH(dataIn_NORTH),
		. readReady_NORTH(readReady_NORTH),
		. requesterAddressOut_NORTH(requesterAddressOut_NORTH),
		
		
		//. from South Port
		. cacheAddressIn_SOUTH(cacheAddressIn_SOUTH),
		. requesterAddressIn_SOUTH(requesterAddressIn_SOUTH),
		. memRead_SOUTH(memRead_SOUTH),
		. memWrite_SOUTH(memWrite_SOUTH),
		. dataIn_SOUTH(dataIn_SOUTH),
		. readReady_SOUTH(readReady_SOUTH),
		. requesterAddressOut_SOUTH(requesterAddressOut_SOUTH),
		
		//. from East Port
		. cacheAddressIn_EAST(cacheAddressIn_EAST),
		. requesterAddressIn_EAST(requesterAddressIn_EAST),
		. memRead_EAST(memRead_EAST),
		. memWrite_EAST(memWrite_EAST),
		. dataIn_EAST(dataIn_EAST),
		. readReady_EAST(readReady_EAST),
		. requesterAddressOut_EAST(requesterAddressOut_EAST),
		
		//. from West Port
		. cacheAddressIn_WEST(cacheAddressIn_WEST),
		. requesterAddressIn_WEST(requesterAddressIn_WEST),
		. memRead_WEST(memRead_WEST),
		. memWrite_WEST(memWrite_WEST),
		. dataIn_WEST(dataIn_WEST),
		. readReady_WEST(readReady_WEST),
		. requesterAddressOut_WEST(requesterAddressOut_WEST),
		

		//Cache bank IO
		.cacheDataIn_A(cacheDataIn_A),
		.cacheAddressIn_A(cacheAddressIn_A),
		.cacheDataOut_A(cacheDataOut_A),
		.memWrite_A(memWrite_A),
		
		.cacheDataIn_B(cacheDataIn_B),
		.cacheAddressIn_B(cacheAddressIn_B),
		.cacheDataOut_B(cacheDataOut_B),
		.memWrite_B(memWrite_B)
	);

	//		syncRAM cacheBank( 
	//			.Clk(clk),
	//			.reset(reset),
				
	//			.dataIn(cacheDataIn), 
	//			.dOut_0(cacheDataOut_0), 
	//			.dOut_1(cacheDataOut_1), 
	//			.dOut_2(cacheDataOut_2), 
	//			.dOut_3(cacheDataOut_3), 
	//			.writeAddr(cacheWriteAddressIn), 
	//			.readAddr_0(cacheReadAddress_0), 
	//			.readAddr_1(cacheReadAddress_1), 
	//			.readAddr_2(cacheReadAddress_2), 
	//			.readAddr_3(cacheReadAddress_3), 
	//			.writeEnable(memWrite), 
	//			.readEnable(memRead)
	//			);
		
	always begin
	//Create your clock 
		`HALF_CLOCK_PERIOD;
	   	clk = ~clk;
	end

	initial begin
		clk = 1;
		reset = 1;
		#10
		reset = 0;
		//posedge
		#10
		memWrite_NORTH = 1;
		dataIn_NORTH = 10;
		cacheAddressIn_NORTH = 8'h2;
		#10
		memWrite_NORTH = 1;
		dataIn_NORTH = 5;
		cacheAddressIn_NORTH = 8'h3;
		memWrite_SOUTH = 1;
		dataIn_SOUTH = 4;
		cacheAddressIn_SOUTH = 8'h1;
		//posedge
		#10
		memWrite_NORTH = 0;
		memWrite_SOUTH = 0;
		#10
		memWrite_SOUTH = 0;
		memRead_SOUTH = 1;
		dataIn_SOUTH = 9;
		cacheAddressIn_SOUTH = 8'h9;
		memWrite_EAST = 1;
		dataIn_EAST = 6;
		cacheAddressIn_EAST = 8'h5;
		memWrite_WEST = 1;
		dataIn_WEST = 7;
		cacheAddressIn_WEST = 8'h4;
		//posedge
		#10
		memWrite_SOUTH = 0;
		memRead_SOUTH = 0;
		memWrite_EAST = 0;
		memWrite_WEST = 0;
		#10
		memWrite_EAST = 1;
		dataIn_EAST = 4;
		cacheAddressIn_EAST = 8'h6;
		//posedge
		#10
		memWrite_EAST = 0;
		#10
		memWrite_NORTH = 1;
		dataIn_NORTH = 10;
		cacheAddressIn_NORTH = 8'h2;
		memWrite_SOUTH = 0;
		memRead_SOUTH = 1;
		dataIn_SOUTH = 9;
		cacheAddressIn_SOUTH = 8'h9;
		memWrite_EAST = 1;
		dataIn_EAST = 6;
		cacheAddressIn_EAST = 8'h5;
		memWrite_WEST = 1;
		dataIn_WEST = 7;
		cacheAddressIn_WEST = 8'h4;

		//posedge
		#10
		memWrite_NORTH = 0;
		memWrite_SOUTH = 0;
		memRead_SOUTH = 0;
		memWrite_EAST = 0;
		memWrite_WEST = 0;
		#100
		$stop;
	end



endmodule
