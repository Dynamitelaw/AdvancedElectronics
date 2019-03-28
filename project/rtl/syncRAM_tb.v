
`timescale 1ns / 1ps

module syncRAM_tb;


 // Inputs

   reg [7:0] dataIn;
   reg [7:0] writeAddr;
   reg [7:0] readAddr_0;
   reg [7:0] readAddr_1;
   reg [7:0] readAddr_2;
   reg [7:0] readAddr_3;	   
   reg chipSelect;
   reg writeEnable;
   reg readEnable;
   reg Clk;
 // Outputs

   wire [7:0] dOut_0;
   wire [7:0] dOut_1;
   wire [7:0] dOut_2;
   wire [7:0] dOut_3;


 // Instantiate the Unit Under Test (UUT)

 syncRAM uut (
	      .dataIn(dataIn), 
	      .dOut_0(dOut_0), 
	      .dOut_1(dOut_1),
	      .dOut_2(dOut_2), 
	      .dOut_3(dOut_3),
	      .writeAddr(writeAddr),
	      .readAddr_0(readAddr_0),
	      .readAddr_1(readAddr_1),
	      .readAddr_2(readAddr_2),
	      .readAddr_3(readAddr_3),
  .chipSelect(chipSelect), 
  .writeEnable(writeEnable), 
  .readEnable(readEnable), 
  .Clk(Clk)
  );


 initial begin

  // Initialize Inputs

    dataIn  = 8'h0;
    writeAddr  = 8'h0;
    readAddr_0  = 8'h0;
    readAddr_1  = 8'h0;
    readAddr_2  = 8'h0;
    readAddr_3  = 8'h0;
    chipSelect  = 1'b0;
    writeEnable  = 1'b0;
    readEnable  = 1'b0;
    Clk  = 1'b0;


  // writeAddrit 100 ns for global reset to finish

  #100;

       

  // Add stimulus here

  dataIn  = 8'h0;
  writeAddr  = 8'h0;
  chipSelect  = 1'b1;
  writeEnable  = 1'b1;
  readEnable  = 1'b0;
    
  #20;
  dataIn  = 8'h0;
  writeAddr  = 8'h0;

  #20;
  dataIn  = 8'h1;
  writeAddr  = 8'h1;

  #20;
  dataIn  = 8'h10;
  writeAddr  = 8'h2;

  #20;
  dataIn  = 8'h6;
  writeAddr  = 8'h3;

  #20;
  dataIn  = 8'h12;
  writeAddr  = 8'h4;

  #20;
  writeEnable  = 1'b0;
  readEnable  = 1'b1;

  #20;
  readAddr_0    = 8'h1;
  readAddr_1    = 8'h2;
  readAddr_2    = 8'h3;
  readAddr_3    = 8'h4;
  #20;
  readAddr_0    = 8'h4;
  readAddr_1    = 8'h1;
  readAddr_2    = 8'h2;
  readAddr_3    = 8'h3;

  #20;
  readAddr_0    = 8'h3;
  readAddr_1    = 8'h4;
  readAddr_2    = 8'h1;
  readAddr_3    = 8'h2;
  #20;
  readAddr_0    = 8'h2;
  readAddr_1    = 8'h3;
  readAddr_2    = 8'h4;
  readAddr_3    = 8'h1;
    

 end

   

 always #10 Clk = ~Clk;

 

endmodule
