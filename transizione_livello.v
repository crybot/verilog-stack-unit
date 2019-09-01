module TRANSIZIONE_LIVELLO(output out, input in, input clock, input beta);

  wire s_out;
  wire contatore_out;
  reg contatore_mod_2 = 0; // conta mod 2 quante volte beta diventa 1

  REGISTRO#(1) s(s_out, in, clock, 1'b1);
  CONFRONTATORE c(out, s_out, contatore_out);

  // Si utilizza un registro per memorizzare lo stato del contatore.
  // Altrimenti all'arrivo di un set/reset il confrontatore cambierebbe immediatamente
  // l'uscita.
  REGISTRO#(1) contatore(contatore_out, contatore_mod_2, clock, 1'b1);

  // 2tp di ritardo per il contatore modulo 2
  always @(beta)
  begin
    #2 contatore_mod_2 = contatore_mod_2 ^ beta;
  end

endmodule
