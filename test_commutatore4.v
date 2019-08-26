module test_commutatore4();

  reg [31:0]x1, x2, x3, x4;
  reg [1:0]alpha;
  wire [31:0]out;

  COMMUTATORE4 K(out, x1, x2, x3, x4, alpha);

  initial
  begin
    $dumpfile("test_commutatore4.vcd");
    $dumpvars;
    x1 = 10;
    x2 = 20;
    x3 = 30;
    x4 = 40;
    alpha = 0;
    #4 alpha = 1;
    #4 alpha = 2;
    #4 alpha = 3;

    #10 $finish;
  end
endmodule

