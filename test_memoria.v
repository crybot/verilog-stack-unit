module test_memoria();
  reg [31:0]x = 0;
  reg clock = 1;
  reg beta = 0;
  wire [31:0]out1;
  wire [31:0]out2;
  reg [9:0]ind1;
  reg [9:0]ind2;

  always
  begin
    if (clock == 0)
      #40 clock = 1;
    else 
      #1 clock = 0;
  end

  MEMORIA memoria(out1, out2, x, ind1, ind2, clock, beta);

  initial
  begin
    $dumpfile("test_memoria.vcd");
    $dumpvars;
    beta = 0;
    #4;
    beta = 1;
    x <= 42;
    ind1 <= 0;
    ind2 <= 0;
    beta <= 1;
    #100;
    x <= 128;
    ind2 <= 1023;
    beta <= 1;
    #16;
    ind1 <= 1023;
    x <= 256;
    #100;
    $finish;
  end
endmodule
