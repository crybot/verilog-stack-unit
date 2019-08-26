/*
* Confrontatore con 2 ingressi da un bit: calcola 0 se i due bit in ingresso sono uguali, 1 altrimenti
*/

module CONFRONTATORE(output out, input x1, input x2);
  assign #2 out = x1 ^ x2; // operatore xor
endmodule

