`ifndef DRIVER_SV
`define DRIVER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "ifc.sv"
`include "xor_rw.sv"

typedef class driver;

class driver extends uvm_driver #(xor_rw);
     `uvm_component_utils(driver)
     
     virtual ifc xor_vif;
     
     function new(string name, uvm_component parent);
         super.new(name, parent);
     endfunction

     function void build();
         uvm_report_info(get_full_name(),"Build", UVM_LOW);
         if (!uvm_config_db#(virtual ifc)::get(this, "", "vif", xor_vif)) begin
            `uvm_fatal("APB/DRV/NOVIF", "No virtual interface specified for this driver instance")
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

         this.xor_vif.a    <= '0;
         this.xor_vif.rst <= '0;
         this.xor_vif.v_a  <= '0;
         this.xor_vif.p    <= '0;
         this.xor_vif.q    <= '0;

         forever begin
            xor_rw tr;
            @ (this.xor_vif.clk);
            seq_item_port.get_next_item(tr);
            this.write(tr);
            seq_item_port.item_done();
          end
     endtask
     
     virtual protected task write(xor_rw tr);
            if(tr.rst == 0)
               begin
                 this.xor_vif.a   <= tr.a;
                 this.xor_vif.rst <= '0;
                 this.xor_vif.v_a  <= tr.v_a;
                 this.xor_vif.p    <= tr.p;
                 this.xor_vif.q    <= tr.q;
               end
             else
               begin
									       @(posedge this.xor_vif.clk)
								         this.xor_vif.a = $random();
								         this.xor_vif.rst = 1;
								         this.xor_vif.v_a = 1;
               end
     endtask: write

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
