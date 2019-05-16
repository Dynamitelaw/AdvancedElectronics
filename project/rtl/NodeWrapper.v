/*
 * Wrapper for modules that make up a single network node
 */
 
`include "globalVariables.v"
`include "cacheBank.nl.v"
`include "router.v"


module Node(
	input clk,
	input reset,
	input [`NETWORK_ADDRESS_WIDTH -1:0] localRouterAddress,
	
	//North port (1)
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_NORTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH,
	input readIn_NORTH,
	input writeIn_NORTH,
	input [`DATA_WIDTH -1:0] dataIn_NORTH,
		
	output wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_NORTH,
	output wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_NORTH,
	output wire readOut_NORTH,
	output wire writeOut_NORTH,
	output wire [`DATA_WIDTH -1:0] dataOut_NORTH,
	
	//South port (2)
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_SOUTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH,
	input readIn_SOUTH,
	input writeIn_SOUTH,
	input [`DATA_WIDTH -1:0] dataIn_SOUTH,
		
	output wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_SOUTH,
	output wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_SOUTH,
	output wire readOut_SOUTH,
	output wire writeOut_SOUTH,
	output wire [`DATA_WIDTH -1:0] dataOut_SOUTH, 
	
	//East port (3)
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_EAST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST,
	input readIn_EAST,
	input writeIn_EAST,
	input [`DATA_WIDTH -1:0] dataIn_EAST,
		
	output wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_EAST,
	output wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_EAST,
	output wire readOut_EAST,
	output wire writeOut_EAST,
	output wire [`DATA_WIDTH -1:0] dataOut_EAST, 
	
	//West port (4)
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_WEST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST,
	input readIn_WEST,
	input writeIn_WEST,
	input [`DATA_WIDTH -1:0] dataIn_WEST,
		
	output wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0]destinationAddressOut_WEST,
	output wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_WEST,
	output wire readOut_WEST,
	output wire writeOut_WEST,
	output wire [`DATA_WIDTH -1:0] dataOut_WEST
	);
	
	//Cache bank IO	
	wire [`DATA_WIDTH -1:0] cacheDataIn_A;
	wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_A;
	wire [`DATA_WIDTH -1:0] cacheDataOut_A;
	wire memWrite_A;
	wire portA_writtenTo;

	wire [`DATA_WIDTH -1:0] cacheDataIn_B;
	wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_B;
	wire [`DATA_WIDTH -1:0] cacheDataOut_B;
	wire memWrite_B;
	wire portB_writtenTo;
	
	//Router instance
	router rtr(
		.clk(clk),
		.reset(reset),
		.localRouterAddress(NodeID[`NETWORK_ADDRESS_WIDTH -1:0]),

		//North port (1)
		.destinationAddressIn_NORTH(destinationAddressIn_NORTH),
		.requesterAddressIn_NORTH(requesterAddressIn_NORTH),
		.readIn_NORTH(readIn_NORTH),
		.writeIn_NORTH(writeIn_NORTH),
		.dataIn_NORTH(dataIn_NORTH),

		.destinationAddressOut_NORTH(destinationAddressOut_NORTH),
		.requesterAddressOut_NORTH(requesterAddressOut_NORTH),
		.readOut_NORTH(readOut_NORTH),
		.writeOut_NORTH(writeOut_NORTH),
		.dataOut_NORTH(dataOut_NORTH),

		//South port (2)
		.destinationAddressIn_SOUTH(destinationAddressIn_SOUTH),
		.requesterAddressIn_SOUTH(requesterAddressIn_SOUTH),
		.readIn_SOUTH(readIn_SOUTH),
		.writeIn_SOUTH(writeIn_SOUTH),
		.dataIn_SOUTH(dataIn_SOUTH),

		.destinationAddressOut_SOUTH(destinationAddressOut_SOUTH),
		.requesterAddressOut_SOUTH(requesterAddressOut_SOUTH),
		.readOut_SOUTH(readOut_SOUTH),
		.writeOut_SOUTH(writeOut_SOUTH),
		.dataOut_SOUTH(dataOut_SOUTH),

		//East port (3)
		.destinationAddressIn_EAST(destinationAddressIn_EAST),
		.requesterAddressIn_EAST(requesterAddressIn_EAST),
		.readIn_EAST(readIn_EAST),
		.writeIn_EAST(writeIn_EAST),
		.dataIn_EAST(dataIn_EAST),

		.destinationAddressOut_EAST(destinationAddressOut_EAST),
		.requesterAddressOut_EAST(requesterAddressOut_EAST),
		.readOut_EAST(readOut_EAST),
		.writeOut_EAST(writeOut_EAST),
		.dataOut_EAST(dataOut_EAST),

		//West port (4)
		.destinationAddressIn_WEST(destinationAddressIn_WEST),
		.requesterAddressIn_WEST(requesterAddressIn_WEST),
		.readIn_WEST(readIn_WEST),
		.writeIn_WEST(writeIn_WEST),
		.dataIn_WEST(dataIn_WEST),

		.destinationAddressOut_WEST(destinationAddressOut_WEST),
		.requesterAddressOut_WEST(requesterAddressOut_WEST),
		.readOut_WEST(readOut_WEST),
		.writeOut_WEST(writeOut_WEST),
		.dataOut_WEST(dataOut_WEST),

		//Cache bank IO
		.cacheDataIn_A(cacheDataIn_A),
		.cacheAddressIn_A(cacheAddressIn_A),
		.cacheDataOut_A(cacheDataOut_A),
		.memWrite_A(memWrite_A),
		.portA_writtenTo(portA_writtenTo),

		.cacheDataIn_B(cacheDataIn_B),
		.cacheAddressIn_B(cacheAddressIn_B),
		.cacheDataOut_B(cacheDataOut_B),
		.memWrite_B(memWrite_B),
		.portB_writtenTo(portB_writtenTo)
		);
		
	//Cache bank instance				
	cacheBank localCacheBank( 
		.clk(clk),
		.reset(reset),

		//Port A
		.cacheDataIn_A(cacheDataIn_A),
		.cacheAddressIn_A(cacheAddressIn_A),
		.memWrite_A(memWrite_A),
		.cacheDataOut_A(cacheDataOut_A),
		.portA_writtenTo(portA_writtenTo),

		//Port B
		.cacheDataIn_B(cacheDataIn_B),
		.cacheAddressIn_B(cacheAddressIn_B),
		.memWrite_B(memWrite_B),
		.cacheDataOut_B(cacheDataOut_B),
		.portB_writtenTo(portB_writtenTo)
		);
endmodule
