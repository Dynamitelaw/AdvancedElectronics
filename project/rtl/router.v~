/*
 * Defines the microarchitecture of a router
 *
 * Jose Rubianes (jer2201)
 */
 
//Include dependencies
`include globalVariables.v


/*
 * Top-level router module
 */
module router(
	input clk,
	
	//North port
	input portEnable_NORTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] destinationAddressIn_NORTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH,
	input readIn_NORTH,
	input writeIn_NORTH,
	input [`DATA_WIDTH -1:0] dataIn_NORTH,
		
	output [`NETWORK_ADDRESS_WIDTH -1:0] destinationAddressOut_NORTH,
	output [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_NORTH,
	output readOut_NORTH,
	output writeOut_NORTH,
	output [`DATA_WIDTH -1:0] dataOut_NORH,
	
	//South port
	input portEnable_SOUTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] destinationAddressIn_SOUTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH,
	input readIn_SOUTH,
	input writeIn_SOUTH,
	input [`DATA_WIDTH -1:0] dataIn_SOUTH,
		
	output [`NETWORK_ADDRESS_WIDTH -1:0] destinationAddressOut_SOUTH,
	output [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_SOUTH,
	output readOut_SOUTH,
	output writeOut_SOUTH,
	output [`DATA_WIDTH -1:0] dataOut_SOUTH, 
	
	//East port
	input portEnable_EAST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] destinationAddressIn_EAST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST,
	input readIn_EAST,
	input writeIn_EAST,
	input [`DATA_WIDTH -1:0] dataIn_EAST,
		
	output [`NETWORK_ADDRESS_WIDTH -1:0] destinationAddressOut_EAST,
	output [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_EAST,
	output readOut_EAST,
	output writeOut_EAST,
	output [`DATA_WIDTH -1:0] dataOut_EAST, 
	
	//West port
	input portEnable_WEST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] destinationAddressIn_WEST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST,
	input readIn_WEST,
	input writeIn_WEST,
	input [`DATA_WIDTH -1:0] dataIn_WEST,
		
	output [`NETWORK_ADDRESS_WIDTH -1:0] destinationAddressOut_WEST,
	output [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_WEST,
	output readOut_WEST,
	output writeOut_WEST,
	output [`DATA_WIDTH -1:0] dataOut_WEST, 
		
	//Cache bank IO
	input [`DATA_WIDTH -1:0] cacheDataOut,
	
	output [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddress,
	output [`DATA_WIDTH -1:0] cacheDataIn,
	output memRead,
	output memWrite
	)
	
	generate
		if (portEnable_NORTH)
			//instantiate porthandler
		else
			//don't instantiate	
		//is this possible?: need to look into it
		// https://stackoverflow.com/questions/15240591/conditional-instantiation-of-verilog-module
	endgenerate
	
endmodule  //router


/*
 * Router port handler
 */
module portHandler(
	input clk,
	
	//External IO
	input [`NETWORK_ADDRESS_WIDTH -1:0] destinationAddressIn,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn,
	input readIn,
	input writeIn,
	input [`DATA_WIDTH -1:0] dataIn,
		
	output [`NETWORK_ADDRESS_WIDTH -1:0] destinationAddressOut,
	output [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut,
	output readOut,
	output writeOut,
	output [`DATA_WIDTH -1:0] dataOut,
	
	//Internal IO
	)
	
	

endmodule  //portHandler

