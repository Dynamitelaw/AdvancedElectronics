`include "globalVariables.v"
`include "outputportarbiter.v"


`timescale 1ns/1ns
`define SD #1000
`define HALF_CLOCK_PERIOD #5

module testbench;
	reg reset = 0;
	reg clk;

	reg selectBit_NORTH;
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_NORTH;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH;
	reg readIn_NORTH;
	reg writeIn_NORTH;
	reg [`DATA_WIDTH -1:0] dataIn_NORTH;

	
	//reg from South Port
	reg selectBit_SOUTH;
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_SOUTH;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH;
	reg readIn_SOUTH;
	reg writeIn_SOUTH;
	reg [`DATA_WIDTH -1:0] dataIn_SOUTH;
	
	//reg from East Port
	reg selectBit_EAST;
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_EAST;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST;
	reg readIn_EAST;
	reg writeIn_EAST;
	reg [`DATA_WIDTH -1:0] dataIn_EAST;
	
	//reg from West Port
	reg selectBit_WEST;
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_WEST;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST;
	reg readIn_WEST;
	reg writeIn_WEST;
	reg [`DATA_WIDTH -1:0] dataIn_WEST;
	
	//reg from Cache Arbiter
	reg readReady;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] readRequesterAddress;
	reg [`DATA_WIDTH -1:0] cacheDataOut;
	
	//Arbiter Output
	wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut;
	wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut;
	wire readOut;
	wire writeOut;
	wire [`DATA_WIDTH -1:0] dataOut;
	

	outputPortArbiter test1(
		.reset(reset),
		.clk(clk),

		. selectBit_NORTH(selectBit_NORTH),
		. destinationAddressIn_NORTH(destinationAddressIn_NORTH),
		. requesterAddressIn_NORTH(requesterAddressIn_NORTH),
		. readIn_NORTH(readIn_NORTH),
		. writeIn_NORTH(writeIn_NORTH),
		. dataIn_NORTH(dataIn_NORTH),

		
		//. from South Port
		. selectBit_SOUTH(selectBit_SOUTH),
		. destinationAddressIn_SOUTH(destinationAddressIn_SOUTH),
		. requesterAddressIn_SOUTH(requesterAddressIn_SOUTH),
		. readIn_SOUTH(readIn_SOUTH),
		. writeIn_SOUTH(writeIn_SOUTH),
		. dataIn_SOUTH(dataIn_SOUTH),
		
		//. from East Port
		. selectBit_EAST(selectBit_EAST),
		. destinationAddressIn_EAST(destinationAddressIn_EAST),
		. requesterAddressIn_EAST(requesterAddressIn_EAST),
		. readIn_EAST(readIn_EAST),
		. writeIn_EAST(writeIn_EAST),
		. dataIn_EAST(dataIn_EAST),
		
		//. from West Port
		. selectBit_WEST(selectBit_WEST),
		. destinationAddressIn_WEST(destinationAddressIn_WEST),
		. requesterAddressIn_WEST(requesterAddressIn_WEST),
		. readIn_WEST(readIn_WEST),
		. writeIn_WEST(writeIn_WEST),
		. dataIn_WEST(dataIn_WEST),
		
		//. from Cache Arbiter
		. readReady(readReady),
		. readRequesterAddress(readRequesterAddress),
		. cacheDataOut(cacheDataOut),
		
		//Arbiter Output
		.destinationAddressOut(destinationAddressOut),
		.requesterAddressOut(requesterAddressOut),
		.readOut(readOut),
		.writeOut(writeOut),
		.dataOut(dataOut)
	);
	always begin
	//Create your clock 
		`HALF_CLOCK_PERIOD;
	   	clk = ~clk;
	end

	initial begin
		clk = 0;
		reset = 1;
		#10
		reset = 0;
		#10
		selectBit_NORTH = 1;
		dataIn_NORTH = 10;
		#13
		selectBit_NORTH = 0;
		#25
		selectBit_WEST = 1;
		selectBit_SOUTH = 1;
		dataIn_SOUTH = 20;
		dataIn_WEST = 15;
		#13
		selectBit_WEST = 0;
		selectBit_SOUTH = 0;
		#25
		selectBit_EAST = 1;
		selectBit_NORTH = 1;
		selectBit_SOUTH = 1;
		dataIn_SOUTH = 30;
		dataIn_EAST = 15;
		dataIn_NORTH = 8;
		#13
		selectBit_EAST = 0;
		selectBit_SOUTH = 0;
		selectBit_NORTH = 0;
		#100
		$finish;
	end



endmodule
