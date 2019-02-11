module xor_compl(
				         input [19:0]a,
                 input clk,rst,v_a,
                 input [19:0] p,
                 output reg v_q, 
                 output reg [19:0]q = 0
                 );
	
	// temp signals - output of block a that are input to block b
	reg [19:0] a_out ;
	reg [19:0] neg_a_out ;
	reg v_a_out ;
	wire [19:0] my_signal_q = 0 ;
	
	// temp signal - counter for block a and b
	integer count_a = 0 ;
	integer count_b = 0 ;
	integer i,j = 0 ;
  integer	get_q = 0 ;
	
	always @(posedge clk)
		begin
			if (!rst)
				begin
					a_out=0;
					v_a_out=0 ;
					v_q=0 ;
					q=0 ;
				end
			else
				begin
					if (v_a)
						begin
							repeat (4)
								begin
									@(posedge clk)
									count_a=count_a + 1 ;
									if (count_a == 4)
										begin
										  for (i=0;i<=19;i=i+1)
                        begin
              											a_out[i]=a[i] ^ p[i] ;
           											  end
             											v_a_out=1 ;
						       					count_a=0 ;
									    		wait (v_q == 1'b1) ;
									    		v_a_out = 0 ;
									    		wait (v_q == 1'b0) ;
										end
								end
						end
				end
		end
		
	always @(posedge clk)
		begin
			if (v_a_out == 1)
				begin
					repeat (2)
						begin
							@(posedge clk)
							count_b=count_b + 1 ;
							if  (count_b == 2)
								begin
								  for (j=0;j<=19;j=j+1)
								    begin
								      neg_a_out[j] = ~(a_out[j]) ;
								    end
           									q=(neg_a_out + 1'b1) ;
					      				v_q=1 ;
					      				count_b = 0 ;
                    @(posedge clk)             
								   	v_q = 0 ;
								end
						end
 				end
		end
		
		assign p[19:0] = q[19:0];
		
endmodule