`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "ifc.sv"
`include "xor_rw.sv"

`uvm_analysis_imp_decl(_FROM_MONITOR)

class scoreboard extends uvm_scoreboard;
     `uvm_component_utils(scoreboard)
     
     virtual ifc xor_vif;
     xor_rw Driver_pkt;
     xor_rw Driver_Queue1[$];
     xor_rw Driver_Queue2[$];
     int tmp1, tmp2, tmp3, tmp4;
     int count_a = 0;
     int count_b = 0;
     
     uvm_analysis_imp_FROM_MONITOR #(xor_rw, scoreboard) sbd_mon_export;

     function new(string name, uvm_component parent);
         super.new(name, parent);
         sbd_mon_export = new("sbd_mon_export", this);
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
         `uvm_info("scoreboard run task", "WAITING for expected output", UVM_DEBUG)
     endtask

     virtual function void write_FROM_MONITOR(xor_rw tr);
        tr.print();
        tmp1 = tr.a;
        tmp2 = tr.p;
        Driver_Queue1.push_back(tr);          //Data saved in Driver Queue 1
        Driver_Queue2.push_back(tr);          //Data saved in Driver Queue 2
        if(tr.v_a == 1)
          begin
            if(Driver_Queue1.size() == 4)
              begin
                Driver_pkt=Driver_Queue1.pop_front();      //Packet Popped out from Queue.
                Driver_pkt=Driver_Queue1.pop_front();      //Packet Popped out from Queue.
                Driver_pkt=Driver_Queue1.pop_front();      //Packet Popped out from Queue.
                tmp3 = tmp1 ^ tmp2;
              end
          end
        if(tr.v_q == 1)
          begin
            if(Driver_Queue2.size() == 6)
              begin
                Driver_pkt=Driver_Queue2.pop_front();      //Packet Popped out from Queue.
                Driver_pkt=Driver_Queue2.pop_front();      //Packet Popped out from Queue.
                Driver_pkt=Driver_Queue2.pop_front();      //Packet Popped out from Queue.
                Driver_pkt=Driver_Queue2.pop_front();      //Packet Popped out from Queue.
                Driver_pkt=Driver_Queue2.pop_front();      //Packet Popped out from Queue.
                tmp4 = (~tmp3)+1;
              end
          end
        if(tmp4 == tr.q)
          $display("MATCHED!");
        else
          $display("NOT MATCHED!");
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
