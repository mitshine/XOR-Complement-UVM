`ifndef XOR_RW_SV
`define XOR_RW_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class xor_rw extends uvm_sequence_item;
  
   rand bit   [19:0] a;
   rand bit rst;
   rand bit v_a;
   rand bit v_q;
   rand bit [19:0]  p;
   rand bit [19:0]  q;
 
   `uvm_object_utils_begin(xor_rw)
     `uvm_field_int(a, UVM_ALL_ON | UVM_NOPACK);
     `uvm_field_int(v_a, UVM_ALL_ON | UVM_NOPACK);
     `uvm_field_int(v_q, UVM_ALL_ON | UVM_NOPACK);
     `uvm_field_int(p, UVM_ALL_ON | UVM_NOPACK);
     `uvm_field_int(q, UVM_ALL_ON | UVM_NOPACK);
   `uvm_object_utils_end
   
   function new (string name = "xor_rw");
      super.new(name);
   endfunction

   function string convert2string();
     return $sformatf("Value for A block=%0h Valid signal for A block=%0h Valid signal for Q=%0h",a,v_a,v_q);
   endfunction

endclass: xor_rw

`endif
