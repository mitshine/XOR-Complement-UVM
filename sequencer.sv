`ifndef SEQUENCER_SV
`define SEQUENCER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "xor_rw.sv"
 
class sequencer extends uvm_sequencer #(xor_rw);

   `uvm_component_utils(sequencer)

   function new(input string name, uvm_component parent=null);
      super.new(name, parent);
   endfunction : new

endclass : sequencer

`endif
