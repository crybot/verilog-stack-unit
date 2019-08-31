module TRANSIZIONE_LIVELLO(output out, input in, input clock, input beta);

  wire s_out;
  reg contatore_mod_2 = 0; // conta mod 2 quante volte beta diventa 1

  REGISTRO#(1) s(s_out, in, clock, 1'b1);
  CONFRONTATORE c(out, s_out, contatore_mod_2);

  // 2tp di ritardo per il contatore modulo 2
  always @(beta)
  begin
    #2 contatore_mod_2 = contatore_mod_2 ^ beta;
  end

endmodule
