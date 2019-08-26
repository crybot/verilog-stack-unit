
/*
* Confrontatore con 2 ingressi da N bit ciascuno: 
* calcola 0 se i bit del primo ingresso coincidono con quelli del secondo, 1 altrimenti.
* Il confrontatore e` parametrico nel numero dei bit per ingresso e nel ritardo di stabilizzazione,
* che di default e` pari a: 2tp (per i confrontatori da un bit) + (floor(N/8) + 1)tp
* poiche` le porte AND vengono disposte in serie secondo
* una struttura ad albero di arieta` 8.
*/

module CONFRONTATORE_N(output reg out, input [N-1:0]x1, input [N-1:0]x2);
  parameter N = 16;
  parameter RITARDO = 2 + N/8 + 1;

  genvar i;
  integer j;
  wire wires[0:N-1];

  generate
    for(i=0; i<N; i=i+1)
    begin
      CONFRONTATORE c_i(wires[i], x1[i], x2[i]);
    end
  endgenerate

  always
  begin
    #RITARDO; // simula il ritardo delle porte AND in serie
    out = 1;
    for(j=0; j<N; j=j+1)
      out = out & ~wires[j];
    out = ~out;
  end

endmodule
