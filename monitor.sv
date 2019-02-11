`ifndef MONITOR_SV
`define MONITOR_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "ifc.sv"
`include "xor_rw.sv"
 
 typedef class monitor;
 
 class monitor extends uvm_monitor;

     `uvm_component_utils(monitor)
     
     virtual ifc xor_vif;
     uvm_analysis_port#(xor_rw) ap;

     function new(string name, uvm_component parent);
         super.new(name, parent);
         ap = new("ap", this);
     endfunction

     function void build();
         uvm_report_info(get_full_name(),"Build", UVM_LOW);
         if (!uvm_config_db#(virtual ifc)::get(this, "", "vif", xor_vif)) begin
            `uvm_fatal("APB/MON/NOVIF", "No virtual interface specified for this monitor instance")
         end
     endfunction

     function void connect();
         uvm_report_info(get_full_name(),"Connect", UVM_LOW);
     endfunction

     function void end_of_elaboration();
         uvm_report_info(get_full_name(),"End_of_elaboration", UVM_LOW);
     endfunction

     function void start_of_simulation();
         uvm_report_info(get_full_name(),"Start_of_simulation", UVM_LOW);
     endfunction

     task run_phase(uvm_phase phase);
         uvm_report_info(get_full_name(),"Run", UVM_LOW);
         super.run_phase(phase);
         forever@(posedge xor_vif.clk) begin
            xor_rw tr;
            tr = xor_rw::type_id::create("tr", this);
            tr.a = xor_vif.a;
            tr.v_a = xor_vif.v_a;
            tr.v_q = xor_vif.v_q;
            tr.p = xor_vif.p;
            ap.write(tr);
         end
     endtask

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
