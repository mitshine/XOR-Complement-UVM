`ifndef ENV_SV
`define ENV_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "agent.sv"
`include "scoreboard.sv"

class env extends uvm_env;

    `uvm_component_utils(env)
     agent ag1;
     scoreboard sbd;
      
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build();
        uvm_report_info(get_full_name(),"Build", UVM_LOW);
        ag1 = agent::type_id::create("ag1",this); 
        sbd = scoreboard::type_id::create("sbd",this);  
    endfunction

    function void connect();
        uvm_report_info(get_full_name(),"Connect", UVM_LOW);
        ag1.ap.connect(sbd.sbd_mon_export);
    endfunction

    function void end_of_elaboration();
        uvm_report_info(get_full_name(),"End_of_elaboration", UVM_LOW);
    endfunction

    function void start_of_simulation();
        uvm_report_info(get_full_name(),"Start_of_simulation", UVM_LOW);
    endfunction

    function void extract();
        uvm_report_info(get_full_name(),"Extract", UVM_LOW);
    endfunction

    function void check();
        uvm_report_info(get_full_name(),"Check", UVM_LOW);
    endfunction

    function void report();
        uvm_report_info(get_full_name(),"Report", UVM_LOW);
    endfunction

endclass

`endif
