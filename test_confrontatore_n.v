module test_confrontatore_n();
  parameter N = 10;
  parameter RITARDO = 2 + N/8 + 1;

  reg [N-1:0]x1, x2;
  wire out;

  CONFRONTATORE_N#(10) C10(out, x1, x2);

  initial
  begin
    $dumpfile("test_confrontatore_n.vcd");
    $dumpvars;
    x1 = 0;
    x2 = 0;
    #(RITARDO*2) x1 = 1023;
    #(RITARDO*2) x2 = 1023;
    #(RITARDO*2) x1 = 256;
    #(RITARDO*2) x2 = 128;
    #(RITARDO*2) x1 = 0;
    #(RITARDO*2) x2 = 0;

    #10 $finish;
  end
endmodule

