`include "globalVariables.v"

module cacheAccessArbiter(
	input clk,
	input reset,
	
	//Input from North Port
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_NORTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH,
	input memRead_NORTH,
	input memWrite_NORTH,
	input [`DATA_WIDTH -1:0] dataIn_NORTH,
	
	output reg readReady_NORTH,
	output reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_NORTH,
	
	//Input from South Port
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_SOUTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH,
	input memRead_SOUTH,
	input memWrite_SOUTH,
	input [`DATA_WIDTH -1:0] dataIn_SOUTH,
	
	output reg readReady_SOUTH,
	output reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_SOUTH,
	
	//Input from East Port
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_EAST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST,
	input memRead_EAST,
	input memWrite_EAST,
	input [`DATA_WIDTH -1:0] dataIn_EAST,
	
	output reg readReady_EAST,
	output reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_EAST,
	
	//Input from West Port
	input [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheAddressIn_WEST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST,
	input memRead_WEST,
	input memWrite_WEST,
	input [`DATA_WIDTH -1:0] dataIn_WEST,
	
	output reg readReady_WEST,
	output reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut_WEST,
	
	//Cache bank IO
	output reg [`DATA_WIDTH -1:0] cacheDataIn,
	output reg [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheWriteAddressIn,
	output wire memRead,
	output reg memWrite,
	
	output wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheReadAddress_0,  //North's port
	output wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheReadAddress_1,  //South's port
	output wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheReadAddress_2,  //East's port
	output wire [`CACHE_BANK_ADDRESS_WIDTH -1:0] cacheReadAddress_3  //West's port
	);
	
	
	wire [3:0] localWrites = {memWrite_WEST, memWrite_EAST, memWrite_SOUTH, memWrite_NORTH};  //Concatenate local write signals
	
	//Read wire assignments
	assign memRead = memRead_WEST || memRead_EAST|| memRead_SOUTH || memRead_NORTH;
	assign cacheReadAddress_0 = cacheAddressIn_NORTH;
	assign cacheReadAddress_1 = cacheAddressIn_SOUTH;
	assign cacheReadAddress_2 = cacheAddressIn_EAST;
	assign cacheReadAddress_3 = cacheAddressIn_WEST;
	
	reg prevMemRead_NORTH;
	reg prevMemRead_SOUTH;
	reg prevMemRead_EAST;
	reg prevMemRead_WEST;
	
	reg [`NETWORK_ADDRESS_WIDTH -1:0] prevRequesterAddress_NORTH;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] prevRequesterAddress_SOUTH;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] prevRequesterAddress_EAST;
	reg [`NETWORK_ADDRESS_WIDTH -1:0] prevRequesterAddress_WEST;
	
	reg [`DATA_WIDTH -1:0] dataToWriteBuffer [`BUFFER_SIZE-1 :0];
	reg [`NETWORK_ADDRESS_WIDTH -1:0] addressToWriteBuffer [`BUFFER_SIZE-1:0];
	reg [1:0] isReadOrWrite [`BUFFER_SIZE-1:0];
	reg [`BUFFER_SIZE-1:0] bufferWrittenToTracker;
	integer i;
	integer j;
	integer k;
	reg [4:0] ones;
	reg [`BUFFER_SIZE:0] A;
	
	
	initial begin	
	bufferWrittenToTracker = {`BUFFER_SIZE{1'b0}};
	end

	always @ (posedge clk) begin
		//Synchronous reset
		if (reset) begin
			cacheDataIn <= 0;
			cacheWriteAddressIn <= 0;
			memWrite <= 0;
			
			prevMemRead_NORTH <= 0;
			prevMemRead_SOUTH <= 0;
			prevMemRead_EAST <= 0;
			prevMemRead_WEST <= 0;
		end
		
		else begin //if nothing in buffer, regularly send out data as was being sent out in router.v
			if (bufferWrittenToTracker == {`BUFFER_SIZE{1'b0}}) begin
				case (localWrites)
				//No local writes
				4'b0000 : begin
					memWrite <= 0;
				end
				//Write from north port
				4'b0001 : begin
					memWrite <= 1;
					cacheDataIn <= dataIn_NORTH;
					cacheWriteAddressIn <= cacheAddressIn_NORTH;
				end
				//Write from south port
				4'b0010 : begin
					memWrite <= 1;
					cacheDataIn <= dataIn_SOUTH;
					cacheWriteAddressIn <= cacheAddressIn_SOUTH;
				end
				//Write from east port
				4'b0100 : begin
					memWrite <= 1;
					cacheDataIn <= dataIn_EAST;
					cacheWriteAddressIn <= cacheAddressIn_EAST;
				end
				//Write from west port
				4'b1000 : begin
					memWrite <= 1;
					cacheDataIn <= dataIn_WEST;
					cacheWriteAddressIn <= cacheAddressIn_WEST;
				end
				endcase
			end
			else begin 
			// if buffer has something in it, then we iterate through the register bufferWrittenToTracker to see if anything has been written to that buffer position, if buffer position is empty, we write to it, update bufferWrittenToTracker, and move to the next buffer position
				for (i=0; i < `BUFFER_SIZE; i=i+1) begin
					if (bufferWrittenToTracker[i] == 1'b0) begin
						if (memWrite_NORTH == 1'b1) begin
							dataToWriteBuffer[i] = dataIn_NORTH;
							addressToWriteBuffer[i] = cacheAddressIn_NORTH;
							bufferWrittenToTracker[i] = 1'b1;
							i=i+1;
						end
						if (memWrite_SOUTH == 1'b1) begin
							dataToWriteBuffer[i] = dataIn_SOUTH;
							addressToWriteBuffer[i] = cacheAddressIn_SOUTH;
							bufferWrittenToTracker[i] = 1'b1;
							i=i+1;
						end
						if (memWrite_EAST == 1'b1) begin
							dataToWriteBuffer[i] = dataIn_EAST;
							addressToWriteBuffer[i] = cacheAddressIn_EAST;
							bufferWrittenToTracker[i] = 1'b1;
							i=i+1;
						end
						if (memWrite_WEST == 1'b1) begin
							dataToWriteBuffer[i] = dataIn_WEST;
							addressToWriteBuffer[i] = cacheAddressIn_WEST;
							bufferWrittenToTracker[i] = 1'b1;
							i=i+1;
						end
					end
				end
				//num_ones_for( . bufferWrittenToTracker(bufferWrittenToTracker), .ones(ones) ); // this module checks how many buffer positions have been written to
				for (j=0; j < ones; j=j+1) begin
				// here we send out the data in the first buffer position, and move the rest up one in the stack
					if (j==0) begin
						cacheDataIn = dataToWriteBuffer[j];
						cacheWriteAddressIn = addressToWriteBuffer[i];
					end
					else begin 
						dataToWriteBuffer[j] = dataToWriteBuffer[j+1];
						addressToWriteBuffer[j] = addressToWriteBuffer[j+1];
					end
					
				end	
				bufferWrittenToTracker[ones] = 1'b0; //	here we set last buffer position that had been written to empty as we have moved everything up one
			end
		end
	end
	always@(A)
	begin
    	ones = 0;  //initialize count variable.
    	for(k=0;k<`BUFFER_SIZE;k=k+1)   //for all the bits.
        	ones = ones + A[k]; //Add the bit to the count.
	end
endmodule 
 
//module num_ones_for(
 //   input [`BUFFER_SIZE:0] A,
 //   output reg [4:0] ones
 //   );
//integer k;


//endmodule
