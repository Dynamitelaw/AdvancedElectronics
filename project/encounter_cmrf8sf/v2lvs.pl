#!/usr/bin/perl
use strict;
use warnings;

system ("v2lvs -i -v $ARGV[0].nophy.v -o $ARGV[0].cdl -s /tools2/courses/ee6321/share/ibm13rflpvt/lvs_netlist/ibm13rflpvt.cdl -lsp /tools2/courses/ee6321/share/ibm13rflpvt/lvs_netlist/ibm13rflpvt.sp");
