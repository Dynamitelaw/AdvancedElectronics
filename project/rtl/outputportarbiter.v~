<<<<<<< HEAD
/*
 * Ouput Port Arbiter
 *
 * Takes the port fowarding desicion of all incomingPortHandlers as inputs, and determines which incoming packet to write to its output. 
 * Impliments contention arbitration and output buffering.
 */
 
=======
/*
 * Ouput Port Arbiter
 *
 * Takes the port fowarding desicion of all incomingPortHandlers as inputs, and determines which incoming packet to write to its output. 
 * Impliments contention arbitration and output buffering.
 */
 
>>>>>>> 06cd6f1ef6982bb44307800ea115c126dba1c554
`include "globalVariables.v"

module outputPortArbiter(
	input clk,
	input reset,
	
	//Input from North Port
	input selectBit_NORTH,
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_NORTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_NORTH,
	input readIn_NORTH,
	input writeIn_NORTH,
	input [`DATA_WIDTH -1:0] dataIn_NORTH,

	
	//Input from South Port
	input selectBit_SOUTH,
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_SOUTH,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_SOUTH,
	input readIn_SOUTH,
	input writeIn_SOUTH,
	input [`DATA_WIDTH -1:0] dataIn_SOUTH,
	
	//Input from East Port
	input selectBit_EAST,
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_EAST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_EAST,
	input readIn_EAST,
	input writeIn_EAST,
	input [`DATA_WIDTH -1:0] dataIn_EAST,
	
	//Input from West Port
	input selectBit_WEST,
	input [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_WEST,
	input [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressIn_WEST,
	input readIn_WEST,
	input writeIn_WEST,
	input [`DATA_WIDTH -1:0] dataIn_WEST,
	
	//Input from Cache Arbiter
	input readReady,
	input [`NETWORK_ADDRESS_WIDTH -1:0] readRequesterAddress,
	input [`DATA_WIDTH -1:0] cacheDataOut,
	
	//Arbiter Output
	output reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressOut,
	output reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressOut,
	output reg readOut,
	output reg writeOut,
	output reg [`DATA_WIDTH -1:0] dataOut

	
	//output reg contentionError  //temporary error to handle contention. Will be gone when buffering is implimented
	);
	
	//Concatenate select bits
	wire [4:0] inputSelection = {readReady, selectBit_WEST, selectBit_EAST, selectBit_SOUTH, selectBit_NORTH};
	
	//registers to save the input and corresponding index
	reg [4:0] inputbuffer;
	reg [`DATA_WIDTH -1:0] databuffer [4:0];
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destAddrbuffer [4:0];
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requestAddrbuffer [4:0];
	reg readbuffer [4:0];
	reg writebuffer [4:0];

	//buffers
	wire write_enable;
	wire empty,full; //indicate weather the buffer is empty or full
	reg [`DATA_WIDTH -1:0] dataoutbuffer [`BUFFER_SIZE-1 :0];
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressbuffer [0:`BUFFER_SIZE-1];
	reg [`NETWORK_ADDRESS_WIDTH -1:0] requesterAddressbuffer [0:`BUFFER_SIZE-1];
	reg readOutbuffer [0:`BUFFER_SIZE-1];
	reg writeOutbuffer [0:`BUFFER_SIZE-1];
	
	reg [`BIT_SIZE-1:0] write_reg, write_next,write_succ;
	reg [`BIT_SIZE-1:0] read_reg, read_next,read_succ;
	reg [`BIT_SIZE:0] blank;
	reg full_reg,empty_reg,full_next,empty_next;

	integer i;

	
	/*
	 * Determine where to place new write requests in the buffer
	 */
	 
		//Incrementer for North buffer index
	wire [1:0] indexIncrementer_NORTH = 1'b0; 
	
		//Incrementer for South buffer index
	reg [1:0] indexIncrementer_SOUTH; 
	integer m;
	always@(inputSelection) begin
	    	indexIncrementer_SOUTH = 0;
	    	for(m=0; m<1;m=m+1) indexIncrementer_SOUTH = indexIncrementer_SOUTH + inputSelection[m];
	end
	
		//Incrementer for East buffer index
	reg [1:0] indexIncrementer_EAST; 
	integer n;
	always@(inputSelection) begin
	    	indexIncrementer_EAST = 0;  
	    	for(n=0;n<2;n=n+1) indexIncrementer_EAST = indexIncrementer_EAST + inputSelection[n];
	end
	
		//Incrementer for West buffer index
	reg [1:0] indexIncrementer_WEST; 
	integer p;
	always@(inputSelection) begin
	    	indexIncrementer_WEST = 0;
	    	for(p=0;p<3;p=p+1) indexIncrementer_WEST = indexIncrementer_WEST + inputSelection[p];
	end

		//Incrementer for West buffer index
	reg [1:0] indexIncrementer_CACHE; 
	integer q;
	always@(inputSelection) begin
	    	indexIncrementer_CACHE = 0;
	    	for(q=0;q<4;q=q+1) indexIncrementer_CACHE  = indexIncrementer_CACHE  + inputSelection[p];
	end
	
		//Wire array to combine increment values
	wire [2:0] inputamount [4:0];
	assign inputamount[0] = indexIncrementer_NORTH;
	assign inputamount[1] = indexIncrementer_SOUTH;
	assign inputamount[2] = indexIncrementer_EAST;
	assign inputamount[3] = indexIncrementer_WEST;
	assign inputamount[4] = indexIncrementer_CACHE;


	assign write_enable = readReady||selectBit_WEST||selectBit_EAST||selectBit_SOUTH||selectBit_NORTH;

	//write operation
	always @(negedge clk) begin
		if (write_enable && ~full) begin
			for(i = 0; i < 5; i = i + 1) begin
				if(inputbuffer[i]) begin
					dataoutbuffer[write_reg + inputamount[i]] <= databuffer[i];
					destinationAddressbuffer[write_reg + inputamount[i]] <= destAddrbuffer[i];
					requesterAddressbuffer[write_reg + inputamount[i]] <= requestAddrbuffer[i];
					readOutbuffer[write_reg + inputamount[i]] <= readbuffer[i];
					writeOutbuffer[write_reg + inputamount[i]] <= writebuffer[i];
				end
			end

		end
	end

	//Handle output writing
	always @ (negedge clk) begin
		if(~empty) begin
			//read out at every posedge when FIFO buffer is not empty
			dataOut <= dataoutbuffer[read_reg];
			destinationAddressOut <= destinationAddressbuffer[read_reg];
			requesterAddressOut <= requesterAddressbuffer[read_reg];
			readOut <= readOutbuffer[read_reg];
			writeOut <= writeOutbuffer[read_reg];
		end
		else begin
			//Nothing in the buffers. Use normal routing protocalls
			case (inputSelection)
				5'b00001 :  begin //North input routed a packet to this output port
					destinationAddressOut <= destinationAddressIn_NORTH;
					requesterAddressOut <= requesterAddressIn_NORTH;
					readOut <= readIn_NORTH;
					writeOut <= writeIn_NORTH;
					dataOut <= dataIn_NORTH;
				end
					
				5'b00010 :  begin //South input routed a packet to this output port
					destinationAddressOut <= destinationAddressIn_SOUTH;
					requesterAddressOut <= requesterAddressIn_SOUTH;
					readOut <= readIn_SOUTH;
					writeOut <= writeIn_SOUTH;
					dataOut <= dataIn_SOUTH;
				end
					
				5'b00100 :  begin //East input routed a packet to this output port
					destinationAddressOut <= destinationAddressIn_EAST;
					requesterAddressOut <= requesterAddressIn_EAST;
					readOut <= readIn_EAST;
					writeOut <= writeIn_EAST;
					dataOut <= dataIn_EAST;
				end
				
				5'b01000 :  begin //West input routed a packet to this output port
					destinationAddressOut <= destinationAddressIn_WEST;
					requesterAddressOut <= requesterAddressIn_WEST;
					readOut <= readIn_WEST;
					writeOut <= writeIn_WEST;
					dataOut <= dataIn_WEST;
				end
				
				5'b10000 :  begin //Read request from cache to send out this port
					destinationAddressOut <= readRequesterAddress;
					requesterAddressOut <= readRequesterAddress;
					readOut <= 1;
					writeOut <= 0;
					dataOut <= cacheDataOut;
				end
					
				5'b00000 :  begin //No packet routed to this output port
					readOut <= 0;
					writeOut <= 0;
				end
			endcase
		end
	end

	
	always @ (negedge clk) begin
		if(reset) begin
			write_reg <= 0;
			read_reg <= 0;
			full_reg <= 1'b0;
			empty_reg <= 1'b1;
			blank <= 1'b1;
		end

		else begin
			write_reg <= write_next;
			read_reg <= read_next;
			full_reg <= full_next;
			empty_reg <= empty_next;
		end
	end

	always @ (*) begin
		databuffer[4] = cacheDataOut;
		databuffer[3] = dataIn_WEST;
		databuffer[2] = dataIn_EAST;
		databuffer[1] = dataIn_SOUTH;
		databuffer[0] = dataIn_NORTH;

		destAddrbuffer[4] = readRequesterAddress;
		destAddrbuffer[3] = destinationAddressIn_WEST;
		destAddrbuffer[2] = destinationAddressIn_EAST;
		destAddrbuffer[1] = destinationAddressIn_SOUTH;
		destAddrbuffer[0] = destinationAddressIn_NORTH;

		requestAddrbuffer[4] = readRequesterAddress;
		requestAddrbuffer[3] = requesterAddressIn_WEST;
		requestAddrbuffer[2] = requesterAddressIn_EAST;
		requestAddrbuffer[1] = requesterAddressIn_SOUTH;
		requestAddrbuffer[0] = requesterAddressIn_NORTH;

		readbuffer[4] = 1;
		readbuffer[3] = readIn_WEST;
		readbuffer[2] = readIn_EAST;
		readbuffer[1] = readIn_SOUTH;
		readbuffer[0] = readIn_NORTH;

		writebuffer[4] = 0;
		writebuffer[3] = writeIn_WEST;
		writebuffer[2] = writeIn_EAST;
		writebuffer[1] = writeIn_SOUTH;
		writebuffer[0] = writeIn_NORTH;

		inputbuffer[4] = readReady;
		inputbuffer[3] = selectBit_WEST;
		inputbuffer[2] = selectBit_EAST;
		inputbuffer[1] = selectBit_SOUTH;
		inputbuffer[0] = selectBit_NORTH;
		//inputamount <= readReady + selectBit_WEST + selectBit_EAST + selectBit_SOUTH + selectBit_NORTH;
		

		//write_succ = write_reg + readReady + selectBit_WEST + selectBit_EAST + selectBit_SOUTH + selectBit_NORTH;
		write_succ = readReady + selectBit_WEST + selectBit_EAST + selectBit_SOUTH + selectBit_NORTH;
		read_succ = read_reg + 1;

		write_next = write_reg;  
		read_next = read_reg; 
		full_next = full_reg; 
		empty_next = empty_reg;  

		if(~empty) begin
			read_next = read_succ;  
			full_next = 1'b0;  
			if(read_succ == write_reg)
				empty_next = 1'b1;  
		end
		if(~full && write_enable) begin   

			if(read_reg > write_reg) 
				blank = read_reg - write_reg;
			else
				blank = read_reg + `BUFFER_SIZE - write_reg;
			if(write_succ > blank)
				write_succ = write_reg;
			else 
				write_succ = write_succ + write_reg;
				write_next = write_succ;
				empty_next = 1'b0; 

			if(write_succ == read_reg)
				full_next = 1'b1;  
		end
	end

	assign full = full_reg;
	assign empty = empty_reg;
		
endmodule  //outputPortArbiter
