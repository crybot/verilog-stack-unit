module test_commutatore2();

  reg [31:0]x1, x2;
  reg alpha;
  wire [31:0]out;

  COMMUTATORE2 K(out, x1, x2, alpha);

  initial
  begin
    $dumpfile("test_commutatore2.vcd");
    $dumpvars;
    x1 = 10;
    x2 = 20;
    alpha = 0;
    #2 alpha = 1;

    #10 $finish;
  end
endmodule

