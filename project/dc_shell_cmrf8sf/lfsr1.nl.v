
module lfsr1 ( clk, resetn, lfsr_out );
  output [27:0] lfsr_out;
  input clk, resetn;
  wire   n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14;

  DFFRXLTS \lfsr_out_reg[1]  ( .D(lfsr_out[0]), .CK(clk), .RN(n8), .Q(
        lfsr_out[1]) );
  DFFRXLTS \lfsr_out_reg[2]  ( .D(lfsr_out[1]), .CK(clk), .RN(n8), .Q(
        lfsr_out[2]) );
  DFFRXLTS \lfsr_out_reg[3]  ( .D(lfsr_out[2]), .CK(clk), .RN(n8), .Q(
        lfsr_out[3]) );
  DFFRXLTS \lfsr_out_reg[4]  ( .D(lfsr_out[3]), .CK(clk), .RN(n9), .Q(
        lfsr_out[4]) );
  DFFRXLTS \lfsr_out_reg[5]  ( .D(lfsr_out[4]), .CK(clk), .RN(n9), .Q(
        lfsr_out[5]) );
  DFFRXLTS \lfsr_out_reg[6]  ( .D(lfsr_out[5]), .CK(clk), .RN(n9), .Q(
        lfsr_out[6]) );
  DFFRXLTS \lfsr_out_reg[7]  ( .D(lfsr_out[6]), .CK(clk), .RN(n9), .Q(
        lfsr_out[7]) );
  DFFRXLTS \lfsr_out_reg[8]  ( .D(lfsr_out[7]), .CK(clk), .RN(n10), .Q(
        lfsr_out[8]) );
  DFFRXLTS \lfsr_out_reg[9]  ( .D(lfsr_out[8]), .CK(clk), .RN(n10), .Q(
        lfsr_out[9]) );
  DFFRXLTS \lfsr_out_reg[10]  ( .D(lfsr_out[9]), .CK(clk), .RN(n10), .Q(
        lfsr_out[10]) );
  DFFRXLTS \lfsr_out_reg[11]  ( .D(lfsr_out[10]), .CK(clk), .RN(n10), .Q(
        lfsr_out[11]) );
  DFFRXLTS \lfsr_out_reg[12]  ( .D(lfsr_out[11]), .CK(clk), .RN(n11), .Q(
        lfsr_out[12]) );
  DFFRXLTS \lfsr_out_reg[13]  ( .D(lfsr_out[12]), .CK(clk), .RN(n11), .Q(
        lfsr_out[13]) );
  DFFRXLTS \lfsr_out_reg[14]  ( .D(lfsr_out[13]), .CK(clk), .RN(n11), .Q(
        lfsr_out[14]) );
  DFFRXLTS \lfsr_out_reg[15]  ( .D(lfsr_out[14]), .CK(clk), .RN(n11), .Q(
        lfsr_out[15]) );
  DFFRXLTS \lfsr_out_reg[17]  ( .D(lfsr_out[16]), .CK(clk), .RN(n12), .Q(
        lfsr_out[17]) );
  DFFRXLTS \lfsr_out_reg[18]  ( .D(lfsr_out[17]), .CK(clk), .RN(n12), .Q(
        lfsr_out[18]) );
  DFFRXLTS \lfsr_out_reg[19]  ( .D(lfsr_out[18]), .CK(clk), .RN(n12), .Q(
        lfsr_out[19]) );
  DFFRXLTS \lfsr_out_reg[20]  ( .D(lfsr_out[19]), .CK(clk), .RN(n13), .Q(
        lfsr_out[20]) );
  DFFRXLTS \lfsr_out_reg[21]  ( .D(lfsr_out[20]), .CK(clk), .RN(n13), .Q(
        lfsr_out[21]) );
  DFFRXLTS \lfsr_out_reg[22]  ( .D(lfsr_out[21]), .CK(clk), .RN(n13), .Q(
        lfsr_out[22]) );
  DFFRXLTS \lfsr_out_reg[24]  ( .D(lfsr_out[23]), .CK(clk), .RN(n14), .Q(
        lfsr_out[24]) );
  DFFRXLTS \lfsr_out_reg[25]  ( .D(lfsr_out[24]), .CK(clk), .RN(n14), .Q(
        lfsr_out[25]) );
  DFFRXLTS \lfsr_out_reg[26]  ( .D(lfsr_out[25]), .CK(clk), .RN(n14), .Q(
        lfsr_out[26]) );
  DFFRXLTS \lfsr_out_reg[27]  ( .D(lfsr_out[26]), .CK(clk), .RN(n14), .Q(
        lfsr_out[27]) );
  DFFRXLTS \lfsr_out_reg[23]  ( .D(lfsr_out[22]), .CK(clk), .RN(n13), .Q(
        lfsr_out[23]) );
  DFFRXLTS \lfsr_out_reg[0]  ( .D(n3), .CK(clk), .RN(n8), .Q(lfsr_out[0]) );
  DFFRXLTS \lfsr_out_reg[16]  ( .D(lfsr_out[15]), .CK(clk), .RN(n12), .Q(
        lfsr_out[16]) );
  XOR2XLTS U6 ( .A(lfsr_out[0]), .B(n6), .Y(n7) );
  XOR2XLTS U7 ( .A(lfsr_out[16]), .B(lfsr_out[23]), .Y(n6) );
  CLKBUFX2TS U8 ( .A(resetn), .Y(n4) );
  CLKBUFX2TS U9 ( .A(n4), .Y(n5) );
  CLKBUFX2TS U10 ( .A(n5), .Y(n9) );
  CLKBUFX2TS U11 ( .A(n4), .Y(n10) );
  CLKBUFX2TS U12 ( .A(n4), .Y(n11) );
  CLKBUFX2TS U13 ( .A(n5), .Y(n12) );
  CLKBUFX2TS U14 ( .A(n4), .Y(n14) );
  CLKBUFX2TS U15 ( .A(n5), .Y(n13) );
  CLKBUFX2TS U16 ( .A(n5), .Y(n8) );
  XNOR2X1TS U17 ( .A(lfsr_out[27]), .B(n7), .Y(n3) );
endmodule

