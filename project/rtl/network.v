/*
 * Network Top module
 *
 * Jose Rubianes (jer2201)
 */
 

//Include dependencies
`include "globalVariables.v"
`include "router.v"
//`include "cacheBank.v"
`include "cacheBank_new.v"
//`include "../dc_shell_cmrf8sf/router.nl.v"


module network(
	input clk,
	input reset,
	
	//Access port 0 (North/Top)
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_port0,
	input readIn_port0,
	input writeIn_port0,
	input [`DATA_WIDTH -1:0] dataIn_port0,
	
	output wire readReady_port0,
	output wire [`DATA_WIDTH -1:0] dataOut_port0,
	
	//Access port 1 (South/Bottom)
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_port1,
	input readIn_port1,
	input writeIn_port1,
	input [`DATA_WIDTH -1:0] dataIn_port1,
	
	output wire readReady_port1,
	output wire [`DATA_WIDTH -1:0] dataOut_port1,
	
	//Access port 2 (East/Right)
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_port2,
	input readIn_port2,
	input writeIn_port2,
	input [`DATA_WIDTH -1:0] dataIn_port2,
	
	output wire readReady_port2,
	output wire [`DATA_WIDTH -1:0] dataOut_port2,
	
	//Access port (West/Left)
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_port3,
	input readIn_port3,
	input writeIn_port3,
	input [`DATA_WIDTH -1:0] dataIn_port3,
	
	output wire readReady_port3,
	output wire [`DATA_WIDTH -1:0] dataOut_port3
	);
	
	
	parameter networkHeight = `NETWORK_HEIGHT;
	parameter networkWidth = `NETWORK_WIDTH;
	
	parameter port0_NodeID = networkWidth/2;
	parameter port1_NodeID = (networkHeight-1)*networkWidth + networkWidth/2;
	parameter port2_NodeID = (networkHeight/2)*networkWidth;
	parameter port3_NodeID = ((networkHeight-1)/2)*networkWidth;
	
	genvar NodeID;
	generate
		/*
		 * Generate router instances and IO buses
		 */
		for (NodeID = 0; NodeID < networkHeight*networkWidth; NodeID = NodeID+1)
		begin : Node			
			//North IO
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_NORTH;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH;
			wire readIn_NORTH;
			wire writeIn_NORTH;
			wire [`DATA_WIDTH -1:0] dataIn_NORTH;
			
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_NORTH;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_NORTH;
			wire readOut_NORTH;
			wire writeOut_NORTH;
			wire [`DATA_WIDTH -1:0] dataOut_NORTH;

			//South IO
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_SOUTH;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH;
			wire readIn_SOUTH;
			wire writeIn_SOUTH;
			wire [`DATA_WIDTH -1:0] dataIn_SOUTH;
			
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_SOUTH;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_SOUTH;
			wire readOut_SOUTH;
			wire writeOut_SOUTH;
			wire [`DATA_WIDTH -1:0] dataOut_SOUTH;

			//East IO
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_EAST;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST;
			wire readIn_EAST;
			wire writeIn_EAST;
			wire [`DATA_WIDTH -1:0] dataIn_EAST;
			
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_EAST;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_EAST;
			wire readOut_EAST;
			wire writeOut_EAST;
			wire [`DATA_WIDTH -1:0] dataOut_EAST;

			//West IO
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_WEST;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST;
			wire readIn_WEST;
			wire writeIn_WEST;
			wire [`DATA_WIDTH -1:0] dataIn_WEST;
			
			wire [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut_WEST;
			wire [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_WEST;
			wire readOut_WEST;
			wire writeOut_WEST;
			wire [`DATA_WIDTH -1:0] dataOut_WEST;
			
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
				.localRouterAddress(NodeID),
	
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
		end
		
		/*
		 * Connect IO buses in mesh topology
		 */
		for (NodeID = 0; NodeID < networkHeight*networkWidth; NodeID = NodeID+1)
		begin : BusConnections
			//Connect north inputs
			if (NodeID >= networkWidth) begin
				assign Node[NodeID].destinationAddressIn_NORTH = Node[NodeID-networkWidth].destinationAddressOut_SOUTH;
				assign Node[NodeID].requesterAddressIn_NORTH = Node[NodeID-networkWidth].requesterAddressOut_SOUTH;
				assign Node[NodeID].readIn_NORTH = Node[NodeID-networkWidth].readOut_SOUTH;
				assign Node[NodeID].writeIn_NORTH = Node[NodeID-networkWidth].writeOut_SOUTH;
				assign Node[NodeID].dataIn_NORTH = Node[NodeID-networkWidth].dataOut_SOUTH;
			end
			else if (NodeID != port0_NodeID) begin
				assign Node[NodeID].destinationAddressIn_NORTH = 0;
				assign Node[NodeID].requesterAddressIn_NORTH = 0;
				assign Node[NodeID].readIn_NORTH = 0;
				assign Node[NodeID].writeIn_NORTH = 0;
				assign Node[NodeID].dataIn_NORTH = 0;
			end
			
			//Connect south inputs
			if (NodeID < networkHeight*networkWidth - networkWidth) begin
				assign Node[NodeID].destinationAddressIn_SOUTH = Node[NodeID+networkWidth].destinationAddressOut_NORTH;
				assign Node[NodeID].requesterAddressIn_SOUTH = Node[NodeID+networkWidth].requesterAddressOut_NORTH;
				assign Node[NodeID].readIn_SOUTH = Node[NodeID+networkWidth].readOut_NORTH;
				assign Node[NodeID].writeIn_SOUTH = Node[NodeID+networkWidth].writeOut_NORTH;
				assign Node[NodeID].dataIn_SOUTH = Node[NodeID+networkWidth].dataOut_NORTH;
			end
			else if (NodeID != port1_NodeID) begin
				assign Node[NodeID].destinationAddressIn_SOUTH = 0;
				assign Node[NodeID].requesterAddressIn_SOUTH = 0;
				assign Node[NodeID].readIn_SOUTH = 0;
				assign Node[NodeID].writeIn_SOUTH = 0;
				assign Node[NodeID].dataIn_SOUTH = 0;
			end
			
			//Connect east inputs
			if ((NodeID+1)%networkWidth != 0) begin
				assign Node[NodeID].destinationAddressIn_EAST = Node[NodeID+1].destinationAddressOut_WEST;
				assign Node[NodeID].requesterAddressIn_EAST = Node[NodeID+1].requesterAddressOut_WEST;
				assign Node[NodeID].readIn_EAST = Node[NodeID+1].readOut_WEST;
				assign Node[NodeID].writeIn_EAST = Node[NodeID+1].writeOut_WEST;
				assign Node[NodeID].dataIn_EAST = Node[NodeID+1].dataOut_WEST;
			end
			else if (NodeID != port2_NodeID) begin
				assign Node[NodeID].destinationAddressIn_EAST = 0;
				assign Node[NodeID].requesterAddressIn_EAST = 0;
				assign Node[NodeID].readIn_EAST = 0;
				assign Node[NodeID].writeIn_EAST = 0;
				assign Node[NodeID].dataIn_EAST = 0;
			end
			
			//Connect west inputs
			if (NodeID%networkWidth != 0) begin
				assign Node[NodeID].destinationAddressIn_WEST = Node[NodeID-1].destinationAddressOut_EAST;
				assign Node[NodeID].requesterAddressIn_WEST = Node[NodeID-1].requesterAddressOut_EAST;
				assign Node[NodeID].readIn_WEST = Node[NodeID-1].readOut_EAST;
				assign Node[NodeID].writeIn_WEST = Node[NodeID-1].writeOut_EAST;
				assign Node[NodeID].dataIn_WEST = Node[NodeID-1].dataOut_EAST;
			end
			else if (NodeID != port3_NodeID) begin
				assign Node[NodeID].destinationAddressIn_WEST = 0;
				assign Node[NodeID].requesterAddressIn_WEST = 0;
				assign Node[NodeID].readIn_WEST = 0;
				assign Node[NodeID].writeIn_WEST = 0;
				assign Node[NodeID].dataIn_WEST = 0;
			end
		end
		
		
		/*
		 * Connect access ports
		 */
		
		//Port 0 (North/Top)
		assign Node[port0_NodeID].destinationAddressIn_NORTH = destinationAddressIn_port0;
		assign Node[port0_NodeID].requesterAddressIn_NORTH = port0_NodeID;
		assign Node[port0_NodeID].readIn_NORTH = readIn_port0;
		assign Node[port0_NodeID].writeIn_NORTH = writeIn_port0;
		assign Node[port0_NodeID].dataIn_NORTH = dataIn_port0;
		
		responseCatcher responseCatcher_0(
			.clk(clk),
			.reset(reset),
			//Access port IO
			.localAddress(port0_NodeID),
			.readyReady(readReady_port0),
			.dataOut(dataOut_port0),
			//portA probes
			.requesterAddressIn_A(Node[port0_NodeID].requesterAddressIn_SOUTH),
			.readIn_A(Node[port0_NodeID].readIn_SOUTH),
			.dataIn_A(Node[port0_NodeID].dataIn_SOUTH),
			//portA probes
			.requesterAddressIn_B(Node[port0_NodeID].requesterAddressIn_EAST),
			.readIn_B(Node[port0_NodeID].readIn_EAST),
			.dataIn_B(Node[port0_NodeID].dataIn_EAST),
			//portA probes
			.requesterAddressIn_C(Node[port0_NodeID].requesterAddressIn_WEST),
			.readIn_C(Node[port0_NodeID].readIn_WEST),
			.dataIn_C(Node[port0_NodeID].dataIn_WEST)
			);
		
		//Port 1 (South/Bottom)
		assign Node[port1_NodeID].destinationAddressIn_SOUTH = destinationAddressIn_port1;
		assign Node[port1_NodeID].requesterAddressIn_SOUTH = port1_NodeID;
		assign Node[port1_NodeID].readIn_SOUTH = readIn_port1;
		assign Node[port1_NodeID].writeIn_SOUTH = writeIn_port1;
		assign Node[port1_NodeID].dataIn_SOUTH = dataIn_port1;
		
		responseCatcher responseCatcher_1(
			.clk(clk),
			.reset(reset),
			//Access port IO
			.localAddress(port1_NodeID),
			.readyReady(readReady_port1),
			.dataOut(dataOut_port1),
			//portA probes
			.requesterAddressIn_A(Node[port1_NodeID].requesterAddressIn_NORTH),
			.readIn_A(Node[port1_NodeID].readIn_NORTH),
			.dataIn_A(Node[port1_NodeID].dataIn_NORTH),
			//portB probes
			.requesterAddressIn_B(Node[port1_NodeID].requesterAddressIn_EAST),
			.readIn_B(Node[port1_NodeID].readIn_EAST),
			.dataIn_B(Node[port1_NodeID].dataIn_EAST),
			//portC probes
			.requesterAddressIn_C(Node[port1_NodeID].requesterAddressIn_WEST),
			.readIn_C(Node[port1_NodeID].readIn_WEST),
			.dataIn_C(Node[port1_NodeID].dataIn_WEST)
			);
		
		//Port 2 (East/Right)
		assign Node[port2_NodeID].destinationAddressIn_EAST = destinationAddressIn_port2;
		assign Node[port2_NodeID].requesterAddressIn_EAST = port2_NodeID;
		assign Node[port2_NodeID].readIn_EAST = readIn_port2;
		assign Node[port2_NodeID].writeIn_EAST = writeIn_port2;
		assign Node[port2_NodeID].dataIn_EAST = dataIn_port2;
		
		responseCatcher responseCatcher_2(
			.clk(clk),
			.reset(reset),
			//Access port IO
			.localAddress(port2_NodeID),
			.readyReady(readReady_port2),
			.dataOut(dataOut_port2),
			//portA probes
			.requesterAddressIn_A(Node[port2_NodeID].requesterAddressIn_NORTH),
			.readIn_A(Node[port2_NodeID].readIn_NORTH),
			.dataIn_A(Node[port2_NodeID].dataIn_NORTH),
			//portB probes
			.requesterAddressIn_B(Node[port2_NodeID].requesterAddressIn_SOUTH),
			.readIn_B(Node[port2_NodeID].readIn_SOUTH),
			.dataIn_B(Node[port2_NodeID].dataIn_SOUTH),
			//portC probes
			.requesterAddressIn_C(Node[port2_NodeID].requesterAddressIn_WEST),
			.readIn_C(Node[port2_NodeID].readIn_WEST),
			.dataIn_C(Node[port2_NodeID].dataIn_WEST)
			);
		
		//Port 3 (West/Left)
		assign Node[port3_NodeID].destinationAddressIn_WEST = destinationAddressIn_port3;
		assign Node[port3_NodeID].requesterAddressIn_WEST = port3_NodeID;
		assign Node[port3_NodeID].readIn_WEST = readIn_port3;
		assign Node[port3_NodeID].writeIn_WEST = writeIn_port3;
		assign Node[port3_NodeID].dataIn_WEST = dataIn_port3;
		
		responseCatcher responseCatcher_3(
			.clk(clk),
			.reset(reset),
			//Access port IO
			.localAddress(port3_NodeID),
			.readyReady(readReady_port3),
			.dataOut(dataOut_port3),
			//portA probes
			.requesterAddressIn_A(Node[port3_NodeID].requesterAddressIn_NORTH),
			.readIn_A(Node[port3_NodeID].readIn_NORTH),
			.dataIn_A(Node[port3_NodeID].dataIn_NORTH),
			//portB probes
			.requesterAddressIn_B(Node[port3_NodeID].requesterAddressIn_SOUTH),
			.readIn_B(Node[port3_NodeID].readIn_SOUTH),
			.dataIn_B(Node[port3_NodeID].dataIn_SOUTH),
			//portC probes
			.requesterAddressIn_C(Node[port3_NodeID].requesterAddressIn_EAST),
			.readIn_C(Node[port3_NodeID].readIn_EAST),
			.dataIn_C(Node[port3_NodeID].dataIn_EAST)
			);
			
	endgenerate
	
	/*
	initial begin
		$display("Port 0 ID = %d\n", port0_NodeID);
		$display("Port 1 ID = %d\n", port1_NodeID);
		$display("Port 2 ID = %d\n", port2_NodeID);
		$display("Port 3 ID = %d\n", port3_NodeID);
	end
	*/
endmodule


/*
 *
 */
module responseCatcher(
	input clk,
	input reset,
	
	//Access port IO
	input [`NETWORK_ADDRESS_WIDTH -1:0] localAddress,
	output reg readyReady,
	output reg [`DATA_WIDTH -1:0] dataOut,
	
	//portA probes
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_A,
	input readIn_A,
	input [`DATA_WIDTH -1:0] dataIn_A,
	
	//portB probes
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_B,
	input readIn_B,
	input [`DATA_WIDTH -1:0] dataIn_B,
	
	//portC probes
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_C,
	input readIn_C,
	input [`DATA_WIDTH -1:0] dataIn_C
	);
	
	always @ (posedge clk) begin
		if (reset) begin
			readyReady <= 0;
			dataOut <= 0;
		end
		
		else begin
			if (requesterAddressIn_A == localAddress) begin
				readyReady <= readIn_A;
				dataOut <= dataIn_A;
			end
			
			else if (requesterAddressIn_B == localAddress) begin
				readyReady <= readIn_B;
				dataOut <= dataIn_B;
			end
			
			else if (requesterAddressIn_C == localAddress) begin
				readyReady <= readIn_C;
				dataOut <= dataIn_C;
			end
			
			else begin
				readyReady <= 0;
			end
		end
	end
endmodule
