module test_confrontatore();

  reg x1, x2;
  wire out;

  CONFRONTATORE K(out, x1, x2);

  initial
  begin
    $dumpfile("test_confrontatore.vcd");
    $dumpvars;
    x1 = 0;
    x2 = 0;
    #2 x1 = 1;
    #2 x2 = 1;

    #10 $finish;
  end
endmodule

