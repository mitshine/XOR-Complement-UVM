interface ifc(input bit clk);
   logic [19:0] a;
   logic        v_a;
   logic        rst;
   logic        v_q;
   logic [19:0]   p;
   logic [19:0]   q;

   clocking pck @(posedge clk);
      output a, v_a, rst;
      input p, v_q, q;
   endclocking: pck

endinterface: ifc
