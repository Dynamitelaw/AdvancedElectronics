
`timescale 1ns / 1ps

module syncRAM_tb;


 // Inputs

   reg [7:0] dataIn;
   reg [7:0] WA;
   reg [7:0] RA_0;
   reg [7:0] RA_1;
   reg [7:0] RA_2;
   reg [7:0] RA_3;	   
   reg CS;
   reg WE;
   reg RD;
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
	      .WA(WA),
	      .RA_0(RA_0),
	      .RA_1(RA_1),
	      .RA_2(RA_2),
	      .RA_3(RA_3),
  .CS(CS), 
  .WE(WE), 
  .RD(RD), 
  .Clk(Clk)
  );


 initial begin

  // Initialize Inputs

    dataIn  = 8'h0;
    WA  = 8'h0;
    RA_0  = 8'h0;
    RA_1  = 8'h0;
    RA_2  = 8'h0;
    RA_3  = 8'h0;
    CS  = 1'b0;
    WE  = 1'b0;
    RD  = 1'b0;
    Clk  = 1'b0;


  // Wait 100 ns for global reset to finish

  #100;

       

  // Add stimulus here

  dataIn  = 8'h0;
  WA  = 8'h0;
  CS  = 1'b1;
  WE  = 1'b1;
  RD  = 1'b0;
    
  #20;
  dataIn  = 8'h0;
  WA  = 8'h0;

  #20;
  dataIn  = 8'h1;
  WA  = 8'h1;

  #20;
  dataIn  = 8'h10;
  WA  = 8'h2;

  #20;
  dataIn  = 8'h6;
  WA  = 8'h3;

  #20;
  dataIn  = 8'h12;
  WA  = 8'h4;

  #20;
  WE  = 1'b0;
  RD  = 1'b1;

  #20;
  RA_0    = 8'h1;
  RA_1    = 8'h2;
  RA_2    = 8'h3;
  RA_3    = 8'h4;
  #20;
  RA_0    = 8'h4;
  RA_1    = 8'h1;
  RA_2    = 8'h2;
  RA_3    = 8'h3;

  #20;
  RA_0    = 8'h3;
  RA_1    = 8'h4;
  RA_2    = 8'h1;
  RA_3    = 8'h2;
  #20;
  RA_0    = 8'h2;
  RA_1    = 8'h3;
  RA_2    = 8'h4;
  RA_3    = 8'h1;
    

 end

   

 always #10 Clk = ~Clk;

 

endmodule
