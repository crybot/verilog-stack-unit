module test_registro();
  reg [31:0]x = 0;
  reg clock = 1;
  reg beta = 1;
  wire [31:0]out;

  integer i;

  always
  begin
    if (clock == 0)
      #5 clock = 1;
    else 
      #1 clock = 0;
  end

  REGISTRO#(32) registro(out, x, clock, beta);

  initial
  begin
    $dumpfile("test_registro.vcd");
    $dumpvars;
    for (i=0; i<10; i++)
    begin 
      beta = ~x[0]; // beta = 1 se x e` pari, 0 altrimenti
      #10 x++;
    end

    #10;
    $finish;
  end

endmodule

