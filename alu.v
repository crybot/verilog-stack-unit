/*
* ALU con operandi a N bit. Implementa le operazioni di somma, sottrazione, incremento, decremento e divisione.
* Fornisce in output, oltre al risultato, anche un bit di segno.
*/
module ALU(output reg [N-1:0]z, output reg segno, input [N-1:0]x, input [N-1:0]y, input [2:0]alpha);
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
    segno = z[N-1]; // bit di segno
  end
endmodule
