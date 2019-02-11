`include "uvm_macros.svh"
 import uvm_pkg::*;

`include "test.sv"
`include "xor_compl_rtl.v"

module top;
  
  reg clk;
  wire [19:0] my_q ;
  wire my_v_q ;
  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end
  
  ifc xor_vif(.clk(clk));
  xor_compl XC(.a(xor_vif.a),.clk(xor_vif.clk),.rst(xor_vif.rst),.v_a(xor_vif.v_a),.p(xor_vif.p),.v_q(xor_vif.v_q),.q(xor_vif.q));

  initial
    begin
      uvm_config_db#(virtual ifc)::set(null, "*", "vif", xor_vif);
      run_test("test1");
    end

endmodule
