`ifndef TEST_SV
`define TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "env.sv"
`include "seq1.sv"
`include "sequencer.sv"
 
 class test1 extends uvm_test;

   `uvm_component_utils(test1)
    env t_env;
    seq1 seq_h;
    sequencer seqr_h;
 
    function new (string name="test1", uvm_component parent=null);
        super.new (name, parent);
    endfunction : new 
    
    function void build();
        t_env = env::type_id::create("t_env",this);
        seqr_h = sequencer::type_id::create("seqr_h",this);
        uvm_report_info(get_full_name(),"Build", UVM_LOW);   
    endfunction

    function void end_of_elaboration();
        uvm_report_info(get_full_name(),"End_of_elaboration", UVM_LOW);
        print();
    endfunction : end_of_elaboration
 
    task run_phase (uvm_phase phase);
        phase.raise_objection(this);
        forever begin
          seq_h = seq1::type_id::create("seq_h",this);
          seq_h.start(t_env.ag1.seqr);
        end
        phase.drop_objection(this);
    endtask : run_phase

endclass

`endif
