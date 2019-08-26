module test_alu();
  reg [2:0]alpha = 0;
  reg [31:0]x = 0;
  reg [31:0]y = 0;
  wire signed [31:0]z;
  wire segno;

  ALU#(32, 10) alu(z, segno, x, y, alpha);

  initial
  begin
    $dumpfile("test_alu.vcd");
    $dumpvars;

    #11 $display("%t alpha:%d x:%d y:%d x+y: %d", $time, alpha, x, y, z);

    x = 10;
    y = 5;
    #11 $display("%t alpha:%d x:%d y:%d x+y: %d", $time, alpha, x, y, z);

    x = 20;
    y = 4;
    alpha = 3'b001; // uso della base binaria
    #11 $display("%t alpha:%d x:%d y:%d x-y: %d", $time, alpha, x, y, z);

    x = 1;
    y = 10;
    #11 $display("%t alpha:%d x:%d y:%d x-y: %d", $time, alpha, x, y, z);

    alpha = 3'd3; // uso della base decimale
    #11 $display("%t alpha:%d x:%d y:%d x-1: %d", $time, alpha, x, y, z);

    alpha = 6; // uso della costante decimale 6 invece di 3'd6
    #11 $display("%t alpha:%d x:%d y:%d x/y: %d", $time, alpha, x, y, z);

    #11 $finish;
  end

endmodule

