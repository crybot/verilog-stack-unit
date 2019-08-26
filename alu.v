module ALU (output reg [N-1:0]z, input [2:0]alpha, input [N-1:0]x, input [N-1:0]y);
  parameter N = 32;
  parameter RITARDO = 10;

  always @(alpha or x or y)
  begin
    #RITARDO;
    case(alpha)
      0: z = x + y;
      1: z = x - y;
      2: z = x + 1;
      3: z = x - 1;
      4: z = y + 1;
      5: z = y - 1;
      6: z = x / y;
    endcase
  end
endmodule
