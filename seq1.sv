import uvm_pkg::*;
`include "xor_rw.sv"

class seq1 extends uvm_sequence #(xor_rw);

     `uvm_object_utils(seq1)

     function new(string name="seq1");
         super.new(name);
     endfunction
  
  task body;
    xor_rw tx;
    tx = xor_rw::type_id::create("tx");
    start_item(tx);
    assert(tx.randomize());
    tx.rst = 1 ;
    finish_item(tx);
  endtask
  
endclass: seq1
