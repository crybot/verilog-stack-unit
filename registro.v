/*
* Registro impulsato da N bit
*/
module REGISTRO(output [N-1:0]out, input [N-1:0]in, input clock, input beta);
  parameter N = 32;

  reg [N-1:0]val = 0;
  assign out = val;

  always @(negedge clock)
  begin
    if (beta)
      val = in;
  end
endmodule
