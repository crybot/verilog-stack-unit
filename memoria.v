/*
* Memoria a doppia porta da N posizioni ciascuna da M bit:
* - 1 porta in lettura/scrittura
* - 1 porta in lettura;
* Il ritardo di accesso in memoria e` parametrizzabile, di default e` uguale a 8tp.
* TODO: aggiornare documento di derivazione formale: la memoria e` a doppia porta, non tripla e va aggiunto il segnale di clock, beta, il valore di ingresso e rimuovere alpha.
*/
module MEMORIA(out1, out2, in, ind1, ind2, clock, beta);

  parameter N=1024;
  parameter M=32;
  parameter RITARDO=8;
  parameter IND_SIZE=$clog2(N);

  output [M-1:0]out1, out2;
  input [M-1:0]in;
  input [IND_SIZE-1:0]ind1, ind2;
  input clock;
  input beta; // beta = 1, abilita scrittura in mem[ind1]
  integer i;

  reg [M-1:0]mem[0:N-1];

  initial
  begin
    for (i=0; i<N; i++)
      mem[i] = 0;
  end

  always @(negedge clock && beta)
  begin
    mem[ind1] = in;
  end

  assign #RITARDO out1 = mem[ind1];
  assign #RITARDO out2 = mem[ind2];
  
endmodule

