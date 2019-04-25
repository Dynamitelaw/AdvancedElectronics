module NetworkGeneratedTestBench ;
	reg reset = 0;
	reg clk = 0;

	/*
	 * Network IO
	 */
	//Access port 0
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_port0;
	reg readIn_port0;
	reg writeIn_port0;
	reg [`DATA_WIDTH -1:0] dataIn_port0;

	wire readReady_port0;
	wire [`DATA_WIDTH -1:0] dataOut_port0;

	//Access port 1
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_port1;
	reg readIn_port1;
	reg writeIn_port1;
	reg [`DATA_WIDTH -1:0] dataIn_port1;

	wire readReady_port1;
	wire [`DATA_WIDTH -1:0] dataOut_port1;

	//Access port 2
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_port2;
	reg readIn_port2;
	reg writeIn_port2;
	reg [`DATA_WIDTH -1:0] dataIn_port2;

	wire readReady_port2;
	wire [`DATA_WIDTH -1:0] dataOut_port2;

	//Access port 3
	reg [`NETWORK_ADDRESS_WIDTH + `CACHE_BANK_ADDRESS_WIDTH -1:0] destinationAddressIn_port3;
	reg readIn_port3;
	reg writeIn_port3;
	reg [`DATA_WIDTH -1:0] dataIn_port3;

	wire readReady_port3;
	wire [`DATA_WIDTH -1:0] dataOut_port3;

	/*
	 * Instantiate network
	 */
	network Network(
		.clk(clk),
		.reset(reset),
		//Access port 0 (North/Top)
		.destinationAddressIn_port0(destinationAddressIn_port0),
		.readIn_port0(readIn_port0),
		.writeIn_port0(writeIn_port0),
		.dataIn_port0(dataIn_port0),
		.readReady_port0(readReady_port0),
		.dataOut_port0(dataOut_port0),
		//Access port 1 (South/Bottom)
		.destinationAddressIn_port1(destinationAddressIn_port1),
		.readIn_port1(readIn_port1),
		.writeIn_port1(writeIn_port1),
		.dataIn_port1(dataIn_port1),
		.readReady_port1(readReady_port1),
		.dataOut_port1(dataOut_port1),
		//Access port 2 (East/Right)
		.destinationAddressIn_port2(destinationAddressIn_port2),
		.readIn_port2(readIn_port2),
		.writeIn_port2(writeIn_port2),
		.dataIn_port2(dataIn_port2),
		.readReady_port2(readReady_port2),
		.dataOut_port2(dataOut_port2),
		//Access port (West/Left)
		.destinationAddressIn_port3(destinationAddressIn_port3),
		.readIn_port3(readIn_port3),
		.writeIn_port3(writeIn_port3),
		.dataIn_port3(dataIn_port3),
		.readReady_port3(readReady_port3),
		.dataOut_port3(dataOut_port3)
		);

	//Regs to store expected values of reads
	reg [`DATA_WIDTH -1:0] expectedData_port0 = 0;
	reg [`DATA_WIDTH -1:0] expectedData_port1 = 0;
	reg [`DATA_WIDTH -1:0] expectedData_port2 = 0;
	reg [`DATA_WIDTH -1:0] expectedData_port3 = 0;

	reg error = 0;


	initial begin
		//Reset network
		reset <= 1;
		#1

		//Posedge
		#1
		//Negedge
		#1

		//Posedge
		reset <= 0;
		#1
		//Negedge
		#1

		//===========================
		// Start reading and writing
		//===========================
