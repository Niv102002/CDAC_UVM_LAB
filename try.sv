module try ();

	reg [5:0] data;

	initial #5 force data = 5;

	initial #10 data = 50;

	initial #20 $display("data : %0d ", data);


endmodule : try